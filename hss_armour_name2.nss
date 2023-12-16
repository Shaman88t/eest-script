//::///////////////////////////////////////////////
//:: Name: Armour designer conversation condition
//:: FileName: hss_armour_name2
//:: Copyright Heed.
//:://////////////////////////////////////////////
/*
Adds the PC's first name to the item's name that
is being worked on by the armourer.
*/
//:://////////////////////////////////////////////
//:: Created By:  Heed
//:: Created On:  April 1st, 2006.
//:://////////////////////////////////////////////
//:: Last Update By: Heed
//:: Last Update On: April 10, 2006.

#include "hss_inc_armour"


void main()
{
   object oPC = GetPCSpeaker();

   HSS_ArmourDoInscription(2, oPC);
}



