/////////////////////////////////////////////////////////
#include "cnr_recipe_utils"

#include "cnr_config_inc"
#include "cnr_persist_inc"



float RecipeGetWeightedPcAbility(object oPC, object oDevice)
{
  if (!GetIsPC(oPC)) return 14.0;

  object oModule = GetModule();

  float fRecipeStr = IntToFloat(GetLocalInt(OBJECT_SELF, "RecipeStr"));
  float fRecipeDex = IntToFloat(GetLocalInt(OBJECT_SELF, "RecipeDex"));
  float fRecipeCon = IntToFloat(GetLocalInt(OBJECT_SELF, "RecipeCon"));
  float fRecipeInt = IntToFloat(GetLocalInt(OBJECT_SELF, "RecipeInt"));
  float fRecipeWis = IntToFloat(GetLocalInt(OBJECT_SELF, "RecipeWis"));
  float fRecipeCha = IntToFloat(GetLocalInt(OBJECT_SELF, "RecipeCha"));

  float fPcStr = IntToFloat(GetAbilityScore(oPC, ABILITY_STRENGTH) + GetAbilityModifier(ABILITY_STRENGTH, oPC));
  float fPcDex = IntToFloat(GetAbilityScore(oPC, ABILITY_DEXTERITY) + GetAbilityModifier(ABILITY_DEXTERITY, oPC));
  float fPcCon = IntToFloat(GetAbilityScore(oPC, ABILITY_CONSTITUTION) + GetAbilityModifier(ABILITY_CONSTITUTION, oPC));
  float fPcInt = IntToFloat(GetAbilityScore(oPC, ABILITY_INTELLIGENCE) + GetAbilityModifier(ABILITY_INTELLIGENCE, oPC));
  float fPcWis = IntToFloat(GetAbilityScore(oPC, ABILITY_WISDOM) + GetAbilityModifier(ABILITY_WISDOM, oPC));
  float fPcCha = IntToFloat(GetAbilityScore(oPC, ABILITY_CHARISMA) + GetAbilityModifier(ABILITY_CHARISMA, oPC));

  float fPcAbility;
  fPcAbility  = fPcStr * (fRecipeStr/100.0);
  fPcAbility += fPcDex * (fRecipeDex/100.0);
  fPcAbility += fPcCon * (fRecipeCon/100.0);
  fPcAbility += fPcInt * (fRecipeInt/100.0);
  fPcAbility += fPcWis * (fRecipeWis/100.0);
  fPcAbility += fPcCha * (fRecipeCha/100.0);

  if (fPcAbility == 0.0)
  {
    // if nothing specified, use intelligence
    fPcAbility = fRecipeInt;
  }

  return fPcAbility;
}

int GetPlayerLevel(object oPC)
{
  int nPlayerLevel;
  int nDeviceTradeskillType = GetLocalInt(OBJECT_SELF, "TRADESKIL_TYPE");
  if (nDeviceTradeskillType == CNR_TRADESKILL_NONE)
  {
    nPlayerLevel = GetHitDice(oPC);
  }
  else
  {
    int nXP = CnrGetTradeskillXPByType(oPC, nDeviceTradeskillType);
    nPlayerLevel = CnrDetermineTradeskillLevel(nXP);
  }
  return nPlayerLevel;
}

int RecipeCalculateEffectiveDC(object oPC, object oDevice)
{
  int nRecipeLevel = GetLocalInt(OBJECT_SELF, "RECIPE_LEVEL");
  int nPcLevel = GetPlayerLevel(oPC);
  float fPcAbility = RecipeGetWeightedPcAbility(oPC, oDevice);
  //SpeakString("nRecipeLevel " + IntToString(nRecipeLevel));
  //SpeakString("nPcLevel " + IntToString(nPcLevel));
  //SpeakString("fPcAbility " + FloatToString(fPcAbility));
  // Formula: DC = (((11 - (PL*2)) - (A/2)) + 27) - ((10-RL)*2)
  int nEffDC = (((11 - (nPcLevel*2)) - FloatToInt(fPcAbility/2.0)) + 27) - ((10-nRecipeLevel) * 2);
  int nAdjustment = 0;

  return nEffDC + nAdjustment;
 }



int RecipeCalculateMinimumPcLevel(object oPC)
{
  int nRecipeLevel = GetLocalInt(OBJECT_SELF, "RECIPE_LEVEL");
  int nPcLevel = GetPlayerLevel(oPC);
  float fPcAbility = RecipeGetWeightedPcAbility(oPC,OBJECT_SELF);

  // Get a builder supplied DC adjustment
  int nAdjustment = 0;

  // Given the player's current ability score, calculate the minimum level
  // the PC needs to be to have any chance of success crafting this recipe.
  //int nMinPcLevel = (11 - (((20 + ((10-nRecipeLevel)*2)) - 27) + (nPcAbility/2))) / 2;
  float fMinPcLevel = IntToFloat(11 - ((((20+nAdjustment) + ((10-nRecipeLevel)*2)) - 27) + FloatToInt(fPcAbility/2.0))) / 2.0;
  int nMinPcLevel = FloatToInt(fMinPcLevel);
  if (IntToFloat(nMinPcLevel) < fMinPcLevel)
  {
    // round up
    nMinPcLevel++;
  }
  return nMinPcLevel;
}

int MeRecipeAttemptToCraft(object oPC, object oDevice)
{
  if (!GetIsPC(oPC))
  {
    return 0;
  }

  int nRoll = d20(1);
  int nEffDC = RecipeCalculateEffectiveDC( oPC, oDevice);


  int bSuccess = TRUE;
  string sResult;
  if (nEffDC > 20)
  {
    sResult = "Tato vyroba je na tebe jeste prilis slozita..";
    int nMinPcLevel = RecipeCalculateMinimumPcLevel(oPC);
    sResult = "Potrebujes alespon " + IntToString(nMinPcLevel) + " level.";
    bSuccess = FALSE;
  }
  else
  {
    sResult += CNR_TEXT_YOU_HAVE_A + IntToString(100-((nEffDC-1)*5)) + CNR_TEXT_PERCENT_CHANCE_OF_SUCCESS;
  }

 SetLocalString(oPC, "sCnrTokenText" + IntToString(22000), sResult);
 ActionStartConversation(oPC, "cnr_c_craft_it", TRUE);
 return TRUE;
}

/////////////////////////////////////////////////////////
void main() // testovani vrati jake ma pc sance
{
  object oUser = GetLastUsedBy();
  MeRecipeAttemptToCraft(oUser, OBJECT_SELF);
  return;
}

