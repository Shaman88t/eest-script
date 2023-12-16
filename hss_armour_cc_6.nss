//::///////////////////////////////////////////////
//:: Name: Armour designer conversation condition
//:: FileName: hss_armour_cc_6
//:: Copyright Heed.
//:://////////////////////////////////////////////
/*
Returns true if the pc speaker has given the
armourer a helm or armour.
*/
//:://////////////////////////////////////////////
//:: Created By:  Heed
//:: Created On:  April 6, 2006.
//:://////////////////////////////////////////////
//:: Last Update By: Heed
//:: Last Update On: April 6, 2006.

#include "hss_inc_armour"

int StartingConditional()
{
    int nResult = FALSE;

    if (GetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_ITEM_TYPE") == HSS_TYPE_HELM ||
       GetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_ITEM_TYPE") == HSS_TYPE_ARMOUR)
       {
       if (!GetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_ITEM_IS_EXCLUDED"))
          {
          nResult = TRUE;
          }
       }


    return nResult;
}
