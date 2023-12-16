//tento skript by se mel zeptat, zda uz je neco nastavneho na prodej.
// jestli neni,mel by se spustit timer a az timer dobehne, tak by se mela vygenervoat dalsi shanka po predmetu.

#include "no_obch_q_inc"
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

                if(Random(100) > 69) { //  Vygeneruj quest s tricetiprocentni sanci
                SetLocalInt(OBJECT_SELF,"obch_q_lastquest",ku_GetTimeStamp(0,30));
                                             //30 minut v pripade ze zadny quest neni
                return;
                                    }

    no_nahoda = 1 + Random(pocet_surovin); //musi se napsat kolik je moznosti veci na vykup

    SetLocalInt(OBJECT_SELF,"no_poptavka",no_nahoda);
    switch(no_nahoda) {
      //by Kucik
      case id_bezinka: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_bezinka); break;
      case id_jalovec: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_jalovec); break;
      case id_vino: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_vino); break;
      case id_hruska: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_hruska); break;
      case id_malina: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_malina); break;
      case id_ostruzina: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_ostruzina); break;
      case id_tresne: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_tresne); break;
      //by Nomis
      case id_boruvky: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_boruvky); break;
      case id_brusinky: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_brusinky); break;
      case id_jablko: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_jablko); break;
      case id_andelskylist: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_andelskylist); break;
      case id_korencomfry: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_korencomfry); break;
      case id_korenechinacea: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_korenechinacea); break;
      case id_korengiseng: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_korengiseng); break;
      case id_kvetchmelu: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_kvetchmelu); break;
      case id_kvetmesicku: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_kvetmesicku); break;
      case id_liskovyorisek: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_liskovyorisek); break;
      case id_aloe: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_aloe); break;
      case id_listbodlaku: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_listbodlaku); break;
      case id_listcepicky: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_listcepicky); break;
      case id_listjetele: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_listjetele); break;
      case id_listkoprivy: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_listkoprivy); break;
      case id_listmaty: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_listmaty); break;
      case id_orechovec: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_orechovec); break;
      case id_vlasskyorech: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_vlasskyorech); break;
    }

    no_nahoda = 5 + Random(20); //vygeneruje kolik toho chce
    SetLocalInt(OBJECT_SELF,"no_pocetveci",no_nahoda);
    SetLocalInt(OBJECT_SELF,"obch_q_lastquest",ku_GetTimeStamp(0,150)); //150 minut v pripade zapocateho questu
   }
}
