/////////////////////////////////////////////////////////
//
//  Artefakt Thalia Craft
//
//  Meno: kh_ArtefSperky
//
//  Recept pre artefakty sperky
//
//  Autor: Khain Fripp 12.1.2007
//  Upravene: none
//
/////////////////////////////////////////////////////////
#include "cnr_recipe_utils"

void main()
{
  string sKeyToRecipe;

  PrintString("kh_ArtefSperky init");

  string sMenuRings = CnrRecipeAddSubMenu("kh_ArtefSperky", "Prsteny");
  string sMenuAmulets = CnrRecipeAddSubMenu("kh_ArtefSperky", "Amulety");

  CnrRecipeSetDevicePreCraftingScript("kh_ArtefSperky", "cnr_jeweler_anim");
  CnrRecipeSetDeviceInventoryTool("kh_ArtefSperky", "cnrGemTools", CNR_FLOAT_GEM_CRAFTERS_TOOLS_BREAKAGE_PERCENTAGE);
  CnrRecipeSetDeviceTradeskillType("kh_ArtefSperky", CNR_TRADESKILL_GEM_CRAFTING);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuRings, "Prsten magicke bitvy", "kh_prsmagbit", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldRing", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_srdcedemona", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_magohnisko", 2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant012", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_magbit", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAmulets, "Amulet hrdinstvi", "kh_amulhrd", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldAmulet", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_srdcebslaad", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "me_misc_srdTrCh", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant012", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_amulhrd", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

}
