int StartingConditional()
{
    int iResult;

    iResult = (GetItemPossessedBy(GetPCSpeaker(), "sy_not_signetring") != OBJECT_INVALID);
    return iResult;
}
