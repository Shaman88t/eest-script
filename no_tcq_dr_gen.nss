//tento skript by se mel zeptat, zda uz je neco nastavneho na prodej.
// jestli neni,mel by se spustit timer a az timer dobehne, tak by se mela vygenervoat dalsi shanka po predmetu.

#include "no_tcq_dr_inc"
#include "ku_libtime"

int no_nahoda;
int no_pocet;
//  string no_pomocna;  //jen pro debug

void main()

{
  no_pocet = GetLocalInt(OBJECT_SELF,"no_pocetveci");
  if (no_pocet==0 ) // kdyz je vse sehnane, vygeneruje novy quest
   {

                /// debug info pro zkouseni timeru

   //no_nahoda= GetLocalInt(OBJECT_SELF,"obch_q_lastquest");
   //no_pomocna= IntToString(no_nahoda);
   //SpeakString(" last quest: " + no_pomocna );

   //no_nahoda= ku_GetTimeStamp();
   //no_pomocna= IntToString(no_nahoda);
   //SpeakString(" time stamp: " + no_pomocna );
   //   SpeakString( " zkousi porovnavat" );

                 /// konec debug infa.. potom smazat


                if (GetLocalInt(OBJECT_SELF,"obch_q_lastquest") > ku_GetTimeStamp())
                return;

                if(Random(100) > 75) { //  Vygeneruj quest s 25% sanci
                SetLocalInt(OBJECT_SELF,"obch_q_lastquest",ku_GetTimeStamp(0,40));
                                            //40 minut v pripade ze zadny quest neni
                return;
                                    }

    no_nahoda = 1 + Random(pocet_surovin); // pocet je v no_koze_q_inc

    SetLocalInt(OBJECT_SELF,"no_poptavka",no_nahoda);
    switch(no_nahoda) {
  //osekane drevo
case id_tc_osek_vrb :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_osek_vrb); break;
case id_tc_osek_ore :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_osek_ore); break;
case id_tc_osek_dub :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_osek_dub ); break;
case id_tc_osek_mah :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_osek_mah ); break;
case id_tc_osek_tis :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_osek_tis ); break;
case id_tc_osek_jil :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_osek_jil ); break;
case id_tc_osek_zel :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_osek_zel); break;
case id_tc_osek_pra :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_osek_pra ); break;
  // desky
case id_tc_desk_vrb :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_desk_vrb ); break;
case id_tc_desk_ore :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_desk_ore ); break;
case id_tc_desk_dub :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_desk_dub ); break;
case id_tc_desk_mah :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_desk_mah ); break;
case id_tc_desk_tis :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_desk_tis ); break;
case id_tc_desk_jil :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_desk_jil ); break;
case id_tc_desk_zel :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_desk_zel ); break;
case id_tc_desk_pra :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_desk_pra ); break;
//late
case id_tc_lat_vrb :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_lat_vrb ); break;
case id_tc_lat_ore :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_lat_ore); break;
case id_tc_lat_dub :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_lat_dub ); break;
case id_tc_lat_mah :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_lat_mah ); break;
case id_tc_lat_tis :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_lat_tis ); break;
case id_tc_lat_jil :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_lat_jil ); break;
case id_tc_lat_zel :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_lat_zel ); break;
case id_tc_lat_pra :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_lat_pra ); break;

//nasady
case id_tc_nasa_vrb :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_nasa_vrb ); break;
case id_tc_nasa_ore :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_nasa_ore ); break;
case id_tc_nasa_dub :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_nasa_dub ); break;
case id_tc_nasa_mah :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_nasa_mah ); break;
case id_tc_nasa_tis :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_nasa_tis ); break;
case id_tc_nasa_jil :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_nasa_jil ); break;
case id_tc_nasa_zel :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_nasa_zel ); break;
case id_tc_nasa_pra :SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tc_nasa_pra ); break;
    }




    no_nahoda = Random(30)+3; //vygeneruje kolik toho chce
    SetLocalInt(OBJECT_SELF,"no_pocetveci",no_nahoda);
    SetLocalInt(OBJECT_SELF,"obch_q_lastquest",ku_GetTimeStamp(0,720)); // zachova si quest celej restart
   }                                                                    //=12 hod REAL
}
