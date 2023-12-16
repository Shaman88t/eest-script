int StartingConditional()
{
    int iResult;

    iResult = GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(), "NW_IT_MSMLMISC13"));
    return iResult;
}
