///////////////////////////////////////////////////////
// Modul: Mintaka
// Autor: Labir
// Aktualizace: 10.9.2005 Labir
// Skript: la_mech_make
// Popis: Skript pro overeni zda nebyla dosazena
//        oteviraci kombinace pro dvere, pokud ano
//        otevre dvere a podle nastaveni je po case
//        i pripadne zavre a nastavi novou kombinaci
// Instalace: vlozit do OnUsed Event mechanismu
///////////////////////////////////////////////////////

// VYSVETLIVKY - PROMENNE VSECH MECHANISMU (podlaznich pak)
//   string DOOR_TAG     - tag dveri co se maji otevirat
//   int STATUS          - indikace zap/vyp, pokud bude na pocatku paka
//                         ve stavu vyp tak neni treba nastavovat
//   int KEY             - klic pro otevreni pro danou paku, nastavuje se samo

// VYSVETLIVKY - PROMENNE SPOUSTECIHO TRIGGERU
//   string DOOR_TAG     - tag dveri co se maji otevirat
//   int CODE_GENERATE   - zpusob generovani kodu
//                         0 - vypnuto
//                         1 - vzdy po naslapnuti
//                         2 - jen jednou za restart serveru
//   string OPEN_SOUND   - tag zvuku co se ma prehrat pri nalezeni kombinace
//   int RESET_MECH      - Pokud je 1 tak pri vygenerovani kodu prepne
//                         paky do rezimu vypnuto

// VYSVETLIVKY - PROMENNE DVERI
//   string MECH_TAG     - tag spouustecich pak, paky maj tagy <MECH_TAG>N
//                         kde N je cislo od 1 vcetne
//   int MECH_COUNT      - pocet spoustecich mechanismu
//   int DOORCLOSE       - indikace zda se maji dvere zavrit po otevreni
//                         0..NE, 1..ANO
//   int DOORLOCK        - indikace zda se maji po otevreni dvere zamknout ci ne
//                         0..NE, 1..ANO
//   int DOORCLOSE_DELAY - pocet sec prodleni pred zavrenim dveri
//   int RESET_ON_CLOSE  - indikace znovuvygenerovani kodu po jeho sozlusteni
//                         0..NE zustane stary kod, 1..ANO vygeneruje se novy
//   int RESET_MECH      - Pokud je 1 tak pri vygenerovani kodu prepne
//                         paky do rezimu vypnuto

void main()
{
  object oSelf=OBJECT_SELF;
  string sDoorTag=GetLocalString(oSelf,"DOOR_TAG");
  object oDoor=GetObjectByTag(sDoorTag);
  int iStatus;
  int iKey;
  object oPC=GetLastUsedBy();

  //Pohyb mechanismu
  iStatus=GetLocalInt(oSelf,"STATUS");
  if (iStatus)
    {
      PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
      SetLocalInt(oSelf,"STATUS",0);
    }
      else
    {
      PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
      SetLocalInt(oSelf,"STATUS",1);
    }

  //Kontrola pripadneho nalezeni kombinace a otevreni
  if (GetIsObjectValid(oDoor))
    {
      string sMechTags=GetLocalString(oDoor,"MECH_TAG");
      int iMechCount=GetLocalInt(oDoor,"MECH_COUNT");
      int i;
      string sMechTag;
      object oMech;
      int iSuccess=TRUE;

      //Kontrola kombinace
      for (i=1;i<=iMechCount;i++)
         {
           sMechTag=sMechTags+IntToString(i);
           oMech=GetObjectByTag(sMechTag);

           if (GetIsObjectValid(oMech))
             {
               iStatus=GetLocalInt(oMech,"STATUS");
               iKey=GetLocalInt(oMech,"KEY");
               if (iStatus != iKey) iSuccess=FALSE;
             }
               else
             ActionSpeakString("CHYBA NASTAVENI - Mechanismus nenalezen",TALKVOLUME_TALK);
         }

      //Otevreni dveri
      if (iSuccess)
        {
          PlaySound(GetLocalString(oSelf,"OPEN_SOUND"));
          SetLocked(oDoor,FALSE);
          ActionOpenDoor(oDoor);

          ActionSpeakString("*je slyset jak se sepnul mechanismus*",TALKVOLUME_TALK);

          int iDelay=GetLocalInt(oDoor,"DOORCLOSE_DELAY");
          int iClose=GetLocalInt(oDoor,"DOORCLOSE");
          int iLock=GetLocalInt(oDoor,"DOORLOCK");
          int iReset=GetLocalInt(oDoor,"RESET_ON_CLOSE");
          int iReset_Mech=GetLocalInt(oDoor,"RESET_MECH");

          //Pripadne zavreni a zamceni dveri
          if (iClose>0 && iDelay>=0)
            DelayCommand(IntToFloat(iDelay),ActionCloseDoor(oDoor));
          if (iLock)
            DelayCommand(IntToFloat(iDelay),SetLocked(oDoor,TRUE));

          //Pripadne znovuvygenerovani kodu
          if (iReset)
            for (i=1;i<=iMechCount;i++)
              {
                sMechTag=sMechTags+IntToString(i);
                oMech=GetObjectByTag(sMechTag);

                if (GetIsObjectValid(oMech))
                  {
                    SetLocalInt(oMech,"KEY",Random(2));
                    if (iReset_Mech)
                      {
                        DelayCommand(IntToFloat(iDelay)-0.5,AssignCommand(oMech,PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE)));
                        DelayCommand(IntToFloat(iDelay)-0.5,SetLocalInt(oMech,"STATUS",0));
                      }
                  }
                    else
                  ActionSpeakString("CHYBA NASTAVENI - Mechanismus nenalezen",TALKVOLUME_TALK);
              }
        }
    }
      else
    ActionSpeakString("CHYBA NASTAVENI - Dvere nenalezeny",TALKVOLUME_TALK);
}
