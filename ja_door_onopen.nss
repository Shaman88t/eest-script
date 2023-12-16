/*
    ja_door_onclose
*/
// VYSVETLIVKY
//   int DOORCLOSE=0 - vypnute
//   int DOORCLOSE=1 - zapnute
//   int DOORCLOSE_DELAY=55 - zavrit za 55 sekund
//   int DOORLOCK=0 - vypnute
//   int DOORLOCK=1 - zamknout v noci
//   int DOORLOCK=2 - zamknout ve dne
//   int DOORLOCK=3 - zamknout kdykoliv


void unlock(object oDoor){
    SetLocked(oDoor, FALSE);
    SetLocalInt(oDoor, "JA_DOOR_SETTIMER", 0);
}

int getIsDay(){ //upravene GetIsDay
    int iHour = GetTimeHour();
    if(iHour >= 23 || iHour <= 4)
        return 0;


    return 1;
}

void main()
{

   object oDvere = OBJECT_SELF;
   object oPC = GetLastOpenedBy();

   //if(GetLocalInt(oDvere, "JA_DOOR_DELAY")) return; //delay catch

   int iDoorClose = GetLocalInt (oDvere, "DOORCLOSE");
   int iDoorClose_Delay = GetLocalInt (oDvere, "DOORCLOSE_DELAY");
   int iDoorLock = GetLocalInt(oDvere, "JA_DOOR_NIGHTLOCK");
    if(!iDoorLock) iDoorLock = GetLocalInt (oDvere, "DOORLOCK");

   //Overime, jestli je Close_Time zadanej, jestli ne, nebudeme dvere
   //zavirat a vypiseme Debug hlasku v pripade, ze je zadany, aby se zaviraly
   if(iDoorClose_Delay < 1 && iDoorClose == 1)
   {
       iDoorClose_Delay = 20;
//       SendMessageToPC(oPC, "[DEBUG] - Tyto dvere maji spatne nastavene promenne, prosim kontaktujte DM a informujte ho o teto chybe");
//       return;
   }

   //Pokud mame dvere zavirt a je spravne nastavnenj close time, tak je zavreme
   if(iDoorClose == 1 && iDoorClose_Delay >= 1)
   {
       DelayCommand(IntToFloat(iDoorClose_Delay),ActionCloseDoor(oDvere));
   }

   //Pokud mame dvere zamknout, tak je zamkneme... K tomu potrebujeme overit, jestli je
   //den, nebo noc

   int isDay = getIsDay();

   if(!isDay && iDoorLock == 1) //v noci zavrit
   {
       ActionCloseDoor(oDvere);
       SetLocked(oDvere,TRUE);
       SetLockKeyRequired(oDvere, TRUE);

       //nastavime delay na otevreni
        if(!GetLocalInt(OBJECT_SELF, "JA_DOOR_SETTIMER")){
            int iDuration = GetTimeHour();

            if(iDuration >= 23)
                iDuration = 29-iDuration;
            else
               iDuration = 5-iDuration;

            DelayCommand(HoursToSeconds(iDuration), unlock(oDvere));
            SetLocalInt(OBJECT_SELF, "JA_DOOR_SETTIMER", 1);
        }
   }
   else if(isDay && iDoorLock == 2) //ve dne zavrit
   {
       ActionCloseDoor(oDvere);
       SetLocked(oDvere,TRUE);
       SetLockKeyRequired(oDvere, TRUE);

       //nastavime delay na otevreni
        if(!GetLocalInt(OBJECT_SELF, "JA_DOOR_SETTIMER")){
            int iDuration = 23 - GetTimeHour();

            DelayCommand(HoursToSeconds(iDuration), unlock(oDvere));
            SetLocalInt(OBJECT_SELF, "JA_DOOR_SETTIMER", 1);
        }
   }
   else if(iDoorLock == 3) //vzdy
   {
//       ActionCloseDoor(oDvere);
       SetLocked(oDvere,TRUE);
   }

   SetLocalInt(oDvere, "JA_DOOR_DELAY", 1);
   DelayCommand(1.0f, DeleteLocalInt(oDvere, "JA_DOOR_DELAY"));
}
