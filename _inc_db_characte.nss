// Authors  : TondaLee (AV) - Antonin Vins
// Created  : 05/2005
// Modified : 17/06/2005

#include "_inc_config"
#include "_inc_nwnx_db"

// Character variables (tabulka 'characters variables')
// ukladani
void SetCharacterString(object oPlayer, string sVariableName, string sVariableValue, int iExpiration =0);
void SetCharacterFloat(object oPlayer, string sVariableName, float fVariableValue, int iExpiration = 0);
void SetCharacterInt(object oPlayer, string sVariableName, int iVariableValue, int iExpiration = 0);
void SetCharacterCDKeyValue(object oPlayer, string sCDKey);
// nacitani
string GetCharacterString(object oPlayer, string sName);
float  GetCharacterFloat(object oPlayer, string sName);
int    GetCharacterInt(object oPlayer, string sName);
string GetCharacterCDKeyValue(object oPlayer);
// smaze danou promenou z DB
void DeleteCharacterVariable(object oPlayer, string sName);
// nacitani a ukladani karmy
int  GetCharacterKarma(object oPlayer);
void SetCharacterKarma(object oPlayer, int iKarmaValue);
// nacitani a ukladani stavu hitpointu
int  LoadCharacterHP(object oPlayer);
void SaveCharacterHP(object oPlayer); //ulozi aktualni stav HP do DB
// system xp za prieskum sveta
void GiveXpFromExploring(object oArea, object oPC);

// Charakters (tabulka 'characters')
// logovani a od-logovani hrace
void CharacterLogin(object oPlayer, int nLoginTime = TRUE);
void CharacterLogout(object oPlayer);
void CharacterLogoutForAll();
// nahravani a ukladani pozice hrace
void CharacterLoadLocation(object oPlayer);
void CharacterSaveLocation(object oPlayer);
void CharacterSaveLocationForAll();
// ulozeni a nacteni RespawPointu
void CharacterSaveRespawnPoint(object oPlayer, string sWayPointTag);
void CharacterLoadRespawnPoint(object oPlayer);
void CharacterLoadStaritngPoint(object oPlayer, int nSummonEffect = FALSE);
void CharacterDeleteRespawnPoint(object oPlayer);
void CharacterDeleteLocation(object oPlayer);

// smaze veskere zaznamy o postave ze vsech tabulek!!!!
void DeleteCharacterTotal(object oPlayer);

// Characters stored object (stejnojmena tabulka)
object GetCharacterStoredObject(object oPlayer, int iStoredObjectIndex, object oOwnerObject);
void SetCharacterStoredObject(object oPlayer, int iStoredObjectIndex, string sOwnerObjectTag, object oStoredObject);
void DeleteCharacterStoredObject(object oPlayer, int iStoredObjectIndex, string sOwnerObjectTag);
void DeleteCharacterAllStoredObject(object oPlayer, string sOwnerObjectTag);

// zobrazi zpravy od DM
void ShowDMMessages(object oPlayer);
// vrati datum vzniku postavy
string GetCharacterDateCreation(object oPlayer);


// filtrovany seznam postav
string GetCharacterListGUID(int iNumber, string sFilter, object oPlayer);
string GetCharacterListTag(int iNumber, string sFilter, object oPlayer);
string GetCharacterListName(string sGUID);
string GetCharacterListType(string sGUID);
string GetPlayerListName(string sGUID);
int GetCharacterListNumbers(string sFilter, object oPlayer);

string GetStoredCharacterItemsList(object oPlayer);

int GetCharacterFaitigure(object oPlayer);
void SetCharacterFaitigure(object oPlayer, int iFaitigure);
int IsSubraceUnderGround(string sSubrace);

// Characters stored items (stejnojmena tabulka)
object GetCharacterStoredItems(object oPlayer, int iStoredObjectIndex, object oOwnerObject);
void SetCharacterStoredItems(object oPlayer, int iStoredObjectIndex, string sOwnerObjectTag, object oStoredObject);
void DeleteCharacterStoredItems(object oPlayer, int iStoredObjectIndex, string sOwnerObjectTag);
void DeleteCharacterAllStoredItems(object oPlayer, string sOwnerObjectTag);

// Bezpecnostny system kvoli hackingu postav
int GetIsCharacterLegal(object oPlayer);
void SetCharacterAsLegal(object oPlayer);
void SetCharacterAsIlegal(object oPlayer);
int GetCharacterLegalStatus(object oPlayer);
int IlegalCharacterMoveToTemporaryLocation(object oPlayer);

// Riadenie banov

// Plati OR logika ale aspon jedna polozka musi byt zadana inak je automaticky FALSE
// Vrati TRUE ak zadany acc PlayerName, IPAdresa alebo CDKluc ma ban a tento nevyprsal
int GetBanValue(string PlayerName = "", string IPAddres = "", string CDKey = "");

// Nastavy BanExpiration pre zadane PlayerName, IPAddres a CDKey kde plati AND logika pokial zaznam uz existuje
// Nastavenie BanExpiration na "0000-00-00" ma za nasledok zmazanie zaznamu s banom
int SetBanValue(string PlayerName = "", string IPAddres = "", string CDKey = "", string BanExpiration = "0000-00-00");

// Nastavy BanExpiration pre konkretne ID zaznau, hodnota 0000-00-00 znamena okamzite zrusenie banu
int SetBanExpirationByID(string sID, string BanExpiration = "0000-00-00");

// Prepne status banu podla ID
int SwitchBanStatusByID(string sID);

// Vykona Ban proceduru na hracovi oPlayer
void BanExecute(object oPlayer);

// Prejde vsetkych hracov a skontroluje ich bany
void CheckBanForAll();

// Vrati tabulku banov alebo spravu o neexistujucich banoch
string GetBanEditTable();

// nastavy HP na postave
void SetPlayerHitPoints(object oPlayer, int iHitPoints);

// sporiaci ucet
void CharacterUpdateSaveBillForAll(float fModifier);

// Riadenie pokladov

// Nastavi cas kedy bol otvoreny poklad
void CharacterSetOpenTime(object oPC);

// Vrati TRUE ak je mozne vygenerovat novy poklad
int CharacterTreasureOpening(object oPC, int nTimeOut);

// Character Variable
// ukladani promenych postavy do DB
void SetCharacterString(object oPlayer, string sVariableName, string sVariableValue, int iExpiration =0)
{
    string sGUID;
    string sTag;
    string sPlayerName;
    string sCharacterName;

    if (GetIsPC(oPlayer))
    {
        sGUID = GetCharacterGUID(oPlayer);
        sTag  = GetCharacterTag(oPlayer);
        sPlayerName = GetPCPlayerName(oPlayer);
        sCharacterName = GetName(oPlayer);
    }
    else return;

    sVariableName  = SQLEncodeSpecialChars(sVariableName);
    sVariableValue = SQLEncodeSpecialChars(sVariableValue);
    sPlayerName =SQLEncodeSpecialChars(sPlayerName);
    sCharacterName =SQLEncodeSpecialChars(sCharacterName);

    string sSQL = "SELECT GUID FROM " + TABLE_CHARACTERS_VARIABLES
            + " WHERE GUID = " + sGUID
            + " AND CharacterTag = " + sTag
            + " AND VariableName = '" + sVariableName + "'";

    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
    {
        sSQL = "UPDATE " + TABLE_CHARACTERS_VARIABLES
            + " SET VariableValue='" + sVariableValue + "' , Expiration=" + IntToString(iExpiration) + ", "
            + " CharacterName = '" + sCharacterName + "', PlayerName = '" + sPlayerName + "'"
            + " WHERE GUID = " + sGUID
            + " AND CharacterTag = " + sTag + ""
            + " AND VariableName = '" + sVariableName + "'";
        SQLExecDirect(sSQL);
    }
    else
    {
        sSQL = "INSERT INTO " + TABLE_CHARACTERS_VARIABLES
            + " (GUID,CharacterTag,VariableName,VariableValue,Expiration,CharacterName,PlayerName) VALUES"
            + " (" + sGUID + "," + sTag + ",'" + sVariableName + "','" + sVariableValue + "'," + IntToString(iExpiration)
            + ",'" + sCharacterName + "', '" + sPlayerName + "')";
        SQLExecDirect(sSQL);
    }
}
void SetCharacterFloat(object oPlayer, string sVariableName, float fVariableValue, int iExpiration = 0)
{
    SetCharacterString(oPlayer, sVariableName, FloatToString(fVariableValue), iExpiration);
}
void SetCharacterInt(object oPlayer, string sVariableName, int iVariableValue, int iExpiration = 0)
{
    SetCharacterString(oPlayer, sVariableName, IntToString(iVariableValue), iExpiration);
}
// nacitani promenych z DB
string GetCharacterString(object oPlayer, string sVariableName)
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
        return "";
    }
    sVariableName  = SQLEncodeSpecialChars(sVariableName);

    string sSQL = "SELECT VariableValue FROM " + TABLE_CHARACTERS_VARIABLES
        + " WHERE GUID=" + sGUID
        + " AND CharacterTag = " + sTag + ""
        + " AND VariableName= '" + sVariableName + "'";

    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS)
        return SQLDecodeSpecialChars(SQLGetData(1));
    else return "";
}
float GetCharacterFloat(object oPlayer, string sVariableName)
{
    return StringToFloat(GetCharacterString(oPlayer, sVariableName));
}
int GetCharacterInt(object oPlayer, string sVariableName)
{
    int iReturnValue;
    string sReturnValue = GetCharacterString(oPlayer, sVariableName);
    if (sReturnValue == "") iReturnValue = 0;
    else iReturnValue = StringToInt(sReturnValue);

    return iReturnValue;
}
// vymaze promenou postavy z DB
void DeleteCharacterVariable(object oPlayer, string sVariableName)
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
    sVariableName  = SQLEncodeSpecialChars(sVariableName);

    string sSQL = "DELETE FROM " + TABLE_CHARACTERS_VARIABLES
        + " WHERE GUID=" + sGUID
        + " AND CharacterTag = " + sTag
        + " AND VariableName = '" + sVariableName + "'";
    SQLExecDirect(sSQL);
}
// metody pro praci s Karmou
void SetCharacterKarma(object oPlayer, int iKarmaValue)
{
    SetCharacterInt(oPlayer, VARIABLE_CHARACTER_KARMA, iKarmaValue);
}
int GetCharacterKarma(object oPlayer)
{
    return GetCharacterInt(oPlayer, VARIABLE_CHARACTER_KARMA);
}
// metody pro praci s poctem HitPointu
int LoadCharacterHP(object oPlayer)
{
    int iHP = GetCharacterInt(oPlayer, VARIABLE_CHARACTER_HP);
    return iHP;
}
void SaveCharacterHP(object oPlayer)
{
    int iHp = GetCurrentHitPoints(oPlayer);
    SetCharacterInt(oPlayer, VARIABLE_CHARACTER_HP, iHp);
}

// Characters
void CharacterLogin(object oPlayer, int nLoginTime = TRUE)
{
    string sGUID;
    string sCHT;
    if (GetIsPC(oPlayer)) sGUID = GetCharacterGUID(oPlayer);
    else return;

    sCHT = GetCharacterTag(oPlayer);

    string sType="1";
    if (GetIsDM(oPlayer))
      sType="2";

    string sSQL = "SELECT GUID FROM " + TABLE_CHARACTERS
            + " WHERE GUID = " + sGUID + " AND PlayerName = '" + SQLEncodeSpecialChars(GetPCPlayerName(oPlayer)) + "'";
    SQLExecDirect(sSQL);

    if (SQLFetch() != SQL_SUCCESS)
    {
        sSQL = "INSERT INTO " + TABLE_CHARACTERS
            + " (GUID, MUID, Status, Type, CharacterName, PlayerName, DateCreation, PublicCDKey) VALUES"
            + " (" + sGUID + "," + GetModuleMUID() + ",'0','" + sType + "','" + SQLEncodeSpecialChars(GetName(oPlayer)) + "','" + SQLEncodeSpecialChars(GetPCPlayerName(oPlayer)) + "', NOW(),'" + GetPCPublicCDKey(oPlayer) + "')";

        SQLExecDirect(sSQL);
    }
    sSQL = "UPDATE " + TABLE_CHARACTERS
       + (nLoginTime ? " SET DateLastLogin = NOW() , " : "")
       + "Status = '1', "
       + " Type = '" + sType + "', "
       + " IPAdress = '" + GetPCIPAddress(oPlayer) + "'"
       + " WHERE GUID = " + sGUID + " AND PlayerName = '" + SQLEncodeSpecialChars(GetPCPlayerName(oPlayer)) + "'";

    SQLExecDirect(sSQL);

    if (!GetIsDM(oPlayer))
        sType = "player";
    else
        sType = "dungeon master";

    if (nLoginTime)
    {
        // Zapis do tabulky log_connections
         sSQL = "INSERT INTO log_connections (Type, PlayerName, CharacterName, IPAddress, CDKey, DateTime) VALUES"
        + "('LogIn as " + sType + "', '" + SQLEncodeSpecialChars(GetPCPlayerName(oPlayer)) + "', '" + SQLEncodeSpecialChars(GetName(oPlayer)) + "', '" + GetPCIPAddress(oPlayer) + "', '" + GetPCPublicCDKey(oPlayer) + "', NOW())";

        SQLExecDirect(sSQL);
    }
}

void CharacterLoginBack()
{
    object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC))
    {
        CharacterLogin(oPC, FALSE);
        oPC = GetNextPC();
    }
}

void CharacterLogout(object oPlayer)
{
    SaveCharacterHP(oPlayer);

    string sGUID;
    sGUID = GetCharacterGUID(oPlayer);

    string sSQL = "UPDATE " + TABLE_CHARACTERS
        + " SET DateLastLogout = NOW() , Status = '0'"
        + " WHERE GUID = " + sGUID + " AND Status = '1'";

     SQLExecDirect(sSQL);

    string sType;

    if (!GetIsDM(oPlayer))
        sType = "player";
    else
        sType = "dungeon master";

    // Zapis do tabulky log_connections
    sSQL = "INSERT INTO log_connections (Type, PlayerName, CharacterName, IPAddress, CDKey, DateTime) VALUES"
    + "('LogOut as " + sType + "', '" + SQLEncodeSpecialChars(GetPCPlayerName(oPlayer)) + "', '" + SQLEncodeSpecialChars(GetName(oPlayer)) + "', '" + GetPCIPAddress(oPlayer) + "', '" + GetPCPublicCDKey(oPlayer) + "', NOW())";

    SQLExecDirect(sSQL);

    DelayCommand(0.1, CharacterLoginBack());
}
void CharacterLogoutForAll()
{
    string sSQL = "UPDATE " + TABLE_CHARACTERS
        + " SET DateLastLogout = NOW() , Status = '0' WHERE Status = '1'" ;
     SQLExecDirect(sSQL);
}
// funkce pro praci s pozici
void CharacterLoadLocation(object oPlayer)
{
    string sLocation  = GetCharacterString(oPlayer, VARIABLE_CHARACTER_LOCATION);

    if (sLocation != "")
    {
        SendMessageToPC(oPlayer, TEXT_CHARACTER_POSITION_LOAD);
        AssignCommand(oPlayer, JumpToLocation(APSStringToLocation(sLocation)));
    }
    else
    {
        AssignCommand(oPlayer, JumpToLocation(GetStartingLocation()));
    }

    DelayCommand(1.0, SetPlayerHitPoints(oPlayer, LoadCharacterHP(oPlayer)));
}
void CharacterSaveLocation(object oPlayer)
{
    // Ak je postava legalna, ulozi jej polohu
    if (GetCharacterLegalStatus(oPlayer))
        SetCharacterString(oPlayer, VARIABLE_CHARACTER_LOCATION, APSLocationToString(GetLocation(oPlayer)));
}

int CharGetLevel(object oPC)
{
    return GetLevelByPosition(1, oPC) + GetLevelByPosition(2, oPC) + GetLevelByPosition(3, oPC);
}

void CharacterSaveLocationForAll()
{
  object oPlayer = OBJECT_INVALID;

  oPlayer = GetFirstPC();

  while (oPlayer != OBJECT_INVALID)
  {
    if (GetIsPC(oPlayer) && GetIsObjectValid(GetArea(oPlayer)))
    {
        CharacterSaveLocation(oPlayer);
        SaveCharacterHP(oPlayer);
        SendMessageToPC(oPlayer, TEXT_CHARACTER_POSITION_SAVED);
        SetCharacterInt(oPlayer, "CharPCLevel", CharGetLevel(oPlayer));
    }
    oPlayer = GetNextPC();
  }
}
// funkce pro praci s RespawnPointy
void CharacterSaveRespawnPoint(object oPlayer, string sWayPointTag)
{
    object wayPointObject = GetWaypointByTag(sWayPointTag);
    if (wayPointObject == OBJECT_INVALID)
    {
        return;
    }
    SetCharacterString(oPlayer,VARIABLE_CHARACTER_RESPAWN_POINT, sWayPointTag);
    SendMessageToPC(oPlayer, TEXT_CHARACTER_RESPAWNPOINT_SAVED);
}
void CharacterLoadRespawnPoint(object oPlayer)
{
    string sWayPointTag  = GetCharacterString(oPlayer,VARIABLE_CHARACTER_RESPAWN_POINT);
    object oWayPoint = GetWaypointByTag(sWayPointTag);

    effect eVisual2 = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    effect eVisual1 = EffectVisualEffect(VFX_IMP_LIGHTNING_M);

    if (sWayPointTag != "" && oWayPoint != OBJECT_INVALID)
    {
        SendMessageToPC(oPlayer, TEXT_CHARACTER_RESPAWNPOINT_LOAD);
        location lWayPoint = GetLocation(oWayPoint);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVisual1, lWayPoint);
        AssignCommand(oPlayer, JumpToLocation(lWayPoint));
        AssignCommand(oPlayer, ActionDoCommand(ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVisual2, lWayPoint)));
    }
    else
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVisual1, GetStartingLocation());
        AssignCommand(oPlayer, JumpToLocation(GetStartingLocation()));
        AssignCommand(oPlayer, ActionDoCommand(ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVisual2, GetStartingLocation())));
    }
}
void CharacterLoadStaritngPoint(object oPlayer, int nSummonEffect = FALSE)
{
    string sWayPointTag  = GetCharacterString(oPlayer,VARIABLE_CHARACTER_RESPAWN_POINT);
    object oWayPoint = GetWaypointByTag(sWayPointTag);

    effect eVisual2 = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    effect eVisual1 = EffectVisualEffect(VFX_IMP_LIGHTNING_M);

    location lWayPoint;

    if (sWayPointTag != "" && oWayPoint != OBJECT_INVALID)
    {
        SendMessageToPC(oPlayer, TEXT_CHARACTER_RESPAWNPOINT_LOAD);
        lWayPoint = GetLocation(oWayPoint);
    }
    else
    {
        string sStartingWayPoint = STARTING_WAYPOINT;
        string sSubRace = GetStringLowerCase(GetSubRace(oPlayer));

        if (GetRacialType(oPlayer) == RACIAL_TYPE_ELF) sStartingWayPoint = STARTING_WAYPOINT_WOOD;
        if (sSubRace == "") sStartingWayPoint = STARTING_WAYPOINT;

        if (IsSubraceUnderGround(GetSubRace(oPlayer)) == 1) sStartingWayPoint = STARTING_WAYPOINT_UNDERGROUND;

        lWayPoint = GetLocation(GetObjectByTag(sStartingWayPoint));
    }

    if (nSummonEffect)
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVisual1, lWayPoint);
        AssignCommand(oPlayer, JumpToLocation(lWayPoint));
        AssignCommand(oPlayer, ActionDoCommand(ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVisual2, lWayPoint)));
    }
    else
        AssignCommand(oPlayer, JumpToLocation(lWayPoint));
}
void CharacterDeleteRespawnPoint(object oPlayer)
{
    DeleteCharacterVariable(oPlayer, VARIABLE_CHARACTER_RESPAWN_POINT);
    SendMessageToPC(oPlayer, TEXT_CHARACTER_RESPAWNPOINT_DELETED);
}
void CharacterDeleteLocation(object oPlayer)
{
    DeleteCharacterVariable(oPlayer, VARIABLE_CHARACTER_LOCATION);
}

// smaze veskere zaznamy o postave ze vsech tabulek!!!!
void DeleteCharacterTotal(object oPlayer)
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
    string sSQL = "DELETE FROM " + TABLE_CHARACTERS_VARIABLES
        + " WHERE GUID=" + sGUID
        + " AND CharacterTag = " + sTag;
    SQLExecDirect(sSQL);

    sSQL = "DELETE FROM " + TABLE_CHARACTERS
        + " WHERE GUID=" + sGUID
        + " AND CharacterTag = " + sTag;
    SQLExecDirect(sSQL);

    sSQL = "DELETE FROM " + TABLE_CHARACTERS_QUESTS
        + " WHERE GUID=" + sGUID
        + " AND CharacterTag = " + sTag;
    SQLExecDirect(sSQL);

    sSQL = "DELETE FROM " + TABLE_CHARACTERS_SKILLS
        + " WHERE GUID=" + sGUID
        + " AND CharacterTag = " + sTag;
    SQLExecDirect(sSQL);

    sSQL = "DELETE FROM " + TABLE_CHARACTERS_STORED_OBJECTS
        + " WHERE GUID=" + sGUID
        + " AND CharacterTag = " + sTag;
    SQLExecDirect(sSQL);

    sSQL = "DELETE FROM " + TABLE_CHARACTERS_SCHEMATICS
        + " WHERE GUID=" + sGUID
        + " AND CharacterTag = " + sTag;
    SQLExecDirect(sSQL);

    sSQL = "DELETE FROM " + TABLE_MESSAGE_BOARD
        + " WHERE GUID=" + sGUID
        + " AND CharacterTag = " + sTag;
    SQLExecDirect(sSQL);
}



// nacte predmet z DB
object GetCharacterStoredObject(object oPlayer, int iStoredObjectIndex, object oOwnerObject)
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
        sGUID = "~";
        sTag = GetTag(oPlayer);
    }
    string sOwnerObjectTag = GetTag(oOwnerObject);
    sOwnerObjectTag = SQLEncodeSpecialChars(sOwnerObjectTag);

    string sSQL = "SELECT StackSize, OwnerObjectRes FROM " + TABLE_CHARACTERS_STORED_OBJECTS +
        " WHERE OwnerObjectTag = '" + sOwnerObjectTag + "'" +
        " AND StoredObjectIndex = 'Item_" + IntToString(iStoredObjectIndex) + "'";

    SQLExecDirect(sSQL);
    int nStackSize = 1;
    string sResref = "wambo";
    if (SQLFetch() == SQL_SUCCESS)
    {
        nStackSize = StringToInt(SQLGetData(1));
        sResref = SQLGetData(2);
    }

    sSQL = "SELECT StoredObject FROM " + TABLE_CHARACTERS_STORED_OBJECTS +
        " WHERE GUID = " + sGUID +
        " AND CharacterTag = " + sTag +
        " AND OwnerObjectTag = '" + sOwnerObjectTag + "'" +
        " AND StoredObjectIndex = 'Item_" + IntToString(iStoredObjectIndex) + "'";
    SetLocalString(GetModule(), "NWNX!ODBC!SETSCORCOSQL", sSQL);

    object oTemp;
    oTemp = RetrieveCampaignObject ("NWNX", "-", GetLocation(oPlayer), oOwnerObject);
    if (!GetIsObjectValid(oTemp))
    {
        oTemp = CreateItemOnObject(sResref, oOwnerObject, nStackSize);
    }

    return oTemp;
}
// ulozi predmet do DB - pouziva se v cyklu pro vsechny predmety v inventari (treba truhla)
void SetCharacterStoredObject(object oPlayer, int iStoredObjectIndex, string sOwnerObjectTag, object oStoredObject)
{
    string sGUID;
    string sTag;
    string sCharacterName;
    string sPlayerName;

    if (GetIsPC(oPlayer))
    {
        sGUID = GetCharacterGUID(oPlayer);
        sTag  = GetCharacterTag(oPlayer);
        sCharacterName = SQLEncodeSpecialChars(GetName(oPlayer));
        sPlayerName = SQLEncodeSpecialChars(GetPCPlayerName(oPlayer));
    }
    else
    {
        sGUID = "~";
        sTag = GetTag(oPlayer);
    }
    sOwnerObjectTag = SQLEncodeSpecialChars(sOwnerObjectTag);
    string sStoredObjectTag = GetTag(oStoredObject);
    string sStoredObjectName = SQLEncodeSpecialChars(GetName(oStoredObject));

    string sSQL = "SELECT GUID FROM " + TABLE_CHARACTERS_STORED_OBJECTS +
        " WHERE GUID = " + sGUID +
        " AND CharacterTag = " + sTag +
        " AND OwnerObjectTag = '" + sOwnerObjectTag + "'" +
        " AND StoredObjectIndex = 'Item_" + IntToString(iStoredObjectIndex) + "'";

    SQLExecDirect(sSQL);

    int nStackSize = GetItemStackSize(oStoredObject);
    if (SQLFetch() == SQL_SUCCESS)
    {
        sSQL = "UPDATE " + TABLE_CHARACTERS_STORED_OBJECTS + " SET StoredObject=%s, StackSize = '" + IntToString(nStackSize) + "', ObjectResRef = '" + GetResRef(oStoredObject) + "'" +
            " WHERE GUID = " + sGUID +
            " AND CharacterTag = " + sTag +
            " AND OwnerObjectTag = '" + sOwnerObjectTag + "'" +
            " AND StoredObjectIndex = 'Item_" + IntToString(iStoredObjectIndex) + "'";

        SetLocalString(GetModule(), "NWNX!ODBC!SETSCORCOSQL", sSQL);
        int nSuccess = StoreCampaignObject ("NWNX", "-", oStoredObject);
        if (nSuccess == 0)
        {
            sSQL = "UPDATE " + TABLE_CHARACTERS_STORED_OBJECTS + " SET StackSize = '" + IntToString(nStackSize) + "', ObjectResRef = '" + GetResRef(oStoredObject) + "'" +
            " WHERE GUID = " + sGUID +
            " AND CharacterTag = " + sTag +
            " AND OwnerObjectTag = '" + sOwnerObjectTag + "'" +
            " AND StoredObjectIndex = 'Item_" + IntToString(iStoredObjectIndex) + "'";
            SQLExecDirect(sSQL);
        }
    }
    else
    {
        sSQL = "INSERT INTO " + TABLE_CHARACTERS_STORED_OBJECTS +
            " (GUID,CharacterTag,OwnerObjectTag,StoredObjectIndex,StoredObject,StoredObjectTag,StoredObjectName,CharacterName,Playername,StackSize,ObjectResRef) VALUES"
            + "(" + sGUID + "," + sTag + ",'" + sOwnerObjectTag + "','" + "Item_" + IntToString(iStoredObjectIndex) + "',%s,"
            + "'" + sStoredObjectTag + "','" + sStoredObjectName + "','" + sCharacterName + "','" + sPlayerName + "','" + IntToString(nStackSize) + "','" + GetResRef(oStoredObject) + "')";
        SetLocalString(GetModule(), "NWNX!ODBC!SETSCORCOSQL", sSQL);
        int nSuccess = StoreCampaignObject ("NWNX", "-", oStoredObject);
        if (nSuccess == 0)
        {
            sSQL = "INSERT INTO " + TABLE_CHARACTERS_STORED_OBJECTS +
            " (GUID,CharacterTag,OwnerObjectTag,StoredObjectIndex,StoredObjectTag,StoredObjectName,CharacterName,Playername,StackSize,ObjectResRef) VALUES"
            + "(" + sGUID + "," + sTag + ",'" + sOwnerObjectTag + "','" + "Item_" + IntToString(iStoredObjectIndex) + "',"
            + "'" + sStoredObjectTag + "','" + sStoredObjectName + "','" + sCharacterName + "','" + sPlayerName + "','" + IntToString(nStackSize) + "','" + GetResRef(oStoredObject) + "')";
            SQLExecDirect(sSQL);
        }
    }
}
// smaze zaznam
void DeleteCharacterStoredObject(object oPlayer, int iStoredObjectIndex, string sOwnerObjectTag)
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
        sGUID = "~";
        sTag = GetTag(oPlayer);
    }
    sOwnerObjectTag = SQLEncodeSpecialChars(sOwnerObjectTag);

    string sSQL = "DELETE FROM " + TABLE_CHARACTERS_STORED_OBJECTS +
        " WHERE GUID = " + sGUID +
        " AND CharacterTag = " + sTag +
        " AND OwnerObjectTag = '" + sOwnerObjectTag + "'" +
        " AND StoredObjectIndex = 'Item_" + IntToString(iStoredObjectIndex) + "'";
    SQLExecDirect(sSQL);
}
// smaze zaznam
void DeleteCharacterAllStoredObject(object oPlayer, string sOwnerObjectTag)
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
        sGUID = "~";
        sTag = GetTag(oPlayer);
    }
    sOwnerObjectTag = SQLEncodeSpecialChars(sOwnerObjectTag);

    string sSQL = "DELETE FROM " + TABLE_CHARACTERS_STORED_OBJECTS +
        " WHERE GUID = " + sGUID +
        " AND CharacterTag = " + sTag +
        " AND OwnerObjectTag = '" + sOwnerObjectTag + "'";
    SQLExecDirect(sSQL);
}
// zobrazi zpravy od DM
void ShowDMMessages(object oPlayer)
{
    string sPlayerName;
    string sCharacterName;

    if (GetIsPC(oPlayer))
    {
        sPlayerName = GetPCPlayerName(oPlayer);
        sCharacterName  = GetName(oPlayer);
    }
    else return;

    string sSQL = "SELECT MessageType, MessageCreateBy, MessageText, CreationDate FROM " + TABLE_CHARACTERS_DM_MESSAGES +
        " WHERE CharacterName = " + sCharacterName +
        " AND PlayerName = " + sPlayerName;
    SQLExecDirect(sSQL);

    while (SQLFetch() == SQL_SUCCESS)
    {
        SendMessageToPC(oPlayer, SQLGetData(1) + ":" + SQLGetData(3) + "(" + SQLGetData(2) + "," + SQLGetData(4) + ")");
    }
}
// vrati datum vzniku postavy
string GetCharacterDateCreation(object oPlayer)
{
    string sGUID;
    string sTag;

    if (GetIsPC(oPlayer))
    {
        sGUID = GetCharacterGUID(oPlayer);
        sTag  = GetCharacterTag(oPlayer);
    }
    else return "";

    string sSQL = "SELECT DateCreation FROM " + TABLE_CHARACTERS
        + " WHERE GUID=" + sGUID
        + " AND CharacterTag = " + sTag;

    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS)
        return SQLGetData(1);
    else return "";
}

// filtrovany seznam postav
string GetCharacterListGUID(int iNumber, string sFilter, object oPlayer)
{
    string sSpeakerName;
    if (GetIsPC(oPlayer))
    {
        sSpeakerName = SQLEncodeSpecialChars(GetName(oPlayer));
    }
    else return "";

    string sSQL;
    sSQL = "SELECT GUID FROM " + TABLE_CHARACTERS
            + " WHERE CharacterName != '" + sSpeakerName + "'"
            + " AND CharacterName LIKE '%" + sFilter + "%'";

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
string GetCharacterListTag(int iNumber, string sFilter, object oPlayer)
{
    string sSpeakerName;
    if (GetIsPC(oPlayer))
    {
        sSpeakerName = SQLEncodeSpecialChars(GetName(oPlayer));
    }
    else return "";

    string sSQL;
    sSQL = "SELECT CharacterTag FROM " + TABLE_CHARACTERS
            + " WHERE CharacterName != '" + sSpeakerName + "'"
            + " AND CharacterName LIKE '%" + sFilter + "%'";

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
string GetCharacterListType(string sGUID)
{
    string sSQL;
    sSQL = "SELECT Type FROM " + TABLE_CHARACTERS
            + " WHERE GUID = '" + sGUID + "'";
    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS)
    {
        return SQLGetData(1);
    }
    return "";
}
string GetCharacterListName(string sGUID)
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
string GetPlayerListName(string sGUID)
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
int GetCharacterListNumbers(string sFilter, object oPlayer)
{
    string sSpeakerName;
    if (GetIsPC(oPlayer))
    {
        sSpeakerName = SQLEncodeSpecialChars(GetName(oPlayer));
    }
    else return 0;

    string sSQL;
    sSQL = "SELECT COUNT(GUID) FROM " + TABLE_CHARACTERS
            + " WHERE CharacterName != '" + sSpeakerName + "'"
            + " AND CharacterName LIKE '%" + sFilter + "%'";

    SQLExecDirect(sSQL);
    while (SQLFetch() == SQL_SUCCESS)
    {
        return StringToInt(SQLGetData(1));
    }
    return 0;
}
string GetStoredCharacterItemsList(object oPlayer)
{
    string sGUID;
    if (GetIsPC(oPlayer))
    {
        sGUID = GetCharacterGUID(oPlayer);
    }
    else
    {
        return "";
    }

    string sSQL = "SELECT StoredObjectName FROM " + TABLE_CHARACTERS_STORED_OBJECTS +
        " WHERE GUID = " + sGUID;

    string sTemp;
    string sReturn;
    SQLExecDirect(sSQL);
    while (SQLFetch() == SQL_SUCCESS)
    {
        sReturn = sTemp + SQLGetData(1);
        sTemp = ", ";
    }
    return sReturn;
}
int GetCharacterFaitigure(object oPlayer)
{
    return GetCharacterInt(oPlayer, "Faitigure");
}
void SetCharacterFaitigure(object oPlayer, int iFaitigure)
{
    SetCharacterInt(oPlayer, "Faitigure", iFaitigure);
}
int IsSubraceUnderGround(string sSubrace)
{
    sSubrace = GetStringLowerCase(sSubrace);
    if (sSubrace == "half_drow") return TRUE;
    if (sSubrace == "tiefling") return TRUE;
    if (sSubrace == "dwarf_duergar") return TRUE;
    if (sSubrace == "elf_night") return TRUE;
    if (sSubrace == "deep") return TRUE;
    if (sSubrace == "svirfneblin") return TRUE;
    if (sSubrace == "vampire") return TRUE;
    if (sSubrace == "skeletfight") return TRUE;
    return 0;
}
// nacte predmet z DB
object GetCharacterStoredItems(object oPlayer, int iStoredObjectIndex, object oOwnerObject)
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
        sGUID = "~";
        sTag = GetTag(oPlayer);
    }
    string sOwnerObjectTag = GetTag(oOwnerObject);
    sOwnerObjectTag = SQLEncodeSpecialChars(sOwnerObjectTag);

    string sSQL = "SELECT StackSize, ObjectResRef FROM " + TABLE_CHARACTERS_STORED_ITEMS +
        " WHERE OwnerObjectTag = '" + sOwnerObjectTag + "'" +
        " AND GUID = " + sGUID +
        " AND CharacterTag = " + sTag +
        " AND StoredObjectIndex = 'Item_" + IntToString(iStoredObjectIndex) + "'";

    SQLExecDirect(sSQL);
    int nStackSize = 1;
    string sResref = "wambo";
    if (SQLFetch() == SQL_SUCCESS)
    {
        nStackSize = StringToInt(SQLGetData(1));
        sResref = SQLGetData(2);
    }
    else
    {
        return OBJECT_INVALID;
    }

    object oTemp;
    oTemp = CreateItemOnObject(sResref, oOwnerObject, nStackSize);

    return oTemp;
}
// ulozi predmet do DB - pouziva se v cyklu pro vsechny predmety v inventari (treba truhla)
void SetCharacterStoredItems(object oPlayer, int iStoredObjectIndex, string sOwnerObjectTag, object oStoredObject)
{
    string sGUID;
    string sTag;
    string sCharacterName;
    string sPlayerName;

    if (GetIsPC(oPlayer))
    {
        sGUID = GetCharacterGUID(oPlayer);
        sTag  = GetCharacterTag(oPlayer);
        sCharacterName = SQLEncodeSpecialChars(GetName(oPlayer));
        sPlayerName = SQLEncodeSpecialChars(GetPCPlayerName(oPlayer));
    }
    else
    {
        sGUID = "~";
        sTag = GetTag(oPlayer);
    }
    sOwnerObjectTag = SQLEncodeSpecialChars(sOwnerObjectTag);
    string sStoredObjectTag = GetTag(oStoredObject);
    string sStoredObjectName = SQLEncodeSpecialChars(GetName(oStoredObject));

    string sSQL = "SELECT GUID FROM " + TABLE_CHARACTERS_STORED_ITEMS +
        " WHERE GUID = " + sGUID +
        " AND CharacterTag = " + sTag +
        " AND OwnerObjectTag = '" + sOwnerObjectTag + "'" +
        " AND StoredObjectIndex = 'Item_" + IntToString(iStoredObjectIndex) + "'";

    SQLExecDirect(sSQL);

    int nStackSize = GetItemStackSize(oStoredObject);
    if (SQLFetch() == SQL_SUCCESS)
    {
        sSQL = "UPDATE " + TABLE_CHARACTERS_STORED_ITEMS + " SET StackSize = '" + IntToString(nStackSize) + "', ObjectResRef = '" + GetResRef(oStoredObject) + "'" +
        " WHERE GUID = " + sGUID +
        " AND CharacterTag = " + sTag +
        " AND OwnerObjectTag = '" + sOwnerObjectTag + "'" +
        " AND StoredObjectIndex = 'Item_" + IntToString(iStoredObjectIndex) + "'";
        SQLExecDirect(sSQL);
    }
    else
    {
        sSQL = "INSERT INTO " + TABLE_CHARACTERS_STORED_ITEMS +
        " (GUID,CharacterTag,OwnerObjectTag,StoredObjectIndex,StoredObjectTag,StoredObjectName,CharacterName,Playername,StackSize,ObjectResRef) VALUES"
        + "(" + sGUID + "," + sTag + ",'" + sOwnerObjectTag + "','" + "Item_" + IntToString(iStoredObjectIndex) + "',"
        + "'" + sStoredObjectTag + "','" + sStoredObjectName + "','" + sCharacterName + "','" + sPlayerName + "','" + IntToString(nStackSize) + "','" + GetResRef(oStoredObject) + "')";
        SQLExecDirect(sSQL);
    }
}
// smaze zaznam
void DeleteCharacterStoredItems(object oPlayer, int iStoredObjectIndex, string sOwnerObjectTag)
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
        sGUID = "~";
        sTag = GetTag(oPlayer);
    }
    sOwnerObjectTag = SQLEncodeSpecialChars(sOwnerObjectTag);

    string sSQL = "DELETE FROM " + TABLE_CHARACTERS_STORED_ITEMS +
        " WHERE GUID = " + sGUID +
        " AND CharacterTag = " + sTag +
        " AND OwnerObjectTag = '" + sOwnerObjectTag + "'" +
        " AND StoredObjectIndex = 'Item_" + IntToString(iStoredObjectIndex) + "'";
    SQLExecDirect(sSQL);
}
// smaze zaznam
void DeleteCharacterAllStoredItems(object oPlayer, string sOwnerObjectTag)
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
        sGUID = "~";
        sTag = GetTag(oPlayer);
    }
    sOwnerObjectTag = SQLEncodeSpecialChars(sOwnerObjectTag);

    string sSQL = "DELETE FROM " + TABLE_CHARACTERS_STORED_ITEMS +
        " WHERE GUID = " + sGUID +
        " AND CharacterTag = " + sTag +
        " AND OwnerObjectTag = '" + sOwnerObjectTag + "'";
    SQLExecDirect(sSQL);
}

// Vlozi do DB CDKey postavy oPlayer
void SetCharacterCDKeyValue(object oPlayer, string sCDKey)
{
    SetCharacterString(oPlayer, "CDKey", sCDKey);
}

// Nacita z DB CDKey postavy oPlayer
string GetCharacterCDKeyValue(object oPlayer)
{
    return GetCharacterString(oPlayer, "CDKey");
}

// Vrati TRUE ak je postava legalna, tj. ak sa zhoduje jej CDKey s CDKeyom v DB
int GetIsCharacterLegal(object oPlayer)
{
    // DM je legalny charakter
    if (GetIsDM(oPlayer))
        return TRUE;

    string sCDKey = GetPCPublicCDKey(oPlayer);
    string sDBCDKey = GetCharacterCDKeyValue(oPlayer);

    if (sDBCDKey == "")
    {
        SetCharacterCDKeyValue(oPlayer, sCDKey);
        sDBCDKey = sCDKey;
    }

    if (sDBCDKey == sCDKey)
    {
        SetCharacterAsLegal(oPlayer);
        return TRUE;
    }
    SetCharacterAsIlegal(oPlayer);
    return FALSE;
}

// Nastavy docasnu premennu pre kontrolu legalnosti charakteru na true
void SetCharacterAsLegal(object oPlayer)
{
    SetLocalInt(GetModule(), "PC_LEGAL_" + GetName(oPlayer), TRUE);
}
// Nastavy docasnu premennu pre kontrolu legalnosti charakteru na false
void SetCharacterAsIlegal(object oPlayer)
{
    SetLocalInt(GetModule(), "PC_LEGAL_" + GetName(oPlayer), FALSE);
}
// Vykona kontrolu a skok na docasne uloziste, ak je postava nelegalna
// Ak skoci, vrati true
// Ak neskoci, vrati false
int IlegalCharacterMoveToTemporaryLocation(object oPlayer)
{
    if (!GetCharacterLegalStatus(oPlayer))
    {
        location lWP = GetLocation(GetWaypointByTag(STARTING_ILEGAL_CHARACTER));
        AssignCommand(oPlayer, ClearAllActions(TRUE));
        AssignCommand(oPlayer, JumpToLocation(lWP));
        return TRUE;
    }
    return FALSE;
}

// Vrati ulozeny status legalneho charakteru z pamate modulu
int GetCharacterLegalStatus(object oPlayer)
{
    return GetLocalInt(GetModule(), "PC_LEGAL_" + GetName(oPlayer));
}

// Privatna funkcia na zmazanie starych banov
void DeleteOldBans()
{
    string sSQL = "DELETE FROM players_banlist WHERE BanExpiration < NOW()";
    SQLExecDirect(sSQL);
}

int GetBanValue(string PlayerName = "", string IPAddres = "", string CDKey = "")
{
    //Kontrola zadania udajov
    if (PlayerName == "" && IPAddres == "" && CDKey == "")
        return FALSE;

    //Vymazanie preslich banov
    DeleteOldBans();

    //Overenie ci je ban
    string sSQL = "SELECT Ban FROM players_banlist WHERE (PlayerName LIKE '" + SQLEncodeSpecialChars(PlayerName) + "' OR IPAddres LIKE '" + IPAddres + "' OR CDKey LIKE '" + CDKey + "') AND BanExpiration >= NOW() AND Ban = 1";
    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS)
        return TRUE;
    return FALSE;
}

int SetBanValue(string PlayerName = "", string IPAddres = "", string CDKey = "", string BanExpiration = "0000-00-00")
{
    int nSucc = FALSE;
    string sSQL = "SELECT Ban FROM players_banlist WHERE PlayerName LIKE '" + SQLEncodeSpecialChars(PlayerName) + "' AND IPAddres LIKE '" + IPAddres + "' AND CDKey LIKE '" + CDKey + "'";
    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS)
    {
        sSQL = "UPDATE players_banlist SET BanExpiration = '" + BanExpiration + "' WHERE PlayerName LIKE '" + PlayerName + "' AND IPAddres LIKE '" + IPAddres + "' AND CDKey LIKE '" + CDKey + "'";
        SQLExecDirect(sSQL);
    }
    else
    {
        sSQL = "INSERT INTO players_banlist SET PlayerName = '" + SQLEncodeSpecialChars(PlayerName) + "', IPAddres = '" + IPAddres + "', CDKey = '" + CDKey + "', BanCreated = NOW(), BanExpiration = '" + BanExpiration + "', Ban = 1";
        SQLExecDirect(sSQL);
    }

    sSQL = "SELECT Ban FROM players_banlist WHERE PlayerName LIKE '" + SQLEncodeSpecialChars(PlayerName) + "' AND IPAddres LIKE '" + IPAddres + "' AND CDKey LIKE '" + CDKey + "' AND BanExpiration LIKE '" + BanExpiration + "'";
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
        nSucc = TRUE;

    //Vymazanie starych banov
    DeleteOldBans();

    return nSucc;
}

int SetBanExpirationByID(string sID, string BanExpiration = "0000-00-00")
{
    string sSQL = "UPDATE players_banlist SET BanExpiration = '" + BanExpiration + "' WHERE id = " + sID;
    SQLExecDirect(sSQL);
    sSQL = "SELECT Ban FROM players_banlist WHERE BanExpiration = " + BanExpiration + " AND id = " + sID;
    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS)
        return TRUE;
    return FALSE;
}

int SwitchBanStatusByID(string sID)
{
    string sSQL = "SELECT Ban FROM players_banlist WHERE id = " + sID;
    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS)
    {
        string sBanStatus = SQLGetData(1);
        sBanStatus = IntToString(!StringToInt(sBanStatus));
        sSQL = "UPDATE players_banlist SET Ban = '" + sBanStatus + "' WHERE id = " + sID;
        SQLExecDirect(sSQL);
        sSQL = "SELECT Ban FROM players_banlist WHERE Ban = " + sBanStatus + " AND id = " + sID;
        SQLExecDirect(sSQL);
        if (SQLFetch() == SQL_SUCCESS)
            return TRUE;
        return FALSE;
    }

    return FALSE;
}

void BanExecute(object oPlayer)
{
    // Vykonat ban
    effect eImobilize = EffectCutsceneImmobilize();
    SetCutsceneMode(oPlayer);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eImobilize, oPlayer);
    DelayCommand(10.0, FloatingTextStringOnCreature("Bol ti udeleny BAN.", oPlayer));
    DelayCommand(25.0, FloatingTextStringOnCreature("Bol ti udeleny BAN, zachvilu budes odpojeny.", oPlayer));
    DelayCommand(26.0, FadeToBlack(oPlayer));
    DelayCommand(30.0, BootPC(oPlayer));
}

void CheckBanForAll()
{
    object oPlayer = GetFirstPC();
    while (GetIsObjectValid(oPlayer))
    {
        if (GetBanValue(GetPCPlayerName(oPlayer), GetPCIPAddress(oPlayer), GetPCPublicCDKey(oPlayer)))
            BanExecute(oPlayer);
        oPlayer = GetNextPC();
    }
}

string GetBanEditTable()
{
    string sSQL = "SELECT id, PlayerName, IPAddres, CDKey, Ban, BanExpiration FROM players_banlist ORDER BY id ASC";
    string sTableHRL = "-----------------------------------------";
    string sTableHeader = "<cú  >ID</c> | <c€  >Ucet</c> | <cúú >IP Adresa</c> | <cú€ >CD Key</c> | <c€ €>Stav</c> | <c ú >Expiracia</c>\n"+sTableHRL;
    string sTableEmptyCell = "(-------)";
    string sBanEnabled = "Povoleny";
    string sBanDisabled = "Pozastaveny";

    string sData = "";

    string sTableContent = "";

    SQLExecDirect(sSQL);

    while (SQLFetch() == SQL_SUCCESS)
    {
        // Novy riadok
        sTableContent += "\n";
        // ID
        sTableContent += "<cú  >" + SQLGetData(1) + "</c> | ";
        // Ucet
        sData = SQLDecodeSpecialChars(SQLGetData(2));
        if (sData == "")
            sData = sTableEmptyCell;
        sTableContent += "<c€  >" + sData + "</c> | ";
        // IP
        sData = SQLGetData(3);
        if (sData == "")
            sData = sTableEmptyCell;
        sTableContent += "<cúú >" + sData + "</c> | ";
        // CDKey
        sData = SQLGetData(4);
        if (sData == "")
            sData = sTableEmptyCell;
        sTableContent += "<cú€ >" + sData + "</c> | ";
        // Stav
        sData = SQLGetData(5);
        if (sData == "1")
            sData = sBanEnabled;
        else
            sData = sBanDisabled;
        sTableContent += "<c€ €>" + sData + "</c> | ";
        // Expiracia
        sTableContent += "<c ú >" + SQLGetData(6) + "</c>\n"+sTableHRL;
    }

    if (sTableContent == "")
        return "<cú  >Nie su ziadne zaznamy o BANoch.</c>";

    return sTableHeader + sTableContent;
}

// nastavy HP na postave
void SetPlayerHitPoints(object oPlayer, int iHitPoints)
{
    int iMaxHP = GetMaxHitPoints(oPlayer);
    int iDamage = iMaxHP - iHitPoints;
    effect eHeal = EffectHeal(iMaxHP);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPlayer);

    effect eDamage = EffectDamage(iDamage, DAMAGE_TYPE_DIVINE, DAMAGE_POWER_NORMAL);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPlayer);
}

void GiveXpFromExploring(object oArea, object oPC)
{
    if (GetIsDM(oPC) || GetIsDMPossessed(oPC))
        return;

    string MEMORY = "ExploredLocations";
    string sExplList = GetCharacterString(oPC, MEMORY);
    int nInterior = GetIsAreaInterior(oArea);
    string sAreaID = GetResRef(oArea);
    int iXp = 50;

    if (FindSubString(sExplList, sAreaID) == -1)
    {
        sExplList = sExplList + "|" + sAreaID;

        if (!nInterior)
            iXp = 70;

        SendMessageToPC(oPC, "Ziskal si skusenosti s cestovania po svete!");
        int iXpC = GetXP(oPC);
        iXpC += iXp;
        SetXP(oPC, iXpC);

        SetCharacterString(oPC, MEMORY, sExplList);
    }
}

string ModifTrim(string Modif)
{
    int i;
    string n = "";
    for (i=0;i<GetStringLength(Modif);i++)
    {
        if (GetSubString(Modif, i, 1) != " ")
            n += GetSubString(Modif, i, 1);
    }
    return n;
}

void CharacterUpdateSaveBillForAll(float fModifier)
{
    string sSQL = "UPDATE " + TABLE_CHARACTERS_VARIABLES + " SET VariableValue = Round(VariableValue * " + ModifTrim(FloatToString(fModifier)) + ") WHERE VariableName = '" + VARIABLE_CHARACTER_SAVE_MONEY + "' AND Round(VariableValue) < 1000000";

    SendMessageToAllDMs("Debug: " + sSQL);

    SQLExecDirect(sSQL);
}

// Nastavi cas kedy bol otvoreny poklad
void CharacterSetOpenTime(object oPC)
{
    string sGUID;
    string sTag;
    string sPlayerName;
    string sCharacterName;

    if (GetIsPC(oPC))
    {
        sGUID = GetCharacterGUID(oPC);
        sTag  = GetCharacterTag(oPC);
        sPlayerName = GetPCPlayerName(oPC);
        sCharacterName = GetName(oPC);
    }
    else return;

    string sVariableName = VARNAME_CHARACTER_TREASURE_OPEN;
    sVariableName  = SQLEncodeSpecialChars(sVariableName);
    sPlayerName =SQLEncodeSpecialChars(sPlayerName);
    sCharacterName =SQLEncodeSpecialChars(sCharacterName);

    string sSQL = "SELECT GUID FROM " + TABLE_CHARACTERS_VARIABLES
            + " WHERE GUID = " + sGUID
            + " AND CharacterTag = " + sTag
            + " AND VariableName = '" + sVariableName + "'";

    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
    {
        sSQL = "UPDATE " + TABLE_CHARACTERS_VARIABLES
            + " SET VariableValue=UNIX_TIMESTAMP() , Expiration=0, "
            + " CharacterName = '" + sCharacterName + "', PlayerName = '" + sPlayerName + "'"
            + " WHERE GUID = " + sGUID
            + " AND CharacterTag = " + sTag + ""
            + " AND VariableName = '" + sVariableName + "'";
        SQLExecDirect(sSQL);
    }
    else
    {
        sSQL = "INSERT INTO " + TABLE_CHARACTERS_VARIABLES
            + " (GUID,CharacterTag,VariableName,VariableValue,Expiration,CharacterName,PlayerName) VALUES"
            + " (" + sGUID + "," + sTag + ",'" + sVariableName + "',UNIX_TIMESTAMP()," + "0"
            + ",'" + sCharacterName + "', '" + sPlayerName + "')";
        SQLExecDirect(sSQL);
    }
}

// Vrati TRUE ak je mozne vygenerovat novy poklad
int CharacterTreasureOpening(object oPC, int nTimeOut)
{
    string sGUID;
    string sTag;

    if (GetIsPC(oPC))
    {
        sGUID = GetCharacterGUID(oPC);
        sTag  = GetCharacterTag(oPC);
    }
    else
    {
        return FALSE;
    }
    string sVariableName = VARNAME_CHARACTER_TREASURE_OPEN;
    sVariableName  = SQLEncodeSpecialChars(sVariableName);

    // Kontrola ci vobec existuje nejaky zaznam
    string sSQL = "SELECT GUID FROM " + TABLE_CHARACTERS_VARIABLES
            + " WHERE GUID = " + sGUID
            + " AND CharacterTag = " + sTag
            + " AND VariableName = '" + sVariableName + "'";

    SQLExecDirect(sSQL);

    // Ak ziadny zaznam neexistuje, znamena to ze postava poklad este neotvorila, takze ho otvorit moze
    if (SQLFetch() == SQL_ERROR)
    {
        return TRUE;
    }

    sSQL = "SELECT VariableValue FROM " + TABLE_CHARACTERS_VARIABLES
        + " WHERE GUID=" + sGUID
        + " AND CharacterTag = " + sTag + ""
        + " AND VariableName= '" + sVariableName + "'"
        + " AND (Round(VariableValue) + " + IntToString(60 * nTimeOut) + ") < UNIX_TIMESTAMP()";

    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS)
        return TRUE;


    return FALSE;
}
