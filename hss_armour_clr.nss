//::///////////////////////////////////////////////
//:: Name: Armour information action
//:: FileName: hss_armour_clr
//:: Copyright Heed.
//:://////////////////////////////////////////////
/*
Runs the the reset routine to give the original
armour to the PC and then reset the armourer for
the next customer.
*/
//:://////////////////////////////////////////////
//:: Created By:  Heed
//:: Created On:  March 20, 2006.
//:://////////////////////////////////////////////
//:: Last Update By: Heed
//:: Last Update On: March 20, 2006.

#include "hss_inc_armour"

void main()
{
   object oPC= GetPCSpeaker();

   DelayCommand(1.0, HSS_ArmourFinishRoutine(oPC, FALSE));
}
