void main()
{
object oPC = GetEnteringObject();
object oHovna = GetNearestObjectByTag("sm_hovna");
int iSmrad;
effect eDisease = EffectDisease(DISEASE_GHOUL_ROT);

if (GetLocalInt(oHovna, "iSmrad")== 1 )
   {
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eDisease, oPC);
   }
else
   {
   ClearAllActions();
   }
}
