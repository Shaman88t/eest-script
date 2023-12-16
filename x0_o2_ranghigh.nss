//::///////////////////////////////////////////////////
//:: X0_O2_RANGHIGH.NSS
//:: OnOpened/OnDeath script for a treasure container.
//:: Treasure type: Any ranged weapon (includes throwing weapons but not ammunition)
//:: Treasure level: TREASURE_TYPE_HIGH
//::
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 11/21/2002
//::///////////////////////////////////////////////////

void main()
{

    ExecuteScript( "nw_o2_classhig", OBJECT_SELF );

}

