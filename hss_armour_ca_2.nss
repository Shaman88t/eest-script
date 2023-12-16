//:: Name: Armour Conversation action
//:: FileName: hss_armour_ca_2
//:: Copyright Heed.
//:://////////////////////////////////////////////
/*
Start listening for colour related commands--
colour has been chosen.

*/
//:://////////////////////////////////////////////
//:: Created By:  Heed
//:: Created On:  March 16, 2006.
//:://////////////////////////////////////////////
//:: Last Update By: Heed
//:: Last Update On: March 16, 2006.


void main()
{
   SetListenPattern(OBJECT_SELF, "***a*n**", 1387);

//   SetListenPattern(OBJECT_SELF, "**(metal 1|metal one|primary metal|" +
//   "first metal|metal 2|metal two|secondary metal|second metal|cloth 1|" +
//   "cloth one|primary cloth|first cloth|cloth 2|cloth two|secondary cloth|" +
//   "second cloth|leather 1|leather one|primary leather|first leather|" +
//   "leather 2|leather two|secondary leather|second leather)**", 1391);

   SetListenPattern(OBJECT_SELF, "**(kov 1|kov jedna|zakladni kov|" +
   "prvni kov|kov 2|kov dva|druhotny kov|druhy kov|latka 1|" +
   "latka jedna|zakladni latka|prvni latka|latka 2|latka dva|druhotny latka|" +
   "druhy latka|kuze 1|kuze jedna|zakladni kuze|prvni kuze|" +
   "kuze 2|kuze dva|druhotny kuze|druhy kuze)**", 1391);

}
