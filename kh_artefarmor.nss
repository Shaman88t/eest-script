/////////////////////////////////////////////////////////
//
//  Artefakt Thalia Craft
//
//  Meno: kh_ArtefArmor
//
//  Recept pre artefakty brnenia
//
//  Autor: Khain Fripp 12.1.2007
//  Upravene: none
//
/////////////////////////////////////////////////////////
#include "cnr_recipe_utils"

void main()
{
  string sKeyToRecipe;

  PrintString("kh_ArtefArmor init");

  string sMenuOcelovaKuze = CnrRecipeAddSubMenu("kh_ArtefArmor", "Ocelova kuze");
  string sMenuDusevniClona = CnrRecipeAddSubMenu("kh_ArtefArmor", "Dusevni clona");
  string sMenuCelenka = CnrRecipeAddSubMenu("kh_ArtefArmor", "Celenka cernokeznika");
  string sMenuOhnivyKrunyr = CnrRecipeAddSubMenu("kh_ArtefArmor", "Ohnivy krunyr");
  string sMenuOhnivyStit = CnrRecipeAddSubMenu("kh_ArtefArmor", "Ohnivy stit");

  CnrRecipeSetDevicePreCraftingScript("kh_ArtefArmor", "cnr_anvil_anim");
  CnrRecipeSetDeviceEquippedTool("kh_ArtefArmor", "cnrSmithsHammer", CNR_FLOAT_SMITH_HAMMER_BREAKAGE_PERCENTAGE);
  CnrRecipeSetDeviceTradeskillType("kh_ArtefArmor", CNR_TRADESKILL_ARMOR_CRAFTING);

  // Ocelova kuze

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuOcelovaKuze, "Ocelova kuze (krouzkova kosile)", "kh_ocelkuze001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrChainMailAda", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_supmutanta", 8, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "supinybuleta", 20, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_ocelkuze", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuOcelovaKuze, "Ocelova kuze (hrudni krunyr)", "kh_ocelkuze002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrScaleMailAda", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_supmutanta", 8, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "supinybuleta", 20, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_ocelkuze", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

// Dusevni clona

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuDusevniClona, "Dusevni clona (helmice)", "kh_dusclona", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrHelmJutAda", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_mozstarmoz", 5, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant012", 15, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_dusclon", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

// Celenka cernokeznika

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCelenka, "Celenka cernokeznika (helmice)", "kh_celcerno", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrHelmPotAda", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_lepdemilicha", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_zublicha", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_celcerno", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

// Ohnivy krunyr

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuOhnivyKrunyr, "Ohnivy krunyr (pulpat)", "kh_ohnkrun001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrHalfPlateAda", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_krovohnivkral", 5, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "it_cmat_elmw001", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_ohnkrunyr", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuOhnivyKrunyr, "Ohnivy krunyr (pancir)", "kh_ohnkrun002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrSplitMailAda", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_krovohnivkral", 5, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "it_cmat_elmw001", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_ohnkrunyr", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuOhnivyKrunyr, "Ohnivy krunyr (plna platova zbroj)", "kh_ohnkrun003", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrFullPlateAda", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_krovohnivkral", 5, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "it_cmat_elmw001", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_ohnkrunyr", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuOhnivyKrunyr, "Ohnivy krunyr (paskova zbroj)", "kh_ohnkrun004", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrBandedMailAda", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_krovohnivkral", 5, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "it_cmat_elmw001", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_ohnkrunyr", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

// Ohnivy stit

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuOhnivyStit, "Ohnivy stit (maly stit)", "kh_ohnstit001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "me_stit_malada", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_krovohnivkral", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "it_cmat_elmw001", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_ohnstit", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuOhnivyStit, "Ohnivy stit (velky stit)", "kh_ohnstit002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "me_stit_strada", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_krovohnivkral", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "it_cmat_elmw001", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_ohnstit", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuOhnivyStit, "Ohnivy stit (paveza)", "kh_ohnstit003", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "me_stit_velada", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_krovohnivkral", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "it_cmat_elmw001", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_ohnstit", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

}
