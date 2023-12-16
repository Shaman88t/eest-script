//::///////////////////////////////////////////////
//:: FileName li_barvy
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 22.1.2008 14:58:48
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{

	// Buï otevøi obchod s tímto tagem, nebo uživateli oznam, že žádný obchod neexistuje.
	object oStore = GetNearestObjectByTag("li_barvy");
	if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
		gplotAppraiseOpenStore(oStore, GetPCSpeaker());
	else
		ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
}
