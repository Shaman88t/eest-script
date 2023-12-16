/*
 * revlease Kucik 24.01.2008
 * Postihy zbrani
 * rev. 07. 08. 2008 Zjednoduseno
 */

void main()
{
 object oPC=GetLocalObject(OBJECT_SELF,"KU_OWNER");
 int iPenalty = GetLocalInt(OBJECT_SELF,"KU_WPENALTY");

 object oMod = GetModule();
 int iRestrict = GetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(GetBaseItemType(OBJECT_SELF)));

 if(!iRestrict)
   return;

 effect eEff;

 // Nastav efekt
 if(iPenalty>0) {
   eEff=EffectAttackDecrease(iPenalty);
   eEff=EffectLinkEffects(eEff,EffectDamageDecrease(iPenalty));
   eEff=SupernaturalEffect(eEff);
   ApplyEffectToObject(DURATION_TYPE_PERMANENT,eEff,oPC);
   return;
 }

 //Sundej efekt
 //SendMessageToPC(oPC,"ja jsem tvuj item:)");
 eEff = GetFirstEffect(oPC);
 object oCreator;
 int iItemType=0;
 int bByItem = FALSE;

 while(GetIsEffectValid(eEff)) {
   iItemType=-1;
   bByItem = FALSE;
   oCreator = GetEffectCreator(eEff);

   if( (GetObjectType(oCreator)==OBJECT_TYPE_ITEM) &&
       (GetEffectSubType(eEff)==SUBTYPE_SUPERNATURAL) ) {
     iItemType = GetBaseItemType(oCreator);

     if(GetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(iItemType)))
       bByItem = TRUE;
   }

//   if( (GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC))==iItemType) || (GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC))==iItemType) )
//      bByItem = FALSE;

   if( (bByItem) && (GetObjectType(oCreator)==OBJECT_TYPE_ITEM) && (GetEffectSubType(eEff)==SUBTYPE_SUPERNATURAL) )
     RemoveEffect(oPC,eEff);
   eEff=GetNextEffect(oPC);
 }


}
