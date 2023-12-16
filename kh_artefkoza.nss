/////////////////////////////////////////////////////////
//
//  Artefakt Thalia Craft
//
//  Meno: kh_ArtefKoza
//
//  Recept pre artefakty boty, plaste, roby, opasky, rukavice
//
//  Autor: Khain Fripp 12.1.2007
//  Upravene: none
//
/////////////////////////////////////////////////////////
#include "cnr_recipe_utils"

void main()
{
  string sKeyToRecipe;

  PrintString("kh_ArtefKoza init");

  string sMenuKyklop = CnrRecipeAddSubMenu("kh_ArtefKoza", "Pas zuriveho kyklopa");
  string sMenuTygri = CnrRecipeAddSubMenu("kh_ArtefKoza", "Tygri zbroj");
  string sMenuOhnive = CnrRecipeAddSubMenu("kh_ArtefKoza", "Ohnive piesti");
  string sMenuRobaPulmesice = CnrRecipeAddSubMenu("kh_ArtefKoza", "Roba pulmesice");
  string sMenuStitovyPlast = CnrRecipeAddSubMenu("kh_ArtefKoza", "Stitovy plast");
  string sMenuSedmimilove = CnrRecipeAddSubMenu("kh_ArtefKoza", "Sedmimilove boty");

  CnrRecipeSetDevicePreCraftingScript("kh_ArtefKoza", "cnr_tailor_anim");
  CnrRecipeSetDeviceInventoryTool("kh_ArtefKoza", "cnrSewingKit", CNR_FLOAT_SEWING_KIT_BREAKAGE_PERCENTAGE);
  CnrRecipeSetDeviceTradeskillType("kh_ArtefKoza", CNR_TRADESKILL_TAILORING);

// Pas zuriveho kyklopa

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuKyklop, "Pas zuriveho kyklopa", "kh_paskyklopa", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_srdcenackyk", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kuzealansijskeho", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_paskyk", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

// Tygri zbroj

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTygri, "Tygri zbroj (vycpana)", "kh_tygrzbroj001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "Kuzesamicealansijskehotygra", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_prachzla", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_tygzbroj", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTygri, "Tygri zbroj (normalni)", "kh_tygrzbroj002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "Kuzesamicealansijskehotygra", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_prachzla", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_tygzbroj", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTygri, "Tygri zbroj (vyztuzena)", "kh_tygrzbroj003", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "Kuzesamicealansijskehotygra", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_prachzla", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_tygzbroj", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

// Ohnive piesti

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuOhnive, "Ohnive piesti", "kh_ohnpiest", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "Kuzesamicealansijskehotygra", 2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_krovohnivkral", 5, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "it_cmat_elmw001", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_ohnpiest", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

// Roba pulmesice

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuRobaPulmesice, "Roba pulmesice", "kh_pulmesroba", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "Kuzesamicealansijskehotygra", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_magohnisko", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_supmutanta", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_pulmes", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

// Stitovy plast

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuStitovyPlast, "Stitovy plast", "kh_ocelpla", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "me_misc_souMGol", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_srdcedemona", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "Kuzesamicealansijskehotygra", 4, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_ocelpal", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

// Sedmimilove boty

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSedmimilove, "Sedmimilove boty", "kh_sedmilboty", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_bleskohnisko", 2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_srdcepravlk", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "Kuzesamicealansijskehotygra", 2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_sedmil", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

}
