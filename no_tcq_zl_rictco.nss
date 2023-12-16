//skript by mel rict co shani, ci rict,ze  obchodnik nic neshani

#include "no_tcq_zl_inc"

string no_nazev;
string no_pomocna;
int no_pocet;

void main()
{

no_pocet = GetLocalInt(OBJECT_SELF,"no_pocetveci");
no_pomocna = IntToString(no_pocet);
/////////////nutne pro receni, kolik toho chce.


string no_zbozi = GetLocalString(OBJECT_SELF,"no_poptavka");
///to nahraje tag, co se vygeneroval.
no_udelejjmeno(no_zbozi);
// z tagu udela nazev veci, kterj ulozi do veci, ze ktere ho vyvolame.
no_nazev = GetLocalString(OBJECT_SELF,"no_jmeno");

/*
if (no_nazev == "no_boruvka") { no_nazev = "boruvek";   }    //musi se vepsta nazvy veci podle resref
if (no_nazev == "no_malina") { no_nazev = "malin";   }
*/

if (no_pocet==0 ) SpeakString(" Momentalne nic neshanim. ");   // kdyz nic nechce

else SpeakString(" Jdes jako na zavolanou. Kdyz mi prineses " + no_pomocna + "  " +  no_nazev + " tak ti za ne zaplatim dvakrat vice, nez kterykoliv jiny obchodnik. " );
}
