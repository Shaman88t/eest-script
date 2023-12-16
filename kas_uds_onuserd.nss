float DetermineNextInterval()
{
    int iDice = GetLocalInt(OBJECT_SELF, "iDice");
    int iMultiplier = GetLocalInt(OBJECT_SELF, "iMultiplier");
    if(iMultiplier <= 0)
       iMultiplier = 5;

    int iInterval;

    switch (iDice)
     {
          case 0:
                iInterval = iMultiplier;
                break;
          case 1:
                iInterval = d2() * iMultiplier;
                break;
          case 2:
                iInterval = d3() * iMultiplier;
                break;
          case 3:
                iInterval = d4() * iMultiplier;
                break;
          case 4:
                iInterval = d6() * iMultiplier;
                break;
          case 5:
                iInterval = d8() * iMultiplier;
                break;
          case 6:
                iInterval = d10() * iMultiplier;
                break;
     }

     return IntToFloat(iInterval);
}

void  DamagePC()
{
    int iInterval;
    switch (GetLocalInt(OBJECT_SELF, "iDmg"))
     {
          case 1:
                iInterval = d10();
                break;
          case 2:
                iInterval = d20();
                break;
          case 3:
                iInterval = d20() + 10;
                break;
          case 4:
                iInterval = d20() + 30;
                break;
          case 5:
                iInterval = d20() + 50;
                break;
          case 6:
                iInterval = d20() + 60;
                break;
     }

   effect eDmg = EffectDamage(iInterval, DAMAGE_TYPE_BLUDGEONING);
   object oPC = GetFirstPC();

   while (GetIsObjectValid(oPC) == TRUE)
   {
      if(GetArea(oPC) == OBJECT_SELF)
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oPC);

      oPC = GetNextPC();
   }
}

void main()
{
    effect eShaker = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    int iEvent = GetUserDefinedEventNumber();
//     switch (GetUserDefinedEventNumber())
//     {
//          case 701:
//                {
     if(iEvent == 701) {
//                SendMessageToPC(GetFirstPC(),"start signal sent");
                object oPCShaker = GetLocalObject(OBJECT_SELF,"oPCShaker"); // podivam se kdo zemetreseni naposledy spustil
                if(GetTag(GetArea(oPCShaker)) != GetTag(OBJECT_SELF)) {
//                  SendMessageToPC(GetFirstPC(),"find PC");
                  oPCShaker = GetFirstPC();
                  while( (GetIsObjectValid(oPCShaker)) &&  (GetTag(GetArea(oPCShaker)) != GetTag(OBJECT_SELF))){
                    oPCShaker = GetNextPC();
                  }

                }
                if(GetIsObjectValid(oPCShaker))
//                if(GetLocalInt(OBJECT_SELF, "iPCsIn") > 0)
                {
                    if(GetLocalInt(OBJECT_SELF, "iDmg") > 0) DamagePC();
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eShaker, oPCShaker);
                    DelayCommand(DetermineNextInterval(), SignalEvent(OBJECT_SELF, EventUserDefined(701)));
                    SetLocalInt(OBJECT_SELF,"isShaker",TRUE);
                    SetLocalObject(OBJECT_SELF,"oPCShaker",oPCShaker);
                }
                else
                    SetLocalInt(OBJECT_SELF,"isShaker",FALSE);
     }
     else if(iEvent == 702 ) {
//          case 702:
                SetLocalInt(OBJECT_SELF,"isShaker",FALSE);
                ClearAllActions();
//                break;
     }
     else
       SetLocalInt(OBJECT_SELF,"isShaker",FALSE);
}
