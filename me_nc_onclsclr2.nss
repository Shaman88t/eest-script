void main()
{
  object oItem = GetFirstItemInInventory(OBJECT_SELF);
  object oSelf = OBJECT_SELF;
  location lSelf = GetLocation(oSelf);
  object oDuplicate = GetNearestObjectByTag(GetTag(oSelf),oSelf,1);
  object oPC = GetLastClosedBy();
  DeleteLocalObject(oPC,"oLastOpened");
  if (GetDistanceBetween(oDuplicate,oSelf)<0.3)DestroyObject(oDuplicate);
  if (GetLocalInt(oSelf,"iAmInUse")==0)
   {
    object oNewPlaceable = CreateObject(OBJECT_TYPE_PLACEABLE, GetResRef(oSelf),lSelf,FALSE);
    int iDay = GetLocalInt(oSelf,"iLastDay");
    int iHour = GetLocalInt(oSelf,"iLastHour");
    int iHoneyComb = GetLocalInt(oSelf,"iHoneyComb");
    int iHoney = GetLocalInt(oSelf,"iHoney");
    SetLocalInt(oNewPlaceable,"iLastDay",iDay);
    SetLocalInt(oNewPlaceable,"iLastHour",iHour);
    SetLocalInt(oNewPlaceable,"iHoneyComb",iHoneyComb);
    SetLocalInt(oNewPlaceable,"iHoney",iHoney);
    DestroyObject(oSelf,0.5);
   }
  if (oItem == OBJECT_INVALID) return;
  while (oItem != OBJECT_INVALID)
   {
    DestroyObject(oItem);
    oItem = GetNextItemInInventory(OBJECT_SELF);
    if (oItem == OBJECT_INVALID) break;
   }
   //SendMessageToPC(GetFirstPC(),"DONE WITH CLOSE SCRIPT");

}

