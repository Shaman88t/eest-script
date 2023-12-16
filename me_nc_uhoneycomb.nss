//#include "_persist_01a"
#include "cnr_persist_inc"
void CreateAnObject(string sResource, object oPC, int iStackSize);

void main()
{
  object oPC = GetItemActivator();
  //int iBeeSkill = GetTokenPair(oPC,13,1);
  int iBeeSkill = CnrGetPersistentInt(oPC,"iBeeSkill");
  int iBeeChance = iBeeSkill;
  int iSkillGain = 0;
  SetLocalInt(oPC,"iUSeHoneyComb",99);
  AssignCommand(oPC,DelayCommand(8.0,SetLocalInt(oPC,"iUseHoneyComb",0)));

  if (iBeeChance <350)
   {
    iBeeChance = GetAbilityScore(oPC,ABILITY_WISDOM)*5;
    iBeeChance = iBeeChance +(GetAbilityScore(oPC,ABILITY_DEXTERITY)*3);
    iBeeChance = iBeeChance +(GetAbilityScore(oPC,ABILITY_CHARISMA)*2);
    iBeeChance = iBeeChance * 3;
    if (iBeeChance >350) iBeeChance = 350;
    if (iBeeSkill>iBeeChance)iBeeChance=iBeeSkill;
   }


  if (Random(1000) <= iBeeChance)
    {
     iSkillGain = 97;
     AssignCommand(oPC,DelayCommand(2.0,FloatingTextStringOnCreature("Ziskal jsi med ze vceli plastve.",oPC,FALSE)));
     AssignCommand(oPC,DelayCommand(2.0,CreateAnObject("honey",oPC,1)));
    }
   else
    {
     AssignCommand(oPC,DelayCommand(2.0,FloatingTextStringOnCreature("Nanestesti jsi znecistil(a) med kdyz ses ho snazil(a) dostat z plastve.",oPC,FALSE)));
    }
  iBeeChance = iBeeChance-250;

  if (Random(1000) <= iBeeChance)
    {
     iSkillGain = 98;
     AssignCommand(oPC,DelayCommand(4.0,FloatingTextStringOnCreature("Ziskal(a) jsi nejaky vcely vosk z plastve.",oPC,FALSE)));
     AssignCommand(oPC,DelayCommand(4.0,CreateAnObject("beeswax",oPC,1)));
    }
   else
    {
     AssignCommand(oPC,DelayCommand(4.0,FloatingTextStringOnCreature("Nepodarilo se ti ziskat med ani vosk.",oPC,FALSE)));
    }

  iBeeChance = iBeeChance - 250;

  if (Random(1000) <= iBeeChance)
    {
     if (Random(1000)<=400)
       {
        AssignCommand(oPC,DelayCommand(6.0,FloatingTextStringOnCreature("Ziskal(a) jsi kralovsky rosol!",oPC,FALSE)));
        AssignCommand(oPC,DelayCommand(6.0,CreateAnObject("royaljelly",oPC,1)));
        iSkillGain = 99;
       }
      else
       {
        AssignCommand(oPC,DelayCommand(6.0,FloatingTextStringOnCreature("Zadny krolovsky rosol tam nebyl..",oPC,FALSE)));
       }
    }
   else
    {
     AssignCommand(oPC,DelayCommand(6.0,FloatingTextStringOnCreature("Nanestesti jsi znicil(a) kralovsky rosol kdyz jsi se ho snazil(a) dostat z plastve..",oPC,FALSE)));
    }



  if (iSkillGain >0)
   {
    if (Random(1000) > iBeeSkill)
     {
      if (d10(1)+1 >= iBeeSkill/100)
       {
        if (iSkillGain ==97)
         {
          if (d20(1) <5) iSkillGain =1;  // 20% chance to gain if a gain is indicated
         }
        if (iSkillGain ==98)
         {
          if (d20(1) <8) iSkillGain =1;  //approx 33% chance to gain if a gain is indicated
         }
        if (iSkillGain ==99) iSkillGain=1;
       }
     }
   }

  if (iSkillGain == 1)
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
     }
   }
}


void CreateAnObject(string sResource, object oPC, int iStackSize)
 {
  CreateItemOnObject(sResource,oPC,iStackSize);
  return;
 }

