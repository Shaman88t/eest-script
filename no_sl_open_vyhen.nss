#include "ku_libtime"

object no_oPC;
int no_menu;
void main()


/////////////////////////
//no_menu:
//1 - cistit                 tag:no_cistit
//2 - legovat                tag:no_legovat
//3 - slevat slitiny         tag:no_slevat
//0 - zpet na start          tag:no_zpet
//
//////////////////////////
{
no_oPC=GetLastDisturbed();


// budto horime od zacatku, nebo to znovu nastavi cas horeni od ted na 5minut

/////////////////////////////////////////////////////////////////////////////////
/////zjistime zda ted otvira stejne pc jako minule, jestli ne, nastavime menu na zacatek
no_oPC = GetLastOpenedBy();
if  (GetLocalObject(OBJECT_SELF,"no_lastopened") == no_oPC  ) {
no_oPC = GetLastOpenedBy();
SetLocalInt(OBJECT_SELF,"no_MULTIKLIK",GetLocalInt(OBJECT_SELF,"no_MULTIKLIK")+1);}
else {      // neni to stejne, takze menu na start
SetLocalObject(OBJECT_SELF,"no_lastopened",no_oPC);
SetLocalInt(OBJECT_SELF,"no_menu",0);        }
/////////////////////////////////////////////////////////////////////////////////
no_menu = GetLocalInt(OBJECT_SELF,"no_menu");
if(no_menu == 0)   // zacatek menu
  {
if (GetLocalInt(OBJECT_SELF,"no_sl_horipec") < ku_GetTimeStamp() )
FloatingTextStringOnCreature(" Pec uhasina, chtelo by to vice uhli ",no_oPC,FALSE );

else  FloatingTextStringOnCreature(" V peci jeste hori stare uhli ",no_oPC,FALSE );

SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_cistit"),"Cistit kov");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_legovat"),"Legovat kov");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_slevat"),"Slevat slitiny");
} else
  if(no_menu == 1)
  {
  if (GetLocalInt(OBJECT_SELF,"no_sl_horipec") > ku_GetTimeStamp() )
FloatingTextStringOnCreature("Teplota v peci je nastavena na cisteni nugetu",no_oPC,FALSE );
else    FloatingTextStringOnCreature("Pec uhasina, chtelo by to vice uhli",no_oPC,FALSE );
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet");
}  else
  if(no_menu == 2)
  {
    if (GetLocalInt(OBJECT_SELF,"no_sl_horipec") > ku_GetTimeStamp() )
FloatingTextStringOnCreature("Teplota v peci je nastavena na legovani kovu",no_oPC,FALSE );
else    FloatingTextStringOnCreature("Pec uhasina, chtelo by to vice uhli",no_oPC,FALSE );
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet");
} else
  if(no_menu == 3)
  {
      if (GetLocalInt(OBJECT_SELF,"no_sl_horipec") > ku_GetTimeStamp() )
FloatingTextStringOnCreature("Teplota v peci je nastavena na slevani slitin",no_oPC,FALSE );
else    FloatingTextStringOnCreature("Pec uhasina, chtelo by to vice uhli",no_oPC,FALSE );
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet");
};



}
