//::///////////////////////////////////////////////
//:: Name: Armour information action
//:: FileName: hss_armour_info
//:: Copyright Heed.
//:://////////////////////////////////////////////
/*
Reports the current armour colours converted to
the chart layout.
*/
//:://////////////////////////////////////////////
//:: Created By:  Heed
//:: Created On:  March 19, 2006.
//:://////////////////////////////////////////////
//:: Last Update By: Heed
//:: Last Update On: March 19, 2006.

#include "x2_inc_itemprop"
#include "hss_inc_armour"

void main()
{
   int nGender = GetLocalInt(OBJECT_SELF, HSS_PREFX + "CUSTOMER_GENDER");
   int nType = GetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_ITEM_TYPE");
   object oPC = GetPCSpeaker();
   object oDummy;

   if (nGender == 2)
      {
      oDummy = GetNearestObjectByTag(HSS_PREFX + "ARMOUR_DUMMY_F");
      }
      else
      {
      oDummy = GetNearestObjectByTag(HSS_PREFX + "ARMOUR_DUMMY_M");
      }

   HSS_ArmourReportColours(oDummy, nType);
   DelayCommand(1.0, HSS_ArmourFinishRoutine(oPC, FALSE));
}


