void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC, "supinybuleta");

    if( oItem == OBJECT_INVALID ) return;

    DestroyObject(oItem);
    GiveGoldToCreature(oPC, 35);
}

