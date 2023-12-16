void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC, "cnrAnimalMeat");

    if( oItem == OBJECT_INVALID ) return;

    DestroyObject(oItem);
    GiveGoldToCreature(oPC, 6);
}

