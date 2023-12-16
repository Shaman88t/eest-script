int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oMaster = GetLocalObject(OBJECT_SELF, "JA_HORSE_PC");

    return (oMaster == oPC);
}
