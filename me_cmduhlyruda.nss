/////////////////////////////////////////////////////////
//
//  Craftable Merchant Dialogs (CMD) by Festyx
//
//  Name:  me_cmduhlyruda
//
//  Generated by 'MerchantMaker'. A utility by Festyx.
//
/////////////////////////////////////////////////////////
#include "cnr_merch_utils"

void ProcessMenu_me_cmduhlyruda_0(string sMenu_me_cmduhlyruda_0);
void ProcessMenu_me_cmduhlyruda_1(string sMenu_me_cmduhlyruda_1);
void ProcessMenu_me_cmduhlyruda_2(string sMenu_me_cmduhlyruda_2);
void ProcessMenu_me_cmduhlyruda_3(string sMenu_me_cmduhlyruda_3);

void main()
{
  CnrMerchantSetMerchantGreetingText("me_cmduhlyruda", "No rad bych nakoupil suroviny co k vyrobe potrebuji.");
  CnrMerchantSetMerchantBuyText("me_cmduhlyruda", "Mate neco z techto veci?");
  CnrMerchantSetMerchantSellText("me_cmduhlyruda", "..");

  string sMenu_me_cmduhlyruda_0 = CnrMerchantAddSubMenu("me_cmduhlyruda", "Uhl�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmduhlyruda_0(sMenu_me_cmduhlyruda_0));

  string sMenu_me_cmduhlyruda_1 = CnrMerchantAddSubMenu("me_cmduhlyruda", "Ruda");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmduhlyruda_1(sMenu_me_cmduhlyruda_1));

  string sMenu_me_cmduhlyruda_2 = CnrMerchantAddSubMenu("me_cmduhlyruda", "Pruty kov�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmduhlyruda_2(sMenu_me_cmduhlyruda_2));

  string sMenu_me_cmduhlyruda_3 = CnrMerchantAddSubMenu("me_cmduhlyruda", "O�arovan� pruty kov�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmduhlyruda_3(sMenu_me_cmduhlyruda_3));
}

void ProcessMenu_me_cmduhlyruda_0(string sMenu_me_cmduhlyruda_0)
{
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_0, "Hrouda uhl�", "cnrLumpOfCoal", 5, 5, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmduhlyruda_1(string sMenu_me_cmduhlyruda_1)
{
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_1, "Nuget adamantinu", "cnrNuggetAdam", 6, 6, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_1, "Nuget c�nu", "cnrNuggetTin", 2, 0, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_1, "Nuget kobaltu", "cnrNuggetCoba", 5, 5, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_1, "Nuget m�di", "cnrNuggetCopp", 2, 2, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_1, "Nuget mitrilu", "cnrNuggetMith", 5, 5, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_1, "Nuget platiny", "cnrNuggetPlat", 4, 4, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_1, "Nuget st��bra", "cnrNuggetSilv", 4, 4, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_1, "Nuget titanu", "cnrNuggetTita", 4, 4, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_1, "Nuget zlata", "cnrNuggetGold", 4, 4, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_1, "Nuget �eleza", "cnrNuggetIron", 3, 3, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmduhlyruda_2(string sMenu_me_cmduhlyruda_2)
{
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_2, "Prut adamantinu", "cnrIngotAdam", 18, 18, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_2, "Prut bronzu", "cnrIngotBron", 11, 11, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_2, "Prut c�nu", "cnrIngotTin", 5, 5, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_2, "Prut kobaltu", "cnrIngotCoba", 16, 16, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_2, "Prut m�di", "cnrIngotCopp", 5, 5, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_2, "Prut mitrilu", "cnrIngotMith", 17, 17, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_2, "Prut platiny", "cnrIngotPlat", 15, 15, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_2, "Prut st��bra", "cnrIngotSilv", 13, 13, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_2, "Prut titanu", "cnrIngotTita", 15, 15, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_2, "Prut zlata", "cnrIngotGold", 13, 13, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_2, "Prut �eleza", "cnrIngotIron", 12, 12, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmduhlyruda_3(string sMenu_me_cmduhlyruda_3)
{
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_3, "Okouzlen� prut bronzu", "cnrEnchIngotBron", 30, 30, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_3, "Okouzlen� prut m�di", "cnrEnchIngotCopp", 20, 20, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_3, "Okouzlen� prut platiny", "cnrEnchIngotPlat", 40, 40, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_3, "Okouzlen� prut st��bra", "cnrEnchIngotSilv", 45, 45, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_3, "Okouzlen� prut titanu", "cnrEnchIngotTita", 47, 47, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmduhlyruda_3, "Okouzlen� prut zlata", "cnrEnchIngotGold", 47, 47, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}


