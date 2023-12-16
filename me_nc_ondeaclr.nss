void main()
{

 object oSearchForBag = GetNearestObjectByTag("Body Bag",OBJECT_SELF,1);
 if (oSearchForBag == OBJECT_INVALID)
  {
   //SendMessageToPC(GetFirstPC(),"No body bag found.");
   return;
  }

 object oBagItem = OBJECT_INVALID;

 if (GetDistanceToObject(oSearchForBag)<= 0.5)
  {
   //SendMessageToPC(GetFirstPC(),"Body bag found.. destroying contents..");
   oBagItem = GetFirstItemInInventory(oSearchForBag);
   while (oBagItem != OBJECT_INVALID)
    {
     //SendMessageToPC(GetFirstPC(),"Destroying : "+GetName(oBagItem));
     DestroyObject(oBagItem);
     oBagItem = GetNextItemInInventory(oSearchForBag);
    }
   DestroyObject(oSearchForBag,1.0);
  }


}
