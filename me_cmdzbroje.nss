/////////////////////////////////////////////////////////
//
//  Craftable Merchant Dialogs (CMD) by Festyx
//
//  Name:  me_cmdzbroje
//
//  Generated by 'MerchantMaker'. A utility by Festyx.
//
/////////////////////////////////////////////////////////
#include "cnr_merch_utils"

void ProcessMenu_me_cmdzbroje_0(string sMenu_me_cmdzbroje_0);
void ProcessMenu_me_cmdzbroje_0_0(string sMenu_me_cmdzbroje_0_0);
void ProcessMenu_me_cmdzbroje_0_1(string sMenu_me_cmdzbroje_0_1);
void ProcessMenu_me_cmdzbroje_0_2(string sMenu_me_cmdzbroje_0_2);
void ProcessMenu_me_cmdzbroje_0_3(string sMenu_me_cmdzbroje_0_3);
void ProcessMenu_me_cmdzbroje_0_4(string sMenu_me_cmdzbroje_0_4);
void ProcessMenu_me_cmdzbroje_0_5(string sMenu_me_cmdzbroje_0_5);
void ProcessMenu_me_cmdzbroje_0_6(string sMenu_me_cmdzbroje_0_6);
void ProcessMenu_me_cmdzbroje_0_7(string sMenu_me_cmdzbroje_0_7);
void ProcessMenu_me_cmdzbroje_0_8(string sMenu_me_cmdzbroje_0_8);
void ProcessMenu_me_cmdzbroje_1(string sMenu_me_cmdzbroje_1);
void ProcessMenu_me_cmdzbroje_1_0(string sMenu_me_cmdzbroje_1_0);
void ProcessMenu_me_cmdzbroje_1_1(string sMenu_me_cmdzbroje_1_1);
void ProcessMenu_me_cmdzbroje_1_2(string sMenu_me_cmdzbroje_1_2);
void ProcessMenu_me_cmdzbroje_1_3(string sMenu_me_cmdzbroje_1_3);
void ProcessMenu_me_cmdzbroje_1_4(string sMenu_me_cmdzbroje_1_4);
void ProcessMenu_me_cmdzbroje_1_5(string sMenu_me_cmdzbroje_1_5);
void ProcessMenu_me_cmdzbroje_1_6(string sMenu_me_cmdzbroje_1_6);
void ProcessMenu_me_cmdzbroje_1_7(string sMenu_me_cmdzbroje_1_7);
void ProcessMenu_me_cmdzbroje_1_8(string sMenu_me_cmdzbroje_1_8);
void ProcessMenu_me_cmdzbroje_1_9(string sMenu_me_cmdzbroje_1_9);
void ProcessMenu_me_cmdzbroje_2(string sMenu_me_cmdzbroje_2);
void ProcessMenu_me_cmdzbroje_2_0(string sMenu_me_cmdzbroje_2_0);
void ProcessMenu_me_cmdzbroje_2_1(string sMenu_me_cmdzbroje_2_1);
void ProcessMenu_me_cmdzbroje_2_2(string sMenu_me_cmdzbroje_2_2);
void ProcessMenu_me_cmdzbroje_2_3(string sMenu_me_cmdzbroje_2_3);
void ProcessMenu_me_cmdzbroje_2_4(string sMenu_me_cmdzbroje_2_4);
void ProcessMenu_me_cmdzbroje_2_5(string sMenu_me_cmdzbroje_2_5);
void ProcessMenu_me_cmdzbroje_2_6(string sMenu_me_cmdzbroje_2_6);
void ProcessMenu_me_cmdzbroje_2_7(string sMenu_me_cmdzbroje_2_7);
void ProcessMenu_me_cmdzbroje_2_8(string sMenu_me_cmdzbroje_2_8);
void ProcessMenu_me_cmdzbroje_2_9(string sMenu_me_cmdzbroje_2_9);

void main()
{
  CnrMerchantSetMerchantGreetingText("me_cmdzbroje", "Koupim dobre udelane zbroje.");
  CnrMerchantSetMerchantBuyText("me_cmdzbroje", "Mas neco ?");
  CnrMerchantSetMerchantSellText("me_cmdzbroje", "..");

  string sMenu_me_cmdzbroje_0 = CnrMerchantAddSubMenu("me_cmdzbroje", "Helmy");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_0(sMenu_me_cmdzbroje_0));

  string sMenu_me_cmdzbroje_1 = CnrMerchantAddSubMenu("me_cmdzbroje", "Zbroje");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_1(sMenu_me_cmdzbroje_1));

  string sMenu_me_cmdzbroje_2 = CnrMerchantAddSubMenu("me_cmdzbroje", "�t�ty");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_2(sMenu_me_cmdzbroje_2));
}

void ProcessMenu_me_cmdzbroje_0(string sMenu_me_cmdzbroje_0)
{
  string sMenu_me_cmdzbroje_0_0 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_0, "Adamantiov�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_0_0(sMenu_me_cmdzbroje_0_0));

  string sMenu_me_cmdzbroje_0_1 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_0, "Bronzov�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_0_1(sMenu_me_cmdzbroje_0_1));

  string sMenu_me_cmdzbroje_0_2 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_0, "Kobaltov�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_0_2(sMenu_me_cmdzbroje_0_2));

  string sMenu_me_cmdzbroje_0_3 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_0, "M�d�n�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_0_3(sMenu_me_cmdzbroje_0_3));

  string sMenu_me_cmdzbroje_0_4 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_0, "Mitrilov�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_0_4(sMenu_me_cmdzbroje_0_4));

  string sMenu_me_cmdzbroje_0_5 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_0, "Platinov�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_0_5(sMenu_me_cmdzbroje_0_5));

  string sMenu_me_cmdzbroje_0_6 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_0, "St�ibrn�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_0_6(sMenu_me_cmdzbroje_0_6));

  string sMenu_me_cmdzbroje_0_7 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_0, "Zlat�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_0_7(sMenu_me_cmdzbroje_0_7));

  string sMenu_me_cmdzbroje_0_8 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_0, "�elezn�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_0_8(sMenu_me_cmdzbroje_0_8));

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_0_0(string sMenu_me_cmdzbroje_0_0)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_0, "Adamantinov� helma obrany", "cnrHelmExeAda", 146, 146, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_0, "Adamantinov� helma ochrany pred smrti", "cnrHelmSpikeAda", 101, 101, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_0, "Adamantinov� helma reflexu", "cnrHelmBasAda", 76, 76, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_0, "Adamantinov� helma stesti", "cnrHelmJutAda", 282, 282, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_0, "Adamantinov� helma vule", "cnrHelmPotAda", 76, 76, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_0, "Adamantinov� helma vydrze", "cnrHelmVisAda", 76, 76, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_0_1(string sMenu_me_cmdzbroje_0_1)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_1, "Bronzov� pav�za", "cnrShldTowrBron", 30, 30, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_1, "Bronzov� dra�� �t�t", "cnrShldKiteBron", 30, 30, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_1, "Bronzov� hv�zdicov� �t�t", "cnrShldStarBron", 28, 28, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_1, "Bronzov� mal� �t�t", "cnrShldSmalBron", 26, 26, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_1, "Bronzov� p�stn� �t�t", "cnrShldBuckBron", 26, 26, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_1, "Bronzov� v�t�� �t�t", "cnrShldLargBron", 28, 28, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_1, "Bronzov� vy��han� �t�t", "cnrShldHeatBron", 30, 30, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_0_2(string sMenu_me_cmdzbroje_0_2)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_2, "Kobaltov� helma blesku", "cnrHelmPotCob", 10, 10, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_2, "Kobaltov� helma chladu", "cnrHelmExeCob", 8, 8, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_2, "Kobaltov� helma kyseliny", "cnrHelmJutCob", 7, 7, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_2, "Kobaltov� helma ohn�", "cnrHelmBasCob", 12, 12, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_2, "Kobaltov� helma ochrany pred negativn� energi�", "cnrHelmVisCob", 12, 12, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_2, "Kobaltov� helma zvuku", "cnrHelmSpikeCob", 12, 12, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_0_3(string sMenu_me_cmdzbroje_0_3)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_3, "Medena helma carozpytu", "me_helm_medcar", 3, 3, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_3, "Medena helma hledani", "me_helm_medhle", 3, 3, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_3, "Medena helma krytu", "me_helm_medkry", 3, 3, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_3, "Medena helma leceni", "me_helm_medlec", 3, 3, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_3, "Medena helma soustredeni", "me_helm_medsou", 3, 3, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_3, "Medena helma vsimavosti", "me_helm_medvsi", 3, 3, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_0_4(string sMenu_me_cmdzbroje_0_4)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_4, "Mitrilov� helma charisma", "cnrHelmVisMit", 364, 364, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_4, "Mitrilov� helma inteligence", "cnrHelmJutMit", 364, 364, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_4, "Mitrilov� helma moudrosti", "cnrHelmSpikeMit", 364, 364, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_4, "Mitrilov� helma obratnosti", "cnrHelmPotMit", 364, 364, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_4, "Mitrilov� helma odolnosti", "cnrHelmExeMit", 364, 364, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_4, "Mitrilov� helma s�ly", "cnrHelmBasMit", 364, 364, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_0_5(string sMenu_me_cmdzbroje_0_5)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_5, "Platinov� helma charismy", "cnrHelmBasPla", 72, 72, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_5, "Platinov� helma intelektu", "cnrHelmExePla", 72, 72, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_5, "Platinov� helma moudrosti", "cnrHelmPotPla", 72, 72, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_5, "Platinov� helma obratnosti", "cnrHelmVisPla", 72, 72, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_5, "Platinov� helma odolnosti", "cnrHelmJutPla", 72, 72, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_5, "Platinov� helma sily", "cnrHelmSpikePla", 72, 72, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_0_6(string sMenu_me_cmdzbroje_0_6)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_6, "Stribrna helma ochrany mysli", "me_helm_strmys", 22, 22, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_6, "Stribrna helma ochrany pred smrt�", "me_helm_strsmr", 22, 22, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_6, "Stribrna helma reflexu", "me_helm_strref", 17, 17, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_6, "Stribrna helma stesti", "me_helm_strste", 17, 17, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_6, "Stribrna helma vule", "me_helm_strvul", 17, 17, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_6, "Stribrna helma vydrze", "me_helm_strvyd", 17, 17, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_0_7(string sMenu_me_cmdzbroje_0_7)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_7, "Zlata helma carozpytu", "me_helm_zlacar", 72, 72, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_7, "Zlata helma hledani", "me_helm_zlahle", 72, 72, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_7, "Zlata helma krytu", "me_helm_zlakry", 72, 72, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_7, "Zlata helma obrany", "me_helm_zladef", 72, 72, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_7, "Zlata helma soustreden�", "me_helm_zlasou", 72, 72, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_7, "Zlata helma vycviku", "me_helm_zlavyc", 72, 72, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_0_8(string sMenu_me_cmdzbroje_0_8)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_8, "�elezn� helma �arozpytu", "cnrHelmExeIro", 18, 18, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_8, "�elezn� helma hled�n�", "cnrHelmVisIro", 18, 18, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_8, "�elezn� helma l��en�", "cnrHelmSpikeIro", 18, 18, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_8, "�elezn� helma obrany", "cnrHelmBasIro", 18, 18, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_8, "�elezn� helma soust�ed�n�", "cnrHelmPotIro", 18, 18, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_0_8, "�elezn� helma v�cviku", "cnrHelmJutIro", 18, 18, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_1(string sMenu_me_cmdzbroje_1)
{
  string sMenu_me_cmdzbroje_1_0 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_1, "Bronzov�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_1_0(sMenu_me_cmdzbroje_1_0));

  string sMenu_me_cmdzbroje_1_1 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_1, "Adamantiove");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_1_1(sMenu_me_cmdzbroje_1_1));

  string sMenu_me_cmdzbroje_1_2 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_1, "Kobaltove");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_1_2(sMenu_me_cmdzbroje_1_2));

  string sMenu_me_cmdzbroje_1_3 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_1, "M�d�n�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_1_3(sMenu_me_cmdzbroje_1_3));

  string sMenu_me_cmdzbroje_1_4 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_1, "Mitrilov�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_1_4(sMenu_me_cmdzbroje_1_4));

  string sMenu_me_cmdzbroje_1_5 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_1, "Platinov�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_1_5(sMenu_me_cmdzbroje_1_5));

  string sMenu_me_cmdzbroje_1_6 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_1, "St��brn�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_1_6(sMenu_me_cmdzbroje_1_6));

  string sMenu_me_cmdzbroje_1_7 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_1, "Adamitove");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_1_7(sMenu_me_cmdzbroje_1_7));

  string sMenu_me_cmdzbroje_1_8 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_1, "�elezn�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_1_8(sMenu_me_cmdzbroje_1_8));

  string sMenu_me_cmdzbroje_1_9 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_1, "Zlat�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_1_9(sMenu_me_cmdzbroje_1_9));

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_1_0(string sMenu_me_cmdzbroje_1_0)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_0, "Bronzova krouzkova kosile", "cnrChainMailBro", 27, 27, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_0, "Bronzova lehka krouzkova kosile", "cnrChainShirtBro", 25, 25, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_0, "Bronzova plna platova", "cnrFullPlateBro", 95, 95, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_0, "Bronzova supinova zbroj", "cnrScaleMailBro", 25, 25, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_0, "Bronzove paskove brneni", "cnrBandedMailBro", 30, 30, TRUE, 0, 1);
  CnrMerchantAddItem2(sMenu_me_cmdzbroje_1_0, "Bronzovy pancir", "cnrSplitMailBro", "cnrsplintmailbro", 30, 30, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_0, "Bronzovy pulplat", "cnrHalfPlateBro", 50, 50, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_1_1(string sMenu_me_cmdzbroje_1_1)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_1, "Adamantinova krouzkova zbroj", "cnrChainMailAda", 658, 658, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_1, "Adamantinova lehka kosile", "cnrChainShirtAda", 655, 655, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_1, "Adamantinova paskova zbroj", "cnrBandedMailAda", 660, 660, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_1, "Adamantinova plna platova zbroj", "cnrFullPlateAda", 725, 725, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_1, "Adamantinova supinova zbroj", "cnrScaleMailAda", 655, 655, TRUE, 0, 1);
  CnrMerchantAddItem2(sMenu_me_cmdzbroje_1_1, "Adamantinovy pancir", "cnrSplitMailAda", "cnrsplintmailada", 376, 376, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_1, "Adamantiovy pulplat", "cnrHalfPlateAda", 680, 680, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_1_2(string sMenu_me_cmdzbroje_1_2)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_2, "Kobaltova kosile", "cnrChainMailCob", 550, 550, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_2, "Kobaltova lehka krouzkova zbroj", "cnrChainShirtCob", 550, 550, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_2, "Kobaltova paskova zbroj", "cnrBandedMailCob", 550, 550, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_2, "Kobaltova plna zbroj", "cnrFullPlateCob", 550, 550, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_2, "Kobaltova supinova zbroj", "cnrScaleMailCob", 550, 550, TRUE, 0, 1);
  CnrMerchantAddItem2(sMenu_me_cmdzbroje_1_2, "Kobaltovy pancir", "cnrSplitMailCob", "cnrsplintmailcob", 550, 550, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_2, "Kobaltovy pulplat", "cnrHalfPlateCob", 550, 550, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_1_3(string sMenu_me_cmdzbroje_1_3)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_3, "Medena krouzkova kosile", "me_zbroj_medkrou", 14, 14, TRUE, 0, 1);
  CnrMerchantAddItem2(sMenu_me_cmdzbroje_1_3, "Medena lehka krouzkova kosile", "me_zbroj_medlkrou", "me_zbroj_medlkro", 12, 12, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_3, "Medena paskove brneni", "me_zbroj_medpask", 17, 17, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_3, "Medena plna platova", "me_zbroj_medpln", 82, 82, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_3, "Medena supinova zbroj", "me_zbroj_medsup", 12, 12, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_3, "Medeny pancir", "me_zbroj_medpanc", 17, 17, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_3, "Medeny pulplat", "me_zbroj_medpul", 37, 37, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_1_4(string sMenu_me_cmdzbroje_1_4)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_4, "Mitrilova krouzkova zbroj", "cnrChainMailMit", 1537, 1537, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_4, "Mitrilova lehka kosile", "cnrChainShirtMit", 1535, 1535, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_4, "Mitrilova paskova zbroj", "cnrBandedMailMit", 1540, 1540, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_4, "Mitrilova plna platova zbroj", "cnrFullPlateMit", 1605, 1605, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_4, "Mitrilova supinova zbroj", "cnrScaleMailMit", 1535, 1535, TRUE, 0, 1);
  CnrMerchantAddItem2(sMenu_me_cmdzbroje_1_4, "Mitrilovy pancir", "cnrSplitMailMit", "cnrsplintmailmit", 1540, 1540, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_4, "Mitrilovy pulplat", "cnrHalfPlateMit", 1560, 1560, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_1_5(string sMenu_me_cmdzbroje_1_5)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_5, "Platinova krouzkova kosile", "cnrChainMailPla", 280, 280, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_5, "Platinova lehka krouzkova kosile", "cnrChainShirtPla", 280, 280, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_5, "Platinova paskova zbroj", "cnrBandedMailPla", 285, 285, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_5, "Platinova plna zbroj", "cnrFullPlatePla", 350, 350, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_5, "Platinova supinova zbroj", "cnrScaleMailPla", 280, 280, TRUE, 0, 1);
  CnrMerchantAddItem2(sMenu_me_cmdzbroje_1_5, "Platinovy pancir", "cnrSplitMailPla", "cnrsplintmailpla", 285, 285, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_5, "Platinovy pulplat", "cnrHalfPlatePla", 305, 305, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_1_6(string sMenu_me_cmdzbroje_1_6)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_6, "Stribrna krouzkova kosile", "me_zbroj_strkro", 274, 274, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_6, "Stribrna lehka krouzkova kosile", "me_zbroj_strlkro", 271, 271, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_6, "Stribrna paskova zbroj", "me_zbroj_strpas", 276, 276, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_6, "Stribrna plna platova zbroj", "me_zbroj_strpln", 341, 341, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_6, "Stribrna supinova zbroj", "me_zbroj_strsup", 271, 271, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_6, "Stribrny pancir", "me_zbroj_strpan", 276, 276, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_6, "Stribrny pulplat", "me_zbroj_strpul", 296, 296, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_1_7(string sMenu_me_cmdzbroje_1_7)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_7, "Zdobena krouzkova kosile", "cnrChainMailAdo", 1588, 1588, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_7, "Zdobena lehka kosile", "cnrChainShirtAdo", 1585, 1585, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_7, "Zdobena paskova zbroj", "cnrBandedMailAdo", 1590, 1590, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_7, "Zdobena plna platova zbroj", "cnrFullPlateAdo", 1655, 1655, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_7, "Zdobena supinova zbroj", "cnrScaleMailAdo", 1585, 1585, TRUE, 0, 1);
  CnrMerchantAddItem2(sMenu_me_cmdzbroje_1_7, "Zdobeny pancir", "cnrSplitMailAdo", "cnrsplintmailado", 1590, 1590, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_7, "Zdobeny pulplat", "cnrHalfPlateAdo", 1610, 1610, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_1_8(string sMenu_me_cmdzbroje_1_8)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_8, "Zelezna krouzkova kosile", "cnrChainMailIro", 262, 262, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_8, "Zelezna lehka krouzkova kosile", "cnrChainShirtIro", 260, 260, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_8, "Zelezna paskova zbroj", "cnrBandedMailIro", 265, 265, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_8, "Zelezna plna platova", "cnrFullPlateIro", 330, 330, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_8, "Zelezna supinova kosile", "cnrScaleMailIro", 260, 260, TRUE, 0, 1);
  CnrMerchantAddItem2(sMenu_me_cmdzbroje_1_8, "Zelezny pancir", "cnrSplitMailIro", "cnrsplintmailiro", 265, 265, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_8, "Zelezny pulplat", "cnrHalfPlateIro", 285, 285, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_1_9(string sMenu_me_cmdzbroje_1_9)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_9, "Zlata Krouzkova kosile", "me_zbroj_zlakro", 395, 395, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_9, "Zlata lehka krouzkova kosile", "me_zbroj_zlalkro", 392, 392, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_9, "Zlata paskova zbroj", "me_zbroj_zlapas", 397, 397, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_9, "Zlata plna zbroj", "me_zbroj_zlapln", 462, 462, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_9, "Zlata supinova zbroj", "me_zbroj_zlasup", 392, 392, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_9, "Zlaty pancir", "me_zbroj_zlapan", 397, 397, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_1_9, "Zlaty pulplat", "me_zbroj_zlapul", 417, 417, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_2(string sMenu_me_cmdzbroje_2)
{
  string sMenu_me_cmdzbroje_2_0 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_2, "Adamantiov�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_2_0(sMenu_me_cmdzbroje_2_0));

  string sMenu_me_cmdzbroje_2_1 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_2, "Bronzov�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_2_1(sMenu_me_cmdzbroje_2_1));

  string sMenu_me_cmdzbroje_2_2 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_2, "Kobaltov�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_2_2(sMenu_me_cmdzbroje_2_2));

  string sMenu_me_cmdzbroje_2_3 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_2, "O�arovan�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_2_3(sMenu_me_cmdzbroje_2_3));

  string sMenu_me_cmdzbroje_2_4 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_2, "M�d�n�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_2_4(sMenu_me_cmdzbroje_2_4));

  string sMenu_me_cmdzbroje_2_5 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_2, "Mitrilov�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_2_5(sMenu_me_cmdzbroje_2_5));

  string sMenu_me_cmdzbroje_2_6 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_2, "Platinov�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_2_6(sMenu_me_cmdzbroje_2_6));

  string sMenu_me_cmdzbroje_2_7 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_2, "St��brn�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_2_7(sMenu_me_cmdzbroje_2_7));

  string sMenu_me_cmdzbroje_2_8 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_2, "Zlat�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_2_8(sMenu_me_cmdzbroje_2_8));

  string sMenu_me_cmdzbroje_2_9 = CnrMerchantAddSubMenu(sMenu_me_cmdzbroje_2, "�elezn�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzbroje_2_9(sMenu_me_cmdzbroje_2_9));

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_2_0(string sMenu_me_cmdzbroje_2_0)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_0, "Adamantiovy maly stit", "me_stit_malada", 592, 592, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_0, "Adamantiovy stredni stit", "me_stit_strada", 595, 595, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_0, "Adamantiovy velky stit", "me_stit_velada", 597, 597, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_2_1(string sMenu_me_cmdzbroje_2_1)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_1, "Bronzov� pav�za", "cnrShldTowrBron", 30, 30, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_1, "Bronzov� dra�� �t�t", "cnrShldKiteBron", 30, 30, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_1, "Bronzov� hv�zdicov� �t�t", "cnrShldStarBron", 28, 28, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_1, "Bronzov� mal� �t�t", "cnrShldSmalBron", 26, 26, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_1, "Bronzov� p�stn� �t�t", "cnrShldBuckBron", 26, 26, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_1, "Bronzov� v�t�� �t�t", "cnrShldLargBron", 28, 28, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_1, "Bronzov� vy��han� �t�t", "cnrShldHeatBron", 30, 30, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_2_2(string sMenu_me_cmdzbroje_2_2)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_2, "Kobaltovy maly stit", "me_stit_malkob", 381, 381, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_2, "Kobaltovy stredni stit", "me_stit_strkob", 383, 383, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_2, "Kobaltovy velky stit", "me_stit_velkob", 385, 385, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_2_3(string sMenu_me_cmdzbroje_2_3)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_3, "Mal� �t�tek blesku", "cnrShldSmalLtng", 23, 23, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_3, "Mal� �t�tek kyseliny", "cnrShldSmalAcid", 89, 89, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_3, "Mal� �t�tek ohn�", "cnrShldSmalFire", 303, 303, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_3, "Pav�za blesku", "cnrShldTowrLtng", 27, 27, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_3, "Pav�za blesku", "cnrShldKiteLtng", 27, 27, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_3, "Pav�za blesku", "cnrShldHeatLtng", 27, 27, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_3, "Pav�za kyseliny", "cnrShldKiteAcid", 94, 94, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_3, "Pav�za kyseliny", "cnrShldTowrAcid", 94, 94, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_3, "Pav�za kyseliny", "cnrShldHeatAcid", 94, 94, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_3, "Pav�za ohn�", "cnrShldTowrFire", 307, 307, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_3, "Pav�za ohn�", "cnrShldKiteFire", 307, 307, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_3, "Pav�za ohn�", "cnrShldHeatFire", 307, 307, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_3, "P�stn� �t�t blesku", "cnrShldBuckLtng", 23, 23, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_3, "P�stn� �t�t kyseliny", "cnrShldBuckAcid", 89, 89, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_3, "P�stn� �t�t ohn�", "cnrShldBuckFire", 303, 303, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_3, "Velk� �t�t blesku", "cnrShldStarLtng", 25, 25, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_3, "Velk� �t�t blesku", "cnrShldLargLtng", 25, 25, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_3, "Velk� �t�t kyseliny", "cnrShldStarAcid", 91, 91, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_3, "Velk� �t�t kyseliny", "cnrShldLargAcid", 91, 91, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_3, "Velk� �t�t ohn�", "cnrShldStarFire", 305, 305, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_3, "Velk� �t�t ohn�", "cnrShldLargFire", 305, 305, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_2_4(string sMenu_me_cmdzbroje_2_4)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_4, "M�d�n� pav�za", "cnrShldTowrCopp", 11, 11, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_4, "M�d�n� dra�� �t�t", "cnrShldKiteCopp", 11, 11, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_4, "M�d�n� hv�zdicov� �t�t", "cnrShldStarCopp", 8, 8, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_4, "M�d�n� mal� �t�t", "cnrShldSmalCopp", 6, 6, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_4, "M�d�n� p�stn� �t�t", "cnrShldBuckCopp", 6, 6, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_4, "M�d�n� v�t�� �t�t", "cnrShldLargCopp", 8, 8, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_4, "M�d�n� vy��han� �t�t", "cnrShldHeatCopp", 11, 11, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_2_5(string sMenu_me_cmdzbroje_2_5)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_5, "Mithrilovy maly stit", "me_stit_malmit", 459, 459, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_5, "Mithrilovy stredni stit", "me_stit_strmit", 461, 461, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_5, "Mithrilovy velky stit", "me_stit_velmit", 464, 464, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_2_6(string sMenu_me_cmdzbroje_2_6)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_6, "Platinovy maly stit", "me_stit_malpla", 317, 317, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_6, "Platinovy stredni stit", "me_stit_strpla", 320, 320, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_6, "Platinovy velky stit", "me_stit_velpla", 322, 322, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_2_7(string sMenu_me_cmdzbroje_2_7)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_7, "Stribrny velky stit", "me_stit_velstr", 245, 245, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_7, "St��brn� mal� �t�t", "me_stit_malstr", 241, 241, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_7, "St��brn� st�edn� �t�t", "me_stit_strstr", 243, 243, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_2_8(string sMenu_me_cmdzbroje_2_8)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_8, "Zlaty maly stit", "me_stit_malzla", 57, 57, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_8, "Zlaty stredni stit", "me_stit_strzla", 60, 60, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_8, "Zlaty velky stit", "me_stit_velzla", 62, 62, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzbroje_2_9(string sMenu_me_cmdzbroje_2_9)
{
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_9, "�elezn� pav�za", "cnrShldTowrIron", 84, 84, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_9, "�elezn� dra�� �t�t", "cnrShldKiteIron", 84, 84, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_9, "�elezn� hv�zdicov� �t�t", "cnrShldStarIron", 81, 81, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_9, "�elezn� mal� �t�t", "cnrShldSmalIron", 79, 79, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_9, "�elezn� p�stn� �t�t", "cnrShldBuckIron", 79, 79, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_9, "�elezn� v�t�� �t�t", "cnrShldLargIron", 81, 81, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzbroje_2_9, "�elezn� vy��han� �t�t", "cnrShldHeatIron", 84, 84, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}


