void main()
{
 object oUser = GetLastUsedBy();
 string sDestination = GetLocalString(OBJECT_SELF, "DESTINATION");
// effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2);

 object oDestination = GetObjectByTag(sDestination);


 DelayCommand(0.5f, AssignCommand(oUser, JumpToObject(oDestination)));
}
