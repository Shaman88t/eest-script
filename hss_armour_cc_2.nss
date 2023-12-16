//::///////////////////////////////////////////////
//:: Name: Armour designer conversation condition
//:: FileName: hss_armour_cc_2
//:: Copyright Heed.
//:://////////////////////////////////////////////
/*
Returns true if the pc doesn't have enough
gold to pay for the service.
*/
//:://////////////////////////////////////////////
//:: Created By:  Heed
//:: Created On:  March 18, 2006.
//:://////////////////////////////////////////////
//:: Last Update By: Heed
//:: Last Update On: March 18, 2006.

#include "hss_inc_armour"

int StartingConditional()
{
    int nResult = FALSE;
    object oPC = GetPCSpeaker();
    int nCost = GetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_COST");

    if (GetGold(oPC) < nCost)
       {
       nResult = TRUE;
       }

    return nResult;
}
