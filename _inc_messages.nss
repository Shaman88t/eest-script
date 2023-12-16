// Authors  : TondaLee (AV) - Antonin Vins
// Created  : 05/2005
// Modified : 08/06/2005
// prace se zpravama

#include "_inc_nwnx_db"
#include "_inc_db_module"
#include "_inc_config"

// zpravy, ktere se zobrazuji pouze pokud je modul v rezimu DEBUG=1
void DebugPlayerMessage(object oPlayer, string text);
void DebugDMMessage(string text);
void DebugDBMessage(string text, string type = "info", object oPlayer = OBJECT_SELF);

// standardni zpravy
void StandardPlayerMessage(object oPlayer, string text);
void StandardDMMessage(string text);
void StandardDBMessage(string text, string type = "info", object oPlayer = OBJECT_SELF);

// zpravy, ktere se zobrazuji pouze pokud je modul v rezimu DEBUG=1
void DebugPlayerMessage(object oPlayer, string text)
{
    if (IS_MODULE_DEBUG == 1)
    {
        SendMessageToPC(oPlayer, "DEBUG INFO: " + text);
    }
}
void DebugDMMessage(string text)
{
    if (IS_MODULE_DEBUG == 1)
    {
        SendMessageToAllDMs("DM DEBUG INFO: " + text);
    }
}
//sType - INFO, WARNING, ERROR, RULES
void DebugDBMessage(string text, string type = "info", object oPlayer = OBJECT_SELF)
{
    if (IS_MODULE_DEBUG == 1)
    {
        InsertModuleMessage(text, type, oPlayer);
    }
}

// standardni zpravy
void StandardPlayerMessage(object oPlayer, string text)
{
    SendMessageToPC(oPlayer, text);
}
void StandardDMMessage(string text)
{
    SendMessageToAllDMs("DM STANDARD INFO: " + text);
}
//sType - INFO, WARNING, ERROR, RULES
void StandardDBMessage(string text, string type = "info", object oPlayer = OBJECT_SELF)
{
    InsertModuleMessage(text, type, oPlayer);
}
