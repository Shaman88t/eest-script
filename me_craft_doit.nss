/////////////////////////////////////////////////////////
#include "cnr_recipe_utils"

#include "cnr_config_inc"
#include "cnr_persist_inc"

const int REC_TITAN_COAT = 100;

// titanovani - recept 1
itemproperty TITAN_COAT_0 = ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1);
itemproperty TITAN_COAT_1 = ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2);
itemproperty TITAN_COAT_2 = ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3);
itemproperty TITAN_COAT_3 = ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4);
// postribreni - recept 2
itemproperty SILVER_COAT_0 = ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,IP_CONST_DAMAGETYPE_SONIC,IP_CONST_DAMAGEBONUS_2);
itemproperty SILVER_COAT_1 = ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,IP_CONST_DAMAGETYPE_SONIC,IP_CONST_DAMAGEBONUS_1d4);
itemproperty SILVER_COAT_2 = ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,IP_CONST_DAMAGETYPE_SONIC,IP_CONST_DAMAGEBONUS_1d6);
itemproperty SILVER_COAT_3 = ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,IP_CONST_DAMAGETYPE_SONIC,IP_CONST_DAMAGEBONUS_2d4);
// ohen    - recept 3
itemproperty FIRE_DMG_0 = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_1);
itemproperty FIRE_DMG_1 = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_2);
itemproperty FIRE_DMG_2 = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_1d4);
itemproperty FIRE_DMG_3 = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_1d6);
// kyselina  - - recept 4
itemproperty ACID_DMG_0 = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGEBONUS_1);
itemproperty ACID_DMG_1 = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGEBONUS_2);
itemproperty ACID_DMG_2 = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGEBONUS_1d4);
itemproperty ACID_DMG_3 = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGEBONUS_1d6);
// blesk - recept 5
itemproperty LIGHTING_DMG_0 = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEBONUS_1);
itemproperty LIGHTING_DMG_1 = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEBONUS_2);
itemproperty LIGHTING_DMG_2 = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEBONUS_1d4);
itemproperty LIGHTING_DMG_3 = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEBONUS_1d6);
// chlad - recept 6
itemproperty COLD_DMG_0 = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEBONUS_1);
itemproperty COLD_DMG_1 = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEBONUS_2);
itemproperty COLD_DMG_2 = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEBONUS_1d4);
itemproperty COLD_DMG_3 = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEBONUS_1d6);


// potitanovani zbrane
void craftItemTitaning(object oItem, object oPc){
    int bOK = FALSE;
    itemproperty ipProperty = GetFirstItemProperty(oItem);
    while(GetIsItemPropertyValid(ipProperty)){
        if((GetItemPropertyType(ipProperty) == ITEM_PROPERTY_ENHANCEMENT_BONUS )){
            int ipCostValue = GetItemPropertyCostTableValue(ipProperty);
            if(ipCostValue == 1){
                AddItemProperty(DURATION_TYPE_PERMANENT, TITAN_COAT_1 ,oItem);
                bOK = TRUE;
            }else if(ipCostValue == 2){
                AddItemProperty(DURATION_TYPE_PERMANENT, TITAN_COAT_2 ,oItem);
                bOK = TRUE;
            }else if (ipCostValue == 3){
                AddItemProperty(DURATION_TYPE_PERMANENT, TITAN_COAT_3 ,oItem);
                bOK = TRUE;
            }
        }
    ipProperty = GetNextItemProperty(oItem);
    }
    if(bOK == FALSE){
        AddItemProperty(DURATION_TYPE_PERMANENT, TITAN_COAT_0 ,oItem);
    }
    string sItemName = GetName(oItem,TRUE);
    string sPlayerName = GetName(oPc,TRUE);
    SetName(oItem,sItemName + "(potazeno titanem)" + "  **" + sPlayerName + "**");
    return;
}

void craftItemSilver(object oItem, object oPc){
    int bOK = FALSE;
    itemproperty ipProperty = GetFirstItemProperty(oItem);
    while(GetIsItemPropertyValid(ipProperty)){
        if((GetItemPropertyType(ipProperty) == ITEM_PROPERTY_ENHANCEMENT_BONUS )){
            int ipCostValue = GetItemPropertyCostTableValue(ipProperty);
            if(ipCostValue == 1){
                AddItemProperty(DURATION_TYPE_PERMANENT, SILVER_COAT_1 ,oItem);
                bOK = TRUE;
            }else if(ipCostValue == 2){
                AddItemProperty(DURATION_TYPE_PERMANENT, SILVER_COAT_2 ,oItem);
                bOK = TRUE;
            }else if (ipCostValue == 3){
                AddItemProperty(DURATION_TYPE_PERMANENT, SILVER_COAT_3 ,oItem);
                bOK = TRUE;
            }
        }
    ipProperty = GetNextItemProperty(oItem);
    }
    if(bOK == FALSE){
        AddItemProperty(DURATION_TYPE_PERMANENT, SILVER_COAT_0 ,oItem);
    }
    string sItemName = GetName(oItem,TRUE);
    string sPlayerName = GetName(oPc,TRUE);
    SetName(oItem,sItemName + "(potazeno stribrem)" + "  **" + sPlayerName + "**");
    return;
}

void craftItemFire(object oItem, object oPc){
    int bOK = FALSE;
    itemproperty ipProperty = GetFirstItemProperty(oItem);
    while(GetIsItemPropertyValid(ipProperty)){
        if((GetItemPropertyType(ipProperty) == ITEM_PROPERTY_ENHANCEMENT_BONUS )){
            int ipCostValue = GetItemPropertyCostTableValue(ipProperty);
            if(ipCostValue == 1){
                AddItemProperty(DURATION_TYPE_PERMANENT, FIRE_DMG_1 ,oItem);
                bOK = TRUE;
            }else if(ipCostValue == 2){
                AddItemProperty(DURATION_TYPE_PERMANENT, FIRE_DMG_2 ,oItem);
                bOK = TRUE;
            }else if (ipCostValue == 3){
                AddItemProperty(DURATION_TYPE_PERMANENT, FIRE_DMG_3 ,oItem);
                bOK = TRUE;
            }
        }
    ipProperty = GetNextItemProperty(oItem);
    }
    if(bOK == FALSE){
        AddItemProperty(DURATION_TYPE_PERMANENT, FIRE_DMG_0 ,oItem);
    }
    string sItemName = GetName(oItem,TRUE);
    string sPlayerName = GetName(oPc,TRUE);
    SetName(oItem,sItemName + "(ohen)" + "  **" + sPlayerName + "**");
    return;
}

void craftItemAcid(object oItem, object oPc){
    int bOK = FALSE;
    itemproperty ipProperty = GetFirstItemProperty(oItem);
    while(GetIsItemPropertyValid(ipProperty)){
        if((GetItemPropertyType(ipProperty) == ITEM_PROPERTY_ENHANCEMENT_BONUS )){
            int ipCostValue = GetItemPropertyCostTableValue(ipProperty);
            if(ipCostValue == 1){
                AddItemProperty(DURATION_TYPE_PERMANENT, ACID_DMG_1 ,oItem);
                bOK = TRUE;
            }else if(ipCostValue == 2){
                AddItemProperty(DURATION_TYPE_PERMANENT, ACID_DMG_2 ,oItem);
                bOK = TRUE;
            }else if (ipCostValue == 3){
                AddItemProperty(DURATION_TYPE_PERMANENT, ACID_DMG_3 ,oItem);
                bOK = TRUE;
            }
        }
    ipProperty = GetNextItemProperty(oItem);
    }
    if(bOK == FALSE){
        AddItemProperty(DURATION_TYPE_PERMANENT, ACID_DMG_0 ,oItem);
    }
    string sItemName = GetName(oItem,TRUE);
    string sPlayerName = GetName(oPc,TRUE);
    SetName(oItem,sItemName + "(kyselina)" + "  **" + sPlayerName + "**");
    return;
}

void craftItemLighting(object oItem, object oPc){
    int bOK = FALSE;
    itemproperty ipProperty = GetFirstItemProperty(oItem);
    while(GetIsItemPropertyValid(ipProperty)){
        if((GetItemPropertyType(ipProperty) == ITEM_PROPERTY_ENHANCEMENT_BONUS )){
            int ipCostValue = GetItemPropertyCostTableValue(ipProperty);
            if(ipCostValue == 1){
                AddItemProperty(DURATION_TYPE_PERMANENT, LIGHTING_DMG_1 ,oItem);
                bOK = TRUE;
            }else if(ipCostValue == 2){
                AddItemProperty(DURATION_TYPE_PERMANENT, LIGHTING_DMG_2 ,oItem);
                bOK = TRUE;
            }else if (ipCostValue == 3){
                AddItemProperty(DURATION_TYPE_PERMANENT, LIGHTING_DMG_3 ,oItem);
                bOK = TRUE;
            }
        }
    ipProperty = GetNextItemProperty(oItem);
    }
    if(bOK == FALSE){
        AddItemProperty(DURATION_TYPE_PERMANENT, LIGHTING_DMG_0 ,oItem);
    }
    string sItemName = GetName(oItem,TRUE);
    string sPlayerName = GetName(oPc,TRUE);
    SetName(oItem,sItemName + "(blesk)" + "  **" + sPlayerName + "**");
    return;
}

void craftItemCold(object oItem, object oPc){
    int bOK = FALSE;
    itemproperty ipProperty = GetFirstItemProperty(oItem);
    while(GetIsItemPropertyValid(ipProperty)){
        if((GetItemPropertyType(ipProperty) == ITEM_PROPERTY_ENHANCEMENT_BONUS )){
            int ipCostValue = GetItemPropertyCostTableValue(ipProperty);
            if(ipCostValue == 1){
                AddItemProperty(DURATION_TYPE_PERMANENT, COLD_DMG_1 ,oItem);
                bOK = TRUE;
            }else if(ipCostValue == 2){
                AddItemProperty(DURATION_TYPE_PERMANENT, COLD_DMG_2 ,oItem);
                bOK = TRUE;
            }else if (ipCostValue == 3){
                AddItemProperty(DURATION_TYPE_PERMANENT, COLD_DMG_3 ,oItem);
                bOK = TRUE;
            }
        }
    ipProperty = GetNextItemProperty(oItem);
    }
    if(bOK == FALSE){
        AddItemProperty(DURATION_TYPE_PERMANENT, COLD_DMG_0 ,oItem);
    }
    string sItemName = GetName(oItem,TRUE);
    string sPlayerName = GetName(oPc,TRUE);
    SetName(oItem,sItemName + "(chlad)" + "  **" + sPlayerName + "**");
    return;
}


void craftItem(object oDevice, object oPc){
    object oItem =GetFirstItemInInventory(oDevice);

    int iRecipe = GetLocalInt(OBJECT_SELF, "RECIPE");
        switch(iRecipe)
        {
            case 0:
                return ;
            case 1: // titanovani
                craftItemTitaning(oItem, oPc); break;
            case 2: // stribro
                craftItemSilver(oItem, oPc); break;
            case 3: // ohen
                craftItemFire(oItem, oPc); break;
            case 4: // acid
                craftItemAcid(oItem, oPc); break;
            case 5: // blesk
                craftItemLighting(oItem, oPc); break;
            case 6: // cold
                craftItemCold(oItem, oPc); break;
            default:
                return ;
        }
    SetPlotFlag(oItem, TRUE);
    return ;
}




int hasPcItemInQ(string sItemTag, object oPc,int iQantity){
    object oItem = GetFirstItemInInventory(oPc);
    int iQonPc =0;
    while (oItem != OBJECT_INVALID){
        if ((GetTag(oItem))== sItemTag){
            iQonPc +=  GetNumStackedItems(oItem);
        }
        if (iQonPc >= iQantity){
            return TRUE;
        }
        oItem = GetNextItemInInventory(oPc);
    }
    return FALSE;
}

void remPcItemInQ(string sItemTag, object oPc,int iQantity){
    object oItem = GetFirstItemInInventory(oPc);
    int iQonPc =iQantity;
    int iTemp = 0;
    while ((oItem != OBJECT_INVALID)&&(iQonPc > 0)){

        if ((GetTag(oItem))== sItemTag){
            iTemp = GetNumStackedItems(oItem);
            //SpeakString(GetTag(oItem));
            //SpeakString("temp je " + IntToString(iTemp));
            //SpeakString("iQonPc je " + IntToString(iQonPc));
            if (iTemp >= iQonPc){
                if (iTemp == iQonPc ){
                    DestroyObject(oItem);
                    iQonPc = 0;
                }else{
                    SetItemStackSize(oItem,iTemp - iQonPc);
                    iQonPc = 0;
                }
            }else{
                DestroyObject(oItem);
                iQonPc -= iTemp;
            }
        }
        oItem = GetNextItemInInventory(oPc);
    }
    return ;
}

int checkIngrediencePresence(object oPc, object oDevice)
{
 // cyk pres vschny ingredience (sou na objektu vyroby)
 int iIndex = 1;
 string sIngredTag;
 int iIngredQ;
 int iInredOnPc = 0;
 object oItem;
 while ((sIngredTag = GetLocalString(oDevice,"INGR" + IntToString(iIndex) )) != ""){
    if ((iIngredQ = GetLocalInt(oDevice,"INGR_REC" + IntToString(iIndex))) == 0){
        iIngredQ = 1;
    }

    if ( (hasPcItemInQ(sIngredTag, oPc,iIngredQ)) == FALSE){
        return FALSE;
    }
    iIndex += 1;
 }
 return TRUE;
}

void destroyIngredienceOn(object oPc, object oDevice)
{
 // cyk pres vschny ingredience (sou na objektu vyroby)
 int iIndex = 1;
 string sIngredTag;
 int iIngredQ;
 int iInredOnPc = 0;
 object oItem;
 while ((sIngredTag = GetLocalString(oDevice,"INGR" + IntToString(iIndex) )) != ""){
    if ((iIngredQ = GetLocalInt(oDevice,"INGR_REC" + IntToString(iIndex))) == 0){
        iIngredQ = 1;
    }
    remPcItemInQ(sIngredTag, oPc,iIngredQ);
    iIndex += 1;
 }
 return ;
}         //CreateItemOnObject(sItemTag, oTarget, nQty)

void destroiIngredienceOnFail(object oPc, object oDevice)
{
 // cyk pres vschny ingredience (sou na objektu vyroby)
 int iIndex = 1;
 string sIngredTag;
 int iIngredQ;
 int iIngredQret;
 int iInredOnPc = 0;
 object oItem;
 while ((sIngredTag = GetLocalString(oDevice,"INGR" + IntToString(iIndex) )) != ""){

    if ((iIngredQ = GetLocalInt(oDevice,"INGR_REC" + IntToString(iIndex))) == 0){
        iIngredQ = 1;
    }
    if ((iIngredQret = GetLocalInt(oDevice,"INGR_RET" + IntToString(iIndex))) == 0){
        iIngredQret = 0;
    }

    remPcItemInQ(sIngredTag, oPc,iIngredQ - iIngredQret);
    iIndex += 1;
 }
 return ;
}


void MeRecipeDisplayCraftingResult(object oPC, object oDevice,  int bSuccess, string sResult, int nEffDC, location locPCAtStart)
{
  // if the PC has moved, then consider it an attempt to abort
  location locPC = GetLocation(oPC);
  if (locPC != locPCAtStart)
  {
    return;
  }

    if (bSuccess){  // zniceni ingredienci
        destroyIngredienceOn( oPC,oDevice);
        // tady uprava itemu v placeablu
        craftItem( oDevice,oPC);
    }else{
        object oItem = GetFirstItemInInventory(oDevice);
        DestroyObject(oItem);
        destroiIngredienceOnFail( oPC,  oDevice);
    }

    string sInfo1;
    string sInfo2;
  if (bSuccess)
  {


    // Give the PC the assigned game and trade XP
    int nTradeXP = GetLocalInt(oDevice, "TRADEXP");
    int nDeviceTradeskillType = GetLocalInt(oDevice, "TRADESKIL_TYPE");

    // don't calculate a negative value for XP
    if (nEffDC < 1) nEffDC = 1;

    // XP is scaled as follows...
    // a 5% success chance yields 95% of 2*RecipeXP
    // a 50% success chance yields 50% of 2*RecipeXP
    // a 95% success chance yields 5% of 2*RecipeXP

    int nScaledTradeXP = FloatToInt((IntToFloat(nEffDC-1) / 10.0) * IntToFloat(nTradeXP));


    if (nDeviceTradeskillType != CNR_TRADESKILL_NONE)
    {
      int nOldXP = CnrGetTradeskillXPByType(oPC, nDeviceTradeskillType);
      int nNewXP = nOldXP + (nScaledTradeXP);

      int bUpdateJournal = FALSE;
      string sTradeName = CnrGetTradeskillNameByType(nDeviceTradeskillType);
      if (nScaledTradeXP > 0)
      {
        sInfo2 = CNR_TEXT_YOUR + sTradeName + CNR_TEXT_XP_INCREASED_BY + IntToString(nScaledTradeXP) + ".\n\n";
        bUpdateJournal = TRUE;
      }
      else if (nScaledTradeXP < 0)
      {
        sInfo2 = CNR_TEXT_YOUR + sTradeName + CNR_TEXT_XP_DECREASED_BY + IntToString(nScaledTradeXP) + ".\n\n";
        bUpdateJournal = TRUE;
      }

      int bLevelDenied = FALSE;
      if (bUpdateJournal)
      {
        int nOldLevel = CnrDetermineTradeskillLevel(nOldXP);
        int nNewLevel = CnrDetermineTradeskillLevel(nNewXP);
        if (nNewLevel > nOldLevel)
        {
          // prep for hook script
          SetLocalInt(oPC, "CnrHookHelperTradeskillType", nDeviceTradeskillType);
          SetLocalInt(oPC, "CnrHookHelperNextLevel", nNewLevel);
          SetLocalInt(oPC, "CnrHookHelperLevelUpDenied", FALSE);
          DeleteLocalString(oPC, "CnrHookHelperLevelUpDeniedText");

          // execute hook script
          ExecuteScript("hook_ok_to_level", oPC);

          // check results
          bLevelDenied = GetLocalInt(oPC, "CnrHookHelperLevelUpDenied");
          if (!bLevelDenied)
          {
            string sNewLevel = CNR_TEXT_YOU_HAVE_REACHED_LEVEL + IntToString(nNewLevel) + CNR_TEXT_IN + sTradeName + "!";
            AssignCommand(oPC, DelayCommand(0.6, SendMessageToPC(oPC, sNewLevel)));
          }
          else
          {
            sInfo2 = GetLocalString(oPC, "CnrHookHelperLevelUpDeniedText");

            // set the PC's XP to one point below making the level
            nNewXP = GetLocalInt(GetModule(), "CnrTradeXPLevel" + IntToString(nNewLevel)) - 1;
          }

          // clean up
          DeleteLocalInt(oPC, "CnrHookHelperTradeskillType");
          DeleteLocalInt(oPC, "CnrHookHelperNextLevel");
          DeleteLocalString(oPC, "CnrHookHelperLevelUpDeniedText");

        }

        CnrSetTradeskillXPByType(oPC, nDeviceTradeskillType, nNewXP);

        if (!bLevelDenied)
        {
          if (nNewLevel < 20)
          {
            int nLevelXP = GetLocalInt(GetModule(), "CnrTradeXPLevel" + IntToString(nNewLevel+1));
            nLevelXP -= nNewXP;
            sInfo2 += CNR_TEXT_YOU_NEED + IntToString(nLevelXP) + CNR_TEXT_XP_TO_REACH_THE_NEXT_LEVEL_IN + sTradeName + ".";
          }
          sInfo2 += CNR_TEXT_YOU_ARE_CURRENTLY_AT_LEVEL + IntToString(nNewLevel) + ".\n";
        }
      }
    }

    sResult = "Podarilo se vyrobit predmet.";
  }

    sResult += "\n\n" + sInfo1 + sInfo2;
    //SetCustomToken(22000, sResult);
    SetLocalString(oPC, "sCnrTokenText" + IntToString(22000), sResult);
    // Note: the custom token will be set in "cnr_ta_tok_22000".
    ActionStartConversation(oPC, "cnr_c_craft_it", TRUE);

}

float RecipeGetWeightedPcAbility(object oPC, object oDevice)
{
  if (!GetIsPC(oPC)) return 14.0;

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

  // Formula: DC = (((11 - (PL*2)) - (A/2)) + 27) - ((10-RL)*2)
  int nEffDC = (((11 - (nPcLevel*2)) - FloatToInt(fPcAbility/2.0)) + 27) - ((10-nRecipeLevel) * 2);
  int nAdjustment = 0;

  return nEffDC + nAdjustment;
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
    bSuccess = FALSE;
  }
  else if (nRoll < nEffDC)
  {
    // failure
    sResult = CNR_TEXT_FAILURE + "  " + CNR_TEXT_YOU_ROLLED_A + IntToString(nRoll) + ".\n";
    sResult = sResult + "\n" + CNR_TEXT_YOU_NEEDED_TO_ROLL_A + IntToString(nEffDC) + CNR_TEXT_OR_BETTER + "\n";
    bSuccess = FALSE;
  }

    float fAnimationDelay = 0.0;
    location locPC = GetLocation(oPC);

    // set this for the animation script to use
    SetLocalObject(oDevice, "oCnrCraftingPC", oPC);

    // set this for the animation script to use
    SetLocalInt(oPC, "bCnrCraftingResult", bSuccess);

   // ExecuteScript(sScript, oDevice);

    fAnimationDelay = 0.5;//GetLocalFloat(oPC, "fCnrAnimationDelay");
    DelayCommand(fAnimationDelay, MeRecipeDisplayCraftingResult(oPC, oDevice,  bSuccess, sResult, nEffDC, locPC));

  if (bSuccess)
  {
    // make sure we return a positive value
    return 1;
  }
  else
  {
    // make sure we return a negative value
    return -1;
  }
}

/////////////////////////////////////////////////////////
void main()
{
  object oUser = GetLastUsedBy();

  object oItem = GetFirstItemInInventory(OBJECT_SELF);
  if (oItem == OBJECT_INVALID){
    SpeakString("Hmm, tak co budem vyrabet");
    return;
  }

  int iRecipe = GetLocalInt(OBJECT_SELF, "RECIPE");     // cislo receptu ktere placeabl dela
 /* if (!GetLocalInt(OBJECT_SELF, "lii1"))         //jsou objektu nastaveny ingredience ?
  {
        SpeakString("Nacteni receptu");
        SetItemLocals(iRecipe);   // nastaveni ingredienci
  }    */
  //SpeakString("Vlozte vec, kterou chcete upravit");
  if(checkIngrediencePresence(oUser, OBJECT_SELF)){
        MeRecipeAttemptToCraft(oUser, OBJECT_SELF);
  }else{
        SpeakString("Nemas potrebne ingredience");
  }
  return;
}



