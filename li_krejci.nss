//::///////////////////////////////////////////////
//:: FileName li_krejci
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 22.1.2008 14:58:22
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{

	// Bu� otev�i obchod s t�mto tagem, nebo u�ivateli oznam, �e ��dn� obchod neexistuje.
	object oStore = GetNearestObjectByTag("li_ob_krejci001");
	if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
		gplotAppraiseOpenStore(oStore, GetPCSpeaker());
	else
		ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
}
