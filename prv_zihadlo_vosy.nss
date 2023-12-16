void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC, "zihadlo_vosy");

    if( oItem == OBJECT_INVALID ) return;

    DestroyObject(oItem);
    GiveGoldToCreature(oPC, 10);
}
