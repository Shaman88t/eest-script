#include "ku_libtime"

object no_Item;
object no_oPC;
string no_kamjde;
string no_posta;
string no_pozde;
int no_cena;
int no_price;



void main()
{
no_price = 0;
no_cena= 0;
no_oPC = GetPCSpeaker();
int no_pocet_provedeni = 0;
float no_delay = 0.0;

no_Item = GetFirstItemInInventory(no_oPC);
while  (GetIsObjectValid(no_Item)) {

if  (GetTag(no_Item)=="no_balik") {
no_kamjde = GetLocalString(no_Item,"no_kamjde");
no_posta = GetLocalString(OBJECT_SELF,"no_posta");
    if (no_kamjde == no_posta)  {  //tak uz vime, ze miri sem
                                    no_cena = GetLocalInt(no_Item,"no_cena");
                                    if (GetLocalInt(no_Item,"no_cas") < ku_GetTimeStamp() ) {
                                    DelayCommand(no_delay,SpeakString(" *prohlidne si balik* Tenhle balik uz tu davno mel byt. Dostanes za nej desetinu ceny, coz dela " + IntToString(no_cena/5)  + " zlataku"));
                                    no_cena =no_cena/5;
                                    no_pocet_provedeni = no_pocet_provedeni+1;
                                    DestroyObject(no_Item,no_delay);
                                    no_delay = no_delay + 1.0;
                                                           }
                                    if (GetLocalInt(no_Item,"no_cas") > ku_GetTimeStamp() ) {
                                    DelayCommand(no_delay,SpeakString(" *prohlidne si balik* Tak, tenhleten balik je tu vcas., coz dela " + IntToString(no_cena)  + " zlataku"));
                                    no_cena =no_cena;
                                    no_pocet_provedeni = no_pocet_provedeni+1;
                                    DestroyObject(no_Item,no_delay);
                                    no_delay = no_delay + 1.0;                                    }

                                no_price = no_price + no_cena;      //cenu poscitam do tohohle kvuli zjisteni
                                                                    //zda nejaky balik prodal

                                }// if je to balik sem.

        }// IF JE TO BALIK
  no_Item = GetNextItemInInventory(no_oPC);
  if (!GetIsObjectValid(no_Item)) break;
  }// prohledavani inventare


if (no_pocet_provedeni >1) {
  DelayCommand(no_delay,SpeakString(" Dohromady tedy za tyhle "+ IntToString(no_pocet_provedeni) + " baliky to mame " + IntToString(no_price) + " zlataku " ));
  DelayCommand(no_delay,GiveGoldToCreature(no_oPC,no_price));
  }
  //rekne cenu, ktera se nastavila uz na zacatku
else if (no_pocet_provedeni ==1)   {
  DelayCommand(no_delay - 1.0,GiveGoldToCreature(no_oPC,no_price));}
else if (no_pocet_provedeni ==0)   {
    DelayCommand(no_delay,SpeakString( " Nemas u sebe zadny balik pro mne " ));
    DelayCommand(no_delay,GiveGoldToCreature(no_oPC,no_price));
    }


}
