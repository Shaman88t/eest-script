//::///////////////////////////////////////////////
//:: FileName lis_female
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6.11.2004 11:03:33
//:://////////////////////////////////////////////
int StartingConditional()
{

	// P�idat omezen� pohlav�
	if(GetGender(GetPCSpeaker()) != GENDER_FEMALE)
		return FALSE;

	return TRUE;
}
