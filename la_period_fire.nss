/*****************************************************************************
  Autor:   Labir
  Zaznam:  13.12.2005
  Skript:  la_period_fire
  Sestava: Lokalni skripty
******************************************************************************
  Popis:   Spousten na triggeru ze skriptu la_period_start nebo ze sebe.

           projde vsechny ACTIVE_TAG waypointy v lokaci a nageneruje na nich
           efekt ohniveho pufnuti (50%) nebo plamene (50%). Efekt aplikuje
           s nahodnou prodlevou 0.0-5.0 sec.

           Pote projde vsechny PC zdali se nejaky nevyskytuje v oblasti, pokud
           ne tak smaze ze sebe promennou ACTIVE. A tim efektivne skonci az
           do dalsi aktivace na triggeru. Pokud v lokaci je n2jake PC tak
           s prodlevou 5.0-10.0 sec spusti sam sebe.
******************************************************************************
  Promenne:
    string CORE_TAG         Tag hlavniho triggeru, je jen jeden i pro vice
                            triggeru, promenna je umistena do vsech triggeru
    string ACTIVE_TAG       Tag waypointu na mistech slehajicich plamenu, ci
                            jinych efektu. Waypointu s timto tagem muze byt
                            vice. Promenna je ulozena v hlavnim triggeru s
                            tagem CORE_TAG.
    string SCRIPT_START     Jmeno skriptu, ktery se ma spustit. Promenna je
                            ulozena v hlavnim triggeru s tagem CORE_TAG.
*****************************************************************************/

void main()
{
  object oSelf=OBJECT_SELF;
  string sWP=GetLocalString(oSelf,"ACTIVE_TAG");
  int i=1;
//  float fDelay;
  effect eEffect;

  object oWP;//=GetNearestObjectByTag(sWP,oSelf,i);
  i =  GetLocalInt(oSelf,"WP_CNT");
  while (i>0)
    {
      oWP=GetLocalObject(oSelf,"FIRE_WP_"+IntToString(i));


//      fDelay=IntToFloat(Random(50))/10.0;
      if (Random(2)==1)
        {
          eEffect=EffectVisualEffect(VFX_IMP_FLAME_M);
          DelayCommand(IntToFloat(Random(30)),ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eEffect,GetLocation(oWP),IntToFloat(Random(30))));
          DelayCommand(IntToFloat(Random(30)),ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eEffect,GetLocation(oWP),IntToFloat(Random(30))));
//          DelayCommand(fDelay,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eEffect,GetLocation(oWP),IntToFloat(Random(50))/10.0));
        }
          else
        {
          eEffect=EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE);
//          DelayCommand(fDelay,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eEffect,GetLocation(oWP)));
          DelayCommand(IntToFloat(Random(30)),ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eEffect,GetLocation(oWP)));
        }
      i--;
//      oWP=GetNearestObjectByTag(sWP,oSelf,i);
    }

  i=0;
  object oPC=GetFirstPC();
  while (GetIsObjectValid(oPC) && !i)
    {
      if (GetTag(GetArea(oPC))==GetTag(GetArea(oSelf))) {
        i=1;
        break;
      }
      oPC=GetNextPC();
    }

  if (i)
//    DelayCommand(5.0+IntToFloat(Random(50))/10.0,ExecuteScript("la_period_fire",oSelf));
    DelayCommand(30.0+IntToFloat(Random(5)),ExecuteScript("la_period_fire",oSelf));
  else
    DeleteLocalInt(oSelf,"ACTIVE");
}
