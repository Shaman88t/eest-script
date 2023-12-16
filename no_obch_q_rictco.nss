//skript by mel rict co shani, ci rict,ze  obchodnik nic neshani

#include "no_obch_q_inc"

string no_nazev;
string no_pomocna;
int no_pocet;

void main()
{

no_nazev = GetLocalString(OBJECT_SELF,"no_nazevveci");   //nahrani promene do skriptu
no_pocet = GetLocalInt(OBJECT_SELF,"no_pocetveci");
no_pomocna = IntToString(no_pocet);
int zbozi = GetLocalInt(OBJECT_SELF,"no_poptavka");


switch(zbozi) {
 case id_bezinka: no_nazev = "bezinek"; break;
 case id_jalovec: no_nazev = "bobuli jalovce"; break;
 case id_vino: no_nazev = "hroznu vina"; break;
 case id_hruska: no_nazev = "hrusek"; break;
 case id_malina: no_nazev = "malin"; break;
 case id_ostruzina: no_nazev = "ostruzin"; break;
 case id_tresne: no_nazev = "tresni"; break;
//by Nomis
      case id_boruvky : no_nazev = "boruvek"; break;
      case id_brusinky : no_nazev = "brusinek"; break;
      case id_jablko: no_nazev = "jablek"; break;
      case id_andelskylist: no_nazev = " andelskych listu"; break;
      case id_korencomfry: no_nazev = "korenu comfry"; break;
      case id_korenechinacea: no_nazev = "korenu echinacea"; break;
      case id_korengiseng: no_nazev = " korenu gisengu"; break;
      case id_kvetchmelu: no_nazev = "kvetu chmelu"; break;
      case id_kvetmesicku: no_nazev = "kvetu mesicku"; break;
      case id_liskovyorisek: no_nazev = "liskovych orisku"; break;
      case id_aloe: no_nazev = " listu aloe"; break;
      case id_listbodlaku: no_nazev = " listu bodlaku"; break;
      case id_listcepicky: no_nazev = " listu cepicky"; break;
      case id_listjetele: no_nazev = "listu jetele"; break;
      case id_listkoprivy: no_nazev = "listu koprivy"; break;
      case id_listmaty: no_nazev = "listu maty"; break;
      case id_orechovec: no_nazev = "listu orechovce"; break;
      case id_vlasskyorech: no_nazev = "valsskych orechu"; break;
}

/*
if (no_nazev == "no_boruvka") { no_nazev = "boruvek";   }    //musi se vepsta nazvy veci podle resref
if (no_nazev == "no_malina") { no_nazev = "malin";   }
*/

if (no_pocet==0 ) SpeakString(" Momentalne mi nic nechybi. ");   // kdyz nic nechce

else SpeakString(" No,neco by se mi hodilo. Kdyz mi nasbiras " + no_pomocna + "  " +  no_nazev + " tak ti za ne dobre zaplatim. " );
}
