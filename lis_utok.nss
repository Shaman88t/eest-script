//::///////////////////////////////////////////////
//:: FileName lis_utok
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 21.12.2004 17:07:39
//:://////////////////////////////////////////////
#include "nw_i0_generic"

void main()
{

	// Nastav�, aby frakce nen�vid�la hr��e a �to�ila na n�j.
	AdjustReputation(GetPCSpeaker(), OBJECT_SELF, -100);
	DetermineCombatRound(GetPCSpeaker());
}
