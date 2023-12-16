//::///////////////////////////////////////////////////
//:: X0_O2_NOAMUNIQ.NSS
//:: OnOpened/OnDeath script for a treasure container.
//:: Treasure type: Any non-ammunition weapon (this does include throwing weapons)
//:: Treasure level: TREASURE_TYPE_UNIQUE
//::
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 11/21/2002
//::///////////////////////////////////////////////////


void main()
{

    ExecuteScript( "nw_o2_classhig", OBJECT_SELF );

}

