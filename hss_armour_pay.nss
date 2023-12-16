//::///////////////////////////////////////////////
//:: Name: Armour information action
//:: FileName: hss_armour_pay
//:: Copyright Heed.
//:://////////////////////////////////////////////
/*
Removes the gold from the PC for pament of the
armour alterations. Also runs the the reset
routine to give the modified armour to the PC
and then reset the armourer for the next
customer.
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
   int nCost = GetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_COST");
   object oPC= GetPCSpeaker();

   TakeGoldFromCreature(nCost, oPC, TRUE);
   DelayCommand(1.0, HSS_ArmourFinishRoutine(oPC, TRUE));
}
