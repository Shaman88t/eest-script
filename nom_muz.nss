//::///////////////////////////////////////////////
//:: FileName nom_muz
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 31.10.2007 21:57:45
//:://////////////////////////////////////////////
int StartingConditional()
{

	// P�idat omezen� pohlav�
	if(GetGender(GetPCSpeaker()) != GENDER_MALE)
		return FALSE;

	return TRUE;
}
