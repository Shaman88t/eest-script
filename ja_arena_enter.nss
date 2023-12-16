#include "ja_variables"
#include "persistence"

void main()
{
    object oPC = GetEnteringObject();

    if( !GetIsPC(oPC) || GetIsDM(oPC) ) return;

    string spells = pGetSpells(oPC);
    SetLocalString(oPC, "JA_ARENA_SPELLS", spells);

    int iAllowed = ( GetTag(GetArea(oPC)) == GetLocalString( oPC, v_ArenaPermission ) );

    if( iAllowed ) return;

    SendMessageToPC( oPC, "POZOR!! Nemas koupenou vstupenku a pokud ted v arene zemres, zemres doopravdy. Vstupenku je mozno zakoupit u prodejce ve vstupni hale.");
}
