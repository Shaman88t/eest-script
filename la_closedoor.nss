/////////////////////////////////////////////////////////
// Modul: Mintaka                                      //
// Autor: eHoly                                        //
// Aktualizace: 19.5.2005 Labir                        //
// Skript: la_closedoor                                //
// Popis: Skript na ovladani dveri. Pokud na dverich   //
//        promena nebude nastavena, bude automaticke   //
//        zavirani popripade zamykani vypnute          //
// Instalace: vlozit do OnOpen Event dveri             //
/////////////////////////////////////////////////////////

// VYSVETLIVKY
//   int DOORCLOSE=0 - vypnute
//   int DOORCLOSE=1 - zapnute
//   int DOORCLOSE_DELAY=55 - zavrit za 55 sekund
//   int DOORLOCK=0 - vypnute, nejde nikdy zamknout
//                    u dveri nenastavovat zamceno!
//   int DOORLOCK=1 - zamknout jen v noci, pres den odemceno.
//                    v noci nejde odemknout ani klicem, nejde zamknout
//                    u dveri nenastavovat zamceno!
//   int DOORLOCK=2 - zamknout jen ve dne, pres noc odemceno
//                    ve dne nejde odemknout ani klicem, nejde zamknout
//                    u dveri nenastavovat zamceno!
//   int DOORLOCK=3 - zamknout kdykoliv
//                    lze odemknout pouze klicem, je nutne nastavit zamceno,
//                    lze znovu zamknout a je zaporebi klic

void main()
{
object oDvere=OBJECT_SELF;
object oPC=GetLastOpenedBy();

int iDoorClose=GetLocalInt (oDvere, "DOORCLOSE");
int iDoorClose_Delay=GetLocalInt (oDvere, "DOORCLOSE_DELAY");
int iDoorLock=GetLocalInt (oDvere, "DOORLOCK");
int isDay=GetIsDay ();

  switch (iDoorLock) {
    case 0: //odemceno vzdy
      if(iDoorClose == 1 && iDoorClose_Delay >= 1)
        DelayCommand(IntToFloat(iDoorClose_Delay),ActionCloseDoor(oDvere));
      break;
    case 1: //pres den odemceno, v noci zamceno
      if (!isDay)
        {
          ActionCloseDoor(oDvere);
          SendMessageToPC(oPC,"*zamceno*");
        }
          else
        if(iDoorClose == 1 && iDoorClose_Delay >= 1)
          DelayCommand(IntToFloat(iDoorClose_Delay),ActionCloseDoor(oDvere));
      break;
    case 2: //pres noc odemceno, ve dne zamceno
      if (isDay)
        {
          ActionCloseDoor(oDvere);
          SendMessageToPC(oPC,"*zamceno*");
        }
          else
        if(iDoorClose == 1 && iDoorClose_Delay >= 1)
          DelayCommand(IntToFloat(iDoorClose_Delay),ActionCloseDoor(oDvere));
      break;
    case 3: //vzdy zamykat, lze otevrit jen klicem
      if(iDoorClose == 1 && iDoorClose_Delay >= 1)
        {
          DelayCommand(IntToFloat(iDoorClose_Delay),ActionCloseDoor(oDvere));
          DelayCommand(IntToFloat(iDoorClose_Delay),SetLocked(oDvere,TRUE));
        }
      break;
  }
}
