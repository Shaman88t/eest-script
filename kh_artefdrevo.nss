/////////////////////////////////////////////////////////
//
//  Artefakt Thalia Craft
//
//  Meno: kh_ArtefDrevo
//
//  Recept pre artefakty strelne zbrane
//
//  Autor: Khain Fripp 12.1.2007
//  Upravene: none
//
/////////////////////////////////////////////////////////
#include "cnr_recipe_utils"

void main()
{
  string sKeyToRecipe;

  PrintString("kh_ArtefDrevo init");

  string sMenuPosle = CnrRecipeAddSubMenu("kh_ArtefDrevo", "Posel pekel");
  string sMenuBalista = CnrRecipeAddSubMenu("kh_ArtefDrevo", "Rucni balista");
  string sMenuHulMoci = CnrRecipeAddSubMenu("kh_ArtefDrevo", "Hul moci");
  string sMenuTotemic = CnrRecipeAddSubMenu("kh_ArtefDrevo", "Totemicka hul");

  CnrRecipeSetDevicePreCraftingScript("kh_ArtefDrevo", "cnr_carp_anim");
  CnrRecipeSetDeviceInventoryTool("kh_ArtefDrevo", "cnrCarpsTools", CNR_FLOAT_CARPS_TOOLS_BREAKAGE_PERCENTAGE);
  CnrRecipeSetDeviceTradeskillType("kh_ArtefDrevo", CNR_TRADESKILL_WOOD_CRAFTING);

// Posel pekel

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuPosle, "Posel pekel (kraty luk)", "kh_posolpek001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "me_luk_COockrMah", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_srdcedemona", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_prastardub", 5, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_pospek", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuPosle, "Posel pekel (dlhy luk)", "kh_posolpek002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "me_luk_COocdlMah", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_srdcedemona", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_prastardub", 5, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_pospek", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

// Rucni balista

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBalista, "Rucni balista (lehka kuse)", "kh_rucbalista", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "me_kus_ockrMah", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_okovsevid", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_prastardub", 5, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_rucbal", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBalista, "Rucni balista (tazka kuse)", "kh_rucbalista002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "me_kus_ocdlMah", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_okovsevid", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_prastardub", 5, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_rucbal", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

// Hul moci

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuHulMoci, "Hul moci (pre maga)", "kh_hulmoc001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant012", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_lebstarlich", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "me_misc_souMGol", 2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_hulmoc", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuHulMoci, "Hul moci (pre zaklinace)", "kh_hulmoc002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant012", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_lebstarlich", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "me_misc_souMGol", 2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_hulmoc", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

// Totemicka hul

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTotemic, "Totemica hul (kyj)", "kh_totemhul001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_srdcepravlk", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_magohnisko", 2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_prastardub", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_totem", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTotemic, "Totemica hul (hul)", "kh_totemhul002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_srdcepravlk", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_magohnisko", 2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_prastardub", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_totem", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  }
