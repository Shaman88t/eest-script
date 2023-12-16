/////////////////////////////////////////////////////////
//
//  Craftable Merchant Dialogs (CMD) by Festyx
//
//  Name:  me_cmdzlatnik
//
//  Generated by 'MerchantMaker'. A utility by Festyx.
//
/////////////////////////////////////////////////////////
#include "cnr_merch_utils"

void ProcessMenu_me_cmdzlatnik_1(string sMenu_me_cmdzlatnik_1);
void ProcessMenu_me_cmdzlatnik_2(string sMenu_me_cmdzlatnik_2);
void ProcessMenu_me_cmdzlatnik_3(string sMenu_me_cmdzlatnik_3);
void ProcessMenu_me_cmdzlatnik_4(string sMenu_me_cmdzlatnik_4);
void ProcessMenu_me_cmdzlatnik_5(string sMenu_me_cmdzlatnik_5);
void ProcessMenu_me_cmdzlatnik_5_0(string sMenu_me_cmdzlatnik_5_0);
void ProcessMenu_me_cmdzlatnik_5_1(string sMenu_me_cmdzlatnik_5_1);
void ProcessMenu_me_cmdzlatnik_5_2(string sMenu_me_cmdzlatnik_5_2);

void main()
{
  CnrMerchantSetMerchantGreetingText("me_cmdzlatnik", "Mate nejake kaminky ci sperky?");
  CnrMerchantSetMerchantBuyText("me_cmdzlatnik", "Jestli mate neco z tohoto rad to koupim.");
  CnrMerchantSetMerchantSellText("me_cmdzlatnik", "..");

  string sMenu_me_cmdzlatnik_0 = CnrMerchantAddSubMenu("me_cmdzlatnik", "Ostatni");

  string sMenu_me_cmdzlatnik_1 = CnrMerchantAddSubMenu("me_cmdzlatnik", "Skaraby");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzlatnik_1(sMenu_me_cmdzlatnik_1));

  string sMenu_me_cmdzlatnik_2 = CnrMerchantAddSubMenu("me_cmdzlatnik", "Nahrdelniky");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzlatnik_2(sMenu_me_cmdzlatnik_2));

  string sMenu_me_cmdzlatnik_3 = CnrMerchantAddSubMenu("me_cmdzlatnik", "Prsteny");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzlatnik_3(sMenu_me_cmdzlatnik_3));

  string sMenu_me_cmdzlatnik_4 = CnrMerchantAddSubMenu("me_cmdzlatnik", "Amulety");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzlatnik_4(sMenu_me_cmdzlatnik_4));

  string sMenu_me_cmdzlatnik_5 = CnrMerchantAddSubMenu("me_cmdzlatnik", "Kameny");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzlatnik_5(sMenu_me_cmdzlatnik_5));
}

void ProcessMenu_me_cmdzlatnik_1(string sMenu_me_cmdzlatnik_1)
{
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_1, "Bronzov� skarab s aventurinem", "cnrBroAdvScarab", 288, 288, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_1, "Bronzov� skarab s malachytem", "cnrBroMalScarab", 288, 288, TRUE, 0, 1);
  CnrMerchantAddItem2(sMenu_me_cmdzlatnik_1, "Bronzov� skarab s nefritem", "cnrBroGreenScarab", "cnrbrogreenscara", 288, 288, TRUE, 0, 1);
  CnrMerchantAddItem2(sMenu_me_cmdzlatnik_1, "Bronzov� skarab s ohniv�m ach�tem", "cnrBroFireAgScarab", "cnrbrofireagscar", 288, 288, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_1, "Zlat� skarab s ametystem", "cnrGoldAmScarab", 288, 288, TRUE, 0, 1);
  CnrMerchantAddItem2(sMenu_me_cmdzlatnik_1, "Zlat� skarab s fenelopem", "cnrGoldPhenScarab", "cnrgoldphenscara", 288, 288, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzlatnik_2(string sMenu_me_cmdzlatnik_2)
{
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_2, "Bronzov� n�hrdeln�k s gran�tem", "cnrBroGarNeck", 22, 22, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_2, "Bronzov� n�hrdeln�k s �ivcem", "cnrBroFeldNeck", 10, 10, TRUE, 0, 1);
  CnrMerchantAddItem2(sMenu_me_cmdzlatnik_2, "Zlat� n�hrdeln�k s ohniv�m op�lem", "cnrGoldFireOpNeck", "cnrgoldfireopnec", 7, 7, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_2, "Zlat� n�hrdeln�k s topazem", "cnrGoldTopNeck", 5, 5, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_2, "Zlat� n�hrdeln�k se saf�rem", "cnrGoldSapNeck", 3, 3, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_2, "Zlat� n�hrdlen�k s alexandritem", "cnrGoldAlexNeck", 10, 10, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzlatnik_3(string sMenu_me_cmdzlatnik_3)
{
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_3, "Bronzov� prsten s ametystem", "cnrBroAmRing", 90, 90, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_3, "Bronzov� prsten s fenelopem", "cnrBroPhenRing", 90, 90, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_3, "Med�n� prsten s aventurinem", "cnrCopAdvRing", 90, 90, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_3, "Med�n� prsten s malachitem", "cnrCopMalRing", 90, 90, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_3, "Med�n� prsten s nefritem", "cnrCopGreenRing", 90, 90, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_3, "Med�n� prsten s ohniv�m ach�tem", "cnrCopFireAgRing", 90, 90, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzlatnik_4(string sMenu_me_cmdzlatnik_4)
{
  CnrMerchantAddItem2(sMenu_me_cmdzlatnik_4, "Platinov� amulet s alexandritem", "cnrPlatAlexAmulet", "cnrplatalexamule", 45, 45, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_4, "Platinov� amulet s diamantem", "cnrPlatDiaNeck", 4, 4, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_4, "Platinov� amulet s emeraldem", "cnrPlatEmNeck", 22, 22, TRUE, 0, 1);
  CnrMerchantAddItem2(sMenu_me_cmdzlatnik_4, "Platinov� amulet s ohniv�m op�lem", "cnrPlatFireOpAmulet", "cnrplatfireopamu", 28, 28, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_4, "Platinov� amulet s rub�nem", "cnrPlatRubyNeck", 7, 7, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_4, "Platinov� amulet s topazem", "cnrPlatTopAmulet", 22, 22, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_4, "Platinov� amulet se saf�rem", "cnrPlatSapAmulet", 13, 13, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_4, "St��brn� amulet s diamantem", "cnrSilvDiaAmulet", 18, 18, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_4, "St��brn� amulet s emeraldem", "cnrSilvEmAmulet", 101, 101, TRUE, 0, 1);
  CnrMerchantAddItem2(sMenu_me_cmdzlatnik_4, "St��brn� amulet s rub�nem", "cnrSilvRubyAmulet", "cnrsilvrubyamule", 28, 28, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_4, "Zlat� amulet s gran�tem", "cnrGoldGarAmulet", 101, 101, TRUE, 0, 1);
  CnrMerchantAddItem2(sMenu_me_cmdzlatnik_4, "Zlat� amulet s �ivcem", "cnrGoldFeldAmulet", "cnrgoldfeldamule", 45, 45, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_4, "Amulet vetsi regenerace", "me_amu_GrRegen", 722, 722, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzlatnik_5(string sMenu_me_cmdzlatnik_5)
{
  string sMenu_me_cmdzlatnik_5_0 = CnrMerchantAddSubMenu(sMenu_me_cmdzlatnik_5, "Vynikajici");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzlatnik_5_0(sMenu_me_cmdzlatnik_5_0));

  string sMenu_me_cmdzlatnik_5_1 = CnrMerchantAddSubMenu(sMenu_me_cmdzlatnik_5, "Brou�en�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzlatnik_5_1(sMenu_me_cmdzlatnik_5_1));

  string sMenu_me_cmdzlatnik_5_2 = CnrMerchantAddSubMenu(sMenu_me_cmdzlatnik_5, "Kazov�");
  CmdIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenu_me_cmdzlatnik_5_2(sMenu_me_cmdzlatnik_5_2));

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzlatnik_5_0(string sMenu_me_cmdzlatnik_5_0)
{
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_0, "Vynikaj�c� alexandrit", "cnrGemFine013", 14, 14, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_0, "Vynikaj�c� ametyst", "cnrGemFine003", 4, 4, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_0, "Vynikaj�c� aventurin", "cnrGemFine014", 2, 2, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_0, "Vynikaj�c� diamant", "cnrGemFine005", 200, 200, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_0, "Vynikaj�c� fenelop", "cnrGemFine004", 2, 2, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_0, "Vynikaj�c� gran�t", "cnrGemFine011", 12, 12, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_0, "Vynikaj�c� malachit", "cnrGemFine007", 1, 1, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_0, "Vynikaj�c� nefrit", "cnrGemFine001", 1, 1, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_0, "Vynikaj�c� ohniv� ach�t", "cnrGemFine002", 1, 1, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_0, "Vynikaj�c� ohniv� op�l", "cnrGemFine009", 150, 150, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_0, "Vynikaj�c� rub�n", "cnrGemFine006", 300, 300, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_0, "Vynikaj�c� saf�r", "cnrGemFine008", 100, 100, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_0, "Vynikaj�c� smaragd", "cnrGemFine012", 400, 400, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_0, "Vynikaj�c� topaz", "cnrGemFine010", 25, 25, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_0, "Vynikaj�c� �ivec", "cnrGemFine015", 5, 5, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzlatnik_5_1(string sMenu_me_cmdzlatnik_5_1)
{
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_1, "Brou�en�  rub�n", "cnrGemCut006", 60, 60, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_1, "Brou�en�  saf�r", "cnrGemCut008", 20, 20, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_1, "Brou�en� alexandrit", "cnrGemCut013", 2, 2, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_1, "Brou�en� ametyst", "cnrGemCut003", 1, 1, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_1, "Brou�en� aventurin", "cnrGemCut014", 1, 1, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_1, "Brou�en� diamant", "cnrGemCut005", 40, 40, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_1, "Brou�en� fenelop", "cnrGemCut004", 1, 1, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_1, "Brou�en� gran�t", "cnrGemCut011", 2, 2, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_1, "Brou�en� malachit", "cnrGemCut007", 1, 1, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_1, "Brou�en� nefrit", "cnrGemCut001", 1, 1, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_1, "Brou�en� ohniv� ach�t", "cnrGemCut002", 1, 1, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_1, "Brou�en� ohniv� op�l", "cnrGemCut009", 30, 30, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_1, "Brou�en� smaragd", "cnrGemCut012", 80, 80, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_1, "Brou�en� topaz", "cnrGemCut010", 5, 5, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_1, "Brou�en� �ivec", "cnrGemCut015", 1, 1, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}

void ProcessMenu_me_cmdzlatnik_5_2(string sMenu_me_cmdzlatnik_5_2)
{
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_2, "Kazov�  diamant", "cnrGemFlawed005", 20, 20, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_2, "Kazov�  fenelop", "cnrGemFlawed004", 1, 1, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_2, "Kazov� alexandrit", "cnrGemFlawed013", 1, 1, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_2, "Kazov� ametyst", "cnrGemFlawed003", 1, 1, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_2, "Kazov� aventurin", "cnrGemFlawed014", 1, 1, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_2, "Kazov� gran�t", "cnrGemFlawed011", 1, 1, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_2, "Kazov� malachit", "cnrGemFlawed007", 1, 1, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_2, "Kazov� nefrit", "cnrGemFlawed001", 1, 1, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_2, "Kazov� ohniv� ach�t", "cnrGemFlawed002", 1, 1, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_2, "Kazov� ohniv� op�l", "cnrGemFlawed009", 15, 15, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_2, "Kazov� rub�n", "cnrGemFlawed006", 30, 30, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_2, "Kazov� saf�r", "cnrGemFlawed008", 10, 10, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_2, "Kazov� smaragd", "cnrGemFlawed012", 40, 40, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_2, "Kazov� topaz", "cnrGemFlawed010", 2, 2, TRUE, 0, 1);
  CnrMerchantAddItem(sMenu_me_cmdzlatnik_5_2, "Kazov� �ivec", "cnrGemFlawed015", 1, 1, TRUE, 0, 1);

  CmdDecrementStackCount(OBJECT_SELF);
}


