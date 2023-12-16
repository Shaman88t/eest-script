//tento skript by se mel zeptat, zda uz je neco nastavneho na prodej.
// jestli neni,mel by se spustit timer a az timer dobehne, tak by se mela vygenervoat dalsi shanka po predmetu.

#include "no_love_q_inc"
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

case id_Bleskoveohnisko: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Bleskoveohnisko); break;
case id_Drahokamcirehozla: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Drahokamcirehozla); break;
case id_Drevoprastarehodubu: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Drevoprastarehodubu); break;
case id_Hlasivkysireny: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Hlasivkysireny); break;
case id_Hlavaprastarehourozenehotroloka: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Hlavaprastarehourozenehotroloka); break;
case id_Hlavastarehoorka: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Hlavastarehoorka); break;
case id_Hlavaurozenerakshasy:SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Hlavaurozenerakshasy); break;
case id_Hlavavudceyettiu:SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Hlavavudceyettiu); break;
case id_Kladelkokralovnyformianu:SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kladelkokralovnyformianu); break;
case id_Krevprvnihoupira: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Krevprvnihoupira); break;
case id_Krovkykralovnybroukuohnivaku:SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Krovkykralovnybroukuohnivaku); break;
case id_Krunyrsamicecernehostira:SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Krunyrsamicecernehostira); break;
case id_Krunyrsamicerudehostira: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Krunyrsamicerudehostira); break;
case id_Krunyrstarehohakovce: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Krunyrstarehohakovce); break;
case id_Krunyrstingera: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Krunyrstingera); break;
case id_Kuzesamicealansijskehotygra: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzesamicealansijskehotygra); break;
case id_Kuzecernehodraka: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzecernehodraka); break;
case id_Kuzeledovehodraka: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzeledovehodraka); break;
case id_Kuzemodrehodraka: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzemodrehodraka); break;
case id_Kuzeohnivehodraka: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzeohnivehodraka); break;
case id_Kuzeohnivehowyrma: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzeohnivehowyrma); break;
case id_Kuzestarezurivegorily: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzestarezurivegorily); break;
case id_Kuzezelenehodraka: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzezelenehodraka); break;
case id_Kuzezlatehodraka: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzezlatehodraka); break;
case id_Kyseleohnisko: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kyseleohnisko); break;
case id_Lebkademilicha: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Lebkademilicha); break;
case id_Lebkapanavlkodlaku: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Lebkapanavlkodlaku); break;
case id_Lebkaprastareholicha: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Lebkaprastareholicha); break;
case id_Lebkastareholicha: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Lebkastareholicha); break;
case id_Magickeohnisko: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Magickeohnisko); break;
case id_Mozekklepetnatcepsyonika: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Mozekklepetnatcepsyonika); break;
case id_Mozekstarsihomozkomora: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Mozekstarsihomozkomora); break;
case id_Mozkomysnimokstarehoklepetnatceokroveho: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Mozkomysnimokstarehoklepetnatceokroveho); break;
case id_Okovelkehoorbu: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Okovelkehoorbu); break;
case id_OkoVsevidouciho: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_OkoVsevidouciho); break;
case id_Ostnystarehodrapatce: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Ostnystarehodrapatce); break;
case id_Paratvlkodlacihovelekneze: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Paratvlkodlacihovelekneze); break;
case id_Pirkoerynie:SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Pirkoerynie); break;
case id_PirkomladeErinye: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_PirkomladeErinye); break;
case id_Posvatnykamen:SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Posvatnykamen); break;
case id_Slinyohnivehoslaada: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Slinyohnivehoslaada); break;
case id_Slizhnilovnika: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Slizhnilovnika); break;


///////////////////pridano 7.srpna ///////////////////////
case id_Mitrilovygolem: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Mitrilovygolem); break;
case id_Prvnizprastarych: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Prvnizprastarych); break;
case id_Bilyslaad: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Bilyslaad); break;
case id_Demoniprinc: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Demoniprinc); break;
case id_Harpyjematriarcha: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Harpyjematriarcha); break;
case id_Staryelementalkyseliny: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Staryelementalkyseliny); break;
case id_Nacelnikkyklopu: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Nacelnikkyklopu); break;
case id_Nacelnikohnivcu: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Nacelnikohnivcu); break;
case id_Kralsalamandru: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kralsalamandru); break;
case id_Puldrak: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Puldrak); break;
case id_Staryelementalohne: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Staryelementalohne); break;
case id_Staryelementalvody: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Staryelementalvody); break;
case id_Trolinacelnik: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Trolinacelnik); break;
case id_Vudceprastarychvlku: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Vudceprastarychvlku); break;
case id_Vladcestinu: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Vladcestinu); break;
case id_Obrimutant: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Obrimutant); break;
case id_Padlabojovnice: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Padlabojovnice); break;
case id_Kralovnacelistnatek: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kralovnacelistnatek); break;
case id_Nacelnikvzdusnychelementalu: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Nacelnikvzdusnychelementalu); break;
case id_Starymykoid: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Starymykoid); break;
case id_Pekelnyzplozenec: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Pekelnyzplozenec); break;
case id_Samanpralesnichtrollu: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Samanpralesnichtrollu); break;

///////////////////////////pridano 11.2:2009////////////////
case id_Starydrider: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Starydrider); break;
case id_Zlobriarcimag: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Zlobriarcimag); break;
case id_ledovywyrm : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_ledovywyrm); break;
case id_Balor : SetLocalString(OBJECT_SELF,"no_nazevveci", resref_Balor); break;
case id_Temnydruid : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Temnydruid); break;
case id_Veleknezkapaniledu : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Veleknezkapaniledu); break;
case id_samankyselinovychliliputu : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_samankyselinovychliliputu); break;
case id_pankamene : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_pankamene); break;
case id_Belibith : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Belibith); break;
case id_Kapitanpalacovestraze : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kapitanpalacovestraze); break;

case id_ld_asabi_hlava: SetLocalString(OBJECT_SELF,"no_nazevveci","ld_asabi_hlava"); break;
case id_ld_laerti_luk: SetLocalString(OBJECT_SELF,"no_nazevveci","ld_laerti_luk"); break;
case id_ld_sarrukh_kuz: SetLocalString(OBJECT_SELF,"no_nazevveci","ld_sarrukh_kuz"); break;




    }




    no_nahoda = 1; //vygeneruje kolik toho chce
    SetLocalInt(OBJECT_SELF,"no_pocetveci",no_nahoda);
    SetLocalInt(OBJECT_SELF,"obch_q_lastquest",ku_GetTimeStamp(0,720)); // zachova si quest celej restart
   }                                                                    //=12 hod REAL
}
