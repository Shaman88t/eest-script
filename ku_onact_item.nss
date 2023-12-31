/*
 * release Kucik 06.01.2008
 * rev. 08.01.2008 Kucik pridani dmhulky
 * rev. 11.01.2008 Kucik upravy v loot hulce
 * rev. Kucik 05.01.2009 Pridana dynamicka munice
 * rev. Kucik 02. 07. 2009 Uprava DM hulky
 */
#include "ja_lib"
/*
 * melvik upava na novy zpusob nacitani soulstone 16.5.2009
 */

#include "ku_libbase"
#include "ku_ships"
#include "ku_dlg_inc"
#include "sh_sipy_inc"

void FRAKCE_ZabitiHracePoAktivaciItemu(object oPC,string sInt);
void FRAKCE_ZabitiHracePoAktivaciItemu(object oPC,string sInt)
{
object oTarget = oPC; //komu ublizime (tomu kdo aktivoval)
//hlaska nad postavu
    AssignCommand(oPC,ActionSpeakString(sInt,TALKVOLUME_WHISPER));
//nadefinujeme efekt
    effect eVis1 = EffectVisualEffect(VFX_IMP_POISON_L); //efekt jedu
//zabijeme postavu za 10 sekund
    DelayCommand(3.0f,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis1,oTarget)); //efekt jedu
    DelayCommand(6.0f,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis1,oTarget)); //efekt jedu
    DelayCommand(9.0f,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis1,oTarget)); //efekt jedu
    DelayCommand(9.0f,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(),oTarget)); //smrt
} //endfce




void kill_himself(object oPC) {

  string sInt="*n�co v jeho �stech k�uplo, po kr�tk� k�e�i um�r�*"; //hlaska nad postavu

  FRAKCE_ZabitiHracePoAktivaciItemu(oPC,sInt);//smrt
}

void main()
{
  object oPlayer=GetItemActivator ();
  object oActivated=GetItemActivated();
  string sActivated=GetTag(oActivated);
  object oTarget=GetItemActivatedTarget();

//  SendMessageToPC(oPlayer,"Tag = "+GetTag(oActivated));

  if(sActivated == "mk_zub_smrti") {
    kill_himself(oPlayer);
  }

  // Knihy
  if (sActivated=="ku_readable_book"){
    string sReadBookDialog = "read_book";
    SetCustomToken(8001,GetName(oActivated));
    AssignCommand(oPlayer,ActionStartConversation(OBJECT_SELF,"read_book",TRUE,FALSE));
    return;
  }

  // Prehozy na zbroje
  if (GetStringLeft(sActivated,13) == "ku_armordust_" ) {
     object oActArmor = GetItemInSlot(INVENTORY_SLOT_CHEST,oPlayer);
     if(oTarget==oActArmor)
       KU_ChangeArmorDust(oPlayer,oTarget,oActivated);
     else
       KU_ChangeArmorDust(oPlayer,oTarget,oActivated,FALSE);
  }

  // Lodni listek "ku_ship_ticket"
  if (GetStringLeft(sActivated,14) == "ku_ship_ticket" ) {
     ku_ShipsTellDepartureTime(GetStringRight(sActivated,GetStringLength(sActivated) - 14),oPlayer);
  }

  // DM hulka
  if (GetTag(oActivated)=="ku_dmwand1"){
    if(GetObjectType(oTarget)==OBJECT_TYPE_CREATURE) {
      SetLocalObject(oPlayer,"KU_DM_WAND_USED_TO",oTarget);
      SendMessageToPC(oPlayer,"Postava: " + GetName(oTarget));
      SendMessageToPC(oPlayer,"Hrac: " + GetPCPlayerName(oTarget));
      int iHD = GetHitDice(oTarget);
      object oSoul =GetSoulStone(oTarget);
      int iLastCheck = GetLocalInt(oSoul,"KU_LOOT_LAST_CHECK");
      int iTime = ku_GetTimeStamp() - iLastCheck;
//      float fLootGP = GetLocalFloat(oSoul,"KU_LOOT_GP");
      SetLocalInt(oSoul,"KU_LOOT_LAST_CHECK",ku_GetTimeStamp());


      // XP
      int xpt = GetLocalInt(oSoul,"ku_XPbyXPPT");
      int xpk = GetLocalInt(oSoul,"ku_XPbyKill");
      SendMessageToPC(oPlayer,"Postava ziskala " + IntToString(xpt) + "xp casem a " + IntToString(xpk) + "xp bojem;");

      float fborder = 2.0/3.0;
      float fkoef = 1.6;
      float pomer = (IntToFloat(xpk)/(IntToFloat(xpt + 1) + IntToFloat(xpk)));
      int perc = FloatToInt((1- ( pomer - fborder)/(1-fborder)*fkoef ) * 100);
      if( pomer <= fborder )
        perc = 100;

      SendMessageToPC(oPlayer,"Bude dostavat "+IntToString(perc)+"% xp z potvor.");

      AssignCommand(oPlayer,ActionStartConversation(OBJECT_SELF,"ku_dmwand1",TRUE,FALSE));
    }
    else
      SendMessageToPC(oPlayer,"Prestan si s tim hrat!");
  }
  // DM hulka pro dropable a undropable itemy
  if (GetTag(oActivated)=="ku_dmwand2"){
    SetLocalObject(oPlayer,"KU_DM_WAND_USED_TO",oTarget);
    if(GetObjectType(oTarget)==OBJECT_TYPE_ITEM) {
      if(GetDroppableFlag(oTarget)) {
        SetDroppableFlag(oTarget,FALSE);
        SendMessageToPC(oPlayer,"Predmet "+GetName(oTarget)+" byl nastaven jako neodlozitelny");
      }
      else {
        SetDroppableFlag(oTarget,TRUE);
        SendMessageToPC(oPlayer,"Predmet "+GetName(oTarget)+" byl nastaven jako odlozitelny");
      }
    }
    else if(GetObjectType(oTarget)==OBJECT_TYPE_CREATURE) {
      AssignCommand(oPlayer,ActionStartConversation(OBJECT_SELF,"ku_dmwand2",TRUE,FALSE));
    }

  }
  if (GetTag(oActivated) == "ku_uni_dlg"){
    object oPC = oPlayer;
    int iDlg = GetLocalInt(oActivated,"KU_DIALOG");
//    SendMessageToPC(oPlayer,"Na "+GetName(oActivated)+" je KU_DIALOG "+IntToString(iDlg));
    if(iDlg < 1) {
      string sResref = GetResRef(oActivated);
      if(sResref == "ku_uni_dlg_001")
        iDlg = 1;
      else if(sResref == "ku_wand_uni_dlg")
        iDlg = 2;
      else if(sResref == "ku_wand_uni_d001")
        iDlg = 3;
      else if(sResref == "ku_wand_uni_d002")
        iDlg = 4;
      else if(sResref == "ku_uni_dlg_5")
        iDlg = 5;
      else if(sResref == "ku_uni_dlg_006")
        iDlg = 6;
      else if(sResref == "ku_uni_dlg_007")
        iDlg = 7;
      else
        iDlg = 1;
    }

//    SendMessageToPC(oPlayer,"Spoustim dialog "+IntToString(iDlg));
    SetLocalInt(oPlayer,KU_DLG+"dialog",iDlg);
    SetLocalInt(oPlayer,KU_DLG+"state",0);
    SetLocalObject(oPlayer,KU_WAND_TARGET,oTarget);
    SetLocalLocation(oPlayer,KU_WAND_TARGET_LOC,GetItemActivatedTargetLocation());

    SetCustomToken(6300,"Uni Dialog");
    ku_dlg_init(iDlg,oPlayer);

    SetLocalInt(oPC,KU_DLG+"dialog",iDlg);
    SetLocalInt(oPC,KU_DLG+"state",0);
    SetLocalInt(oPC,KU_DLG+"_allow_0",1);
    SetLocalInt(oPC,KU_DLG+"_allow_1",1);
    AssignCommand(oPlayer,ActionStartConversation(OBJECT_SELF,"ku_uni_dlg",TRUE,FALSE));
    return;
  }

  // Baliky sipu, sipek, hvezdic seker a podobneho
  if(GetStringLeft(sActivated,7)=="ry_tou_") {
  //  SendMessageToPC(oPlayer,"Comapare "+GetSubString(sActivated,7,10)+":"+GetSubString(GetTag(oTarget),7,10));
    if(GetSubString(sActivated,7,10) == GetSubString(GetTag(oTarget),7,10)) {
      int obsah = GetLocalInt(oActivated,"ku_contain") + GetItemStackSize(oTarget);
      SetLocalInt(oActivated,"ku_contain",obsah);
      DestroyObject(oTarget,0.0);
      SetName(oActivated,GetLocalString(oActivated,"name")+" - zbyva "+IntToString(obsah)+" munice");
      return;
    }

    string ammo = GetSubString(sActivated,7,2);
    int iType=GetLocalInt(GetModule(),"KU_MUNITION_TYPES_"+ammo);
    ku_GetMunitionFromPack(oPlayer,sActivated,iType,1);
    return;
  }
  if (GetStringLeft(sActivated,6) == "toulec") {
    sh_GetMunitionFromTag(oActivated, oPlayer, oTarget);
  }


/*
if (GetTag(oActivated)=="ku_ability_check"){
  int iCheckDice=GetSkillRank(SKILL_BLUFF,oTarget) + GetSkillRank(SKILL_PERFORM,oTarget) - GetSkillRank(SKILL_SPOT,oPlayer) + d20();
//  SendMessageToPC(oPlayer,IntToString(GetSkillRank(SKILL_BLUFF,oTarget)) + " + " + IntToString(GetSkillRank(SKILL_PERFORM,oTarget)) + " - " + IntToString(GetSkillRank(SKILL_SPOT,oPlayer)) + " + d20");
//  SendMessageToPC(oPlayer," = " + IntToString(iCheckDice));
  if(iCheckDice > 20) {
    iCheckDice=20;
  }
  if(iCheckDice < 0) {
    iCheckDice=0;
  }
  iCheckDice=iCheckDice / 2;
  int iScore;

  iScore=GetAbilityScore(oTarget,ABILITY_CHARISMA) + Random(iCheckDice) - ( iCheckDice / 2 );
  SendMessageToPC(oPlayer,"Charisma " + IntToString(iScore));

  iScore=GetAbilityScore(oTarget,ABILITY_CONSTITUTION) + Random(iCheckDice) - ( iCheckDice / 2 );
  SendMessageToPC(oPlayer,"Odolnost " + IntToString(iScore));

  iScore=GetAbilityScore(oTarget,ABILITY_DEXTERITY) + Random(iCheckDice) - ( iCheckDice / 2 );
  SendMessageToPC(oPlayer,"Obratnost " + IntToString(iScore));

  iScore=GetAbilityScore(oTarget,ABILITY_INTELLIGENCE) + Random(iCheckDice) - ( iCheckDice / 2 );
  SendMessageToPC(oPlayer,"Inteligence " + IntToString(iScore));

  iScore=GetAbilityScore(oTarget,ABILITY_STRENGTH) + Random(iCheckDice) - ( iCheckDice / 2 );
  SendMessageToPC(oPlayer,"Sila" + IntToString(iScore));

  iScore=GetAbilityScore(oTarget,ABILITY_WISDOM) + Random(iCheckDice) - ( iCheckDice / 2 );
  SendMessageToPC(oPlayer,"Wisdom " + IntToString(iScore));
}
*/
}
