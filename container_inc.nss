// Name     : Container Persistence Library Functions
// Purpose  : Store/Load Persistent Container Contents
// Authors  : GrapeApe with assistance from HorredThePlague
// Created  : March 25, 2005
// Modified : April 08, 2005
//
// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2
#include "aps_include"

// database table name
const string DB_TABLE = "pw_containers";

// logger settings
const int DEBUG = 0; // set to 1 to fill up the server log file
const int LOG_NOTICE = 0;
const int LOG_WARN = 1;
const int LOG_ERROR = 2;

// limit the number of items a container can hold
// set to 0 to have no limit
const int MAX_CONTAINER_ITEMS = 250;

// how many items can a pc store in a pc specific container
// set to 0 to have no limit
const int MAX_PC_CONTAINER_ITEMS = 250;

/*/////////////////////////////////////////////////////////////////////////////
//  Make a container's inventory persistent across server restarts.  If oPC
//  is specified then treat the inventory as PC specific, otherwise it will be
//  communally accessible (free for all).
//
//  PC containers should be locked and a local merchant should be set to sell
//  the key to use the container.  The PC close script will lock the container
//  when done.
/////////////////////////////////////////////////////////////////////////////*/

///////////////////////////////////////////////////////////////////////////////
// prototypes
///////////////////////////////////////////////////////////////////////////////

// temporary item structure to allow mux'd items to be passed through functions
struct structItem
{
    string sItemRef;
    int iStack;
    int iIdentified;
    int iInvCount;
};

// log messages to the nwn log file with datestamp and level noted
void ContainerLog(string msg, int loglevel=LOG_NOTICE);

// takes an item struct and returns it as a formatted string
// format: #I#<sItemRef>#<iStack>#<iIdentified>#<iItemCount>#\I#
string StructItemToString(struct structItem stItem);

// takes an item object and returns it as a formatted string
// format: #I#<sItemRef>#<iStack>#<iIdentified>#<iItemCount>#\I#
string ContainerItemMux(object oItem);

// takes an item string and returns it as a struct structItem
struct structItem ContainerItemDemux(string sItem);

// count the number of items in a container
// returns: integer count of the number of items in a container
int ContainerCountContents(object oContainer);

// destroy all items in a container
void ContainerClearContents(object oContainer);

// Load persistent contents into the item, if any.
// Use in the container's OnOpen script
void ContainerGetPersitentContents(object oContainer);

// Load a PC's persistent contents into the item, if any.
// Container will temporarily hold the PC's items and while open
// is viewable and accessible to other PCs.
// Retrieved by coded sPCid, container name, container tag.
// So, container name+tag should be unique unless you want the contents
// accessible from multiple containers.
// Use in the container's OnOpen script.
void ContainerGetPersitentContentsByPC(object oContainer, object oPC);

// Store the contents of a container to a persistent db.
// Deletes all items from the container while not in use.
// Use in the container's OnClose script
void ContainerSetPersistentContents(object oContainer);

// Store the PC's contents of a container to a persistent db.
// Deletes all items from the container while not in use.
// Stored by coded sPCid, container name, container tag.
// So, container name+tag should be unique unless you want the contents
// accessible from multiple containers.
// Use in the container's OnClose script
void ContainerSetPersistentContentsByPC(object oContainer, object oPC, int iRelock=1);

///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// implementations
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
string StructItemToString(struct structItem stItem)
{
    string sItemString = "#I#";

    sItemString += stItem.sItemRef + "#";
    sItemString += IntToString(stItem.iStack) + "#";
    sItemString += IntToString(stItem.iIdentified) + "#";
    sItemString += IntToString(stItem.iInvCount) + "#";

    sItemString += "/I#";

    return sItemString;
}

///////////////////////////////////////////////////////////////////////////////
void ContainerLog(string msg, int loglevel=LOG_NOTICE)
{
    if(!DEBUG) return;

    switch (loglevel)
    {
        case LOG_NOTICE:
            msg = "NOTICE: " + msg;
            break;
        case LOG_WARN:
            msg = "WARNING: " + msg;
            break;
        case LOG_ERROR:
            msg = "ERROR: " + msg;
            break;
        default:
            break;
    }

    WriteTimestampedLogEntry(msg);
}

///////////////////////////////////////////////////////////////////////////////
struct structItem ContainerItemDemux(string sItem)
{
    struct structItem stItem;

    // test for proper stucture
    if(FindSubString(sItem, "#I#") != 0)
    {
        ContainerLog("Invalid item string passed to Container_inc::" +
            "ContainerItemDemux(" + sItem + ") missing begin item.", LOG_ERROR);
        return stItem;
    }
    if(!FindSubString(sItem, "#/I#"))
    {
        ContainerLog("Invalid item string passed to Container_inc::" +
            "ContainerItemDemux(" + sItem + ") missing end item.", LOG_ERROR);
        return stItem;
    }

    sItem = GetSubString(sItem, 3, GetStringLength(sItem));

    // get the item ref
    int iItemRefEnd = FindSubString(sItem, "#");
    stItem.sItemRef = GetSubString(sItem, 0, iItemRefEnd);
    // strip the item ref off the front of the string
    sItem = GetSubString(sItem, iItemRefEnd + 1, GetStringLength(sItem));

    // get and set stack size
    int iItemStackEnd = FindSubString(sItem, "#");
    stItem.iStack = StringToInt(GetSubString(sItem, 0, iItemStackEnd));
    // strip the stack size off the front of the string
    sItem = GetSubString(sItem, iItemStackEnd + 1, GetStringLength(sItem));

    // get the identified status off the string
    stItem.iIdentified = StringToInt(GetSubString(sItem, 0, 1));
    // strip the ident status off the front of the string
    sItem = GetSubString(sItem, 2, GetStringLength(sItem));

    // get and set stack size
    int iInvCountEnd = FindSubString(sItem, "#");
    stItem.iInvCount = StringToInt(GetSubString(sItem, 0, iInvCountEnd));

    return stItem;
}

///////////////////////////////////////////////////////////////////////////////
string ContainerItemMux(object oItem)
{
    struct structItem stItem;

    stItem.sItemRef = GetResRef(oItem);
    stItem.iStack = GetItemStackSize(oItem);
    stItem.iIdentified = GetIdentified(oItem);

    // test for container in container
    if(!GetHasInventory(oItem))
    {
        stItem.iInvCount = 0;
    }
    else
    {
        stItem.iInvCount = ContainerCountContents(oItem);
    }

    return StructItemToString(stItem);
}

///////////////////////////////////////////////////////////////////////////////
int ContainerCountContents(object oContainer)
{
    int iCount = 0;
    object oInvItem = GetFirstItemInInventory(oContainer);
    while(GetIsObjectValid(oInvItem))
    {
        iCount++;
        oInvItem = GetNextItemInInventory(oContainer);
    }

    return iCount;
}

///////////////////////////////////////////////////////////////////////////////
void ContainerClearContents(object oContainer)
{
    int iCount = 0;
    object oInvItem = GetFirstItemInInventory(oContainer);
    while(GetIsObjectValid(oInvItem))
    {
        DestroyObject(oInvItem);
        iCount++;
        oInvItem = GetNextItemInInventory(oContainer);
    }

    ContainerLog(IntToString(iCount) + " items destroyed");
}

///////////////////////////////////////////////////////////////////////////////
void ContainerGetPersitentContents(object oContainer)
{
    // first, clear the container in case any debris got left in it
    ContainerClearContents(oContainer);

    // unique key fields
    string sName = SQLEncodeSpecialChars(GetName(oContainer));
    string sTag = SQLEncodeSpecialChars(GetTag(oContainer));

    // get the items (by resref) in this container
 /*   string sSQL = "SELECT sItem FROM " + DB_TABLE + " WHERE name='"
                    + sName + "' AND tag='" + sTag + "' ORDER BY id ASC";*/
    string sSQL = "SELECT sItem FROM " + DB_TABLE + " WHERE tag='" + sTag + "' ORDER BY id ASC";
    // run the SQL
    SQLExecDirect(sSQL);

    // cycle the results, putting each item into the container
    int iTmpCount = 0;
    while(SQLFetch())
    {
        string sItem = SQLGetData(1);
        struct structItem stItem = ContainerItemDemux(SQLDecodeSpecialChars(sItem));

        // create the item on the main container
        object oItem = CreateItemOnObject(stItem.sItemRef, oContainer, stItem.iStack);
        // if it was previously identified, set it as identified
        SetIdentified(oItem, stItem.iIdentified);
        iTmpCount++;

        int i;
        for(i=0; i < stItem.iInvCount; i++)
        {
            if(SQLFetch())
            {
                string sSubItem = SQLGetData(1);
                struct structItem stSubItem = ContainerItemDemux(sSubItem);
                WriteTimestampedLogEntry("NOTICE: Adding item to sub-container (" + sSubItem + ").");

                // create the item on the sub container
                object oSubItem = CreateItemOnObject(stSubItem.sItemRef, oItem, stSubItem.iStack);
                // if it was previously identified, set it as identified
                SetIdentified(oSubItem, stSubItem.iIdentified);
                iTmpCount++;
            }
        }
    }
    SendMessageToPC(GetLastOpenedBy(), "Nasel jsi " + IntToString(iTmpCount) + " veci ve schrance.");
    WriteTimestampedLogEntry("NOTICE: Container filled with " + IntToString(iTmpCount) + " items.");

}

///////////////////////////////////////////////////////////////////////////////
void ContainerGetPersitentContentsByPC(object oContainer, object oPC)
{
    // first, clear the container in case any debris got left in it
    ContainerClearContents(oContainer);

    // unique key fields
    string sName = SQLEncodeSpecialChars(GetName(oContainer));
    string sTag = SQLEncodeSpecialChars(GetTag(oContainer));
    string sPCid = SQLEncodeSpecialChars(GetPCPlayerName(oPC) + "_" + GetName(oPC));

    // lock the container, other openers won't cause an inventory reload
    // this does however let a subsequent opener to root through the first
    // opener's container items  (i.e. looking over shoulder)
    string sLockPCid = GetLocalString(oContainer,"CONTAINER_LOCKED");
    if((sLockPCid != "") && (sLockPCid != sPCid))
    {
        SendMessageToPC(oPC, "Divas se na cizi veci.");
        return;
    }
    SetLocalString(oContainer, "CONTAINER_LOCKED", sPCid);

    // get the items (by resref) in this container
    /*string sSQL = "SELECT sItem FROM " + DB_TABLE + " WHERE name='"
                    + sName + "' AND tag='" + sTag + "'" + " AND PCid='"
                    + sPCid + "' ORDER BY id ASC";*/
    string sSQL = "SELECT sItem FROM " + DB_TABLE + " WHERE tag='" + sTag + "'" + " AND PCid='"
                    + sPCid + "' ORDER BY id ASC";
    // run the SQL
    SQLExecDirect(sSQL);

    // cycle the results, putting each item into the container
    int iTmpCount = 0;
    while(SQLFetch())
    {
        string sItem = SQLGetData(1);
        struct structItem stItem = ContainerItemDemux(SQLDecodeSpecialChars(sItem));

        // create the item on the main container
        object oItem = CreateItemOnObject(stItem.sItemRef, oContainer, stItem.iStack);
        // if it was previously identified, set it as identified
        SetIdentified(oItem, stItem.iIdentified);
        iTmpCount++;

        int i;
        for(i=0; i < stItem.iInvCount; i++)
        {
            if(SQLFetch())
            {
                string sSubItem = SQLGetData(1);
                struct structItem stSubItem = ContainerItemDemux(sSubItem);
                WriteTimestampedLogEntry("NOTICE: Adding item to sub-container (" + sSubItem + ").");
                // create the item on the sub container
                object oSubItem = CreateItemOnObject(stSubItem.sItemRef, oItem, stSubItem.iStack);
                // if it was previously identified, set it as identified
                SetIdentified(oSubItem, stSubItem.iIdentified);
                iTmpCount++;
            }
        }
    }
    SendMessageToPC(oPC, "Nasel jsi " + IntToString(iTmpCount) + " svych veci.");
    WriteTimestampedLogEntry("NOTICE: Container filled with " + IntToString(iTmpCount) + " items.");
}

///////////////////////////////////////////////////////////////////////////////
void ContainerSetPersistentContents(object oContainer)
{
    // unique key fields
    string sName = SQLEncodeSpecialChars(GetName(oContainer));
    string sTag = SQLEncodeSpecialChars(GetTag(oContainer));

    // delete current set of items from the db
    /*string sSQL = "DELETE FROM pw_containers WHERE name='" + sName +
                    "' AND tag='" + sTag + "'";*/
    string sSQL = "DELETE FROM pw_containers WHERE tag='" + sTag + "'";
    // run the SQL
    SQLExecDirect(sSQL);

    // go in and insert the new items
    object oPC = GetLastClosedBy();
    object oItem = GetFirstItemInInventory(oContainer);
    int iTmpCount = 0;
    int iDropCount = 0;
    int iCaughtCount = 0;
    string sWarning = "";
    while(GetIsObjectValid(oItem))
    {
        string sItem = ContainerItemMux(oItem);
        iTmpCount++;
        if(MAX_CONTAINER_ITEMS && (iTmpCount > MAX_CONTAINER_ITEMS))
        {
            ActionGiveItem(oItem, oPC);
            AssignCommand(oPC, ActionPutDownItem(oItem));
            iDropCount++;
        }
        else
        {
            // create the INSERT statement
            sSQL = "INSERT INTO " + DB_TABLE + " (name,tag,sItem) VALUES ('" + sName +
                    "','" + sTag + "','" + SQLEncodeSpecialChars(sItem) + "')";

            // run the SQL
            SQLExecDirect(sSQL);

            // out with the old
            DestroyObject(oItem);
        }

        // move on to the next item in inventory
        oItem = GetNextItemInInventory(oContainer);
    }

    if(iDropCount)
    {
        sWarning = "Preplnil si schranku, " +
                    IntToString(iDropCount) + " predmetu bylo nechano na zemi.";
        SendMessageToPC(oPC, sWarning);
        ContainerLog(sWarning);
    }

    SendMessageToPC(oPC, "Ulozil jsi " + IntToString(iTmpCount) + " predmetu.");
    ContainerLog("Kontejner ulozil " + IntToString(iTmpCount) + " predmetu do DB.");
}

///////////////////////////////////////////////////////////////////////////////
void ContainerSetPersistentContentsByPC(object oContainer, object oPC, int iRelock=1)
{
    // unique key fields
    string sName = SQLEncodeSpecialChars(GetName(oContainer));
    string sTag = SQLEncodeSpecialChars(GetTag(oContainer));
    string sPCid = SQLEncodeSpecialChars(GetPCPlayerName(oPC) + "_" + GetName(oPC));

    // test if another PC already using this container
    // bail if there is, don't want to clobber other PCs inventory
    string sLockPCid = GetLocalString(oContainer,"CONTAINER_LOCKED");
    ContainerLog("Container Closing, PCLocked: " + sLockPCid);

    // delete current set of items from the db
/*    string sSQL = "DELETE FROM pw_containers WHERE name='" + sName +
                    "' AND tag='" + sTag + "'" + " AND PCid='" + sLockPCid + "'";*/
    string sSQL = "DELETE FROM pw_containers WHERE tag='" + sTag + "'" + " AND PCid='" + sLockPCid + "'";
    // run the SQL
    //PrintString("NOTICE: " + sSQL);
    SQLExecDirect(sSQL);

    // go in and insert the new items
    object oPC = GetLastClosedBy();
    object oItem = GetFirstItemInInventory(oContainer);
    int iTmpCount = 0;
    int iDropCount = 0;
    string sWarning = "";
    while(GetIsObjectValid(oItem))
    {
        string sItem = ContainerItemMux(oItem);
        iTmpCount++;

        // added a test for if the pc is the original opener so we don't dump some
        // linkdead player's items on the floor for anyone to pickup
        if(MAX_PC_CONTAINER_ITEMS && (sPCid == sLockPCid) && (iTmpCount > MAX_PC_CONTAINER_ITEMS))
        {
            ActionGiveItem(oItem, oPC);
            if(!ReflexSave(oPC, 5)) {
                AssignCommand(oPC, ActionPutDownItem(oItem));
                iDropCount++;
            }
        }
        else
        {
            // create the INSERT statement
            sSQL = "INSERT INTO " + DB_TABLE + " (name,tag,sItem,PCid) VALUES ('" +
                sName + "','" + sTag + "','" + sItem +
                  "','" + sLockPCid + "')";

            // run the SQL
            SQLExecDirect(sSQL);

            // destroy the item
            DestroyObject(oItem);
        }

        // move on to the next item in inventory
        oItem = GetNextItemInInventory(oContainer);
    }

    if(iDropCount)
    {
        sWarning = "Preplnil si schranku, " +
                    IntToString(iDropCount) + " predmetu bylo nechano na zemi.";
        SendMessageToPC(oPC, sWarning);
        ContainerLog(sWarning);
    }

    // unlock the container
    DeleteLocalString(oContainer, "CONTAINER_LOCKED");
    ContainerLog("Container Close, PCUnlocked");
    // output status messages
    SendMessageToPC(oPC, "You stored " + IntToString(iTmpCount) + " items.");
    ContainerLog("Container stored " + IntToString(iTmpCount) + " items into the DB.");

    // re-lock the container
    if(iRelock && GetLockLockable(oContainer))
    {
        SetLocked(oContainer, 1);
        ContainerLog("Container locked.");
    }
}

///////////////////////////////////////////////////////////////////////////////
void ContainerSetPersistentGold(object oContainer)
{
    // unique key fields
    string sName = SQLEncodeSpecialChars(GetName(oContainer));
    string sTag = SQLEncodeSpecialChars(GetTag(oContainer));

    // go in and insert the new items
    object oPC = GetLastClosedBy();
    object oItem = GetFirstItemInInventory(oContainer);
    int iGP = 0;
    string sWarning = "";
    while(GetIsObjectValid(oItem)) {

        if(GetBaseItemType(oItem) == BASE_ITEM_GOLD) {
          iGP = GetItemStackSize(oItem);
          break;;
        }


        // move on to the next item in inventory
        oItem = GetNextItemInInventory(oContainer);
    }

    if(iGP == GetLocalInt(OBJECT_SELF,"goldpieces"))
      return;

    string sSQL = "DELETE FROM pw_containers WHERE name='" + sName + "' AND tag='" + sTag + "'";
    // run the SQL
    SQLExecDirect(sSQL);

    string sItem = "#I#";
    sItem += "NW_IT_GOLD001#";
    sItem += IntToString(iGP) + "#";
    sItem += "1#";
    sItem += "0#";
    sItem += "/I#";

    // create the INSERT statement
    sSQL = "INSERT INTO " + DB_TABLE + " (name,tag,sItem) VALUES ('" + sName +
           "','" + sTag + "','" + SQLEncodeSpecialChars(sItem) + "')";

    // run the SQL
    SQLExecDirect(sSQL);

    SetLocalInt(OBJECT_SELF,"goldpieces",iGP);

    SendMessageToPC(oPC, "Ulozil jsi " + IntToString(iGP) + " zlatych.");
//    ContainerLog("Kontejner ulozil " + IntToString(iTmpCount) + " predmetu do DB.");
}

///////////////////////////////////////////////////////////////////////////////
void ContainerGetPersistentGold(object oContainer)
{
    // first, clear the container in case any debris got left in it
    //ContainerClearContents(oContainer);

    // Pokud byl od restartu uz kontejner otevren, neni divod koukat do DB
    if(GetLocalInt(OBJECT_SELF,"fetched"))
      return;

    // unique key fields
    string sName = SQLEncodeSpecialChars(GetName(oContainer));
    string sTag = SQLEncodeSpecialChars(GetTag(oContainer));

    // get the items (by resref) in this container
 /*   string sSQL = "SELECT sItem FROM " + DB_TABLE + " WHERE name='"
                    + sName + "' AND tag='" + sTag + "' ORDER BY id ASC";*/
    string sSQL = "SELECT sItem FROM " + DB_TABLE + " WHERE tag='" + sTag + "' ORDER BY id ASC";
    // run the SQL
    SQLExecDirect(sSQL);

    // cycle the results, putting each item into the container
    int iTmpCount = 0;
    struct structItem stItem;
    while(SQLFetch())
    {
        string sItem = SQLGetData(1);
        stItem = ContainerItemDemux(SQLDecodeSpecialChars(sItem));

        // create the item on the main container
        object oItem = CreateItemOnObject(stItem.sItemRef, oContainer, stItem.iStack);
        // if it was previously identified, set it as identified
        SetIdentified(oItem, stItem.iIdentified);
        iTmpCount++;

        int i;

    }
    SendMessageToPC(GetLastOpenedBy(), "Nasel jsi " + IntToString(stItem.iStack) + " zlatych ve schrance.");
//    WriteTimestampedLogEntry("NOTICE: Container filled with " + IntToString(iTmpCount) + " items.");

}

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
