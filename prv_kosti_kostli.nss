void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC, "NW_IT_MSMLMISC13");

    if( oItem == OBJECT_INVALID ) return;

    DestroyObject(oItem);
    GiveGoldToCreature(oPC, 5);
}

