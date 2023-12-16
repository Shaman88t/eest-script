//#include "_persist_01a"
 #include "cnr_persist_inc"
void CreateAnObject(string sResource, object oPC, int iStackSize);
void BeeAttackPC(object oPC, object oSelf);

void main()
{
   object oItem = GetInventoryDisturbItem();
   object oPC = GetLastDisturbed();
   object oSelf = OBJECT_SELF;
   // The following 3 lines are to ensure compatability with UOAbigal's Persistent Token System.
   // You can replace them with whatever 'no-drop' code you have or comment them out.
   string sNoDropFlag = (GetStringLeft(GetTag(oItem),6));
   if (sNoDropFlag == "NoDrop" || sNoDropFlag == "TOKEN_"||sNoDropFlag=="_TBOX_")
    return;
   if (GetBaseItemType(oItem)==BASE_ITEM_LARGEBOX)
    {
     DestroyObject(oItem);
     SendMessageToPC(oPC,"Kontejner vlozen do tohoto prostoru muze byt znicen.");
     return;
    }
   // End of compatability portion.

  if (GetInventoryDisturbType()== INVENTORY_DISTURB_TYPE_ADDED)
   {
    CopyItem(oItem,oPC,TRUE);
    DestroyObject(GetInventoryDisturbItem());
    return;
   }
  if (GetTag(oItem) == "ITEM_BEESWAX")
   {
    FloatingTextStringOnCreature("Posbiral si nejaky vceli vosk z ulu.",oPC,FALSE);
    return;
   }

  int iAmInUse = GetLocalInt(oSelf,"iAmInUse");
  if (iAmInUse != 0)
   {
    //FloatingTextStringOnCreature("Other than collecting beeswax, you can only do one thing at a time!",oPC,FALSE);
    FloatingTextStringOnCreature("Nemuzes delat dve veci zaraz!",oPC,FALSE);
    CopyObject(oItem,GetLocation(oSelf),oSelf,GetTag(oItem));
    DestroyObject(oItem);
    return;
   }
  SetLocalInt(oSelf,"iAmInUse",99);
  DelayCommand(7.0,SetLocalInt(oSelf,"iAmInUse",0));
  //ensure at least 1 respawn 10 minutes after used...
   //this is to prevent a broken placeable that is used, with a 'in use' delay
   //which would cancel the respawn
   if (GetLocalInt(OBJECT_SELF,"iAmSetToRespawn")!=99)
    {
     SetLocalInt(OBJECT_SELF,"iAmSetToRespawn",99);
     DelayCommand(600.0,ExecuteScript("_onclose_clear2",OBJECT_SELF));
    }

  int iDay = GetLocalInt(oSelf,"iLastDay");
  int iHour = GetLocalInt(oSelf,"iLastHour");
  int iHoneyComb = GetLocalInt(oSelf,"iHoneyComb");
  int iHoney = GetLocalInt(oSelf,"iHoney");

  //int iBeeSkill = GetTokenPair(oPC,13,1);
  int iBeeSkill = CnrGetPersistentInt(oPC,"iBeeSkill");
  int iBeeChance = iBeeSkill;

  if (iBeeChance <350)
   {
    iBeeChance = GetAbilityScore(oPC,ABILITY_WISDOM)*5;
    iBeeChance = iBeeChance +(GetAbilityScore(oPC,ABILITY_DEXTERITY)*3);
    iBeeChance = iBeeChance +(GetAbilityScore(oPC,ABILITY_CHARISMA)*2);
    iBeeChance = iBeeChance * 3;
    if (iBeeChance >350) iBeeChance = 350;
    if (iBeeSkill > iBeeChance) iBeeChance = iBeeSkill;
   }

  int iRandom = Random(1000);
  int iSuccess=0;

  string sSuccess = "";
  string sFail = "";
  string sItem = "";

  AssignCommand(oPC,DelayCommand(1.0,PlaySound("as_na_grassmove1")));
  AssignCommand(oPC,DelayCommand(4.0,PlaySound("as_na_grassmove2")));

  if (GetTag(oItem)=="ITEM_HONEYCOMB")
   {
    FloatingTextStringOnCreature("Zacel(a) si vydelavat vceli plastev z ulu..",oPC,FALSE);
    sItem = "honeycomb";
    iBeeChance = iBeeChance - 250;
    //sSuccess = "You carefully cut the honeycomb from the hive.";
    sSuccess = "Opatrne jsi vydelal(a) vceli plastev z ulu";
    if (iRandom <= iBeeChance) iSuccess=1;
    iHoneyComb--;
    if (iSuccess != 1)
     {
      if (Random(1000)>iBeeChance)
        {
         sFail = "Vyrusil si vcely!";
         AssignCommand(oPC,DelayCommand(6.0,BeeAttackPC(oPC,oSelf)));
        }
       else
        {
         sFail = "Znicil(a) jsi plastev, kdyz ses ji snazil(a) vytahnout z ulu.";
        }
     }
   }

  if (GetTag(oItem)=="ITEM_HONEY")
   {
    FloatingTextStringOnCreature("Zacal(a) jsi sbirat med z ulu...",oPC,FALSE);
    sItem = "menchoney";
    iHoney--;
    sSuccess = "Opatrne jsi ziskal(a) med z ulu.";
    if (iRandom <= iBeeChance) iSuccess=1;

    if (iSuccess != 1)
     {
      if (Random(1000)>iBeeChance)
        {
         sFail = "Vyrusil jsi vcely!";
         AssignCommand(oPC,DelayCommand(6.0,BeeAttackPC(oPC,oSelf)));
        }
       else
        {
         sFail = "Znecistil(a) jsi med pri vytahovani z ulu.";
        }
     }
   }

  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,6.0));
  //AssignCommand(oPC,PlaySound(""));

  SetLocalInt(oSelf,"iHoneyComb",iHoneyComb);
  SetLocalInt(oSelf,"iHoney",iHoney);

  DestroyObject(oItem);

  int iSkillGain =0;

  if (iSuccess==1)
    {
     AssignCommand(oPC,DelayCommand(6.0,FloatingTextStringOnCreature(sSuccess,oPC,FALSE)));
     //predani cnr medu
     if (sItem == "menchoney") sItem = "cnrhoney";
     AssignCommand(oPC,DelayCommand(6.0,CreateAnObject(sItem,oPC,1)));
     iRandom = Random(1000);
     if (iRandom >= iBeeSkill)
      {
       if (d10(1)+1 >= iBeeChance/100) iSkillGain = 1;
      }
    }
   else
    {
     AssignCommand(oPC,DelayCommand(6.0,FloatingTextStringOnCreature(sFail,oPC,FALSE)));
    }

  //Ensure no more than 1 skill gain every 10 seconds to avoid token droppage.
      if (iSkillGain ==1)
       {
        if (GetLocalInt(oPC,"iSkillGain")!= 0)
          {
           iSkillGain = 0;
          }
         else
          {
           SetLocalInt(oPC,"iSkillGain",99);
           DelayCommand(10.0,SetLocalInt(oPC,"iSkillGain",0));
          }
       }



  if (iSkillGain ==1)
    {
     string sOldSkill = "";
     string sOldSkill2 = "";
     iBeeSkill++;
     sOldSkill2 = IntToString(iBeeSkill);
     sOldSkill = "."+GetStringRight(sOldSkill2,1);
     if (iBeeSkill > 9)
       {
        sOldSkill = GetStringLeft(sOldSkill2,GetStringLength(sOldSkill2)-1)+sOldSkill;
       }
      else
       {
        sOldSkill = "0"+sOldSkill;
       }
     if (iBeeSkill <= 1000)
      {
       //DelayCommand(6.0,SetTokenPair(oPC,13,1,iBeeSkill));
       DelayCommand(6.0,CnrSetPersistentInt(oPC,"iBeeSkill",iBeeSkill));
       DelayCommand(6.0,SendMessageToPC(oPC,"====================================="));
       DelayCommand(6.0,SendMessageToPC(oPC,"Tvoje umeni vcelarstvi se zvysilo!"));
       DelayCommand(6.0,SendMessageToPC(oPC,"Tvoje aktualni umeni je : "+ sOldSkill+"%"));
       DelayCommand(6.0,SendMessageToPC(oPC,"====================================="));
       //if (GetLocalInt(GetModule(),"_UOACraft_XP")!=0) DelayCommand(5.9,GiveXPToCreature(oPC,GetLocalInt(GetModule(),"_UOACraft_XP")));
      }
    }



}

void CreateAnObject(string sResource, object oPC, int iStackSize)
 {
  CreateItemOnObject(sResource,oPC,iStackSize);
  return;
 }

void BeeAttackPC(object oPC, object oSelf)
 {
  AssignCommand(oPC,PlaySound("al_an_flies1"));
  AssignCommand(oPC,ActionMoveAwayFromObject(oSelf,TRUE,20.0));
  ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d4(1),DAMAGE_TYPE_PIERCING,DAMAGE_POWER_NORMAL),oPC,1.0);
  ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_COM_HIT_ELECTRICAL,FALSE),oPC,1.0);
  PlayVoiceChat(VOICE_CHAT_PAIN1,oPC);
  if (FortitudeSave(oPC,12,SAVING_THROW_TYPE_POISON,oSelf)==0)
   {
    AssignCommand(oPC,DelayCommand(3.0,FloatingTextStringOnCreature("Mas alergickou reakci na zihadla!",oPC,FALSE)));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityDecrease(ABILITY_DEXTERITY,d4(1)),oPC,18000.0);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityDecrease(ABILITY_CONSTITUTION,d4(1)),oPC,18000.0);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityDecrease(ABILITY_STRENGTH,d4(1)),oPC,18000.0);
    AssignCommand(oPC,DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_HEAD_ODD,FALSE),oPC,1.0)));
    AssignCommand(oPC,DelayCommand(3.0,PlayVoiceChat(VOICE_CHAT_PAIN2,oPC)));
   }
 }

