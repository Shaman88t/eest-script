// Authors  : TondaLee (AV) - Antonin Vins
// Created  : 17/06/2005
// Modified : 17/06/2005

#include "_inc_config"
#include "_inc_nwnx_db"

// systemova konverzece s ceduli
string GetEstateEmergencyWay(string sEstateTag);
string GetEstateInnerMainDoor(string sEstateTag);
string GetEstateOuterMainDoor(string sEstateTag);
string GetEstateWorkDoor(string sEstateTag);
string GetEstateRoomDoor(string sEstateTag);
string GetEstateName(string sEstateTag);
int GetIsEstateFree(string sEstateTag);
int GetIsEstateOwner(string sEstateTag, object oPlayer);
int GetIsEstateMasterOwner(string sEstateTag, object oPlayer);
string GetEstateOwnerCharacterName(string sEstate);
string GetEstateOwnerGUID(string sEstate);
string GetEstateOwnerTAG(string sEstate);
int GetEstatePrice(string sEstate);
int GetEstateBuyPrice(string sEstate);
void SellEstate(string sEstateTag, object oPlayer);
void BuyEstate(string sEstateTag, object oPlayer);


// konverzace s NPC
int GetNumbersEstatesOwning(object oPlayer);
void AddEstateUser(string sEstateTag, string sGUID, string sTAG);

string GetEstateControlTag(int iNumber, object oOwningPlayer);

string GetPlayerName(string sGUID);
string GetCharacterName(string sGUID);

void RenameEstate(string sEstateTag, string sNewName);
string GetCharacterOwnerGUID(int iNumber, string sEstateTag);
int GetEstateOwnersNumbers(string sEstateTag);
void DeleteEstateUser(string sEstateTag, string sGUID, string sTAG);
string GetOwningEstatesList(object oPlayer);

string GetEstateEmergencyWay(string sEstateTag)
{
    sEstateTag  = SQLEncodeSpecialChars(sEstateTag);
    string sSQL = "SELECT EmergencyWayTag FROM " + TABLE_PROPERTY_ESTATES
        + " WHERE EstateControlTag = '" + sEstateTag + "'";

    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS)
        return SQLDecodeSpecialChars(SQLGetData(1));
    else return "";
}
string GetEstateInnerMainDoor(string sEstateTag)
{
    sEstateTag  = SQLEncodeSpecialChars(sEstateTag);
    string sSQL = "SELECT InnerMainDoorTag FROM " + TABLE_PROPERTY_ESTATES
        + " WHERE EstateControlTag = '" + sEstateTag + "'";

    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS)
        return SQLGetData(1);
    else return "";
}
string GetEstateOuterMainDoor(string sEstateTag)
{
    sEstateTag  = SQLEncodeSpecialChars(sEstateTag);
    string sSQL = "SELECT OuterMainDoorTag FROM " + TABLE_PROPERTY_ESTATES
        + " WHERE EstateControlTag = '" + sEstateTag + "'";

    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS)
        return SQLGetData(1);
    else return "";
}
string GetEstateWorkDoor(string sEstateTag)
{
    sEstateTag  = SQLEncodeSpecialChars(sEstateTag);
    string sSQL = "SELECT WorkShopDoorTag FROM " + TABLE_PROPERTY_ESTATES
        + " WHERE EstateControlTag = '" + sEstateTag + "'";

    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS)
        return SQLDecodeSpecialChars(SQLGetData(1));
    else return "";
}
string GetEstateRoomDoor(string sEstateTag)
{
    sEstateTag  = SQLEncodeSpecialChars(sEstateTag);
    string sSQL = "SELECT RoomDoorTag FROM " + TABLE_PROPERTY_ESTATES
        + " WHERE EstateControlTag = '" + sEstateTag + "'";

    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS)
        return SQLDecodeSpecialChars(SQLGetData(1));
    else return "";
}
string GetEstateName(string sEstateTag)
{
    sEstateTag  = SQLEncodeSpecialChars(sEstateTag);
    string sSQL = "SELECT EstateName FROM " + TABLE_PROPERTY_ESTATES
        + " WHERE EstateControlTag = '" + sEstateTag + "'";

    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS)
        return SQLDecodeSpecialChars(SQLGetData(1));
    else return "";
}
int GetIsEstateFree(string sEstateTag)
{
    sEstateTag  = SQLEncodeSpecialChars(sEstateTag);
    string sSQL = "SELECT Count(GUID) FROM " + TABLE_PROPERTY_ESTATES_OWNERS
        + " WHERE Type = 'Master' AND EstateControlTag = '" + sEstateTag + "'";

    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS)
    {
        int iTemp = StringToInt(SQLDecodeSpecialChars(SQLGetData(1)));
        if (iTemp > 0) return 0; else return 1;
    }
    else return 0;
}
int GetIsEstateOwner(string sEstateTag, object oPlayer)
{
    sEstateTag  = SQLEncodeSpecialChars(sEstateTag);
    string sSQL = "SELECT COUNT(*) FROM " + TABLE_PROPERTY_ESTATES_OWNERS
        + " WHERE EstateControlTag = '" + sEstateTag + "'"
        + " AND GUID = " + GetCharacterGUID(oPlayer);

    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS)
    {
        int iTemp = StringToInt(SQLGetData(1));
        if (iTemp > 0) return 1; else return 0;
    }
    else return 0;
}
int GetIsEstateMasterOwner(string sEstateTag, object oPlayer)
{
    sEstateTag  = SQLEncodeSpecialChars(sEstateTag);
    string sSQL = "SELECT COUNT(*) as pocet FROM " + TABLE_PROPERTY_ESTATES_OWNERS
        + " WHERE Type = 'Master' AND EstateControlTag = '" + sEstateTag + "'"
        + " AND GUID = " + GetCharacterGUID(oPlayer);

    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS)
    {
        int iTemp = StringToInt(SQLGetData(1));
        if (iTemp > 0) return 1; else return 0;
    }
    else return 0;
}
string GetEstateOwnerCharacterName(string sEstateTag)
{
    string sSQL = "SELECT CharacterName FROM " + TABLE_PROPERTY_ESTATES_OWNERS
        + " WHERE Type = 'Master' AND EstateControlTag = '" + sEstateTag + "'";

    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS) return SQLGetData(1);
    else return "";
}
string GetEstateOwnerGUID(string sEstateTag)
{
    sEstateTag  = SQLEncodeSpecialChars(sEstateTag);
    string sSQL = "SELECT GUID FROM " + TABLE_PROPERTY_ESTATES_OWNERS
        + " WHERE Type = 'Master' AND EstateControlTag = '" + sEstateTag + "'";

    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS) return SQLDecodeSpecialChars(SQLGetData(1));
    else return "";
}
string GetEstateOwnerTAG(string sEstateTag)
{
    sEstateTag  = SQLEncodeSpecialChars(sEstateTag);
    string sSQL = "SELECT CharacterTag FROM " + TABLE_PROPERTY_ESTATES_OWNERS
        + " WHERE Type = 'Master' AND EstateControlTag = '" + sEstateTag + "'";

    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS) return SQLDecodeSpecialChars(SQLGetData(1));
    else return "";
}
int GetEstatePrice(string sEstateTag)
{
    sEstateTag  = SQLEncodeSpecialChars(sEstateTag);
    string sSQL = "SELECT SellCost FROM " + TABLE_PROPERTY_ESTATES
        + " WHERE EstateControlTag = '" + sEstateTag + "'";

    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS) return StringToInt(SQLDecodeSpecialChars(SQLGetData(1)));
    else return 0;
}
int GetEstateBuyPrice(string sEstateTag)
{
    sEstateTag  = SQLEncodeSpecialChars(sEstateTag);
    string sSQL = "SELECT PurchaseCost FROM " + TABLE_PROPERTY_ESTATES
        + " WHERE EstateControlTag = '" + sEstateTag + "'";

    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS) return StringToInt(SQLDecodeSpecialChars(SQLGetData(1)));
    else return 0;
}
void SellEstate(string sEstateTag, object oPlayer)
{
    if (!GetIsPC(oPlayer)) return;

    sEstateTag  = SQLEncodeSpecialChars(sEstateTag);
    string sSQL = "DELETE FROM " + TABLE_PROPERTY_ESTATES_OWNERS
        + " WHERE Type = 'Master' AND EstateControlTag = '" + sEstateTag + "'"
        + " AND GUID = " + GetCharacterGUID(oPlayer);

    SQLExecDirect(sSQL);
}
void BuyEstate(string sEstateTag, object oPlayer)
{
    if (!GetIsPC(oPlayer)) return;

    sEstateTag  = SQLEncodeSpecialChars(sEstateTag);
    string sGUID = GetCharacterGUID(oPlayer);
    string sTag = GetCharacterTag(oPlayer);
    string sCharacterName = SQLEncodeSpecialChars(GetName(oPlayer));
    string sPlayerName = SQLEncodeSpecialChars(GetPCPlayerName(oPlayer));

    string sSQL = "DELETE FROM " + TABLE_PROPERTY_ESTATES_OWNERS
            + " WHERE GUID = " + sGUID
            + " AND EstateControlTag = '" + sEstateTag + "'"
            + " AND Type = 'Slave'";
    SQLExecDirect(sSQL);

    sSQL = "INSERT INTO " + TABLE_PROPERTY_ESTATES_OWNERS
            + " (GUID,CharacterTag,EstateControlTag,Type,CharacterName,PlayerName) VALUES"
            + " (" + sGUID + "," + sTag + ",'" + sEstateTag + "','Master'"
            + ",'" + sCharacterName + "','" + sPlayerName + "')";
    SQLExecDirect(sSQL);
}

// konverzace s NPC
int GetNumbersEstatesOwning(object oPlayer)
{
    string sSpeakerGUID;
    if (GetIsPC(oPlayer))
    {
        sSpeakerGUID = GetCharacterGUID(oPlayer);
    }
    else return 0;

    string sSQL;
    sSQL = "SELECT COUNT(GUID) FROM " + TABLE_PROPERTY_ESTATES_OWNERS
            + " WHERE GUID = " + sSpeakerGUID
            + " AND Type = 'Master'";

    SQLExecDirect(sSQL);
    while (SQLFetch() == SQL_SUCCESS)
    {
        return StringToInt(SQLGetData(1));
    }
    return 0;
}
void AddEstateUser(string sEstateTag, string sGUID, string sTag)
{
    sEstateTag  = SQLEncodeSpecialChars(sEstateTag);

    string sCharacterName = GetCharacterName(sGUID);
    string sPlayerName = GetPlayerName(sGUID);

    string sSQL = "INSERT INTO " + TABLE_PROPERTY_ESTATES_OWNERS
            + " (GUID,CharacterTag,EstateControlTag,Type,CharacterName,PlayerName) VALUES"
            + " ('" + sGUID + "','" + sTag + "','" + sEstateTag + "','Slave'"
            + ",'" + sCharacterName + "','" + sPlayerName + "')";
    SQLExecDirect(sSQL);
}
string GetEstateControlTag(int iNumber, object oOwningPlayer)
{
    string sSpeakerGUID;
    if (GetIsPC(oOwningPlayer))
    {
        sSpeakerGUID = GetCharacterGUID(oOwningPlayer);
    }
    else return "";

    string sSQL;
    sSQL = "SELECT EstateControlTag FROM " + TABLE_PROPERTY_ESTATES_OWNERS
            + " WHERE GUID = " + sSpeakerGUID
            + " AND Type = 'Master'";

    int iTemp = 1;
    SQLExecDirect(sSQL);
    while (SQLFetch() == SQL_SUCCESS)
    {
        if (iTemp == iNumber)
        {
            return SQLGetData(1);
        }
        iTemp++;
    }
    return "";
}
string GetCharacterName(string sGUID)
{
    string sSQL;
    sSQL = "SELECT CharacterName FROM " + TABLE_CHARACTERS
            + " WHERE GUID = '" + sGUID + "'";
    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS)
    {
        return SQLGetData(1);
    }
    return "";
}
string GetPlayerName(string sGUID)
{
    string sSQL;
    sSQL = "SELECT PlayerName FROM " + TABLE_CHARACTERS
            + " WHERE GUID = '" + sGUID + "'";
    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS)
    {
        return SQLGetData(1);
    }
    return "";
}
void RenameEstate(string sEstateTag, string sNewName)
{
    string sSQL = "UPDATE " + TABLE_PROPERTY_ESTATES
       + " SET EstateName = '" + sNewName + "'"
       + " WHERE EstateControlTag = '" + sEstateTag + "'";

    SQLExecDirect(sSQL);
}
// filtrovany seznam postav
string GetCharacterOwnerGUID(int iNumber, string sEstateTag)
{
    string sSQL;
    sSQL = "SELECT GUID FROM " + TABLE_PROPERTY_ESTATES_OWNERS
            + " WHERE EstateControlTag = '" + sEstateTag + "'"
            + " AND Type != 'Master'";

    int iTemp = 1;
    SQLExecDirect(sSQL);
    while (SQLFetch() == SQL_SUCCESS)
    {
        if (iTemp == iNumber)
        {
            return SQLGetData(1);
        }
        iTemp++;
    }
    return "";
}
// filtrovany seznam postav
int GetEstateOwnersNumbers(string sEstateTag)
{
    string sSQL;
    sSQL = "SELECT COUNT(GUID) FROM " + TABLE_PROPERTY_ESTATES_OWNERS
            + " WHERE EstateControlTag = '" + sEstateTag + "'"
            + " AND Type != 'Master'";
    SQLExecDirect(sSQL);
    while (SQLFetch() == SQL_SUCCESS)
    {
        return StringToInt(SQLGetData(1));
    }
    return 0;
}
void DeleteEstateUser(string sEstateTag, string sGUID, string sTAG)
{
    sEstateTag  = SQLEncodeSpecialChars(sEstateTag);

    string sSQL = "DELETE FROM " + TABLE_PROPERTY_ESTATES_OWNERS
            + " WHERE GUID = '" + sGUID + "'"
            + " AND EstateControlTag = '" + sEstateTag + "'";
    SQLExecDirect(sSQL);
}
string GetOwningEstatesList(object oPlayer)
{
    string sSpeakerGUID;
    if (GetIsPC(oPlayer))
    {
        sSpeakerGUID = GetCharacterGUID(oPlayer);
    }
    else return "";

    string sSQL;
    sSQL = "SELECT e.EstateName, e.PurchaseCost FROM " + TABLE_PROPERTY_ESTATES_OWNERS + " eo "
            + " JOIN " + TABLE_PROPERTY_ESTATES + " e ON e.EstateControlTag = eo.EstateControlTag "
            + " WHERE eo.GUID = " + sSpeakerGUID
            + " AND eo.Type = 'Master'";

    string sTemp;
    string sReturn;
    SQLExecDirect(sSQL);
    while (SQLFetch() == SQL_SUCCESS)
    {
        sReturn = sTemp + SQLGetData(1) + "(" + SQLGetData(2) + ")";
        sTemp = ", ";
    }
    return sReturn;
}
