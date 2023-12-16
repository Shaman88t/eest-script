void main()
{
    object oPC     = GetPCSpeaker();
    int    iGender = GetGender(oPC);
    string sSoundTag;

    if (iGender==GENDER_MALE) sSoundTag = "as_pl_cryingm";
    else sSoundTag = "as_pl_cryingf";

    int iID = Random(3) + 1;
    sSoundTag = sSoundTag + IntToString(iID);

    AssignCommand(oPC, SpeakString("*place*"));
    PlaySound(sSoundTag);
}
