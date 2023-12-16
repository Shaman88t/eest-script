/////////////////////////////////////////////////////////
// Modul: Mintaka
// Autor: Labir
// Aktualizace: 17.7.2005
// Skript: la_dooropen
// Popis: Skript na aktivaci placeblu
// Instalace: vlozit do OnEnder Event triggeru
/////////////////////////////////////////////////////////

// VYSVETLIVKY - promenne trigeru
//   int OBJECT_DELAY    - pocet sekund prodlevy po slapnuti na trigger
//   string OBJECT_TAG   - tag dveri pro otevreni
//   int OBJECT_COUNT    - pocet objektu pro otevreni,
//                         vsechny objekty musi mit stejny Tag!
//   int OBJECT_CLOSE    - pokud je 1 tak jsou po case objekty zavreny
//   int OBJECT_STAY     - pocet sec mezi otevrenim a uzavrenim
//   int OBJECT_LOCK     - pokud je 1 tak objekty po zavreni zamkne
//   int ONCE            - pokud je 1 tak trigger funguje jen jednou za restart

// VYSVETLIVKY - promenne oteviranych placeablu
//   int RAND_DELAY      - pocet sec 0-RAND_DELAY o ktere bude zpozdeno otevreni
//                         prave tohoto objektu


void main()
{
  object oSelf = OBJECT_SELF;
  string sObject_Tag = GetLocalString(oSelf,"OBJECT_TAG");
  int iObject_Count=GetLocalInt(oSelf,"OBJECT_COUNT");
  int iDelay = GetLocalInt(oSelf,"OBJECT_DELAY");
  int iDelay2=GetLocalInt(oSelf,"OBJECT_STAY");
  int iClose=GetLocalInt(oSelf,"OBJECT_CLOSE");
  int iLock=GetLocalInt(oSelf,"OBJECT_LOCK");
  int iOnce=GetLocalInt(oSelf,"ONCE");
  int iDone=GetLocalInt(oSelf,"DONE");
  int i,j;
  object oObject;
  object oPC=GetEnteringObject();
  int iRand_Delay;

  if (!iOnce || (iOnce && iDone==0))
    {
      for (i=0;i<iObject_Count;i++)
        {
          oObject = GetObjectByTag(sObject_Tag,i);
          if (GetIsObjectValid(oObject))
            {
              iRand_Delay=GetLocalInt(oObject,"RAND_DELAY");

              j=iDelay+Random(iRand_Delay+1);
              AssignCommand(oObject,DelayCommand(IntToFloat(j),SetLocked(oObject,FALSE)));
              AssignCommand(oObject,DelayCommand(IntToFloat(j),PlayAnimation(ANIMATION_PLACEABLE_OPEN)));

              if (iClose && iDelay2>0)
                {
                  AssignCommand(oObject,DelayCommand(IntToFloat(iDelay+iDelay2),PlayAnimation(ANIMATION_PLACEABLE_CLOSE)));
                  if (iLock)
                    AssignCommand(oObject,DelayCommand(IntToFloat(iDelay+iDelay2),SetLocked(oObject,TRUE)));
                }
            }
              else
            SendMessageToPC(oPC,"Chybne nastavene parametry");
        }

      SetLocalInt(oSelf,"DONE",1);
    }
}
