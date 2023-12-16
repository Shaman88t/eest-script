//::///////////////////////////////////////////////
//:: Name: Armourstand On Conversation
//:: FileName: hss_astand_convo
//:: Copyright Heed.
//:://////////////////////////////////////////////
/*
Simple script to keep the armour dummy from
spinning around if a PC clicks on it. Also pops
up the examine window. Will turn 180 degrees
if it hears the right terms.
*/
//:://////////////////////////////////////////////
//:: Created By:  Heed
//:: Created On:  March 30, 2006.
//:://////////////////////////////////////////////
//:: Last Update By: Heed
//:: Last Update On: April 3, 2006.

#include "x0_i0_position"
#include "hss_inc_armour"

void main()
{
   object oPC = GetLastSpeaker();
   object oDummy = OBJECT_SELF;
   object oArmourer = GetNearestObjectByTag(HSS_PREFX + "ARMOUR_DESIGNER");
   int nMatch = GetListenPatternNumber();
   int nDumGender = GetGender(oDummy);
   int nGender = GetGender(oPC);

   if (nMatch == 1390)
      {
      if (GetLocalObject(oArmourer, HSS_PREFX + "ARMOUR_CUSTOMER") == oPC &&
         GetDistanceBetween(oDummy, oPC) < 4.0)
         {
         if (nDumGender == GENDER_FEMALE && nGender == GENDER_FEMALE)
            {
            PlaySound("as_sw_woodplate1");
            SetFacing(GetOppositeDirection(GetFacing(oDummy)));
            }
            else
            if (nDumGender == GENDER_MALE && nGender != GENDER_FEMALE)
            {
            PlaySound("as_sw_woodplate1");
            SetFacing(GetOppositeDirection(GetFacing(oDummy)));
            }
         }
      return;
      }

   SetFacing(GetFacing(oDummy));
   AssignCommand(oPC, ActionExamine(oDummy));
}
