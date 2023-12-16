void main()
{
   object oBook = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,GetPCSpeaker());
   int iChapter=GetLocalInt(oBook, "iChapter");
   iChapter++;
   string sChapter="sChapter" + IntToString(iChapter);
   string sText=GetLocalString(oBook,sChapter);
   SendMessageToPC(GetPCSpeaker(),sText);
//   SendMessageToPC(GetPCSpeaker(),"*******");
   SetLocalInt(oBook,"iChapter",iChapter);
   SetCustomToken(8001,sText);
}
