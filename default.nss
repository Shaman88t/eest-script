//ulozit ako default, cize to bude player's onHeartBeat script

#include "sy_item_decay"
void main()
{
    if(GetIsInCombat(OBJECT_SELF) )                                                 // dont do anything if we're not in combat
    {                                                                               //
        if (GetLocalInt(OBJECT_SELF,"nLastDamage") == GetDamageDealtByType(DAMAGE_TYPE_BASE_WEAPON)) return;
        SetLocalInt(OBJECT_SELF,"nLastDamage",GetDamageDealtByType(DAMAGE_TYPE_BASE_WEAPON));

        //debug msg.
        //object oPC = GetFirstPC();
        //SendMessageToPC(oPC,"default:utocnik - "+GetName(GetLastDamager(OBJECT_SELF))+" obranca - "+GetName(OBJECT_SELF));

        object oAttacker = GetLastDamager(OBJECT_SELF);
        if (GetIsPC(oAttacker)) eqlAttackerWeaponDecay(GetLastDamager(OBJECT_SELF)); //zbran NPC, alebo zbran druheho hraca
        eqlDefenderArmourDecay(OBJECT_SELF); //hracove AC veci
    }
}
