//::///////////////////////////////////////////////
//:: FileName zz_int_min9
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 24.10.2007 17:55:15
//:://////////////////////////////////////////////
int StartingConditional()
{
	if(!(GetAbilityScore(GetPCSpeaker(), ABILITY_INTELLIGENCE) > 8))
		return FALSE;

	return TRUE;
}
