//tento skript by se mel zeptat, zda uz je neco nastavneho na prodej.
// jestli neni,mel by se spustit timer a az timer dobehne, tak by se mela vygenervoat dalsi shanka po predmetu.

#include "no_tcq_ko_inc"
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

                if(Random(100) > 80) { //  Vygeneruj quest s 25% sanci
                SetLocalInt(OBJECT_SELF,"obch_q_lastquest",ku_GetTimeStamp(0,60));
                                            //40 minut v pripade ze zadny quest neni
                return;
                                    }

    no_nahoda = 1 + Random(pocet_surovin); // pocet je v no_koze_q_inc

    SetLocalInt(OBJECT_SELF,"no_poptavka",no_nahoda);
    switch(no_nahoda) {
  //vycistene veci
case id_no_suse_obyc: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_suse_obyc); break;
case id_no_suse_leps : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_suse_leps); break;
case id_no_suse_kval : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_suse_kval); break;
case id_no_suse_mist : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_suse_mist); break;
case id_no_suse_velm : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_suse_velm); break;
case id_no_suse_lege : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_suse_lege); break;

case id_no_kuze_obyc : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_kuze_obyc); break;
case id_no_kuze_leps : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_kuze_leps); break;
case id_no_kuze_kval : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_kuze_kval); break;
case id_no_kuze_mist : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_kuze_mist); break;
case id_no_kuze_velm : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_kuze_velm); break;
case id_no_kuze_lege : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_kuze_lege); break;
    }




    no_nahoda = Random(10)+3; //vygeneruje kolik toho chce
    SetLocalInt(OBJECT_SELF,"no_pocetveci",no_nahoda);
    SetLocalInt(OBJECT_SELF,"obch_q_lastquest",ku_GetTimeStamp(0,720)); // zachova si quest celej restart
   }                                                                    //=12 hod REAL
}
