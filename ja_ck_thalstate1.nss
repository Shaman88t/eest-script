int StartingConditional()
{
    return (GetLocalInt(GetPCSpeaker(), "THAL_STATE") == 1);
}
