//vzdalenost v jake jeste v pristavu nabira pasazery [m]
float fDepDistance = 15.0;

#include "ku_ships"

void KU_ShipDeparture(int iShip) {

  int i = 1;
  object oMod = GetModule();
  location lShip_s = GetLocation(GetObjectByTag(GetLocalString(oMod,KU_SHIPS_STRUCT_TAG + "_Sea" + IntToString(iShip))));

  string sTicket = "ku_ship_ticket"+IntToString(iShip);

  object oPassanger = GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,i);
  while(GetIsObjectValid(oPassanger) && (GetDistanceToObject(oPassanger) < fDepDistance ) ) {
    if(SHIPS_DEBUG)
        SendMessageToPC(GetFirstPC(),"kontroluji"+GetName(oPassanger));
    if(GetIsObjectValid(GetItemPossessedBy(oPassanger,sTicket))) {
//      SendMessageToPC(GetFirstPC(),"ma listek"+GetName(oPassanger));
      AssignCommand(oPassanger,ClearAllActions(TRUE));
      AssignCommand(oPassanger, JumpToLocation(lShip_s));
      SetLocalInt(oPassanger,"KU_SHIPABOARD",iShip);

      object oHorse = GetLocalObject(oPassanger, "JA_HORSE_OBJECT");
      if(GetIsObjectValid(oHorse)) {
        if(GetDistanceToObject(oHorse) <= fDepDistance ) {
          CopyItem(GetItemPossessedBy(oPassanger,sTicket),oHorse);
          AssignCommand(oHorse,ClearAllActions(TRUE));
          AssignCommand(oHorse, JumpToLocation(lShip_s));
        }
      }

    }

    i++;
    oPassanger = GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,i);
  }
}


void KU_ShipArrival(int iShip) {

  int i = 1;
  object oMod = GetModule();
  location lShip_f = GetLocation(GetObjectByTag(GetLocalString(oMod,KU_SHIPS_STRUCT_TAG + "_Finish" + IntToString(iShip))));

  string sTicket = "ku_ship_ticket"+IntToString(iShip);

  object oPassanger = GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,i);
  while(GetIsObjectValid(oPassanger) && (GetDistanceToObject(oPassanger) < 20.0 ) ) {
    if(GetIsObjectValid(GetItemPossessedBy(oPassanger,sTicket))) {
      AssignCommand(oPassanger,ClearAllActions(TRUE));
      AssignCommand(oPassanger, JumpToLocation(lShip_f));
      DestroyObject(GetItemPossessedBy(oPassanger,sTicket));
    }
    if(GetLocalInt(oPassanger,"KU_SHIPABOARD") == iShip ) {
      AssignCommand(oPassanger,ClearAllActions(TRUE));
      AssignCommand(oPassanger, JumpToLocation(lShip_f));
      DeleteLocalInt(oPassanger,"KU_SHIPABOARD");
    }
    if(GetIsPC(oPassanger) && !GetIsDM(oPassanger)) {
      AssignCommand(oPassanger,ClearAllActions(TRUE));
      AssignCommand(oPassanger, JumpToLocation(lShip_f));
    }
    i++;
    oPassanger = GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,i);
  }
}


void main()
{
// int iShip = GetUserDefinedEventNumber(); _IsDepart

 int iShip = GetLocalInt(OBJECT_SELF,"ShipLineNumber");
 object oMod = GetModule();
// iShip = iShip - 600;
 string sShip = IntToString(iShip);



// if(GetUserDefinedEventNumber() > 600) {
//hlasi o odjezdu nebo prijezdu
   if(GetLocalInt(oMod,KU_SHIPS_STRUCT_TAG + "_IsDepart" + IntToString(iShip))==2 ) {
     KU_ShipDeparture(iShip);
   }
   else {

     KU_ShipArrival(iShip);
   }
//Odjezd za deset sekund

if(SHIPS_DEBUG)
  DelayCommand(10.0f,SendMessageToPC(GetFirstPC(),"dealyed message"));

}
