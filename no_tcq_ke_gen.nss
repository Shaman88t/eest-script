//tento skript by se mel zeptat, zda uz je neco nastavneho na prodej.
// jestli neni,mel by se spustit timer a az timer dobehne, tak by se mela vygenervoat dalsi shanka po predmetu.

#include "no_tcq_ke_inc"
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
  //vycistene veci
case id_no_cist_jil: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_cist_jil); break;
case id_no_cist_pise: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_cist_pise); break;
//vyrobky
case id_mala_forma: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_mala_forma); break;
case id_sklenena_lahev: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_sklenena_lahev); break;
case id_tenka_forma : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tenka_forma); break;
case id_sklenena_ampule : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_sklenena_ampule); break;
case id_stredni_forma : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_stredni_forma); break;
case id_velka_forma: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_velka_forma); break;
case id_zahnuta_forma: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_zahnuta_forma); break;
    }




    no_nahoda = Random(30)+3; //vygeneruje kolik toho chce
    SetLocalInt(OBJECT_SELF,"no_pocetveci",no_nahoda);
    SetLocalInt(OBJECT_SELF,"obch_q_lastquest",ku_GetTimeStamp(0,720)); // zachova si quest celej restart
   }                                                                    //=12 hod REAL
}
