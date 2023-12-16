//::///////////////////////////////////////////////
//:: Name: Armour designer conversation condition
//:: FileName: hss_armour_cc_5
//:: Copyright Heed.
//:://////////////////////////////////////////////
/*
Returns true if the armourer has a stored item that
belongs to oPC. (i.e. oPC crashed or left the game
in the middle of a transaction).  The function
actually creates the item.
*/
//:://////////////////////////////////////////////
//:: Created By:  Heed
//:: Created On:  April 4, 2006.
//:://////////////////////////////////////////////
//:: Last Update By: Heed
//:: Last Update On: April 4, 2006.

#include "hss_inc_armour"

int StartingConditional()
{
    int nResult = FALSE;
    object oPC = GetPCSpeaker();


    if (HSS_ArmourLostAndFound(oPC))
       {
       nResult = TRUE;
       }


    return nResult;
}
