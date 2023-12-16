
#include "no_post_inc"


object no_Item;
string no_nazev;
int no_cena;
int no_vaha;
int no_donaska;
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
//case id_cheel_univ: no_nazev = " arcimagovi University svirfnebliniho mesta Cheel del Wlalths "; break;
//case id_cheel_labo: no_nazev = " alchymistickych laboratori svirfnebliniho mesta Cheel del Wlalths "; break;
//case id_cheel_obch: no_nazev = " universitniho obchodu svirfnebliniho mesta Cheel del Wlalths "; break;
//case id_hagol_soud: no_nazev = " nejvyssimu soudci v duergarskem meste Hagolu "; break;


        case id_char_klen_uli: no_nazev ="Balicek Ulihir S´Lleth klenotnikovi v novem meste v Charaxassu"; break;
        case id_char_klen_bar: no_nazev ="Balicek Barvirce v novem meste Charaxassu"; break;
        case id_char_doup_dro: no_nazev ="Balicek Drowovy v doupeti rozkose v Charaxssu"; break;
        case id_char_hude_oby:no_nazev ="Hraci na klavir v novem meste v Charaxassu "; break;
        case id_char_velk_aka: no_nazev =" Urednikovi v akademii valky v Charaxssu  "; break;
        case id_char_velk_xia:no_nazev =" Elrade v Xi´Anine chramu v Charaxassu"; break;
        case id_char_velk_pal: no_nazev =" Garda matky Szai v palaci v Charaxassu "; break;
        case id_char_star_zei: no_nazev =" Naerlisovi v Zeirove chramu v Charaxassu  "; break;
        case id_char_star_gih: no_nazev ="  Giheirn Mrai´De ve sterem meste v Charaxassu "; break;
        case id_chee_pris: no_nazev ="  Sia, Lilithine knezce v Cheel Del Wlalths "; break;
        case id_chee_inte: no_nazev ="  Staremu demonovy v Cheel Del Wlalths "; break;
        case id_chee_obch: no_nazev =" D´lhiff Alhmur - vobchodni ctvrti  Cheel Del Wlalths "; break;
        case id_chee_obch_fro:no_nazev ="Frobo Felibethu - krejcimu v obchodni ctvrti  Cheel Del Wlalths "; break;
        case id_chee_name: no_nazev ="Vynalezci na namesti v  Cheel Del Wlalths "; break;
        case id_chee_name_alc: no_nazev ="Moduro, správce alchymistickych laboratori v  Cheel Del Wlalths "; break;
        case id_chee_name_mag:no_nazev =" Lorie Nemaros, magicky obchod v  Cheel Del Wlalths "; break;
        case id_chee_inte_sac: no_nazev =" Roirry Bretyad, universitni obchod v  Cheel Del Wlalths "; break;
        case id_chee_magi: no_nazev =" Bardo Krutipirkovi, arcimag university v  Cheel Del Wlalths "; break;
        case id_olat: no_nazev ="  Jeirfel v Olath Deis"; break;
        case id_olat_cern: no_nazev =" Strazi v dilnach v Olath Deis"; break;
        case id_hago_murg: no_nazev =" Murgarovi , Veliteli Chmurne Straze v Hagolu"; break;
        case id_hago_name: no_nazev =" Grarrovi, Helgaronove knezi v Hagolu"; break;
         case id_hago_doln_sip: no_nazev =" remeslnikovi v siparstvi v dolnim Hagolu "; break;
         case id_hago_doln_hut: no_nazev ="Regdarrovi , Vedoucimu slevaci v hutich v Hagolu "; break;
         case id_hago_chmu: no_nazev = "Chmurne strazi v hagolskych hutich"; break;
}

no_vaha = GetWeight(no_Item);  //dava to 10x vetsi vahu bez desetineho mista
no_flvaha = (IntToFloat(no_vaha))/10;

no_donaska = GetLocalInt(OBJECT_SELF,"no_donaska");
no_cena = GetLocalInt(no_Item,"no_cena");

SpeakString("mam tady balik do " + no_nazev + " vazici " + FloatToString(no_flvaha,3,1) + " liber. Kdyz ho stihnes dorucit za " +IntToString(no_donaska) + " hodin, daji ti za nej " + IntToString(no_cena) + " zlatych. Kdyz to nestihnes, daji ti jen petinu zlatek. Jako zalohu si od tebe vezmu desetinu ceny baliku. ");


no_cena = FloatToInt(  IntToFloat(GetLocalInt(no_Item,"no_cena")) / 10 );

//////////////////////////////////////////////////////////
       /// 21.cervence
object no_oPC = GetPCSpeaker();
if  (GetGold(no_oPC) < (no_cena/10)) {
SendMessageToPC(no_oPC, "-------------------------------------" );
SendMessageToPC(no_oPC, " Nemas dostatek penez na odkup baliku " );
SendMessageToPC(no_oPC, "-------------------------------------" );
                                }

//////////////////////////////////////////////////////////

}
}
