//tento skript by se mel zeptat, zda uz je neco nastavneho na prodej.
// jestli neni,mel by se spustit timer a az timer dobehne, tak by se mela vygenervoat dalsi shanka po predmetu.

#include "no_tcq_zl_inc"
#include "ku_libtime"

int no_nahoda;
int no_pocet;
string no_tag;
string no_pomoc_string;
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
no_tag="";
if ( d2() == 1) no_tag = "no_zl_";   //prsten
else no_tag = "no_ZL_";     //amulet
//mame zaklad prstenu ci amuletu ted pouzitej kov

int no_nahoda = 1 + Random(12); // tzn 1-12
no_pomoc_string = IntToString(no_nahoda);
int no_delkastring = GetStringLength(no_pomoc_string);
if (no_delkastring ==1) no_tag = no_tag + "0" + no_pomoc_string + "_";
if (no_delkastring ==2) no_tag = no_tag +       no_pomoc_string + "_";
/// mame kov, ted tam dame nejakej ten prvni kamen. Ten maji vsechny kovy.

int no_nahoda2 = 1 + Random(15); // tzn 1-15
no_pomoc_string = IntToString(no_nahoda2);
    no_delkastring = GetStringLength(no_pomoc_string);
if (no_delkastring ==1) no_tag = no_tag + "0" + no_pomoc_string + "_";
if (no_delkastring ==2) no_tag = no_tag +       no_pomoc_string + "_";

///mame prvni prsten ted tam nacpem druhej, ale to jen kdyz mame na to dobrej kov + bude dobra nahoda.

if ((no_nahoda > 1 ) & ( d3()> 2 )) { // 33% sance, ze tam pribude 2 kamen
                                    no_nahoda2 = 1 + Random(15); // tzn 1-15
                                    no_pomoc_string = IntToString(no_nahoda2);
                                    no_delkastring = GetStringLength(no_pomoc_string);
                                    if (no_delkastring ==1) no_tag = no_tag + "0" + no_pomoc_string + "_00";
                                    if (no_delkastring ==2) no_tag = no_tag +       no_pomoc_string + "_00";
                                    }

else no_tag = no_tag + "00_00";
//kdyz to nevyjde, musime dokoncit syntaxu prstene.

    SetLocalString(OBJECT_SELF,"no_poptavka",no_tag);
/// ulozi na postavu do no_poptavka tag veci, co bude pak po nem chtit.
SendMessageToPC(GetPCSpeaker(),"no_tag veci: " + no_tag);

    no_nahoda = Random(3)+1; //vygeneruje kolik toho chce
    SetLocalInt(OBJECT_SELF,"no_pocetveci",no_nahoda);
    SetLocalInt(OBJECT_SELF,"obch_q_lastquest",ku_GetTimeStamp(0,720)); // zachova si quest celej restart
   }                                                                    //=12 hod REAL
}
