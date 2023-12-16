//:: Name: Armour Conversation action
//:: FileName: hss_armour_ca_1
//:: Copyright Heed.
//:://////////////////////////////////////////////
/*
Start listening for armour related commands--
armour has been chosen.

*/
//:://////////////////////////////////////////////
//:: Created By:  Heed
//:: Created On:  March 16, 2006.
//:://////////////////////////////////////////////
//:: Last Update By: Heed
//:: Last Update On: March 16, 2006.

#include "hss_inc_armour"

void main()
{

/*   SetListenPattern(OBJECT_SELF, "**(right foot|left foot|" +
   "right shin|left shin|left thigh|right thigh|pelvis|torso|belt|neck|" +
   "right forearm|left forearm|right bicep|left bicep|right shoulder|" +
   "left shoulder|right hand|left hand|robe)**", 1388);*/


   SetListenPattern(OBJECT_SELF, "**(prava noha|leva noha|" +
   "prava holen|leva holen|leve stehno|prave stehno|panev|telo|pas|krk|" +
   "prave predlokti|leve predlokti|pravy loket|levy loket|prave rameno|" +
   "leve rameno|prava ruka|leva ruka|roba)**", 1388);

   SetListenPattern(OBJECT_SELF, "**(dalsi|zpet)**", 1389);
/*    SetListenPattern(OBJECT_SELF, "**(next|back)**", 1389);  */
}
