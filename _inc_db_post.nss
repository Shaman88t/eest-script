// Authors  : TondaLee (AV) - Antonin Vins
// Created  : 23/06/2005
// Modified : 18/07/2005
// funkce zajisti obsluhu systemu posty (nacitani a ukladani do DB)

#include "_inc_config"
#include "_inc_nwnx_db"

// funkce pro zachazeni s postovnimy zpravamy
void GetPostObjects(object oRecipient, object oTable);
void AddPostStoredObjects(object oSender, string sRecipientGUID, string sRecipientChName, string sRecipientPlName, string IsAnon, object oItem);
void AddPostLetterObjects(object oSender, string sRecipientGUID, string sRecipientChName, string sRecipientPlName, string sNameLetter, string sTextLetter, string IsAnon);
void DeleteStoredObject(object oRecipient);
void DeleteStoredLetter(object oRecipient);
void DeleteLetter(string sLetterID);
void DeleteOneStoredObject(string sObjectID);
void SendPostMessageToPC(string sPlayerName, string sCharacterName);

string GetLetterName(string sLetterID);
string GetLetterText(string sLetterID);
string GetLetterSender(string sLetterID);

void ShowPostedObjectInfo(object oPlayer);

void GetPostObjects(object oRecipient, object oTable)
{
    string sGUID;
    string sPlName;

    if (GetIsPC(oRecipient) || GetIsDM(oRecipient))
    {
        sGUID = GetCharacterGUID(oRecipient);
        sPlName = SQLEncodeSpecialChars(GetPCPlayerName(oRecipient));
    }
    else
    {
        return;
    }
    //nejprve nactu dopisy
    string sSQL = "SELECT StoredObjectID FROM " + TABLE_POST_STORED_LETTERS
            + " WHERE RecipientGUID = " + sGUID
            + " AND RecipientPlayerName = '" + sPlName + "'"
            + " AND IsReleased = '0'";
    SQLExecDirect(sSQL);

    string sStoredObjectTag;
    //vytvori se dopisy
    while (SQLFetch() == SQL_SUCCESS)
    {
        sStoredObjectTag = ITEM_LETTER_PREFIX + SQLGetData(1);
        object oTemp = CreateItemOnObject(ITEM_LETTER_RES, oTable);
        CopyObject(oTemp, GetLocation(oTemp), oTable, sStoredObjectTag);
        DestroyObject(oTemp);
    }

    sSQL = "UPDATE " + TABLE_POST_STORED_LETTERS
            + " SET IsReleased = '1' WHERE RecipientGUID = " + sGUID
            + " AND RecipientPlayerName = '" + sPlName + "'"
            + " AND IsReleased = '0'";
    SQLExecDirect(sSQL);

    //zaslane predmety
    //nactu ulozene predmety
    string sStoredObjectID;
    int bContinue = TRUE;

    while (bContinue)
    {
        sSQL = "SELECT StoredObjectID FROM " + TABLE_POST_STORED_OBJECTS
            + " WHERE RecipientGUID = " + sGUID
            + " ORDER BY StoredObjectID";
        SQLExecDirect(sSQL);
        if (SQLFetch() == SQL_SUCCESS)
        {
            sStoredObjectID = SQLGetData(1);
            sSQL = "SELECT StoredObject FROM " + TABLE_POST_STORED_OBJECTS
                + " WHERE StoredObjectID = " + sStoredObjectID;
            SetLocalString(GetModule(), "NWNX!ODBC!SETSCORCOSQL", sSQL);
            object oTemp = RetrieveCampaignObject ("NWNX", "-", GetLocation(oTable), oTable);
            //SendMessageToPC(oRecipient, GetTag(oTemp));
            DeleteOneStoredObject(sStoredObjectID);
        }
        else
        {
            bContinue = FALSE;
        }
    }
}

void AddPostStoredObjects(object oSender, string sRecipientGUID, string sRecipientChName, string sRecipientPlName, string IsAnon, object oItem)
{
    sRecipientGUID = SQLEncodeSpecialChars(sRecipientGUID);

    string sStoredObjectTag = GetTag(oItem);
    string sStoredObjectName = SQLEncodeSpecialChars(GetName(oItem));

    string sSenderGUID = GetCharacterTag(oSender);
    string sSenderTag = GetCharacterGUID(oSender);
    string sSenderChName = SQLEncodeSpecialChars(GetName(oSender));
    string sSenderPlName = SQLEncodeSpecialChars(GetPCPlayerName(oSender));

    string sSQL = "INSERT INTO " + TABLE_POST_STORED_OBJECTS +
            " (StoredObject,StoredObjectTag,StoredObjectName,SenderGUID,SenderTAG,SenderCharacterName,SenderPlayerName,"
            + "RecipientGUID,RecipientCharacterName,RecipientPlayerName,IsAnon) VALUES "
            + "(%s,'" + sStoredObjectTag + "','" + sStoredObjectName + "'," + sSenderGUID + "," + sSenderTag
            + ",'" + sSenderChName + "','" + sSenderPlName
            + "','" + sRecipientGUID + "','" + sRecipientChName + "','" + sRecipientPlName
            + "','" + IsAnon + "')";

    SetLocalString(GetModule(), "NWNX!ODBC!SETSCORCOSQL", sSQL);
    StoreCampaignObject ("NWNX", "-", oItem);
}

void AddPostLetterObjects(object oSender, string sRecipientGUID, string sRecipientChName, string sRecipientPlName, string sNameLetter, string sTextLetter, string IsAnon)
{
    sRecipientGUID = SQLEncodeSpecialChars(sRecipientGUID);

    string sSenderGUID = GetCharacterTag(oSender);
    string sSenderTag = GetCharacterGUID(oSender);
    string sSenderChName = SQLEncodeSpecialChars(GetName(oSender));
    string sSenderPlName = SQLEncodeSpecialChars(GetPCPlayerName(oSender));


    string sSQL = "INSERT INTO " + TABLE_POST_STORED_LETTERS +
            " (SenderGUID,SenderTAG,SenderCharacterName,SenderPlayerName,"
            + "RecipientGUID,RecipientCharacterName,RecipientPlayerName,PostName,PostText,IsReleased,IsAnon) VALUES "
            + "(" + sSenderGUID + "," + sSenderTag
            + ",'" + sSenderChName + "','" + sSenderPlName
            + "','" + sRecipientGUID + "','" + sRecipientChName + "','" + sRecipientPlName
            + "','" + sNameLetter + "','" + sTextLetter + "','0','" + IsAnon + "')";
    SQLExecDirect(sSQL);
}

void DeleteStoredObject(object oRecipient)
{
    string sPlName = GetPCPlayerName(oRecipient);
    string sChName = GetName(oRecipient);


    string sSQL = "DELETE FROM " + TABLE_POST_STORED_OBJECTS
        + " WHERE RecipientPlayerName = '" + sPlName + "'"
        + " AND RecipientCharacterName = '" + sChName + "'";
    SQLExecDirect(sSQL);
}
void DeleteStoredLetter(object oRecipient)
{
    string sPlName = GetPCPlayerName(oRecipient);
    string sChName = GetName(oRecipient);

    string sSQL = "DELETE FROM " + TABLE_POST_STORED_LETTERS
        + " WHERE RecipientPlayerName = '" + sPlName + "'"
        + " AND RecipientCharacterName = '" + sChName + "'";
    SQLExecDirect(sSQL);
}
void DeleteLetter(string sLetterID)
{
    string sSQL = "DELETE FROM " + TABLE_POST_STORED_LETTERS
        + " WHERE StoredObjectID = " + sLetterID;
    SQLExecDirect(sSQL);
}
void DeleteOneStoredObject(string sObjectID)
{
    string sSQL = "DELETE FROM " + TABLE_POST_STORED_OBJECTS
        + " WHERE StoredObjectID = " + sObjectID;
    SQLExecDirect(sSQL);
}
string GetLetterName(string sLetterID)
{
    string sSQL = "select PostName from " + TABLE_POST_STORED_LETTERS
        + " WHERE StoredObjectID = " + sLetterID;

    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
    {
        return SQLGetData(1);
    }
    return "";
}
string GetLetterText(string sLetterID)
{
    string sSQL = "select PostText from " + TABLE_POST_STORED_LETTERS
        + " WHERE StoredObjectID = " + sLetterID;

    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
    {
        return SQLGetData(1);
    }
    return "";
}
string GetLetterSender(string sLetterID)
{
    string sSQL = "select SenderCharacterName from " + TABLE_POST_STORED_LETTERS
        + " WHERE IsAnon = '0' AND StoredObjectID = " + sLetterID;

    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
    {
        return SQLGetData(1);
    }
    return "";
}

void ShowPostedObjectInfo(object oPlayer)
{
    string sInfo;
    string sPlName = SQLEncodeSpecialChars(GetPCPlayerName(oPlayer));
    string sChName = SQLEncodeSpecialChars(GetName(oPlayer));


    string sSQL = "select SenderCharacterName, StoredObjectName from " + TABLE_POST_STORED_OBJECTS
        + " WHERE IsAnon = '0' AND RecipientPlayerName = '" + sPlName + "'"
        + " AND RecipientCharacterName = '" + sChName + "'";
    SQLExecDirect(sSQL);

    //vytvori se dopisy
    while (SQLFetch() == SQL_SUCCESS)
    {
        SendMessageToPC(oPlayer, "Odesilatel: " + SQLGetData(1) + ". Predmet: " + SQLGetData(2));
    }
}

void SendPostMessageToPC(string sPlayerName, string sCharacterName)
{
    object oPC = GetFirstPC();

    while (GetIsObjectValid(oPC))
    {
        if (GetName(oPC) == sCharacterName && GetPCPlayerName(oPC) == sPlayerName)
        {
            SendMessageToPC(oPC, "------------------------------");
            SendMessageToPC(oPC, "Bol ti zaslany dopis alebo balik.");
            SendMessageToPC(oPC, "------------------------------");
            return;
        }
        oPC = GetNextPC();
    }
}
