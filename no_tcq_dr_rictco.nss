//skript by mel rict co shani, ci rict,ze  obchodnik nic neshani

#include "no_tcq_dr_inc"

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
case id_tc_osek_vrb : no_nazev = " kusu osekane vrby"; break;
case id_tc_osek_ore : no_nazev = " kusu osekane orechu"; break;
case id_tc_osek_dub : no_nazev = " kusu osekaneho dubu"; break;
case id_tc_osek_mah : no_nazev = " kusu osekaneho mahagonu"; break;
case id_tc_osek_tis : no_nazev = " kusu osekane tisu"; break;
case id_tc_osek_jil : no_nazev = " kusu osekane jilmu"; break;
case id_tc_osek_zel : no_nazev = " kusu osekane zelezneho dubu"; break;
case id_tc_osek_pra : no_nazev = " kusu osekaneho prastareho dubu"; break;
  // desky
case id_tc_desk_vrb : no_nazev = " vrbovych desek"; break;
case id_tc_desk_ore : no_nazev = " orechovych desek"; break;
case id_tc_desk_dub : no_nazev = " dubovych desek"; break;
case id_tc_desk_mah : no_nazev = " mahagonovych desek"; break;
case id_tc_desk_tis : no_nazev = " tisovych desek"; break;
case id_tc_desk_jil : no_nazev = " jilmovych desek"; break;
case id_tc_desk_zel : no_nazev = " desek zelezneho dubu"; break;
case id_tc_desk_pra : no_nazev = " desek prastareho dubu"; break;
//late
case id_tc_lat_vrb : no_nazev = " vrbovych lati"; break;
case id_tc_lat_ore : no_nazev = " orechovych latiu"; break;
case id_tc_lat_dub : no_nazev = " dubovych lati"; break;
case id_tc_lat_mah : no_nazev = " mahagonovych lati"; break;
case id_tc_lat_tis : no_nazev = " tisovych lati"; break;
case id_tc_lat_jil : no_nazev = " jilmovych lati"; break;
case id_tc_lat_zel : no_nazev = " lati zelezneho dubu"; break;
case id_tc_lat_pra : no_nazev = " lati prastareho dubu"; break;

//nasady
case id_tc_nasa_vrb : no_nazev = " vrbovych nasad"; break;
case id_tc_nasa_ore : no_nazev = " orechovych nasad"; break;
case id_tc_nasa_dub : no_nazev = " dubovych nasad"; break;
case id_tc_nasa_mah : no_nazev = " mahagonovych nasad"; break;
case id_tc_nasa_tis : no_nazev = " tisovych nasad"; break;
case id_tc_nasa_jil : no_nazev = " jilmovych nasad"; break;
case id_tc_nasa_zel : no_nazev = " nasad z zelezneho dubu"; break;
case id_tc_nasa_pra : no_nazev = "  nasad z prastareho dubu"; break;
}

/*
if (no_nazev == "no_boruvka") { no_nazev = "boruvek";   }    //musi se vepsta nazvy veci podle resref
if (no_nazev == "no_malina") { no_nazev = "malin";   }
*/

if (no_pocet==0 ) SpeakString(" Momentalne nic neshanim. ");   // kdyz nic nechce

else SpeakString(" Zrovna potrebuji dodavku materialu. Kdyz mi tedy prineses " + no_pomocna + "  " +  no_nazev + " tak ti za ne zaplatim trikrat vice, nez kterykoliv jiny obchodnik. " );
}
