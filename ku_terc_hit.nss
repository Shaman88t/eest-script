void main()
{
   object oPC = GetLastDamager();
   object oStrelec = GetLocalObject(OBJECT_SELF,"strelec");
   if(!GetIsObjectValid(oStrelec)) {
     oStrelec = oPC;
     SetLocalObject(OBJECT_SELF,"strelec",oPC);
   }

   if(oStrelec != oPC) {
    FloatingTextStringOnCreature("Jiny strelec",OBJECT_SELF);
    return;
   }

   FloatingTextStringOnCreature("ZASAH!",OBJECT_SELF,FALSE);

   int iShots = GetLocalInt(OBJECT_SELF,"shots");
   int iHits = GetLocalInt(OBJECT_SELF,"hits") + 1;

//   if(iShots == 1)
//     SetLocalString(OBJECT_SELF,"name",GetName(OBJECT_SELF));

   string name = GetLocalString(OBJECT_SELF,"name");

   SetName(OBJECT_SELF,name + " ( "+IntToString(iHits) + " z "+ IntToString(iShots) +" )");

   SetLocalInt(OBJECT_SELF,"shots",iShots);
   SetLocalInt(OBJECT_SELF,"hits",iHits);
   string sDesc = GetDescription(OBJECT_SELF);
   int iDamage = GetDamageDealtByType(DAMAGE_TYPE_BASE_WEAPON);
   SetDescription(OBJECT_SELF,sDesc+IntToString(iDamage));

}
