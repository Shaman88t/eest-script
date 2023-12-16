#include "ku_libtime"
//#include "no_zb_inc"
#include "no_nastcraft_ini"
#include "no_zb_func"



object no_Item;
object no_oPC;
int no_switch;
int no_menu;


void main()
{

no_oPC=GetLastDisturbed();
///////////nomis nema rad neviditelne craftery (. //////////////
effect no_effect=GetFirstEffect(no_oPC);
while (GetIsEffectValid(no_effect))
   {
   if (GetEffectType(no_effect)==EFFECT_TYPE_INVISIBILITY) RemoveEffect(no_oPC,no_effect);
   if (GetEffectType(no_effect)==EFFECT_TYPE_IMPROVEDINVISIBILITY) RemoveEffect(no_oPC,no_effect);
   if (GetEffectType(no_effect)==EFFECT_TYPE_SANCTUARY) RemoveEffect(no_oPC,no_effect);
   no_effect=GetNextEffect(no_oPC);
   }

/////////////////////////////////////////////////////////////////

SetLocalInt(OBJECT_SELF,"no_MULTIKLIK",0);


     if (GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,no_oPC)) != "ITEM_ARMORHAMMER_NORMAL")
     {
        FloatingTextStringOnCreature("Je treba mit v ruce kovarske kladivo",no_oPC,FALSE);
     }
else {


//no_oPC=GetLastClosedBy();
//no_znicit(OBJECT_SELF); //znicime vsechny prepinace at tam pak pri otevreni nejsou 2x

SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
SetLocalInt(OBJECT_SELF,"no_forma",0);
SetLocalInt(OBJECT_SELF,"no_prisada",0);
SetLocalInt(OBJECT_SELF,"no_nasada",0);
SetLocalString(OBJECT_SELF,"no_vyrobek","");



no_Item = GetFirstItemInInventory(OBJECT_SELF);
no_menu = GetLocalInt(OBJECT_SELF,"no_menu");

//zjisti kovy do no_pouzitykov1 a no_pouzitykov2
no_pouzitykov(no_Item,OBJECT_SELF,FALSE);
no_forma(no_Item,OBJECT_SELF,FALSE);
no_prisada(no_Item,OBJECT_SELF,FALSE);
no_vyrobek(no_Item,OBJECT_SELF,FALSE);
no_nasada(no_Item,OBJECT_SELF,FALSE);


//////////////////////////////////////////////////////////////////////////////////////////////////////
///////////  V teto chvili jsme zjistili co je v peci. takze se jen vytvari pravdepodobnosti dane veci a pripadne vyrobky
/////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////tak a protoze stejnej skript na vecech, tak to musime rozlisit: ////////
//////// no_tr_koza: koza   no_tr_skopek : skopek/////////////////////////////////////////



/////////////polotovar//////////////////////////////////////////////////////
no_Item = GetFirstItemInInventory(OBJECT_SELF);
while (GetIsObjectValid(no_Item)) {
    if (GetResRef(no_Item) == "no_polot_zb") {
        int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
        no_pocet_cyklu = no_pocet_cyklu+1;

        if (( GetLocalString(no_Item,"no_crafter")!= GetName(no_oPC) ) & (GetLocalString(no_Item,"no_crafter")!="") )
        {no_pocet_cyklu = no_pocet_cyklu +10;
         FloatingTextStringOnCreature("Nemuzes pokracovat v praci jineho  remeslnika ! ",no_oPC,FALSE );
        }
                if (no_pocet_cyklu < 10) {
                SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
            no_zamkni(no_oPC);
            DelayCommand(no_zb_delay,no_xp_zb(no_oPC,OBJECT_SELF));
            SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
            SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
            SetLocalInt(OBJECT_SELF,"no_forma",0);
            SetLocalInt(OBJECT_SELF,"no_prisada",0);
            SetLocalString(OBJECT_SELF,"no_vyrobek","");
            SetLocalInt(OBJECT_SELF,"no_nasada",0);

                break;           /// kdyz bude polotovar ve vyrobe, tak zabranime aby se udelal novej z kuze.
                }///kdyz mame mene, nez 10cyklu

        if   (no_pocet_cyklu >= 10) {
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
            SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
            SetLocalInt(OBJECT_SELF,"no_forma",0);
            SetLocalInt(OBJECT_SELF,"no_prisada",0);
            SetLocalString(OBJECT_SELF,"no_vyrobek","");
            SetLocalInt(OBJECT_SELF,"no_nasada",0);

              SetLocalInt(no_Item,"no_pocet_cyklu",0);
              AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED, 1.0, 5.0));
              no_pocet_cyklu = d6();/// jen at nedavame zbytecne dalsi promennou..
              switch (no_pocet_cyklu) {
              case 1: {FloatingTextStringOnCreature(" To je ale namaha ! ",no_oPC,FALSE );
                        break; }
              case 2: {FloatingTextStringOnCreature(" Snad se z toho neupracuju ! ",no_oPC,FALSE );
                        break;}
              case 3: {FloatingTextStringOnCreature(" Jeste chvilku a uz to bude ! ",no_oPC,FALSE );
                        break;}
              case 4:{FloatingTextStringOnCreature(" Snad se tomu nic nestane ! ",no_oPC,FALSE );
                        break; }
              case 5: {FloatingTextStringOnCreature(" Uz jen kousek ! ",no_oPC,FALSE );
                        break;  }
              case 6: {FloatingTextStringOnCreature(" Uz aby to bylo ! ",no_oPC,FALSE );
                        break;  }
              }
               break;

                }
     }//if resref = oplotovar
  no_Item = GetNextItemInInventory(OBJECT_SELF);
}    /// dokud valid
/////////////////////////////////////////////////////////////////////////////





/////////////////////////////////////////////////////////////////////////////

// vyroba prvniho polotovaru
if (( no_menu > 9  &  no_menu < 80 ) & (GetLocalString(OBJECT_SELF,"no_vyrobek")=="")& (GetLocalInt(OBJECT_SELF,"no_pouzitykov1")!=0))
{
no_xp_vyrobpolotovar(no_oPC,OBJECT_SELF);

if (NO_zb_DEBUG == TRUE) {
SendMessageToPC(no_oPC,"kov 1: " + IntToString(GetLocalInt(OBJECT_SELF,"no_pouzitykov1")) + "___kov2: " + IntToString(GetLocalInt(OBJECT_SELF,"no_pouzitykov2")));
SendMessageToPC(no_oPC,"forma : " + IntToString(GetLocalInt(OBJECT_SELF,"no_forma")));
SendMessageToPC(no_oPC,"prisady : " + IntToString(GetLocalInt(OBJECT_SELF,"no_prisada")));
SendMessageToPC(no_oPC,"nasada : " + IntToString(GetLocalInt(OBJECT_SELF,"no_nasada")));
SendMessageToPC(no_oPC,"vyrobek : " + (GetLocalString(OBJECT_SELF,"no_vyrobek")));    }

}

if (GetLocalString(OBJECT_SELF,"no_vyrobek")!="")
{
no_zjistiobsah(GetLocalString(OBJECT_SELF,"no_vyrobek"));

if (GetLocalInt(OBJECT_SELF,"no_druh_nasada") == 0) {   // pokud by nebylo s prisadama delam mecu jak cip..
no_xp_pridej_nasadu(no_oPC,OBJECT_SELF); }

if (GetLocalInt(OBJECT_SELF,"no_druh_nasada") > 0) {   // pokud by nebylo s prisadama delam mecu jak cip..
FloatingTextStringOnCreature(" Tento vyrobek je jiz hotov ! ",no_oPC,FALSE );
}
}

}// kdyz mame kovarske kladivo
}
