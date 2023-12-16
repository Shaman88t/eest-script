#include "ku_libtime"   // casova knihovna
#include "ku_libbase"  // xp system
#include "subraces" // subrasy
#include "ku_ships" // kvuli lodim

void main()
{
//inicializace funkci pro casovani
 SetRoundInMinute();
 SetRoundInHour();

 object oMod = GetModule();
 int iActRound = GetLocalInt(oMod,"ku_RoundInMinute"); //cislo Roundu v aktualni minute

// Lode uz nepouzivaji heartbeaty
// if(iActRound == 1 ) {
//  ku_ShipsDeparture();         //Kontrola odezdu lodi
// }
 if(iActRound == 2 ) { // Pridelovani eXPu za cas
  object oPC = GetFirstPC();
  while(GetIsObjectValid(oPC) == TRUE) {
   ku_CheckXPStop(oPC);
   ku_GiveXPPerTime(oPC);
   oPC = GetNextPC();
  }
 }
 if(iActRound == 3 ) { // Kontrola zmeny den/noc pro subrasy
   Subraces_ModuleHeartBeat();
 }


}
