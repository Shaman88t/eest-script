//::///////////////////////////////////////////////
//:: Example XP2 OnItemUnAcquireScript
//:: x2_mod_def_unaqu
//:: (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Put into: OnItemUnAcquire Event

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-16
//:://////////////////////////////////////////////
#include "x2_inc_switches"
#include "nwnx_item"
void main()
{
     object oItem = GetModuleItemLost();
     // * Generic Item Script Execution Code
     // * If MODULE_SWITCH_EXECUTE_TAGBASED_SCRIPTS is set to TRUE on the module,
     // * it will execute a script that has the same name as the item's tag
     // * inside this script you can manage scripts for all events by checking against
     // * GetUserDefinedItemEventNumber(). See x2_it_example.nss
     if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
     {
        SetUserDefinedItemEventNumber(X2_ITEM_EVENT_UNACQUIRE);
        int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
        if (nRet == X2_EXECUTE_SCRIPT_END)
        {
           return;
        }
     }
     ExecuteScript("me_nc_unacqire", OBJECT_SELF);

     object oLoser = GetModuleItemLostBy();

    // Ochrana cen - kvuli obchodum
    int iGold = GetLocalInt(oItem,"GOLDPIECEVALUE");
    if(iGold > 0 && iGold != GetGoldPieceValue(oItem))
      NWNX_Item_SetBaseGoldPieceValue(oItem,iGold);

    //  ExecuteScript("cnr_cowchic_oui", oLoser);
    ExecuteScript("sy_m_onunacquire", oLoser);
}
