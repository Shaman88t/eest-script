
#include "no_post_inc_povr"


object no_Item;
string no_nazev;
int no_donaska;
int no_cena;
int no_vaha;
float no_flvaha;
void main()
{

no_Item = GetFirstItemInInventory(OBJECT_SELF);
while(GetIsObjectValid(no_Item))  {
  if(GetTag(no_Item) == "no_balik")
    break;
  no_Item = GetNextItemInInventory(OBJECT_SELF);
  }            //projede si vlastni inventar, jestli u sebe ma balik


if (!GetIsObjectValid(no_Item)) {
  SpeakString( " Nemam tu pro tebe zadne baliky " );
  return;                       //kdyz nenajde balik
                                }





if (GetIsObjectValid(no_Item)) {    //kdyz najde balik

int no_nahoda = GetLocalInt(OBJECT_SELF,"no_switch");   //zjisti kam miri balik

switch(no_nahoda) {
case id_alwa_pala: no_nazev = "do kralovskeho palace v Alwarielu"; break;
case id_alwa_drui: no_nazev = "do sidla druidu v Alwarielu"; break;
case id_alwa_host: no_nazev = " hostinskemu U Mrzuteho sotka v Alwarielu"; break;
case id_shar_arci: no_nazev = "arcidruidovy ze Shardonskeho hajku"; break;
case id_doub_star: no_nazev = "starostovy Doubkova"; break;
case id_murg_host: no_nazev = " pro hostinskeho U Prasivyho baziliska z Murgondu"; break;
case id_ivor_zema: no_nazev = "pro zemana z Ivory"; break;
case id_kara_radn: no_nazev = "pro urednika na radnici v Karathe"; break;
case id_kara_obch: no_nazev = " do sidla svazu karathadskych obchodniku v Karathe"; break;
case id_kara_bran: no_nazev = "do vojenske akademie brana Rozvazneho v Karathe"; break;
case id_kara_thal: no_nazev = "do Thalova chramu v chramove ctvrti v Karathe"; break;
case id_kara_univ: no_nazev = "do magicke University v Karathe"; break;
case id_pous_knih: no_nazev = "knihovnikovi z palace mistodrziciho v poustnim meste Kel-A-Hazr"; break;
case id_pous_obch: no_nazev = "obchodnikovi U Mecouna z poustniho mesta Kel-A-Hazr"; break;
case id_kryn_host: no_nazev = "hostinskemu u Hrumburace v Krynskych horach"; break;
case id_dorn_dorn: no_nazev = "Dornovy z Dornova utociste"; break;
case id_tart_stra: no_nazev = "pro velitele strazi, hospoda U Peti soudku, Tarten"; break;
case id_grub_star: no_nazev = "pro starostu Gruberiku"; break;
case id_isil_veli: no_nazev = "pro velitele strazi v Isilske pevnosti"; break;
}

no_vaha = GetWeight(no_Item);  //dava to 10x vetsi vahu bez desetineho mista
no_flvaha = (IntToFloat(no_vaha))/10;
no_donaska = GetLocalInt(OBJECT_SELF,"no_donaska");
no_cena = GetLocalInt(no_Item,"no_cena");

SpeakString("Mam tady balik " + no_nazev + " vazici " + FloatToString(no_flvaha,3,1) + " liber. Kdyz to stihnes dorucit za " +IntToString(no_donaska) + " hodin, daji ti za nej " + IntToString(no_cena) + " zlatych. Jestlize to nestihnes, dostanes jen desetinu zlatek. ");


}
}
