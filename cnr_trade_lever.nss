#include "cnr_recipe_utils"
void main()
{
  int nTrade = 0;
  string sTradeName = GetName(OBJECT_SELF);
  sTradeName = GetStringRight(sTradeName, GetStringLength(sTradeName)-7);
  if (sTradeName == "Taveni")  { nTrade = CNR_TRADESKILL_SMELTING; }
  else if (sTradeName == "Vyroba zbrani")  { nTrade = CNR_TRADESKILL_WEAPON_CRAFTING; }
  else if (sTradeName == "Vyroba zbroji")  { nTrade = CNR_TRADESKILL_ARMOR_CRAFTING; }
  else if (sTradeName == "Alchymie")  { nTrade = CNR_TRADESKILL_ALCHEMY; }
  else if (sTradeName == "Psani")  { nTrade = CNR_TRADESKILL_SCRIBING; }
  else if (sTradeName == "Dratenictvi")  { nTrade = CNR_TRADESKILL_TINKERING; }
  else if (sTradeName == "Truhlarstvi")  { nTrade = CNR_TRADESKILL_WOOD_CRAFTING; }
  else if (sTradeName == "Ocarovani")  { nTrade = CNR_TRADESKILL_ENCHANTING; }
  else if (sTradeName == "Zlatnictvi")  { nTrade = CNR_TRADESKILL_GEM_CRAFTING; }
  else if (sTradeName == "Krejcovstvi")  { nTrade = CNR_TRADESKILL_TAILORING; }
  else if (sTradeName == "Vareni")  { nTrade = CNR_TRADESKILL_FOOD_CRAFTING; }
  else if (sTradeName == "Louhovani")  { nTrade = CNR_TRADESKILL_INFUSING; }


  if (nTrade > 0)
  {
    object oUser = GetLastUsedBy();
    int nXP = CnrGetTradeskillXPByType(oUser, nTrade);
    int nLevel = CnrDetermineTradeskillLevel(nXP);
    int nNextLevelXP = 0;
    if (nLevel != 20)
    {
      nLevel = nLevel + 1;
      nNextLevelXP = GetLocalInt(GetModule(), "CnrTradeXPLevel" + IntToString(nLevel));
    }
    else
    {
      nLevel = 1;
    }
    CnrSetTradeskillXPByType(oUser, nTrade, nNextLevelXP);
    FloatingTextStringOnCreature("Your " + sTradeName + " skill is now level " + IntToString(nLevel), oUser, FALSE);
  }
}
