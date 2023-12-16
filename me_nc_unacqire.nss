int GetIsNoDrop(object oItem);

void main()
{
   //object oItem = GetInventoryDisturbItem();
   object oItem = GetModuleItemLost();
   if (GetIsObjectValid(oItem)!=TRUE) return;  //Aborts script for destroyed items
   object oPC = GetModuleItemLostBy();
   string sNoDropFlag;
   object oSearchForBox;
   object oTemp;
   object oTokenBoxNew;
   object oNewItem;
   int iContainerNoDrop = 0;

  if (GetIsNoDrop(oItem)==0) return;  // item is droppable so aborts script

  object oWho=GetItemPossessor(oItem);
  object oArea=GetArea(oItem);

  // This next section is a direct modification of a cut-n-paste of a post made
  // to the Bioware Forums by the creator of the Nordock public server. (If memory serves)
  if(GetIsObjectValid(oWho)||GetIsObjectValid(oArea))
    {
     if(GetObjectType(oWho) == OBJECT_TYPE_STORE)
      {
       // To prevent exploits, we deduct from the player the base price
       // of the nodrop item that we're about to replace in his inventory.
       // This will be more than the store paid always.
       int nBase = GetGoldPieceValue(oItem);
       TakeGoldFromCreature(nBase,oPC,TRUE);
      }

     object oNewItem = CopyObject(oItem,GetLocation(oPC),oPC);

     if(GetIsObjectValid(oNewItem))
       {
        SendMessageToPC(oPC,"You cannot drop or sell this item!");
        DestroyObject(oItem);
       }
      else
       {
        string sItemName = GetName(oItem)+"("+GetResRef(oItem)+")";
        string sPlayerName = GetName(oPC)+"("+GetPCPublicCDKey(oPC)+")";
        // Log the exception, and send a message to the DMs about the cheat
        PrintString("NODROP: "+sPlayerName+" has dropped "+sItemName);
        SendMessageToAllDMs("NODROP: "+sPlayerName+" has dropped "+ sItemName);
       }
    }
   else // the area, and the possessor are invalid. Its in barter window.
    {
      // This will be our hook in OnAcquiredItem()
      SetLocalObject(oItem,"ND_OWNER",oPC);
    }
  }


int GetIsNoDrop(object oItem)
 {
  string sNoDropFlag = (GetStringLeft(GetTag(oItem),6));
  object oTemp=OBJECT_INVALID;
  if (sNoDropFlag == "NoDrop" || sNoDropFlag == "TOKEN_"||sNoDropFlag=="_TBOX_") return 99;
  if (GetBaseItemType(oItem)==BASE_ITEM_LARGEBOX)
   {
    oTemp = GetFirstItemInInventory(oItem);
    if (oTemp != OBJECT_INVALID)
     {
      while (oTemp !=OBJECT_INVALID)
       {
        sNoDropFlag = GetStringLeft(GetTag(oTemp),6);
        if (sNoDropFlag == "TOKEN_" || sNoDropFlag == "NoDrop")return 99;
        oTemp=GetNextItemInInventory(oItem);
       }
     }
   }
  return 0;
 }

