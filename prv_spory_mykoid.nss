void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC, "sporymykoida");

    if( oItem == OBJECT_INVALID ) return;

    DestroyObject(oItem);
    GiveGoldToCreature(oPC, 30);
}


