//::///////////////////////////////////////////////
//:: Name: Armour designer conversation condition
//:: FileName: hss_armour_cc_3
//:: Copyright Heed.
//:://////////////////////////////////////////////
/*
Returns true if the pc speaker's name cannot be
split reliably into a first name and last name.

i.e. GetName() returns a string that has more
than one space in it.
*/
//:://////////////////////////////////////////////
//:: Created By:  Heed
//:: Created On:  April 3rd, 2006.
//:://////////////////////////////////////////////
//:: Last Update By: Heed
//:: Last Update On: April 3rd, 2006.

#include "hss_inc_armour"

int StartingConditional()
{
    int nResult = FALSE;
    object oPC = GetPCSpeaker();

    if (HSS_ArmourGetSeperatedStringsCount(GetName(oPC), " ") != 2)
       {
       nResult = TRUE;
       }


    return nResult;
}
