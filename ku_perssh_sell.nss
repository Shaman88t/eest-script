//Stript ku_perssh_sell
#include "ku_persist_inc"
#include "nwnx_item"

void main()
{
  object oPC = GetPCSpeaker();
  object oSpeaker = OBJECT_SELF;
  object oItem = GetLocalObject(oSpeaker,"actually_selling_item");
  int iPrice =   GetLocalInt(oSpeaker,KU_PERS_SHOP_ITEMPRICE);
                 SetLocalInt(oItem,KU_PERS_SHOP_ITEMPRICE,iPrice);
  int iStack = GetItemStackSize(oItem);
  iPrice = iPrice / iStack;

  NWNX_Item_SetBaseGoldPieceValue(oItem,iPrice);
  Persist_ShopPutItemToShop(oItem,oPC);

}
