//::///////////////////////////////////////////////
//:: Name: Armour Sign on used
//:: FileName: hss_armour_sign
//:: Copyright Heed.
//:://////////////////////////////////////////////
/*
The onused script for the armour colour sign in
order to play the proper animation.
*/
//:://////////////////////////////////////////////
//:: Created By:  Heed
//:: Created On:  March 19, 2006.
//:://////////////////////////////////////////////
//:: Last Update By: Heed
//:: Last Update On: March 19, 2006.


#include "hss_inc_armour"

void main()
{
   if (!GetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_SIGN_STATE"))
      {
      PlayAnimation(ANIMATION_PLACEABLE_CLOSE);
      SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_SIGN_STATE", 1);
      }
      else
      {
      PlayAnimation(ANIMATION_PLACEABLE_OPEN);
      DeleteLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_SIGN_STATE");
      }
}
