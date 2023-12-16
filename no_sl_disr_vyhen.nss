#include "ku_libtime"
#include "no_sl_functions"
object no_Item;
object no_oPC;



/////////////////////////
//no_menu:
//1 - cistit                 tag:no_cistit
//2 - legovat                tag:no_legovat
//3 - slevat slitiny         tag:no_slevat
//0 - zpet na start          tag:no_zpet
//
//////////////////////////

void main()
{
no_oPC=GetLastDisturbed();

////////////kdyz se z pece neco vezme/////////////////////////////////////////
if (GetInventoryDisturbType()== INVENTORY_DISTURB_TYPE_REMOVED) {
object no_vzataItem = GetInventoryDisturbItem();


/////////////////////////////1-NASTAVIT CISTIT/////////////////////////////////
if (GetTag(no_vzataItem) == "no_cistit" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"); //pridame tlacitko zpet
if (GetLocalInt(OBJECT_SELF,"no_sl_horipec") < ku_GetTimeStamp() )
FloatingTextStringOnCreature("Do pece bude potreba pridat vice uhli",no_oPC,FALSE );
else FloatingTextStringOnCreature("Teplota v peci je nastavena na cisteni nugetu",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",1);
} ///////////////////////////KONEC NASTAVIT CISTIT////////////////////

/////////////////////////////2-NASTAVIT LEGOVAT/////////////////////////////////
if (GetTag(no_vzataItem) == "no_legovat" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"); //pridame tlacitko zpet
if (GetLocalInt(OBJECT_SELF,"no_sl_horipec") < ku_GetTimeStamp() )
FloatingTextStringOnCreature("Do pece bude potreba pridat vice uhli",no_oPC,FALSE );
else FloatingTextStringOnCreature("Teplota v peci je nastavena na legovani kovu",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",2);
} ///////////////////////////KONEC NASTAVIT LEGOVAT////////////////////


/////////////////////////////3-NASTAVIT SLEVAT/////////////////////////////////
if (GetTag(no_vzataItem) == "no_slevat" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"); //pridame tlacitko zpet
if (GetLocalInt(OBJECT_SELF,"no_sl_horipec") < ku_GetTimeStamp() )
FloatingTextStringOnCreature("Do pece bude potreba pridat vice uhli",no_oPC,FALSE );
else FloatingTextStringOnCreature("Teplota v peci je nastavena na slevani slitin",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",3);
} ///////////////////////////KONEC NASTAVIT SLEVAT////////////////////



/////////////////////////////4-NASTAVIT ZPET  /////////////////////////////////
if (GetTag(no_vzataItem) == "no_zpet" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_cistit"),"Cistit kov");    //pridame tlacitka
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_legovat"),"Legovat kov");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_slevat"),"Slevat slitiny");
SetLocalInt(OBJECT_SELF,"no_menu",0);
} ///////////////////////////KONEC NASTAVIT ZPET  /////////////////////////
} //kdyz se z pece neco odstrani


/////////////Kdyz se do pece neco prida ///////////////////////////////////////
if (GetInventoryDisturbType()== INVENTORY_DISTURB_TYPE_ADDED) {
object no_pridanaItem = GetInventoryDisturbItem();

//////////Kdyz se pridalo uhli////////////////////////////////////
if(GetTag(no_pridanaItem) == "cnrLumpOfCoal") no_pridatuhli(no_pridanaItem,OBJECT_SELF);
//////////Konec uhli////////////////////////////////////////





}/////////  kdyz se do pece neco prida //////////////////////////////////


}
