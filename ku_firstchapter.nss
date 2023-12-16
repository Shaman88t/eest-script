void main()
{
   object oBook = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,GetPCSpeaker());
   SetLocalInt(oBook,"iChapter",0);
//   string sText=GetLocalString(oBook,"Chapter1");
//   SendMessageToPC(GetPCSpeaker(),sText);
//   SendMessageToPC(GetPCSpeaker(),"*******");
   SetCustomToken(8001,GetName(OBJECT_SELF));
}
