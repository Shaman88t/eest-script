/////////////////////////////////////////////////////////
//
//  Artefakt Thalia Craft
//
//  Meno: kh_ArtefZbrane
//
//  Recept pre artefakty zbrane
//
//  Autor: Khain Fripp 12.1.2007
//  Upravene: none
//
/////////////////////////////////////////////////////////
#include "cnr_recipe_utils"

void main()
{
  string sKeyToRecipe;

  PrintString("kh_ArtefZbrane init");

  string sMenuTemnaCepel = CnrRecipeAddSubMenu("kh_ArtefZbrane", "Temna cepel");
  string sMenuSpar = CnrRecipeAddSubMenu("kh_ArtefZbrane", "Spar bileho slaada");
  string sMenuPlamenJaz = CnrRecipeAddSubMenu("kh_ArtefZbrane", "Plamenny jazyk");
  string sMenuCepelSvetla = CnrRecipeAddSubMenu ("kh_ArtefZbrane", "Cepel svetla");
  string sMenuBourlivak = CnrRecipeAddSubMenu ("kh_ArtefZbrane", "Bourlivak");
  string sMenuSedlak = CnrRecipeAddSubMenu ("kh_ArtefZbrane", "Sedlakuv udel");
  string sMenuGlad = CnrRecipeAddSubMenu ("kh_ArtefZbrane", "Gladiatorska sekera");
  string sMenuDrtic = CnrRecipeAddSubMenu ("kh_ArtefZbrane", "Drtic lebek");
  string sMenuZpivajici = CnrRecipeAddSubMenu ("kh_ArtefZbrane", "Zpivajici cepel");
  string sMenuPosel = CnrRecipeAddSubMenu ("kh_ArtefZbrane", "Posel smrti");

  CnrRecipeSetDevicePreCraftingScript("kh_ArtefZbrane", "cnr_anvil_anim");
  CnrRecipeSetDeviceEquippedTool("kh_ArtefZbrane", "cnrSmithsHammer", CNR_FLOAT_SMITH_HAMMER_BREAKAGE_PERCENTAGE);
  CnrRecipeSetDeviceTradeskillType("kh_ArtefZbrane", CNR_TRADESKILL_WEAPON_CRAFTING);

// Temna cepel

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTemnaCepel, "Temna cepel (dlhy mec)", "kh_temnacepel001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "ry_ad1_dlmec", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_MSMLMISC06", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_gemzla", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_temcep", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTemnaCepel, "Temna cepel (mec bastard)", "kh_temnacepel002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "ry_ad1_mecba", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_MSMLMISC06", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_gemzla", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_temcep", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTemnaCepel, "Temna cepel (velky mec)", "kh_temnacepel003", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "ry_ad1_velmec", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_MSMLMISC06", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_gemzla", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_temcep", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

// Spar bielho slaada

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSpar, "Spar bileho slaada (dyka)", "kh_sparslaad001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "ry_ad1_dyka", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_srdcebslaad", 5, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_jazykslaad", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_sparslad", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSpar, "Spar bileho slaada (kratky mec)", "kh_sparslaad002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "ry_ad1_krmec", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_srdcebslaad", 5, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_jazykslaad", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_sparslad", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSpar, "Spar bileho slaada (rapir)", "kh_sparslaad003", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "ry_ad1_kord", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_srdcebslaad", 5, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_jazykslaad", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_sparslad", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSpar, "Spar bileho slaada (kukri)", "kh_sparslaad004", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "ry_ad1_kukri", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_srdcebslaad", 5, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_jazykslaad", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_sparslad", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSpar, "Spar bileho slaada (scimitar)", "kh_sparslaad005", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "ry_ad1_scim", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_srdcebslaad", 5, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_jazykslaad", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_sparslad", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

// Plamenny jazyk

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuPlamenJaz, "Plamenny jazyk (dlhy mec)", "kh_plamjazyk001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "ry_ad1_dlmec", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_srdcepuldraka", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "it_cmat_elmw001", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_plmjaz", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuPlamenJaz, "Plamenny jazyk (mec bastard)", "kh_plamjazyk002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "ry_ad1_mecba", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_srdcepuldraka", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "it_cmat_elmw001", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_plmjaz", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuPlamenJaz, "Plamenny jazyk (velky mec)", "kh_plamjazyk003", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "ry_ad1_velmec", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_srdcepuldraka", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "it_cmat_elmw001", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_plmjaz", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

// Cepel svetla

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCepelSvetla, "Cepel svetla (dlhy mec)", "kh_cplsvetla001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "ry_ad1_dlmec002", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_posvetkamen", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_okovsevid", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_cplsvetla", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCepelSvetla, "Cepel svetla (mec bastard)", "kh_cplsvetla002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "ry_ad1_mecba001", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_posvetkamen", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_okovsevid", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_cplsvetla", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCepelSvetla, "Cepel svetla (velky mec)", "kh_cplsvetla003", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "ry_ad1_velmec001", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_posvetkamen", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_okovsevid", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_cplsvetla", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

//  Bourlivak

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBourlivak, "Bourlivak (valecne kladivo)", "kh_bourli001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "ry_ad1_valkl", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_beskohnisko", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_srdcenackyk", 5, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "me_misc_souMGol", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kr_rcp_bourli", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBourlivak, "Bourlivak (lehke kladivo)", "kh_bourli002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "ry_ad1_lekl", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_beskohnisko", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_srdcenackyk", 5, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "me_misc_souMGol", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kr_rcp_bourli", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

//Sedlakuv udel

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSedlak, "Sedlakuv udel (lahky cep)", "kh_sedlak001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "ry_ad1_lehcep002", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_magohnisko", 2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "me_misc_souMGol", 4, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_sedlak", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSedlak, "Sedlakuv udel (tezky cep)", "kh_sedlak002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "ry_ad1_tezcep002", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_magohnisko", 2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "me_misc_souMGol", 4, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_sedlak", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSedlak, "Sedlakuv udel (remdih)", "kh_sedlak003", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "ry_ad1_remd002", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_magohnisko", 2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "me_misc_souMGol", 4, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_sedlak", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

//  Gladiatorska sekera

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuGlad, "Gladiatorska sekera (bitevni sekera)", "kh_gladsekera001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "ry_ad1_bitsek", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_kysohnisko", 2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_srdcenackyk", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "me_misc_souMGol", 2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_gladsek", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuGlad, "Gladiatorska sekera (trpaslici sekera)", "kh_gladsekera002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "ry_ad1_trpsek", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_kysohnisko", 2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_srdcenackyk", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "me_misc_souMGol", 2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_gladsek", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuGlad, "Gladiatorska sekera (velka sekera)", "kh_gladsekera003", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "adm. vel. sekera", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_kysohnisko", 2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_srdcenackyk", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "me_misc_souMGol", 2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_gladsek", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

//Drtic lebek

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuDrtic, "Drtic lebek (palcat)", "kh_drtlebek", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "ry_ad1_palc002", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_lepdemilicha", 2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_srdcepravlk", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_drtleb", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

// Zpivajici cepel

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuZpivajici, "Zpivajici cepel (dlhy mec)", "kh_spevcepel001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "ry_ad1_dlmec", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_okovsevid", 2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_hlassireny", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_magohnisko", 2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_spevcep", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuZpivajici, "Zpivajici cepel (mec bastard)", "kh_spevcepel002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "ry_ad1_mecba", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_okovsevid", 2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_hlassireny", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_magohnisko", 2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_spevcep", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuZpivajici, "Zpivajici cepel (velky mec)", "kh_spevcepel003", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "ry_ad1_velmec", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_okovsevid", 2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_hlassireny", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_magohnisko", 2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_spevcep", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

// Posel smrti

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuPosel, "Posel smrti (kosa)", "kh_possmrt001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "ry_ad1_kosa", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_gemzla", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_srdcedemona", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_lepdemilicha", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_possmrt", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuPosel, "Posel smrti (srp)", "kh_possmrt002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "ry_ad1_srp", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_gemzla", 1, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_srdcedemona", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_lepdemilicha", 10, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "kh_rcp_possmrt", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 20);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 250, 250);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

}
