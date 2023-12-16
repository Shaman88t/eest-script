//ulozit ako nw_c2_default3 ked chcem aby to platilo pre vsetky prisery
//ulozit do eventu OnCombatRoundEnd prisery aby platilo len pre urcite prisery

//::///////////////////////////////////////////////
//:: Default: End of Combat Round
//:: NW_C2_DEFAULT3
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Calls the end of combat script every round
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//:://////////////////////////////////////////////

#include "NW_I0_GENERIC"
#include "sy_item_decay"
void main()
{
    if (GetLocalInt(OBJECT_SELF,"nLastDamage") == GetDamageDealtByType(DAMAGE_TYPE_BASE_WEAPON)) return;                      // is the same as this then return
    SetLocalInt(OBJECT_SELF,"nLastDamage",GetDamageDealtByType(DAMAGE_TYPE_BASE_WEAPON));// else they are different so write the value to the local variable

    //debug msg - len utocnikova zbran hnije(moja)
    //object oPC = GetFirstPC();
    //SendMessageToPC(oPC,"oncbtrnend:utocnik - "+GetName(GetLastDamager(OBJECT_SELF))+" obranca - "+GetName(OBJECT_SELF));

    eqlAttackerWeaponDecay(GetLastDamager(OBJECT_SELF)); //hracova zbran (rukavice sa neberu ako zbran)
    //eqlDefenderArmourDecay(OBJECT_SELF); //brnenie NPC
/*
    if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
    {
        DetermineSpecialBehavior();
    }
    else if(!GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
    {
        DetermineCombatRound();
    }
    if(GetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1003));
    }*/
}




