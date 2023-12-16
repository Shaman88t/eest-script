int StartingConditional()
{
    object sPC = GetLocalObject(OBJECT_SELF, "JA_HORSE_PC");

    return (sPC==OBJECT_INVALID) && (GetLocalInt(OBJECT_SELF, "JA_HORSE_PRICE") != 0);
}
