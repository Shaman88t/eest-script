// Authors  : TondaLee (AV) - Antonin Vins
// Created  : 05/2005
// Modified : 05/06/2005

#include "_inc_nwnx_db"
#include "_inc_config"

// Skills
string GetSkillName(string sSkillID); //vrati nazev skillu

// Charakter Skills
int GetCharacterSkill(object oPlayer, string sSkillID);
void SetCharacterSkill(object oPlayer, string sSkillID, int iSkillValue);
void DeleteCharacterSkill(object oPlayer, string sSkillID);
string GetSkillList(object oPlayer);
int GetNumberSkills(object oPlayer);

// vrati seznam postav, ktera umi dany skill
string GetSkillCharactersList(string sSkillID);

// vrati seznam pozadavku na dany skill
string GetSkillRequirementsList(string sSkillID);

// ma postava vlastnosti na nauceni noveho skillu?
int HasPlayerRequirements(object oPlayer, string sSkillID);


// ********************************************************
// Skills
// vrati nazev skillu
string GetSkillName(string sSkillID)
{
    sSkillID  = SQLEncodeSpecialChars(sSkillID);

    string sSQL = "SELECT SkillName FROM " + TABLE_SKILLS
        + " WHERE SkillID = '" + sSkillID + "'";

    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS)
        return SQLDecodeSpecialChars(SQLGetData(1));
    else
    {
        return ""; //neumi skill
    }
}
// Character Skills
int GetCharacterSkill(object oPlayer, string sSkillID)
{
    string sGUID;
    string sTag;

    if (GetIsPC(oPlayer))
    {
        sGUID = GetCharacterGUID(oPlayer);
        sTag  = GetCharacterTag(oPlayer);
    }
    else
    {
        return 0; //neumi skill
    }

    int iSkillValue;
    sSkillID  = SQLEncodeSpecialChars(sSkillID);

    string sSQL = "SELECT SkillValue FROM " + TABLE_CHARACTERS_SKILLS
        + " WHERE GUID = " + sGUID
        + " AND CharacterTag = " + sTag
        + " AND SkillID = '" + sSkillID + "'";

    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
        iSkillValue = StringToInt(SQLEncodeSpecialChars(SQLGetData(1)));
    else
    {
        iSkillValue = 0; //neumi skill
    }
    return iSkillValue;
}
void SetCharacterSkill(object oPlayer, string sSkillID, int iSkillValue)
{
    string sGUID;
    string sTag;
    string sSkillValue;
    string sPlayerName;
    string sCharacterName;

    if (GetIsPC(oPlayer))
    {
        sGUID = GetCharacterGUID(oPlayer);
        sTag  = GetCharacterTag(oPlayer);
        sSkillValue =IntToString(iSkillValue);
        sPlayerName = GetPCPlayerName(oPlayer);
        sCharacterName = GetName(oPlayer);
    }
    else
    {
        return;
    }
    sSkillID  = SQLEncodeSpecialChars(sSkillID);
    sSkillValue  = SQLEncodeSpecialChars(sSkillValue);
    sPlayerName = SQLEncodeSpecialChars(sPlayerName);
    sCharacterName = SQLEncodeSpecialChars(sCharacterName);

    string sSQL = "SELECT GUID FROM " + TABLE_CHARACTERS_SKILLS
            + " WHERE GUID = " + sGUID
            + " AND CharacterTag = " + sTag
            + " AND SkillID = '" + sSkillID + "'";

    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
    {
        // row exists
        sSQL = "UPDATE " + TABLE_CHARACTERS_SKILLS
            + " SET SkillValue = '" + sSkillValue + "',"
            + " CharacterName = '" + sCharacterName + "', PlayerName = '" + sPlayerName + "'"
            + " WHERE GUID = " + sGUID
            + " AND CharacterTag = " + sTag
            + " AND SkillID = '" + sSkillID + "'";

        SQLExecDirect(sSQL);
    }
    else
    {
        // row doesn't exist
        sSQL = "INSERT INTO " + TABLE_CHARACTERS_SKILLS
            + " (GUID,CharacterTag,SkillID,SkillValue,CharacterName,PlayerName) VALUES"
            + " (" + sGUID + "," + sTag + ",'" + sSkillID + "','" + sSkillValue
            + "','" + sCharacterName + "','" + sPlayerName + "')";
        SQLExecDirect(sSQL);
    }
}
void DeleteCharacterSkill(object oPlayer, string sSkillID)
{
    string sGUID;
    string sTag;

    if (GetIsPC(oPlayer))
    {
        sGUID = GetCharacterGUID(oPlayer);
        sTag  = GetCharacterTag(oPlayer);
    }
    else
    {
        return;
    }
    string sSQL = "DELETE FROM " + TABLE_CHARACTERS_SKILLS
        + " WHERE GUID = " + sGUID
        + " AND CharacterTag = " + sTag
        + " AND SkillID = '" + sSkillID + "'";

    SQLExecDirect(sSQL);
}

// vytvori textovy seznam skillu a jejich hodnot
string GetSkillList(object oPlayer)
{
    string sGUID;
    string sTag;

    if (GetIsPC(oPlayer))
    {
        sGUID = GetCharacterGUID(oPlayer);
        sTag  = GetCharacterTag(oPlayer);
    }
    else
    {
        return ""; //neumi skill
    }

    string sSQL = "SELECT ts.SkillName, chs.SkillValue FROM " + TABLE_CHARACTERS_SKILLS + " chs "
        + " JOIN " + TABLE_SKILLS + " ts ON ts.SkillID = chs.SkillID "
        + " WHERE chs.GUID=" + sGUID
        + " AND chs.CharacterTag = " + sTag;

    SQLExecDirect(sSQL);
    string sReturn;
    while (SQLFetch() == SQL_SUCCESS)
    {
        string sSkillName = SQLDecodeSpecialChars(SQLGetData(1));
        string sSkillValue = SQLDecodeSpecialChars(SQLGetData(2));
        sReturn+=sSkillName + "(" + sSkillValue + "), ";
    }
    return sReturn;
}
// vrati pocet naucenych skillu dane postavy
int GetNumberSkills(object oPlayer)
{
    string sGUID;
    string sTag;

    if (GetIsPC(oPlayer))
    {
        sGUID = GetCharacterGUID(oPlayer);
        sTag  = GetCharacterTag(oPlayer);
    }
    else
    {
        return 0; //neumi skill
    }
    string sSQL = "SELECT COUNT(SkillID) FROM " + TABLE_CHARACTERS_SKILLS
        + " WHERE GUID=" + sGUID
        + " AND CharacterTag = " + sTag;
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
        return StringToInt(SQLDecodeSpecialChars(SQLGetData(1)));
    else
    {
        return 0; //neumi zadny skill
    }
}
// vrati seznam postav, ktera umi dany skill
string GetSkillCharactersList(string sSkillID)
{
    sSkillID  = SQLEncodeSpecialChars(sSkillID);
    if (sSkillID == "") return "";

    string sReturn = "";
    string sTemp = "";

    string sSQL = "SELECT CharacterName FROM " + TABLE_CHARACTERS_SKILLS
        + " WHERE SkillID = '" + sSkillID + "'";
    SQLExecDirect(sSQL);
    while (SQLFetch() == SQL_SUCCESS)
    {
        sReturn+= (sTemp + SQLDecodeSpecialChars(SQLGetData(1)));
        sTemp = ",";
    }
    return sReturn;
}
// vrati seznam pozadavku na dany skill
string GetSkillRequirementsList(string sSkillID)
{
    sSkillID  = SQLEncodeSpecialChars(sSkillID);
    string sReturn = "";
    string sTemp = "";

    string sSQL = "SELECT ReqStr, ReqCon, ReqDex, ReqInt, ReqWis, ReqCha FROM " + TABLE_SKILLS
        + " WHERE SkillID = '" + sSkillID + "'";

    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
    {
        sTemp = SQLGetData(1);
        if (sTemp != "") sReturn = "Sila(" + sTemp + ")";
        sTemp = SQLGetData(2);
        if (sTemp != "")
        {
            if (sReturn != "") sReturn+=",";
            sReturn+= "Odolnost(" + sTemp + ")";
        }
        sTemp = SQLGetData(3);
        if (sTemp != "")
        {
            if (sReturn != "") sReturn+=",";
            sReturn+= "Obratnost(" + sTemp + ")";
        }
        sTemp = SQLGetData(4);
        if (sTemp != "")
        {
            if (sReturn != "") sReturn+=",";
            sReturn+= "Inteligence(" + sTemp + ")";
        }
        sTemp = SQLGetData(5);
        if (sTemp != "")
        {
            if (sReturn != "") sReturn+=",";
            sReturn+= "Moudrost(" + sTemp + ")";
        }
        sTemp = SQLGetData(6);
        if (sTemp != "")
        {
            if (sReturn != "") sReturn+=",";
            sReturn+= "Vzhled(" + sTemp + ")";
        }
    }
    return sReturn;
}

// zjisti zda ma postava potrebne vlastnosti na nauceni skillu
int HasPlayerRequirements(object oPlayer, string sSkillID)
{
    sSkillID  = SQLEncodeSpecialChars(sSkillID);
    int iMinStr, iMinCon, iMinDex, iMinInt, iMinWis, iMinCha;

    string sSQL = "SELECT ReqStr, ReqCon, ReqDex, ReqInt, ReqWis, ReqCha FROM " + TABLE_SKILLS
        + " WHERE SkillID = '" + sSkillID + "'";

    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS)
    {
        string sTemp = SQLGetData(1);
        if (sTemp == "") iMinStr = 0; else iMinStr = StringToInt(sTemp);
        sTemp = SQLGetData(2);
        if (sTemp == "") iMinCon = 0; else iMinCon = StringToInt(sTemp);
        sTemp = SQLGetData(3);
        if (sTemp == "") iMinDex = 0; else iMinDex = StringToInt(sTemp);
        sTemp = SQLGetData(4);
        if (sTemp == "") iMinInt = 0; else iMinInt = StringToInt(sTemp);
        sTemp = SQLGetData(5);
        if (sTemp == "") iMinWis = 0; else iMinWis = StringToInt(sTemp);
        sTemp = SQLGetData(6);
        if (sTemp == "") iMinCha = 0; else iMinCha = StringToInt(sTemp);
    }
    else
    {
        return 0;
    }
    if (GetAbilityScore(oPlayer, ABILITY_STRENGTH) < iMinStr) return 0;
    if (GetAbilityScore(oPlayer, ABILITY_CONSTITUTION) < iMinCon) return 0;
    if (GetAbilityScore(oPlayer, ABILITY_DEXTERITY) < iMinDex) return 0;
    if (GetAbilityScore(oPlayer, ABILITY_INTELLIGENCE) < iMinInt) return 0;
    if (GetAbilityScore(oPlayer, ABILITY_WISDOM) < iMinWis) return 0;
    if (GetAbilityScore(oPlayer, ABILITY_CHARISMA) < iMinCha) return 0;

    sSQL = "SELECT SkillGroup FROM " + TABLE_SKILLS + " where SkillID = '" +sSkillID + "'";
    SQLExecDirect(sSQL);
    string sSkillGroup;
    if (SQLFetch() == SQL_SUCCESS) sSkillGroup = SQLGetData(1);

    sSQL = "SELECT Count(*) FROM " + TABLE_SKILLS + " s "
        + " JOIN " + TABLE_CHARACTERS_SKILLS + " chs ON chs.SkillID = s.SkillID"
        + " WHERE s.SkillGroup = " + sSkillGroup;
    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS) if (StringToInt(SQLGetData(1)) > 0) return 0;

    return 1;
}

