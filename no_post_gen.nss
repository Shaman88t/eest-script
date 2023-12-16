//tento skript by se mel zeptat, zda uz je neco nastavneho na prodej.
// jestli neni,mel by se spustit timer a az timer dobehne, tak by se mela vygenervoat dalsi shanka po predmetu.

#include "no_post_inc"
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
float no_float;
float no_cenabaliku;
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


//////////////////////////////////////////////////////////
no_nebezpecX = 1.0;
no_nebezpecY = 1.0;      //nebezpecenstvi 21.cevence
//////////////////////////////////////////////////////////

    no_posta = GetLocalString(OBJECT_SELF,"no_posta");
    SetLocalString(no_Item,"no_kamjde",no_posta);    //zprvu nastavime baliku stejnou postu, jako ma majitel
    no_kamjde = GetLocalString(no_Item,"no_kamjde");
    while (no_kamjde == no_posta) {                   // a pak opakujem nahodne posty, dokud neni jina.

    no_nahoda = 1 + Random(pocet_post);

   //25 zari = nekter posty nefunguji, takze : /////////////////////////////////
  /// 6,3, 13
  if (( no_nahoda == 6) || (no_nahoda == 3) || ( no_nahoda == 13) )
      no_nahoda = Random(10) + 14;
    ///////////////////////////////////////////////////////////////////////////////


    SetLocalInt(OBJECT_SELF,"no_switch",no_nahoda); //nastavi na osobu promenou, na kterou se tohle preplo,a
                                                    // aby si to pamatovala
    switch(no_nahoda) {

//        case id_chara_akad: {SetLocalString(no_Item,"no_kamjde",posta_chara_akad);
//                       SetName(no_Item,"Balicek do Charaxassaske magicke University");
//                       no_x1 = id_chara_akadx;
//                       no_y1 = id_chara_akady;
//                       break;
//                        }
        case id_char_klen_uli: {SetLocalString(no_Item,"no_kamjde",posta_char_klen_uli);
                       SetName(no_Item,"Balicek Ulihir S´Lleth klenotnikovi v novem meste v Charaxassu");
                       no_x1 = id_char_klen_ulix;
                       no_y1 = id_char_klen_uliy;
                       break;
                        }
        case id_char_klen_bar: {SetLocalString(no_Item,"no_kamjde",posta_char_klen_bar);
                       SetName(no_Item,"Balicek Barvirce v novem meste Charaxassu");
                       no_x1 = id_char_klen_barx;
                       no_y1 = id_char_klen_bary;
                       break;
                        }
        case id_char_doup_dro: {SetLocalString(no_Item,"no_kamjde",posta_char_doup_dro);
                       SetName(no_Item,"Balicek Drowovy v doupeti rozkose v Charaxssu");
                       no_x1 = id_char_doup_drox;
                       no_y1 = id_char_doup_droy;
                       break;
                        }
        case id_char_hude_oby: {SetLocalString(no_Item,"no_kamjde",posta_char_hude_oby);
                       SetName(no_Item,"Hraci na klavir v novem meste v Charaxassu ");
                       no_x1 = id_char_hude_obyx;
                       no_y1 = id_char_hude_obyy;
                       break;
                        }
        case id_char_velk_aka: {SetLocalString(no_Item,"no_kamjde",posta_char_velk_aka);
                       SetName(no_Item," Urednikovi v akademii valky v Charaxssu  ");
                       no_x1 = id_char_velk_akax;
                       no_y1 = id_char_velk_akay;
                       break;
                        }
        case id_char_velk_xia: {SetLocalString(no_Item,"no_kamjde",posta_char_velk_xia);
                       SetName(no_Item," Elrade v Xi´Anine chramu v Charaxassu");
                       no_x1 = id_char_velk_xiax;
                       no_y1 = id_char_velk_xiay;
                       break;
                        }
        case id_char_velk_pal: {SetLocalString(no_Item,"no_kamjde",posta_char_velk_pal);
                       SetName(no_Item," Garda matky Szai v palaci v Charaxassu ");
                       no_x1 = id_char_velk_palx;
                       no_y1 = id_char_velk_paly;
                       break;
                        }
        case id_char_star_zei: {SetLocalString(no_Item,"no_kamjde",posta_char_star_zei);
                       SetName(no_Item," Naerlisovi v Zeirove chramu v Charaxassu  ");
                       no_x1 = id_char_star_zeix;
                       no_y1 = id_char_star_zeiy;
                       break;
                        }
        case id_char_star_gih: {SetLocalString(no_Item,"no_kamjde",posta_char_star_gih);
                       SetName(no_Item,"  Giheirn Mrai´De ve sterem meste v Charaxassu ");
                       no_x1 = id_char_star_gihx;
                       no_y1 = id_char_star_gihy;
                       break;
                        }

        case id_chee_pris: {SetLocalString(no_Item,"no_kamjde",posta_chee_pris);
                       SetName(no_Item,"  Sia, Lilithine knezce v Cheel Del Wlalths ");
                       no_x1 = id_chee_prisx;
                       no_y1 = id_chee_prisy;
                       break;
                        }
        case id_chee_inte: {SetLocalString(no_Item,"no_kamjde",posta_chee_inte);
                       SetName(no_Item,"  Staremu demonovy v Cheel Del Wlalths ");
                       no_x1 = id_chee_intex;
                       no_y1 = id_chee_intey;
                       break;
                        }
        case id_chee_obch: {SetLocalString(no_Item,"no_kamjde",posta_chee_obch);
                       SetName(no_Item," D´lhiff Alhmur - vobchodni ctvrti  Cheel Del Wlalths ");
                       no_x1 = id_chee_obchx;
                       no_y1 = id_chee_obchy;
                       break;
                        }

        case id_chee_obch_fro: {SetLocalString(no_Item,"no_kamjde",posta_chee_obch_fro);
                       SetName(no_Item,"Frobo Felibethu - krejcimu v obchodni ctvrti  Cheel Del Wlalths ");
                       no_x1 = id_chee_obch_frox;
                       no_y1 = id_chee_obch_froy;
                       break;
                        }

        case id_chee_name: {SetLocalString(no_Item,"no_kamjde",posta_chee_name);
                       SetName(no_Item,"Vynalezci na namesti v  Cheel Del Wlalths ");
                       no_x1 = id_chee_namex;
                       no_y1 = id_chee_namey;
                       break;
                        }
        case id_chee_name_alc: {SetLocalString(no_Item,"no_kamjde",posta_chee_name_alc);
                       SetName(no_Item,"Moduro, správce alchymistickych laboratori v  Cheel Del Wlalths ");
                       no_x1 = id_chee_name_alcx;
                       no_y1 = id_chee_name_alcy;
                       break;
                        }
        case id_chee_name_mag: {SetLocalString(no_Item,"no_kamjde",posta_chee_name_mag);
                       SetName(no_Item," Lorie Nemaros, magicky obchod v  Cheel Del Wlalths ");
                       no_x1 = id_chee_name_magx;
                       no_y1 = id_chee_name_magy;
                       break;
                        }

        case id_chee_inte_sac: {SetLocalString(no_Item,"no_kamjde",posta_chee_inte_sac);
                       SetName(no_Item," Roirry Bretyad, universitni obchod v  Cheel Del Wlalths ");
                       no_x1 = id_chee_inte_sacx;
                       no_y1 = id_chee_inte_sacy;
                       break;
                        }

        case id_chee_magi: {SetLocalString(no_Item,"no_kamjde",posta_chee_magi);
                       SetName(no_Item," Bardo Krutipirkovi, arcimag university v  Cheel Del Wlalths ");
                       no_x1 = id_chee_magix;
                       no_y1 = id_chee_magiy;
                       break;
                        }
        case id_olat: {SetLocalString(no_Item,"no_kamjde",posta_olat);
                       SetName(no_Item,"  Jeirfel v Olath Deis");
                       no_x1 = id_olatx;
                       no_y1 = id_olaty;
                       break;
                        }
        case id_olat_cern: {SetLocalString(no_Item,"no_kamjde",posta_olat_cern);
                       SetName(no_Item," Strazi v dilnach v Olath Deis");
                       no_x1 = id_olat_cernx;
                       no_y1 = id_olat_cerny;
                       break;
                        }
        case id_hago_murg: {SetLocalString(no_Item,"no_kamjde",posta_hago_murg);
                       SetName(no_Item," Murgarovi , Veliteli Chmurne Straze v Hagolu");
                       no_x1 = id_hago_murgx;
                       no_y1 = id_hago_murgy;
                       break;
                        }
        case id_hago_name: {SetLocalString(no_Item,"no_kamjde",posta_hago_name);
                       SetName(no_Item," Grarrovi, Helgaronove knezi v Hagolu");
                       no_x1 = id_hago_namex;
                       no_y1 = id_hago_namey;
                       break;
                        }
         case id_hago_doln_sip: {SetLocalString(no_Item,"no_kamjde",posta_hago_doln_sip);
                       SetName(no_Item," remeslnikovi v siparstvi v dolnim Hagolu ");
                       no_x1 = id_hago_doln_sipx;
                       no_y1 = id_hago_doln_sipy;
                       break;
                        }
         case id_hago_doln_hut: {SetLocalString(no_Item,"no_kamjde",posta_hago_doln_hut);
                       SetName(no_Item,"Regdarrovi , Vedoucimu slevaci v hagolske bane ");
                       no_x1 = id_hago_doln_hutx;
                       no_y1 = id_hago_doln_huty;
                       break;
                        }

         case id_hago_chmu: {SetLocalString(no_Item,"no_kamjde",posta_hago_chmu);
                       SetName(no_Item,"Chmurne strazi v hagolskych hutich");
                       no_x1 = id_hago_chmux;
                       no_y1 = id_hago_chmuy;
                       break;
                        }


                        } //konec switche


           no_kamjde = GetLocalString(no_Item,"no_kamjde");
       }// konec opakovani dokud neni posta jina

          if (no_posta == posta_char_klen_uli) { no_x2 = id_char_klen_ulix;
                                     no_y2 = id_char_klen_uliy;
                                        }
          if (no_posta == posta_char_klen_bar) { no_x2 = id_char_klen_barx;
                                     no_y2 = id_char_klen_bary;
                                        }
          if (no_posta == posta_char_doup_dro) { no_x2 = id_char_doup_drox;
                                     no_y2 = id_char_doup_droy;
                                        }
          if (no_posta == posta_char_hude_oby) { no_x2 = id_char_hude_obyx;
                                     no_y2 = id_char_hude_obyy;
                                        }
          if (no_posta == posta_char_velk_aka) { no_x2 = id_char_velk_akax;
                                     no_y2 = id_char_velk_akay;
                                        }
          if (no_posta == posta_char_velk_xia) { no_x2 = id_char_velk_xiax;
                                     no_y2 = id_char_velk_xiay;
                                        }
          if (no_posta == posta_char_velk_pal) { no_x2 = id_char_velk_palx;
                                     no_y2 = id_char_velk_paly;
                                        }
          if (no_posta == posta_char_star_zei) { no_x2 = id_char_star_zeix;
                                     no_y2 = id_char_star_zeiy;
                                        }
          if (no_posta == posta_char_star_gih) { no_x2 = id_char_star_gihx;
                                     no_y2 = id_char_star_gihy;
                                        }
          if (no_posta == posta_chee_pris) { no_x2 = id_chee_prisx;
                                     no_y2 = id_chee_prisy;
                                        }
          if (no_posta == posta_chee_inte) { no_x2 = id_chee_intex;
                                     no_y2 = id_chee_intey;
                                        }
          if (no_posta == posta_chee_obch) { no_x2 = id_chee_obchx;
                                     no_y2 = id_chee_obchy;
                                        }
          if (no_posta == posta_chee_obch_fro) { no_x2 = id_chee_obch_frox;
                                     no_y2 = id_chee_obch_froy;
                                        }
          if (no_posta == posta_chee_name) { no_x2 = id_chee_namex;
                                     no_y2 = id_chee_namey;
                                        }
          if (no_posta == posta_chee_name_alc) { no_x2 = id_chee_name_alcx;
                                     no_y2 = id_chee_name_alcy;
                                        }
          if (no_posta == posta_chee_name_mag) { no_x2 = id_chee_name_magx;
                                     no_y2 = id_chee_name_magy;
                                        }
          if (no_posta == posta_chee_inte_sac) { no_x2 = id_chee_inte_sacx;
                                     no_y2 = id_chee_inte_sacy;
                                        }
          if (no_posta == posta_chee_magi) { no_x2 = id_chee_magix;
                                     no_y2 = id_chee_magiy;
                                        }
          if (no_posta == posta_olat) { no_x2 = id_olatx;
                                     no_y2 = id_olaty;
                                        }
          if (no_posta == posta_olat_cern) { no_x2 = id_olat_cernx;
                                     no_y2 = id_olat_cerny;
                                        }
          if (no_posta == posta_hago_murg) { no_x2 = id_hago_murgx;
                                     no_y2 = id_hago_murgy;
                                        }
          if (no_posta == posta_hago_name) { no_x2 = id_hago_namex;
                                     no_y2 = id_hago_namey;
                                        }
          if (no_posta == posta_hago_doln_sip) { no_x2 = id_hago_doln_sipx;
                                     no_y2 = id_hago_doln_sipy;
                                        }
          if (no_posta == posta_hago_doln_hut) { no_x2 = id_hago_doln_hutx;
                                     no_y2 = id_hago_doln_huty;
                                        }
          if (no_posta == posta_hago_chmu) { no_x2 = id_hago_chmux;
                                     no_y2 = id_hago_chmuy;
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


         no_nahoda = 2 +  Random(10);   //3-24
         SetLocalInt(OBJECT_SELF,"no_donaska",no_nahoda); //nastavi do no_donaska cas, kolilk ma balik na dorazeni
                                                          // do cile

         no_cenabaliku = 30 + ( (no_float)*1.2  + ((no_float)*IntToFloat(no_y1))/80 + (IntToFloat(24 - no_nahoda)*(no_float))/2 );
                        //min cena  //cena za vzdalenost       //bonus za vahu baliku (je take umerny vzdalenosti!!!)  //+cena za rychlost
         no_x1 = FloatToInt(no_cenabaliku);

         SetLocalInt(no_Item,"no_cena",no_x1);


   }


}
