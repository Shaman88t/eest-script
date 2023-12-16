void main()
{
    object oPC = GetPCSpeaker();
    object oStone = GetItemPossessedBy(oPC, "ry_strazce2");
    if( GetIsObjectValid(oStone) ){
        DestroyObject(oStone);
        DelayCommand(0.1, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
        SetLocalInt(OBJECT_SELF, "JA_CRYSTAL_ON", 1);

        object oDoor = GetObjectByTag("ja_flashd2");
        SetLocked(oDoor, 0);
        AssignCommand(oDoor, ActionOpenDoor(oDoor));
    }
}
