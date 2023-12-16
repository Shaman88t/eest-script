/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_gemdep_ou
//
//  Desc:  When a player uses a mineral deposit,
//         they must be equipped with a gem crafter's
//         chisel. They will dig something up 20% of
//         the time.
//
//  Author: David Bobeck 02Mar03
//
/////////////////////////////////////////////////////////

 #include "cnr_persist_inc"
void CheckAction(object oPC, object oSelf);
void CreateAnObject(string sResource, object oPC);
void ReplaceSelf(object oSelf, string sAppearance);
void CreateNew(location lSelf, string sResSelf);
void CreatePlaceable(string sObject, location lPlace, float fDuration);

void main()
{
  object oSelf=OBJECT_SELF;
  object oPC=GetLastUsedBy();
  string sTool = "ZEP_HEAVYPICK";
  string sToolOptional = "ZEP_LIGHTPICK";

  if (GetLocalInt(oPC,"iAmDigging")!= 0) return;
  if (GetLocalInt(oSelf,"iAmSetToDie")==0)SetLocalInt(oPC,"iAmDigging",99);
  DelayCommand(5.0,SetLocalInt(oPC,"iAmDigging",0));


////////////nomis odstraneni effektu invis a hide..///////////////////////
effect no_effect=GetFirstEffect(oPC);
while (GetIsEffectValid(no_effect))
   {
   if (GetEffectType(no_effect)==EFFECT_TYPE_INVISIBILITY) RemoveEffect(oPC,no_effect);
   if (GetEffectType(no_effect)==EFFECT_TYPE_IMPROVEDINVISIBILITY) RemoveEffect(oPC,no_effect);
   if (GetEffectType(no_effect)==EFFECT_TYPE_SANCTUARY) RemoveEffect(oPC,no_effect);
   no_effect=GetNextEffect(oPC);
   }
//////////////////////////////////////////////////////////////

  string sSelf=GetTag(oSelf);
  string sResource = "";
  string sSuccessString = "";
  string sFailString = "";
  string sOldSkill = "";
  string sOldSkill2 = "";
  string sAppearance;
  //int iMiningSkill=GetTokenPair(oPC,14,3);
  int iMiningSkill = CnrGetPersistentInt(oPC,"iMiningSkill");
  int iDigChance=iMiningSkill;
  int iSuccess=0;
  int iToolBreak=GetLocalInt(oPC,"iToolWillBreak");
  int iRandom = 0;
  int iMaxDig = GetLocalInt(oSelf,"iMaxDig");
  if (iMaxDig==0)
   {
    iMaxDig=d4(2);
    SetLocalInt(oSelf,"iMaxDig",iMaxDig);
   }
  object oTool=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
  if ((GetTag(oTool) != sTool)&&(GetTag(oTool) != sToolOptional))
    oTool = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);

  if ((GetTag(oTool) != sTool)&&(GetTag(oTool) != sToolOptional))
     {
        SendMessageToPC(oPC,"K tezbe potrebujes krumpac.");
        return;
     }

  if (iDigChance < 350)
   {
    iDigChance = GetAbilityScore(oPC,ABILITY_STRENGTH)*5;
    iDigChance = iDigChance + (GetAbilityScore(oPC,ABILITY_CONSTITUTION)*3);
    iDigChance = iDigChance + (GetAbilityScore(oPC,ABILITY_DEXTERITY)*2);
    iDigChance = iDigChance*3;
    if (iDigChance >350) iDigChance = 350;
    if (iMiningSkill>iDigChance)iDigChance=iMiningSkill;
   }

   sFailString = "Chvilku jsi kopal(a), ale napodarilo se Ti vykopak zadnou rudu.";

   // zvuky kopani
   AssignCommand(OBJECT_SELF,DelayCommand(2.5,PlaySound("cb_ht_metblston1")));
   AssignCommand(OBJECT_SELF,DelayCommand(5.0,PlaySound("cb_ht_metblston2")));


  if (sSelf == "cnrRockTin") //skala
   {
    sAppearance="temp_placeable";
    sResource = "cnrNuggetTin";
    sSuccessString = "Podarilo se ti vytkutat pekny kus rudy cinu";
   }
  if (sSelf == "cnrRockAdam") //skala
   {
    sAppearance="temp_placeable";
    sResource = "cnrNuggetAdam";
    sSuccessString = "Podarilo se ti vytkutat pekny kus rudy zeleza";
   }
  if (sSelf == "cnrRockGold") //skala
   {
    sAppearance="temp_placeable";
    sResource = "cnrNuggetGold";
    sSuccessString = "Podarilo se ti vytkutat pekny kus rudy zeleza";
   }
  if (sSelf == "cnrRockMith") //skala
   {
    sAppearance="temp_placeable";
    sResource = "cnrNuggetMith";
    sSuccessString = "Podarilo se ti vytkutat pekny kus rudy zeleza";
   }
  if (sSelf == "cnrRockPlat") //skala
   {
    sAppearance="temp_placeable";
    sResource = "cnrNuggetPlat";
    sSuccessString = "Podarilo se ti vytkutat pekny kus rudy zeleza";
   }
  if (sSelf == "cnrRockSilv") //skala
   {
    sAppearance="temp_placeable";
    sResource = "cnrNuggetSilv";
    sSuccessString = "Podarilo se ti vytkutat pekny kus rudy zeleza";
   }
  if (sSelf == "cnrRockTita") //skala
   {
    sAppearance="temp_placeable";
    sResource = "cnrNuggetTita";
    sSuccessString = "Podarilo se ti vytkutat pekny kus rudy zeleza";
   }
  if (sSelf == "cnrRockIron") //skala
   {
    sAppearance="temp_placeable";
    sResource = "cnrNuggetIron";
    sSuccessString = "Podarilo se ti vytkutat pekny kus rudy zeleza";
   }
  if (sSelf == "cnrRockCopp") //skala
   {
    sAppearance="temp_placeable";
    sResource = "cnrNuggetCopp";
    sSuccessString = "Podarilo se ti vytkutat pekny kus rudy medi";
   }

  if (GetStringLeft(sSelf,13) == "cnrGemDeposit") //skala
   {
    sAppearance="temp_placeable";
    sResource = "cnrGemMineral" + GetStringRight(sSelf,3);
    sSuccessString = "Podarilo se ti vytkutat pekny kus nerostu";
   }


  iRandom = Random(1000);

  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM9,1.0,5.0));

  if (iRandom <= iDigChance)
    {
     DelayCommand(5.0,FloatingTextStringOnCreature(sSuccessString,oPC,FALSE));
     iMaxDig--;
     SetLocalInt(oSelf,"iMaxDig",iMaxDig);
     if (iMaxDig==1)
      {
       SetLocalInt(oSelf,"iAmSetToDie",99);
       SetLocalInt(oPC,"iAmDigging",0);
       DelayCommand(3.0,FloatingTextStringOnCreature("Zdroj je pryc!",oPC,FALSE));
       DelayCommand(6.5,ReplaceSelf(oSelf,sAppearance));
      }
     iSuccess = 1;
     DelayCommand(6.0,CreateAnObject(sResource,oPC));
     if (iMaxDig>1) DelayCommand(5.5,AssignCommand(oPC,CheckAction(oPC,oSelf)));
     if (Random(1000)> iMiningSkill)
      {
       if (d10(1)+1>= iMiningSkill/1000)
        {
         if (GetLocalInt(oPC,"iSkillGain")==0)
          {
           if (iMaxDig>1)SetLocalInt(oPC,"iSkillGain",99);
           DelayCommand(10.0,SetLocalInt(oPC,"iSkillGain",0));
           iMiningSkill++;
           sOldSkill2 = IntToString(iMiningSkill);
           sOldSkill = "."+GetStringRight(sOldSkill2,1);
           if (iMiningSkill > 9)
             {
              sOldSkill = GetStringLeft(sOldSkill2,GetStringLength(sOldSkill2)-1)+sOldSkill;
             }
            else
             {
              sOldSkill = "0"+sOldSkill;
             }
           if (iMiningSkill <= 1000)
            {
             //DelayCommand(5.5,SetTokenPair(oPC,14,3,iMiningSkill));
             DelayCommand(6.0,CnrSetPersistentInt(oPC,"iMiningSkill",iMiningSkill));
             DelayCommand(6.0,SendMessageToPC(oPC,"=================================="));
             DelayCommand(6.0,SendMessageToPC(oPC,"Tvoje dovednost se zlepsila!"));
             DelayCommand(6.0,SendMessageToPC(oPC,"Soucasna dovednost hornictvi je : "+ sOldSkill+"%"));
             DelayCommand(6.0,SendMessageToPC(oPC,"=================================="));
             //if (GetLocalInt(GetModule(),"_UOACraft_XP")!=0) DelayCommand(6.0,GiveXPToCreature(oPC,GetLocalInt(GetModule(),"_UOACraft_XP")));
            }
          }
        }
      }
    }
   else
    {
     switch (d8(1))
      {
       case 1:{sFailString="Tvuj pokrok jde pomalu...";break;}
       case 2:{sFailString="Zacinas mit ztuhla zada...";break;}
       case 3:{sFailString="Paze zacinaji byt unaveny...";break;}
       case 4:{sFailString="Nekde to tu prece je..";break;}
       case 5:{sFailString="To je zpatecnicke!";break;}
       default:{break;}
      }
     DelayCommand(5.0,FloatingTextStringOnCreature(sFailString,oPC,FALSE));
     DelayCommand(5.5,AssignCommand(oPC,CheckAction(oPC,oSelf)));
     return;
    }

  if (iSuccess == 1)
   {
    iToolBreak++;
    if (iToolBreak > 100)
     {
      DelayCommand(6.0,FloatingTextStringOnCreature("Zlomil se ti nastroj..",oPC,FALSE));
      DestroyObject(oTool,6.0);
      iToolBreak = 0;
     }
   }

  SetLocalInt(oPC,"iToolWillBreak",iToolBreak);
}

void CheckAction(object oPC, object oSelf)
 {
  int iCurrentAction = GetCurrentAction(oPC);
  if (iCurrentAction == ACTION_MOVETOPOINT) return;
  if (iCurrentAction == ACTION_ATTACKOBJECT) return;
  if (iCurrentAction == ACTION_CASTSPELL) return;
  if (iCurrentAction == ACTION_REST) return;
  if (iCurrentAction == ACTION_PICKUPITEM) return;
  if (iCurrentAction == ACTION_SIT) return;
  if (GetDistanceBetween(oPC,oSelf) >2.5) return;

  AssignCommand(oPC,ActionInteractObject(oSelf));

 }

void CreateAnObject(string sResource, object oPC)
 {
  CreateItemOnObject(sResource,oPC,1);
  return;
 }

void ReplaceSelf(object oSelf, string sAppearance)
 {
  object oTemp;
  location lSelf;
  string sResSelf;
  sResSelf=GetResRef(oSelf);
  lSelf=GetLocation(oSelf);
  oTemp = CreateObject(OBJECT_TYPE_PLACEABLE,sAppearance,lSelf,FALSE);
  DestroyObject(oSelf,1.0);
  AssignCommand(oTemp,DelayCommand(1200.0,CreateNew(lSelf,sResSelf)));
  DestroyObject(oTemp,1230.0);
  return;
 }

void CreateNew(location lSelf, string sResSelf)
 {
  CreateObject(OBJECT_TYPE_PLACEABLE,sResSelf,lSelf,FALSE);
  return;
 }

void CreatePlaceable(string sObject, location lPlace, float fDuration)
{
  object oPlaceable = CreateObject(OBJECT_TYPE_PLACEABLE,sObject,lPlace,FALSE);
  if (fDuration != 0.0)
    DestroyObject(oPlaceable,fDuration);
}



// zakomentovano melvik 20,8.2008

/*
#include "cnr_config_inc"
#include "cnr_language_inc"

void SpawnNewGemDeposit(string sDepositTag, location locDeposit)
{
  CreateObject(OBJECT_TYPE_PLACEABLE, sDepositTag, locDeposit);
  DestroyObject(OBJECT_SELF);
}

void DoPostChiselingSuccessCheck(object oUser, location locUserAtStart, object oDeposit)
{
  DeleteLocalInt(oDeposit, "CnrStopRapidClicks");

  location locUser = GetLocation(oUser);
  if (locUser != locUserAtStart)
  {
    return;
  }

  object oMineral1 = OBJECT_INVALID;
  object oMineral2 = OBJECT_INVALID;
  object oMineral3 = OBJECT_INVALID;

  // chance of success
  if (cnr_d100(1) <= CNR_FLOAT_GEM_MINING_FIND_FIRST_MINERAL_PERCENTAGE)
  {
    string sDepositTag = GetTag(oDeposit);
    string sMineralTag = GetLocalString(GetModule(), sDepositTag + "_MineralTag");
    if (sMineralTag != "")
    {
      oMineral1 = CreateObject(OBJECT_TYPE_ITEM, sMineralTag, locUser);
      FloatingTextStringOnCreature(CNR_TEXT_YOU_CHISELED_OFF_A + GetName(oMineral1) + "!", oUser);

      if (cnr_d100(1) <= CNR_FLOAT_GEM_MINING_FIND_SECOND_MINERAL_PERCENTAGE)
      {
        oMineral2 = CreateObject(OBJECT_TYPE_ITEM, sMineralTag, locUser);
        FloatingTextStringOnCreature(CNR_TEXT_AND_A_SECOND + GetName(oMineral2) + "!", oUser);
      }

      if (cnr_d100(1) <= CNR_FLOAT_GEM_MINING_FIND_MYSTERY_MINERAL_PERCENTAGE)
      {
        oMineral3 = CreateObject(OBJECT_TYPE_ITEM, "cnrGemMineral000", locUser);
        FloatingTextStringOnCreature(CNR_TEXT_AND_A + GetName(oMineral3) + "!", oUser);
      }

      ActionPickUpItem(oMineral1);

      if (oMineral2 != OBJECT_INVALID)
      {
        ActionPickUpItem(oMineral2);
      }

      if (oMineral3 != OBJECT_INVALID)
      {
        ActionPickUpItem(oMineral3);
      }
    }
  }
  else
  {
    ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD, 1.0);
    //FloatingTextStringOnCreature("You failed to find anything in the deposit.", oUser);
    string sFloat;
    int nFloat = d6(1);
    if (nFloat == 1)      {sFloat = CNR_TEXT_GEMDEP_MUMBLE_1;}
    else if (nFloat == 2) {sFloat = CNR_TEXT_GEMDEP_MUMBLE_2;}
    else if (nFloat == 3) {sFloat = CNR_TEXT_GEMDEP_MUMBLE_3;}
    else if (nFloat == 4) {sFloat = CNR_TEXT_GEMDEP_MUMBLE_4;}
    else if (nFloat == 5) {sFloat = CNR_TEXT_GEMDEP_MUMBLE_5;}
    else if (nFloat == 6) {sFloat = CNR_TEXT_GEMDEP_MUMBLE_6;}
    DelayCommand(1.0, FloatingTextStringOnCreature(sFloat, oUser));
    DelayCommand(2.0, DoPlaceableObjectAction(oDeposit, PLACEABLE_ACTION_USE));
  }
}

void main()
{
  int bStopRapidClicks = GetLocalInt(OBJECT_SELF, "CnrStopRapidClicks");
  if (bStopRapidClicks == TRUE) return;
  SetLocalInt(OBJECT_SELF, "CnrStopRapidClicks", TRUE);

  object oDeposit = OBJECT_SELF;
  object oUser = GetLastUsedBy();

  int bValidTool = FALSE;
  object oChisel = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oUser);
  if (oChisel != OBJECT_INVALID)
  {
    if (GetTag(oChisel) == "cnrGemChisel")
    {
      bValidTool = TRUE;
    }
  }

  if (bValidTool == FALSE)
  {
    oChisel = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oUser);
    if (oChisel != OBJECT_INVALID)
    {
      if (GetTag(oChisel) == "cnrGemChisel")
      {
        bValidTool = TRUE;
      }
    }
  }

  if (!bValidTool)
  {
    FloatingTextStringOnCreature(CNR_TEXT_YOU_MUST_HOLD_A_CHISEL, oUser);
    SetLocalInt(OBJECT_SELF, "CnrStopRapidClicks", FALSE);
    return;
  }

  // there's a chance the chisel may break
  if (cnr_d100(1) <= CNR_FLOAT_GEM_MINING_CHISEL_BREAKAGE_PERCENTAGE)
  {
    DestroyObject(oChisel);
    FloatingTextStringOnCreature(CNR_TEXT_YOU_HAVE_BROKEN_YOUR_CHISEL, oUser);
    SetLocalInt(OBJECT_SELF, "CnrStopRapidClicks", FALSE);
    return;
  }

  location locDeposit = GetLocation(OBJECT_SELF);
  string sDepositTag = GetTag(OBJECT_SELF);

  // Sometimes the deposit will get used up
  if (cnr_d100(1) <= CNR_FLOAT_GEM_MINING_DEPOSIT_BREAKAGE_PERCENTAGE)
  {
    if (CNR_FLOAT_GEM_MINING_DEPOSIT_RESPAWN_TIME_SECS > 0.0)
    {
      ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), OBJECT_SELF);
      object oSpawner = CreateObject(OBJECT_TYPE_PLACEABLE, "cnrobjectspawner", locDeposit);
      AssignCommand(oSpawner, DelayCommand(CNR_FLOAT_GEM_MINING_DEPOSIT_RESPAWN_TIME_SECS, SpawnNewGemDeposit(sDepositTag, locDeposit)));
      DestroyObject(OBJECT_SELF, 0.5); // provide time for death effect
      FloatingTextStringOnCreature(CNR_TEXT_THATS_THE_END_OF_THAT, oUser);
    }
    SetLocalInt(OBJECT_SELF, "CnrStopRapidClicks", FALSE);
    return;
  }

  AssignCommand(oUser, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 3.0));
  DelayCommand(1.0, PlaySound("as_cv_chiseling2"));

  location locUser = GetLocation(oUser);
  AssignCommand(oUser, DelayCommand(3.0, DoPostChiselingSuccessCheck(oUser, locUser, oDeposit)));
}
*/
