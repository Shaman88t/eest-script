#include "ku_ships"

void main()
{
 object oMod = GetModule();
//  object oMerchant = GetLastSpeaker();
 object oPC = GetPCSpeaker();
// object oMerchant = GetLastSpeaker();
 string tMerchant = GetTag(OBJECT_SELF);
 string si;
 int i = 1;

 int NumOfShips = GetLocalInt(oMod,KU_SHIPS_COUNT);
 while (i <= NumOfShips ) {
   si = IntToString(i);
   if (GetLocalString(oMod,KU_SHIPS_STRUCT_TAG + "_Merchant" + si) == tMerchant) {
//     AssignCommand(OBJECT_SELF,SpeakString("CENA JE " + IntToString(GetLocalInt(oMod,"ku_ShipsCost" + si))));
//     AssignCommand(OBJECT_SELF,SpeakString("zlato : " + IntToString(GetGold(oPC))));
     int iCost = GetLocalInt(oMod,KU_SHIPS_STRUCT_TAG + "_Cost" + si);
     iCost = iCost * 3;

     if(GetGold(oPC) < iCost) {
       AssignCommand(OBJECT_SELF,SpeakString("Nemas dost zlata!"));
     }
     else {
       object oShip = GetObjectByTag(GetLocalString(oMod,KU_SHIPS_STRUCT_TAG + "_Port" + si));
       SetLocalInt(oShip,GetPCPlayerName(oPC) + GetName(oPC),1);
       TakeGoldFromCreature(iCost,oPC);
     }
    return;
   }
 i++;
 }

}
