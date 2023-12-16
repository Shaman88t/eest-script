int StartingConditional()
{
    int rt = GetRacialType(GetPCSpeaker());

    if(rt == RACIAL_TYPE_DWARF || rt == RACIAL_TYPE_HALFORC)
        return TRUE;

    return FALSE;
}
