// Authors  : TondaLee (AV) - Antonin Vins
// Created  : 05/2005
// Modified : 08/06/2005

#include "_inc_nwnx_db"
#include "_inc_config"

// Constants
const string MODULE_REPORT_VAR = "MODULE_REPORT";

// Modules variables
// funkce pro plneni modulovych promenych
void SetModuleString(string sName, string sValue, int iExpiration =0);
void SetModuleFloat(string sName, float iValue, int iExpiration = 0);
void SetModuleInt(string sName, int iValue, int iExpiration = 0);
void UpdateModuleTimestamp();
//sText - text zpravy
//sType - INFO, WARNING, ERROR, RULES
void InsertModuleMessage(string sText, string sType = "INFO", object oPlayer = OBJECT_SELF);

// funkce pro nacitani modulovych promenych
string GetModuleString(string sName);
float  GetModuleFloat(string sName);
int    GetModuleInt(string sName);

// smaze modulovou promenou z DB
void DeleteModuleVariable(string sName);

//Modules
void ModuleLogin();

//Module activation operations
void ModuleClearReport();
void ModuleAddReport(string sMessage);


// ***************************************************************************
// Module Variable
// funkce pro plneni modulovych promenych
void SetModuleString(string sVariableName, string sVariableValue, int iExpiration =0)
{
    string sMUID;

    sMUID  = GetModuleMUID();
    sVariableName  = SQLEncodeSpecialChars(sVariableName);
    sVariableValue = SQLEncodeSpecialChars(sVariableValue);

    string sSQL = "SELECT MUID FROM " + TABLE_MODULES_VARIABLES
            + " WHERE MUID = " + sMUID
            + " AND VariableName = '" + sVariableName + "'";

    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
    {
        // row exists
        sSQL = "UPDATE " + TABLE_MODULES_VARIABLES
            + " SET VariableValue='" + sVariableValue + "' , Expiration=" + IntToString(iExpiration)
            + " WHERE MUID = " + sMUID
            + " AND VariableName = '" + sVariableName + "'";

        SQLExecDirect(sSQL);
    }
    else
    {
        // row doesn't exist
        sSQL = "INSERT INTO " + TABLE_MODULES_VARIABLES
            + " (MUID,VariableName,VariableValue,Expiration) VALUES"
            + "(" + sMUID + ",'" + sVariableName + "','" + sVariableValue + "'," + IntToString(iExpiration) + ")";
        SQLExecDirect(sSQL);
    }
}
void SetModuleFloat(string sVarableName, float fVariableValue, int iExpiration = 0)
{
    SetModuleString(sVarableName, FloatToString(fVariableValue), iExpiration);
}
void SetModuleInt(string sVarableName, int iVariableValue, int iExpiration = 0)
{
    SetModuleString(sVarableName, IntToString(iVariableValue), iExpiration);
}

void UpdateModuleTimestamp()
{
    string sMUID;

    sMUID  = GetModuleMUID();
    string sVariableName  = SQLEncodeSpecialChars("MODULE_TIMESTAMP");

    string sSQL = "SELECT MUID FROM " + TABLE_MODULES_VARIABLES
            + " WHERE MUID = " + sMUID
            + " AND VariableName = '" + sVariableName + "'";

    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
    {
        // row exists
        sSQL = "UPDATE " + TABLE_MODULES_VARIABLES
            + " SET VariableValue= UNIX_TIMESTAMP() , Expiration=0"
            + " WHERE MUID = " + sMUID
            + " AND VariableName = '" + sVariableName + "'";

        SQLExecDirect(sSQL);
    }
    else
    {
        // row doesn't exist
        sSQL = "INSERT INTO " + TABLE_MODULES_VARIABLES
            + " (MUID,VariableName,VariableValue,Expiration) VALUES"
            + "(" + sMUID + ",'" + sVariableName + "'UNIX_TIMESTAMP(),0)";
        SQLExecDirect(sSQL);
    }
}

// vlozi hlasku do DB
void InsertModuleMessage(string sText, string sType = "INFO", object oPlayer = OBJECT_SELF)
{
    string sMUID;

    sMUID  = GetModuleMUID();
    sText  = SQLEncodeSpecialChars(sText);
    sType = SQLEncodeSpecialChars(sType);
    string sName = "non PC";
    if (GetIsPC(oPlayer)) sName = GetPCPlayerName(oPlayer) + ", " + GetName(oPlayer);

    string sSQL = "INSERT INTO " + TABLE_MODULES_MESSAGES
        + " (MUID,MessageType,MessageText,PlayerName) VALUES"
        + "(" + sMUID + ",'" + sText + "','" + sType + "','" + sName + "')";
    SQLExecDirect(sSQL);
}

// funkce pro nacitani modulovych promenych
string GetModuleString(string sVariableName)
{
    string sMUID;

    sMUID  = GetModuleMUID();
    sVariableName  = SQLEncodeSpecialChars(sVariableName);

    string sSQL = "SELECT VariableValue FROM " + TABLE_MODULES_VARIABLES
        + " WHERE MUID=" + sMUID
        + " AND VariableName='" + sVariableName + "'";

    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
        return SQLDecodeSpecialChars(SQLGetData(1));
    else
    {
        return "";
    }
}
float GetModuleFloat(string sVarableName)
{
    return StringToFloat(GetModuleString(sVarableName));
}
int GetModuleInt(string sVarableName)
{
    string sTemp = GetModuleString(sVarableName);
    int iTemp = 0;
    if (sTemp != "") iTemp = StringToInt(sTemp);
    return iTemp;
}
// smaze modulovou promenou z DB
void DeleteModuleVariable(string sVariableName)
{
   string sMUID;

    sMUID  = GetModuleMUID();
    sVariableName  = SQLEncodeSpecialChars(sVariableName);

    string sSQL = "DELETE FROM " + TABLE_MODULES_VARIABLES
        + " AND VariableName='" + sVariableName + "'";

    SQLExecDirect(sSQL);
}
// Modules
// pri logovani modulu
void ModuleLogin()
{
    string sSQL = "SELECT MUID FROM " + TABLE_MODULES
            + " WHERE MUID = " + GetModuleMUID();

    SQLExecDirect(sSQL);

    if (SQLFetch() != SQL_SUCCESS)
    {
        sSQL = "INSERT INTO " + TABLE_MODULES
            + " (MUID, ModuleName) VALUES"
            + " (" + GetModuleMUID() + ",'" + GetModuleName() + "')";

        SQLExecDirect(sSQL);
    }
}

void ModuleClearReport()
{
    SetModuleString(MODULE_REPORT_VAR, "");
}
void ModuleAddReport(string sMessage)
{
    string sTemp = GetModuleString(MODULE_REPORT_VAR);
    SetModuleString(MODULE_REPORT_VAR, sTemp + sMessage + "\n");
}
