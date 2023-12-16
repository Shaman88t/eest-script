//::///////////////////////////////////////////////
//:: Name: Armour information action
//:: FileName: hss_armour_prov
//:: Copyright Heed.
//:://////////////////////////////////////////////
/*
Reports the current item's provenance.
*/
//:://////////////////////////////////////////////
//:: Created By:  Heed
//:: Created On:  April 25, 2006.
//:://////////////////////////////////////////////
//:: Last Update By: Heed
//:: Last Update On: April 25, 2006.

#include "hss_inc_armour"

void main()
{
   object oPC = GetPCSpeaker();

   HSS_ArmourReportItemProvenance(OBJECT_SELF);
   DelayCommand(1.0, HSS_ArmourFinishRoutine(oPC, FALSE));
}


