#include "aps_include"
#include "persistence"

int StartingConditional()
{
   object oPC = GetPCSpeaker();

   if(GetHitDice(oPC) > 1){
       return 1;
   }

   return 0;
}
