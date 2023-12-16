/* ku_items_inc
 * Knihovna pro vytvareni a cteni Itemu
 * ver. 1.1
 * 03. 03 2009 Kucik
 * 09. 06. 2009 Kucik Upraveno generovani pri resrefu v palete
 * 2010-05-15 Kucik Pridany charges predmetu.
 */

//#include "nwnx_structs"
#include "nwnx_object"
#include "ku_libtime"
#include "strings_inc"
const string PERSISTANCE_TEMP_CONTAINER = "ku_pers_temp_cont";

// Get Temporary container used for persistance
object Persist_GetTempContainer();

// Create Item desribed by sAttr attributes string
object Persist_CreateItemFromAttributesString(string sAttr, object oInv = OBJECT_INVALID);

itemproperty ku_ItemPropertyOnMonsterHitProperties(int a1, int a5);

string itoa(int i) {
  return IntToString(i);
}

object Persist_GetTempContainer() {
  object oMod = GetModule();
  if(GetLocalInt(oMod,"KU_PERSISTANCE_INIT"))
    return GetLocalObject(oMod,"KU_PERSISTANCE_TEMP_CONTAINER");
  else {
    object oPers = GetObjectByTag(PERSISTANCE_TEMP_CONTAINER);
    SetLocalObject(oMod,"KU_PERSISTANCE_TEMP_CONTAINER",oPers);
    return oPers;
  }
}

int GetIsValidItemResref(string sResRef) {
  object oPers = Persist_GetTempContainer();
  object oItem = CreateItemOnObject(sResRef,oPers);
  int bValid = GetIsObjectValid(oItem);
  DestroyObject(oItem);

  return bValid;
}



void RemoveAllProperties(object oItem) {

//  SpeakString(GetName(oItem));

 itemproperty ip = GetFirstItemProperty(oItem);
 while(GetIsItemPropertyValid(ip)) {
//   SpeakString("Removing "+IntToString(GetItemPropertyType(ip)));
   RemoveItemProperty(oItem,ip);
   ip = GetNextItemProperty(oItem);
 }

}



/* String To ItemProperties */




/*******************************************************
**   Item Description
***********************************************************/

// Get item identified description
// Reads primary description from local variable "DESCRIPTION" then from real description
string ku_GetItemDescription(object oItem);

// Set item identified description and set local variable "DESCRIPTION"
void ku_SetItemDescription(object oItem, string sDescription);

string ku_GetItemDescription(object oItem) {
  string sDesc;
  sDesc = GetLocalString(oItem,"DESCRIPTION");
  if(GetStringLength(sDesc) > 0) {
    return sDesc;
  }

  sDesc = GetDescription(oItem,FALSE,TRUE);
  if(sDesc == GetDescription(oItem,TRUE,TRUE))
    sDesc = GetDescription(oItem,TRUE,FALSE);

  return sDesc;
}

void ku_SetItemDescription(object oItem, string sDescription) {
  SetDescription(oItem,sDescription);
  SetLocalString(oItem,"DESCRIPTION",sDescription);
}

/*********************************************************
**  Item Description and Creation
******************************************************************/



object Persist_CreateItemFromAttributesString(string sAttr, object oInv = OBJECT_INVALID) {

    object oItem = NWNX_Object_Deserialize(sAttr);

    /* GetContainer */
    object oCont;
    if(oInv == OBJECT_INVALID)
      oCont = Persist_GetTempContainer();
    else
      oCont = oInv;

    NWNX_Object_AcquireItem(oCont,oItem);
    return oItem;
}

string Persist_GetResRefByBaseType(int iBase) {

  switch(iBase) {
    case 0: return "nw_wswss001";
    case 1: return "nw_wswls001";
    case 2: return "nw_waxbt001";
    case 3: return "nw_wswbs001";
    case 4: return "nw_wblfl001";
    case 5: return "nw_wblhw001";
    case 6: return "nw_wbwxh001";
    case 7: return "nw_wbwxl001";
    case 8: return "nw_wbwln001";
    case 9: return "nw_wblml001"; //?? mace or lightmace
    case 10: return "nw_wplhb001";
    case 11: return "nw_wbwsh001";
    case 12: return "nw_wdbsw001";
    case 13: return "nw_wswgs001";
    case 14: return "nw_ashsw001";
    case 15: return "ku_pers_torch";
    case 16: return "nw_aarcl001"; //?? armor
//    case 17: return "nw_arhe001";  //helmet
    case 17: return "ku_pers_helmet";  //helmet
    case 18: return "nw_waxgr001";
    case 19: return "nw_it_mneck020";
    case 20: return "nw_wamar001";
//    case 21: return "nw_it_mbelt001";
    case 21: return "ku_pers_mbelt";
    case 22: return "nw_wswdg001";
//    case 23: return "DELETED";
    case 24: return "nw_it_msmlmisc25";
    case 25: return "nw_wambo001";
//    case 26: return "nw_it_mboots001";
    case 26: return "ku_pers_boots";
    case 27: return "nw_wambu001";
    case 28: return "nw_wblcl001";
    case 29: return "nw_it_msmlmisc20";
//    case 30: return "DELETED";
    case 31: return "nw_wthdt001";
    case 32: return "nw_wdbma001";
    case 33: return "nw_wdbax001";
    case 34: return "ku_pers_miscl";
    case 35: return "nw_wblfh001";
//    case 36: return "nw_it_mglove001";
    case 36: return "ku_pers_gloves";
    case 37: return "nw_wblhl001";
    case 38: return "nw_waxhn001";
//    case 39: return "nw_it_medkit001";
    case 39: return "ku_pers_heal";
    case 40: return "nw_wspka001";
    case 41: return "nw_wswka001";
    case 42: return "nw_wspku001";
//    case 43: return "DELETED";
//    case 44: return "nw_wmgrd002";
    case 44: return "ku_pers_mgcrod";
//    case 45: return "nw_wmgst002";
    case 45: return "ku_pers_mgcstaff";
    case 46: return "nw_mwgwn003";
    case 47: return "nw_wblms001";
//    case 48: return "DELETED";
//    case 49: return "nw_it_mpotion001";
    case 49: return "ku_pers_potion";
    case 50: return "nw_wdbqs001";
    case 51: return "nw_wswrp001";
    case 52: return "nw_it_mring021";
    case 53: return "nw_wswsc001";
//    case 54: return "DELETED";
    case 55: return "nw_wplsc001";
    case 56: return "nw_ashlw001";
    case 57: return "nw_ashto001";
    case 58: return "nw_wplss001";
    case 59: return "nw_wthsh001";
    case 60: return "nw_wspsc001";
    case 61: return "nw_wbwsl001";
//    case 62: return "nw_it_picks001";
    case 62: return "ku_pers_picks";
    case 63: return "nw_wthax001";
//    case 64: return "nw_it_trap001";
    case 64: return "ku_pers_trapkit";
    case 65: return "ku_pers_key";
    case 66: return "nw_it_contain001";
//    case 67: return "DELETED";
//    case 68: return "DELETED";

//    case 69: return "nw_it_crewps001";
//    case 70: return "nw_it_crewpp001";
//    case 71: return "nw_it_crewpb001";
//    case 72: return "nw_it_crewpsp001";
//    case 73: return "nw_it_creitem057";
    case 69: return "ku_pers_crslash";
    case 70: return "ku_pers_crpierc";
    case 71: return "ku_pers_crbludg";
    case 72: return "ku_pers_crslashp";
    case 73: return "ku_pers_crskin";
    case 74: return "nw_it_book001";
//    case 75: return "nw_it_sparscr001";
    case 75: return "ku_pers_scroll";
    case 76: return "nw_it_gold001";
    case 77: return "nw_it_gem001";
//    case 78: return "nw_it_mbracer001";
    case 78: return "ku_pers_bracer";
    case 79: return "nw_it_thnmisc001";
//    case 80: return "nw_maarcl101";
    case 80: return "ku_pers_cloak";
    case 81: return "x1_wm_grenade001";
    case 82: return "ku_pers_encamp";
//    case ....
    case 92: return "ku_pers_lance";
    case 93: return "ku_pers_trumpet";
    case 94: return "ku_pers_monstck";
    case 95: return "nw_wpltr001";
//    case ...
    case 101: return "ku_pers_b_potion";
    case 102: return "x2_it_cfm_bscrl";
    case 103: return "x2_it_cfm_wand";
    case 104: return "ku_pers_crpotion";
    case 105: return "ku_pers_cr_scr";
    case 106: return "ku_pers_cr_mwnd";
//    case ...
    case 108: return "x2_wdwraxe001";
    case 109: return "x2_it_bmt_cloth";
//    case 110: return "x2_it_amt_spikes";
//    case 111: return "x2_it_wpwhip";
//    case 112: return "x2_it_cmat_iron";
    case 110: return "ku_pers_crcomps";
    case 111: return "ku_pers_whip";
    case 112: return "ku_pers_crbase";
//    case ...
    case 202: return "ku_pers_beermug";
    case 203: return "ku_pers_wplss";
//    case ...
    case 300: return "ku_pers_wpltr1h";
    case 301: return "ku_pers_hvpick";
    case 302: return "ku_pers_ltpick";
    case 303: return "ku_pers_sai";
    case 304: return "ku_pers_nunchaku";
    case 305: return "ku_pers_falch";
    case 306: return "ku_pers_smallbox";
    case 307: return "ku_pers_mmisc2";
    case 308: return "ku_pers_wspsp";
    case 309: return "ku_pers_wswda";
    case 310: return "ku_pers_wswdp";
    case 311: return "ku_pers_smisc2";
    case 312: return "ku_pers_wblmc2"; //?? mace = lightmace ??
    case 313: return "ku_pers_wspkk2";
    case 314: return "ku_pers_fashion";
//    case ...
    case 316: return "ku_pers_wxswfa2";
    case 317: return "ku_pers_wxblmh";
    case 318: return "ku_pers_wxblma";
    case 319: return "ku_pers_wswlsm";
    case 320: return "ku_pers_wswgsm";
    case 321: return "ku_pers_wxdbsc";
    case 322: return "ku_pers_wspgd";
    case 323: return "ku_pers_wspwf";
    case 324: return "ku_pers_wmads";
    case 325: return "ku_pers_flower";
//    case ...
    case 327: return "ku_pers_cflower";
//    case ...
    case 330: return "ku_pers_wswlz";
//    case ...
    case 349: return "ku_pers_cloak2";
    case 350: return "ku_pers_ring2";
  }

  return "";
}

/********************
 * Armor and Cloths *
 ********************/

string Persist_GetArmorACResref(int iAC) {
  switch(iAC) {
    case 0: return "nw_cloth001";
    case 1: return "nw_aarcl009";
    case 2: return "nw_aarcl001";
    case 3: return "nw_aarcl002";
    case 4: return "nw_aarcl003";
    case 5: return "nw_aarcl004";
    case 6: return "nw_aarcl005";
    case 7: return "nw_aarcl006";
    case 8: return "nw_aarcl007";
  }

  return "nw_cloth001";
}

int Persist_GetItemBaseACValue(object oItem) {

  int iModel = GetItemAppearance(oItem,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_TORSO);
  string sAC = Get2DAString("parts_chest","ACBONUS",iModel);

  return StringToInt(sAC);
}
