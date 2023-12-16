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
    CreateObject(OBJECT_TYPE_PLACEABLE, GetResRef(oSelf),lSelf,FALSE);
    DestroyObject(oSelf,0.5);
   }

  if (oItem == OBJECT_INVALID) return;
  while (oItem != OBJECT_INVALID)
   {
    if (GetStringLeft(GetResRef(oItem),7) == "pattern") DestroyObject(oItem);
    if (GetStringLeft(GetResRef(oItem),10) == "flagswitch") DestroyObject(oItem);
    if (GetStringLeft(GetResRef(oItem),8) == "essence_") DestroyObject(oItem);
    if (GetStringLeft(GetTag(oItem),2) == "P_") DestroyObject(oItem);
    if (GetStringLeft(GetResRef(oItem),6) == "recipe") DestroyObject(oItem);
    oItem = GetNextItemInInventory(OBJECT_SELF);
    if (oItem == OBJECT_INVALID) break;
   }
   //SendMessageToPC(GetFirstPC(),"DONE WITH CLOSE SCRIPT");

}

