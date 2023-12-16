int StartingConditional()
{
    int iResult;

    iResult = (GetItemPossessedBy(GetPCSpeaker(), "sy_not_pen") != OBJECT_INVALID);
    return iResult;
}
