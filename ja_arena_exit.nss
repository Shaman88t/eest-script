#include "persistence"

void main()
{
    object oPC = GetEnteringObject();

    if( !GetIsPC(oPC) || GetIsDM(oPC) ) return;

    string spells = GetLocalString(oPC, "JA_ARENA_SPELLS");
    pSetSpells(oPC, spells);

}
