int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oHorse = GetLocalObject(oPC, "JA_HORSE_OBJECT");

    SetCustomToken( 9312, IntToString(GetLocalInt(oHorse, "JA_HORSE_PRICE")/2));

    return TRUE;
}
