/////////////////////////////////////////////////////////
// Modul: Mintaka
// Autor: Labir
// Aktualizace: 17.7.2005
// Skript: la_dooropen
// Popis: Skript na ovladani dveri. Otevre dvere a prehraje
//        animaci na objektu, vyzaduje objekt na pocatku ve
//        vypnutem stavu
// Instalace: vlozit do OnUsed Event objektu
/////////////////////////////////////////////////////////

// VYSVETLIVKY
//   int DOOR_DELAY    - pocet sekund prodlevy mezi aktivaci a otevrenim
//   string DOOR_TAG   - tag dveri pro otevreni
//   int MODE          - mod otevirani dveri
//                       0..dvere se otevrou, zavrou pripadne automaticky
//                          skriptem na nich a paka se presune za 3 sec do
//                          polohy OFF
//                       1..dvere se otevrou, dalsi pouziti paky je zavre
//                          tento mod vyzaduje na pocatku zavrene dvere a
//                          paku ve stavu OFF, nebo otevrene dvere a paku
//                          ve stavu ON
//   int DOORLOCK      - pouze pro MODE==1, pokud je 1 tak po zavreni dveri
//                       je i zamkne

void main()
{
  object oSwitch = OBJECT_SELF;
  string sDoorTag = GetLocalString(oSwitch,"DOOR_TAG");
  int iDoorDelay = GetLocalInt(oSwitch,"DOOR_DELAY");
  int iMode=GetLocalInt(oSwitch,"MODE");
  int iLock=GetLocalInt(oSwitch,"DOORLOCK");

  object oDoor = GetObjectByTag(sDoorTag,0);

  if (GetIsObjectValid(oDoor))
    {
      if (iMode==0)
        {
          PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
          DelayCommand(IntToFloat(iDoorDelay),SetLocked(oDoor,FALSE));
          DelayCommand(IntToFloat(iDoorDelay),ActionOpenDoor(oDoor));
          DelayCommand(3.0,PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
        }
          else
        {
          if (GetIsOpen(oDoor))
            {
              PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
              ActionCloseDoor(oDoor);
              if (iLock>0) SetLocked(oDoor,TRUE);
            }
              else
            {
              PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
              SetLocked(oDoor,FALSE);
              ActionOpenDoor(oDoor);
            }
        }
    }
      else
    ActionSpeakString("Chybne nastavene parametry",TALKVOLUME_TALK);
}
