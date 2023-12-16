int StartingConditional()
{
    int iHar =  GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(), "Tetovaniostrovana"));

    return !iHar;
}
