/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_trade_init
//
//  Desc:  Tradeskill recipe initialization. This script
//         is executed from "cnr_recipe_init".
//
//  Author: David Bobeck 25Jan03
//
/////////////////////////////////////////////////////////
#include "cnr_recipe_utils"

void main()
{
  PrintString("cnr_trade_init");

  // Configure the XP required to achieve each tradeskill level
  object oModule = GetModule();
  SetLocalInt(oModule, "CnrTradeXPLevel1", 0);
  SetLocalInt(oModule, "CnrTradeXPLevel2", 250);
  SetLocalInt(oModule, "CnrTradeXPLevel3", 500);
  SetLocalInt(oModule, "CnrTradeXPLevel4", 1000);
  SetLocalInt(oModule, "CnrTradeXPLevel5", 1750);
  SetLocalInt(oModule, "CnrTradeXPLevel6", 2750);
  SetLocalInt(oModule, "CnrTradeXPLevel7", 4000);
  SetLocalInt(oModule, "CnrTradeXPLevel8", 5500);
  SetLocalInt(oModule, "CnrTradeXPLevel9", 7250);
  SetLocalInt(oModule, "CnrTradeXPLevel10", 9250);
  SetLocalInt(oModule, "CnrTradeXPLevel11", 11500);
  SetLocalInt(oModule, "CnrTradeXPLevel12", 14000);
  SetLocalInt(oModule, "CnrTradeXPLevel13", 16750);
  SetLocalInt(oModule, "CnrTradeXPLevel14", 19750);
  SetLocalInt(oModule, "CnrTradeXPLevel15", 23000);
  SetLocalInt(oModule, "CnrTradeXPLevel16", 26500);
  SetLocalInt(oModule, "CnrTradeXPLevel17", 30250);
  SetLocalInt(oModule, "CnrTradeXPLevel18", 34250);
  SetLocalInt(oModule, "CnrTradeXPLevel19", 38400);
  SetLocalInt(oModule, "CnrTradeXPLevel20", 43000);

  CnrAddTradeskill(CNR_TRADESKILL_SMELTING, "Taveni");
  CnrAddTradeskill(CNR_TRADESKILL_WEAPON_CRAFTING, "Vyroba zbrani");
  CnrAddTradeskill(CNR_TRADESKILL_ARMOR_CRAFTING, "Vyroba zbroji");
  CnrAddTradeskill(CNR_TRADESKILL_ALCHEMY, "Alchymie");
  CnrAddTradeskill(CNR_TRADESKILL_SCRIBING, "Psani");
  CnrAddTradeskill(CNR_TRADESKILL_TINKERING, "Dratenictvi");
  CnrAddTradeskill(CNR_TRADESKILL_WOOD_CRAFTING, "Truhlarstvi"); // includes BOWERING, FLETCHING, CARPENTRY
  CnrAddTradeskill(CNR_TRADESKILL_ENCHANTING, "Ocarovani");   // includes IMBUING
  CnrAddTradeskill(CNR_TRADESKILL_GEM_CRAFTING, "Zlatnictvi");
  CnrAddTradeskill(CNR_TRADESKILL_TAILORING, "Krejcovstvi");
  CnrAddTradeskill(CNR_TRADESKILL_FOOD_CRAFTING, "Vareni");
  CnrAddTradeskill(CNR_TRADESKILL_INFUSING, "Louhovani");


  // Module builders: You should add your trade skills to the
  // file "user_trade_init" so that future versions of
  // CNR don't over-write your work.

}
