//::///////////////////////////////////////////////
//:: FileName chicken_attack
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/14/2002 2:22:03 PM
//:://////////////////////////////////////////////
#include "nw_i0_generic"

void main()
{

	// Set the faction to hate the player, then attack the player
	AdjustReputation(GetPCSpeaker(), OBJECT_SELF, -100);
	DetermineCombatRound(GetPCSpeaker());
}
