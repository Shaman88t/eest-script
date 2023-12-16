///////////////////////////////////////////////////////
// Modul: Mintaka
// Autor: Labir
// Aktualizace: 10.9.2005 Labir
// Skript: la_mech_codegen
// Popis: Skript pro generovani kombinace nastaveni
//        prepinacu pro oteveni dveri, cast pro
//        spousteni ze spouste
// Instalace: vlozit do OnEnter Event spouste
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
  int iCode=GetLocalInt(oSelf,"CODE_GENERATE");
  int iCodeMade=GetLocalInt(oSelf,"CODE_MADE");
  object oPC=GetEnteringObject();

  if (GetIsObjectValid(oDoor))
    {
      if (iCode==1 || (iCode==2 && iCodeMade==0))
        {
          string sMechTags=GetLocalString(oDoor,"MECH_TAG");
          int iMechCount=GetLocalInt(oDoor,"MECH_COUNT");
          int i;
          string sMechTag;
          object oMech;
          int iReset=GetLocalInt(oSelf,"RESET_MECH");

          for (i=1;i<=iMechCount;i++)
            {
              sMechTag=sMechTags+IntToString(i);
              oMech=GetObjectByTag(sMechTag);

              if (GetIsObjectValid(oMech))
                {
                  SetLocalInt(oMech,"KEY",Random(2));
                  if (iReset)
                    {
                      AssignCommand(oMech,PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
                      SetLocalInt(oMech,"STATUS",0);
                    }
                }
                  else
                ActionSpeakString("CHYBA NASTAVENI - Mechanismus nenalezen",TALKVOLUME_TALK);
            }

          SetLocalInt(oSelf,"CODE_MADE",1);
        }
    }
      else
    ActionSpeakString("CHYBA NASTAVENI - Dvere nenalezeny",TALKVOLUME_TALK);
}
