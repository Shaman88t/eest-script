//tento skript by se mel zeptat, zda uz je neco nastavneho na prodej.
// jestli neni,mel by se spustit timer a az timer dobehne, tak by se mela vygenervoat dalsi shanka po predmetu.

#include "no_post_inc_povr"
#include "ku_libtime"
int no_nahoda;
int no_x1;
int no_x2;
int no_y1;
int no_y2;
//////////////////////////////////////////////////////////
float no_nebezpecX;
float no_nebezpecY;      //nebezpecenstvi 21.cevence
//////////////////////////////////////////////////////////
float no_cenabaliku;
float no_float;
string no_nazev; //kvuli debug
object no_oPC;   // kvuli debug
object no_Item;
string no_posta;
string no_kamjde;
void main()

{

no_Item = GetFirstItemInInventory(OBJECT_SELF);
while(GetIsObjectValid(no_Item))  {
  if(GetTag(no_Item) == "no_balik")
    break;
  no_Item = GetNextItemInInventory(OBJECT_SELF);
  }

if (!GetIsObjectValid(no_Item)) {      //pokud nema uz zadnou vec v inventari, tak se pokusi vygenerovat novou

                if (GetLocalInt(OBJECT_SELF,"obch_q_lastquest") > ku_GetTimeStamp())
                return;

                if(Random(100) > 79) { //  Vygeneruj quest s tricetiprocentni sanci
                SetLocalInt(OBJECT_SELF,"obch_q_lastquest",ku_GetTimeStamp(0,140));
                                             //30 minut v pripade ze zadny quest neni
                return;
                                    }


//////////////////////////////////////////////////////////
no_nebezpecX = 1.0;
no_nebezpecY = 1.0;      //nebezpecenstvi 21.cevenc, kdyz neni nebezpec, ci jizda lodi, pak = 1.0
//////////////////////////////////////////////////////////


no_nahoda = 1 + Random(7);
switch(no_nahoda)   {
            case  1:    CreateItemOnObject("no_balik007",OBJECT_SELF,1);    break;
            case  2:    CreateItemOnObject("no_balik001",OBJECT_SELF,1);    break;
            case  3:    CreateItemOnObject("no_balik002",OBJECT_SELF,1);    break;
            case  4:    CreateItemOnObject("no_balik003",OBJECT_SELF,1);    break;
            case  5:    CreateItemOnObject("no_balik004",OBJECT_SELF,1);    break;
            case  6:    CreateItemOnObject("no_balik005",OBJECT_SELF,1);    break;
            case  7:    CreateItemOnObject("no_balik006",OBJECT_SELF,1);    break;
                      }              //6 baliku, kazdy jinak vypada a hlavne kazdej ma trosku jinou vahu
                                     //jeden z nich ji totiz ma 15liber a ta cena by pak byla prilis vysoka.


no_Item = GetFirstItemInInventory(OBJECT_SELF);

while(GetIsObjectValid(no_Item))  {
  if(GetTag(no_Item) == "no_balik")
    break;
  no_Item = GetNextItemInInventory(OBJECT_SELF);   //nactem si balik do no_Item
  }



    no_posta = GetLocalString(OBJECT_SELF,"no_posta");
    SetLocalString(no_Item,"no_kamjde",no_posta);    //zprvu nastavime baliku stejnou postu, jako ma majitel
    no_kamjde = GetLocalString(no_Item,"no_kamjde");
    while (no_kamjde == no_posta) {                   // a pak opakujem nahodne posty, dokud neni jina.

    no_nahoda = 1 + Random(pocet_post);
    SetLocalInt(OBJECT_SELF,"no_switch",no_nahoda); //nastavi na osobu promenou, na kterou se tohle preplo,a
                                                    // aby si to pamatovala
    switch(no_nahoda) {

        case id_alwa_pala: {SetLocalString(no_Item,"no_kamjde",posta_alwa_pala);
                       SetName(no_Item,"Balicek do kralovskeho palace v Alwarielu");
                       no_x1 = id_alwa_palax;
                       no_y1 = id_alwa_palay;
                       no_nebezpecX = 0.8;  // 21.cervenec, jizda lodi
                       break;
                        }
        case id_alwa_drui: {SetLocalString(no_Item,"no_kamjde",posta_alwa_drui);
                       SetName(no_Item,"Balicek do sidla druidu v Alwarielu");
                       no_x1 = id_alwa_druix;
                       no_y1 = id_alwa_druiy;
                       no_nebezpecX = 0.8;  // 21.cervenec, jizda lodi
                       break;
                        }
        case id_alwa_host: {SetLocalString(no_Item,"no_kamjde",posta_alwa_host);
                       SetName(no_Item,"Balicek hostinskemu U Mrzuteho sotka v Alwarielu");
                       no_x1 = id_alwa_hostx;
                       no_y1 = id_alwa_hosty;
                       no_nebezpecX = 0.8;  // 21.cervenec, jizda lodi
                       break;
                        }
        case id_shar_arci: {SetLocalString(no_Item,"no_kamjde",posta_shar_arci);
                       SetName(no_Item," Balicek arcidruidovi ze Shardonskeho hajku");
                       no_x1 = id_shar_arcix;
                       no_y1 = id_shar_arciy;
                       no_nebezpecX = 0.8;  // 21.cervenec, jizda lodi
                       break;
                        }
        case id_doub_star: {SetLocalString(no_Item,"no_kamjde",posta_doub_star);
                       SetName(no_Item,"Balicek starostovi Doubkova");
                       no_x1 = id_doub_starx;
                       no_y1 = id_doub_stary;
                       no_nebezpecX = 0.8;  // 21.cervenec, jizda lodi
                       break;
                        }
        case id_murg_host: {SetLocalString(no_Item,"no_kamjde",posta_murg_host);
                       SetName(no_Item,"Balicek pro hostinskeho U Prasivyho baziliska z Murgondu ");
                       no_x1 = id_murg_hostx;
                       no_y1 = id_murg_hosty;
                       no_nebezpecX = 1.3;  // 21.cervenec, nebezpecna lokace
                       break;
                        }
        case id_ivor_zema: {SetLocalString(no_Item,"no_kamjde",posta_ivor_zema);
                       SetName(no_Item,"Balicek pro zemana z Ivory ");
                       no_x1 = id_ivor_zemax;
                       no_y1 = id_ivor_zemay;
                       break;
                        }
        case id_kara_radn: {SetLocalString(no_Item,"no_kamjde",posta_kara_radn);
                       SetName(no_Item,"Balicek pro urednika na radnici v Karathe ");
                       no_x1 = id_kara_radnx;
                       no_y1 = id_kara_radny;
                       break;
                        }
        case id_kara_obch: {SetLocalString(no_Item,"no_kamjde",posta_kara_obch);
                       SetName(no_Item,"Balicek do sidla svazu karathadskych obchodniku v Karathe ");
                       no_x1 = id_kara_obchx;
                       no_y1 = id_kara_obchy;
                       break;
                        }
        case id_kara_bran: {SetLocalString(no_Item,"no_kamjde",posta_kara_bran);
                       SetName(no_Item,"Balicek do vojenske akademie brana Rozvazneho v Karathe ");
                       no_x1 = id_kara_branx;
                       no_y1 = id_kara_brany;
                       break;
                        }
        case id_kara_thal: {SetLocalString(no_Item,"no_kamjde",posta_kara_thal);
                       SetName(no_Item,"Balicek do Thalova chramu v chramove ctvrti v Karathe ");
                       no_x1 = id_kara_thalx;
                       no_y1 = id_kara_thaly;
                       break;
                        }
        case id_kara_univ: {SetLocalString(no_Item,"no_kamjde",posta_kara_univ);
                       SetName(no_Item,"Balicek do magicke University v Karathe ");
                       no_x1 = id_kara_univx;
                       no_y1 = id_kara_univy;
                       break;
                        }
        case id_pous_knih: {SetLocalString(no_Item,"no_kamjde",posta_pous_knih);
                       SetName(no_Item,"Balicek knihovnikovi z palace mistodrziciho v postnim meste Kel-A-Hazr  ");
                       no_x1 = id_pous_knihx;
                       no_y1 = id_pous_knihy;
                       no_nebezpecX = 0.8;  // 21.cervenec, jizda lodi
                       break;
                        }
        case id_pous_obch: {SetLocalString(no_Item,"no_kamjde",posta_pous_obch);
                       SetName(no_Item,"Balicek obchodnikovi U Mecouna z postniho mesta Kel-A-Hazr ");
                       no_x1 = id_pous_obchx;
                       no_y1 = id_pous_obchy;
                       no_nebezpecX = 0.8;  // 21.cervenec, jizda lodi
                       break;
                        }
        case id_kryn_host: {SetLocalString(no_Item,"no_kamjde",posta_kryn_host);
                       SetName(no_Item,"Balicek hostniskemu u Hrumburace v Krynskych horach ");
                       no_x1 = id_kryn_hostx;
                       no_y1 = id_kryn_hosty;
                       no_nebezpecX = 1.2;  // 21.cervenec, nebezpecna lokace
                       break;
                        }
        case id_dorn_dorn: {SetLocalString(no_Item,"no_kamjde",posta_dorn_dorn);
                       SetName(no_Item,"Balicek Dornovi z Dornova utociste ");
                       no_x1 = id_dorn_dornx;
                       no_y1 = id_dorn_dorny;
                       break;
                        }
        case id_tart_stra: {SetLocalString(no_Item,"no_kamjde",posta_tart_stra);
                       SetName(no_Item,"Balicek pro velitele strazi, hospoda U Peti soudku, Tarten ");
                       no_x1 = id_tart_strax;
                       no_y1 = id_tart_stray;
                       break;
                        }
        case id_grub_star: {SetLocalString(no_Item,"no_kamjde",posta_grub_star);
                       SetName(no_Item,"Balicek pro starostu Gruberiku ");
                       no_x1 = id_grub_starx;
                       no_y1 = id_grub_stary;
                       no_nebezpecX = 1.3;  // 21.cervenec, nebezpecna lokace
                       break;
                        }
        case id_isil_veli: {SetLocalString(no_Item,"no_kamjde",posta_isil_veli);
                       SetName(no_Item,"Balicek pro velite strazi Isilske pevnosti");
                       no_x1 = id_isil_velix;
                       no_y1 = id_isil_veliy;
                       no_nebezpecX = 1.3;  // 21.cervenec, nebezpecna lokace
                       break;
                        }




                        } //konec switche




           no_kamjde = GetLocalString(no_Item,"no_kamjde");
       }// konec opakovani dokud neni posta jina

          if (no_posta == posta_alwa_pala) { no_x2 = id_alwa_palax;           // nastaveni ceny
                                     no_y2 = id_alwa_palay;               // podle posty od ktere vysel
                                     no_nebezpecY = 0.8;  // 21.cervenec, jizda lodi
                                        }
          if (no_posta == posta_alwa_drui) { no_x2 = id_alwa_druix;
                                     no_y2 = id_alwa_druiy;
                                     no_nebezpecY = 0.8;  // 21.cervenec, jizda lodi
                                        }
          if (no_posta == posta_alwa_host) { no_x2 = id_alwa_hostx;
                                     no_y2 = id_alwa_hosty;
                                     no_nebezpecY = 0.8;  // 21.cervenec, jizda lodi
                                        }
          if (no_posta == posta_shar_arci) { no_x2 = id_shar_arcix;
                                     no_y2 = id_shar_arciy;
                                     no_nebezpecY = 0.8;  // 21.cervenec, jizda lodi
                                        }
          if (no_posta == posta_doub_star) { no_x2 = id_doub_starx;
                                     no_y2 = id_doub_stary;
                                        }
          if (no_posta == posta_murg_host) { no_x2 = id_murg_hostx;
                                     no_y2 = id_murg_hosty;
                                     no_nebezpecY = 1.3;  // 21.cervenec, nebezpec.lokace
                                        }
          if (no_posta == posta_ivor_zema) { no_x2 = id_ivor_zemax;
                                     no_y2 = id_ivor_zemay;
                                        }
          if (no_posta == posta_kara_radn) { no_x2 = id_kara_radnx;
                                     no_y2 = id_kara_radny;
                                        }
          if (no_posta == posta_kara_obch) { no_x2 = id_kara_obchx;
                                     no_y2 = id_kara_obchy;
                                        }
          if (no_posta == posta_kara_bran) { no_x2 = id_kara_branx;
                                     no_y2 = id_kara_brany;
                                        }
          if (no_posta == posta_kara_thal) { no_x2 = id_kara_thalx;
                                     no_y2 = id_kara_thaly;
                                        }
          if (no_posta == posta_kara_univ) { no_x2 = id_kara_univx;
                                     no_y2 = id_kara_univy;
                                        }
          if (no_posta == posta_pous_knih) { no_x2 = id_pous_knihx;
                                     no_y2 = id_pous_knihy;
                                     no_nebezpecY = 0.8;  // 21.cervenec, jizda lodi
                                        }
          if (no_posta == posta_pous_obch) { no_x2 = id_pous_obchx;
                                     no_y2 = id_pous_obchy;
                                     no_nebezpecY = 0.8;  // 21.cervenec, jizda lodi
                                        }
          if (no_posta == posta_kryn_host) { no_x2 = id_kryn_hostx;
                                     no_y2 = id_kryn_hosty;
                                     no_nebezpecY = 1.2;  // 21.cervenec, nebezpec.lokace
                                        }
          if (no_posta == posta_dorn_dorn) { no_x2 = id_dorn_dornx;
                                     no_y2 = id_dorn_dorny;
                                        }
          if (no_posta == posta_tart_stra) { no_x2 = id_tart_strax;
                                     no_y2 = id_tart_stray;
                                        }
          if (no_posta == posta_grub_star) { no_x2 = id_grub_starx;
                                     no_y2 = id_grub_stary;
                                     no_nebezpecY = 1.3;  // 21.cervenec, nebezpec.lokace
                                        }

          if (no_posta == posta_isil_veli) { no_x2 = id_isil_velix;
                                     no_y2 = id_isil_veliy;
                                     no_nebezpecY = 1.1;  // 21.cervenec, nebezpec.lokace
                                        }

         no_x1 = (no_x1-no_x2) ;
         if  (no_x1 == 0 ) no_x1 = 2;        //odstraneni pripadne nulove hodnoty

         no_y1 = (no_y1-no_y2) ;
         if  (no_y1 == 0 ) no_y1 = 2;         //odstraneni pripadne nulove hodnoty

////////////////////ZMENA 2.cervence 2008 cena se pocita z uhlopricky///////////////////////////
         no_x1 = (( no_x1 * no_x1 ) + ( no_y1 * no_y1 ));         // do no_x1 dame uhlopricku !!!!
         no_float = sqrt(IntToFloat(no_x1));
///////////////////////////////////////////////////////////////////////////////////////////////


         no_y1 = GetWeight(no_Item);           //zjistim vahu baliku

         no_nahoda = 3 +  Random(22);   //3-24
         SetLocalInt(OBJECT_SELF,"no_donaska",no_nahoda); //nastavi do no_donaska cas, kolilk ma balik na dorazeni
                                                         // do cile

         no_cenabaliku = 200 + no_nebezpecX *no_nebezpecY * ( (no_float)*30  + ((no_float)*IntToFloat(no_y1))/80 + (IntToFloat(24 - no_nahoda)*(no_float)));
                      //min cena  //cena za vzdalenost       //bonus za vahu baliku (je take umerny vzdalenosti!!!)  //+cena za rychlost

         no_x1 = FloatToInt(no_cenabaliku);

         SetLocalInt(no_Item,"no_cena",no_x1);


   }


}
