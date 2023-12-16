void main()
{
   object oPC = GetLastAttacker();
   object oStrelec = GetLocalObject(OBJECT_SELF,"strelec");
   if(!GetIsObjectValid(oStrelec)) {
     oStrelec = oPC;
     SetLocalObject(OBJECT_SELF,"strelec",oPC);
   }

   if(oStrelec != oPC) {
    FloatingTextStringOnCreature("Jiny strelec",OBJECT_SELF);
    return;
   }

   int iShots = GetLocalInt(OBJECT_SELF,"shots") + 1;
   int iHits = GetLocalInt(OBJECT_SELF,"hits");

//   if(iShots == 1)
//     SetLocalString(OBJECT_SELF,"name",GetName(OBJECT_SELF));

   string name = GetLocalString(OBJECT_SELF,"name");

   SetName(OBJECT_SELF,name + " ( "+IntToString(iHits) + " z "+ IntToString(iShots) +" )");

   SetLocalInt(OBJECT_SELF,"shots",iShots);
   SetLocalInt(OBJECT_SELF,"hits",iHits);
   string sDesc = GetDescription(OBJECT_SELF);
   string snl = GetLocalString(OBJECT_SELF,"nl");
   SetDescription(OBJECT_SELF,sDesc+snl+IntToString(iShots)+": - ");

}
