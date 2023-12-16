/*****************************************************************************
  Autor:   Labir
  Zaznam:  13.12.2005
  Skript:  la_period_start
  Sestava: Lokalni skripty
******************************************************************************
  Popis:   Spousten na triggeru (muze jich byt vice) z udalosti OnEnter.

           Vyhleda nastaveny hlavni trigger a pokud je na nem promenna
           ACTIVE nenulova tak skonci - skript pro generovani plamenu jiz
           bezi. Pokud ne, tak je nastavena tato promenna a je spusten
           skript SCRIPT_START na tomto hlavnim triggeru
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
  string sTag=GetLocalString(oSelf,"CORE_TAG");
  object oExWP=GetObjectByTag(sTag);
  string sWP=GetLocalString(oExWP,"ACTIVE_TAG");
  int i=1;

  object oWP=GetNearestObjectByTag(sWP,oSelf,i);
  while (GetIsObjectValid(oWP))
    {
      SetLocalObject(oExWP,"FIRE_WP_"+IntToString(i),oWP);
      i++;
      oWP=GetNearestObjectByTag(sWP,oSelf,i);
    }
  SetLocalInt(oExWP,"WP_CNT",i-1);

  if (GetIsObjectValid(oExWP) && !GetLocalInt(oExWP,"ACTIVE"))
    {
      SetLocalInt(oExWP,"ACTIVE",1);
      ExecuteScript(GetLocalString(oExWP,"SCRIPT_START"),oExWP);
    }
      else
    if (!GetIsObjectValid(oExWP))
      SendMessageToPC(GetEnteringObject(),"[DEBUG] Chyba, nenalezen waypoint pro generovani plamenu.");
}
