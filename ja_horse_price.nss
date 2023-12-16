int StartingConditional()
{
    int iPrice = GetLocalInt(OBJECT_SELF, "JA_HORSE_PRICE");

    SetCustomToken(9311, IntToString(iPrice));

    return TRUE;
}
