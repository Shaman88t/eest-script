void main()
{
    object oPC     = GetPCSpeaker();
    int    iGender = GetGender(oPC);
    string sSoundTag;

    if (iGender==GENDER_MALE) sSoundTag = "as_pl_chantingm";
    else sSoundTag = "as_pl_chantingf";

    //int iID = Random(2) + 1;
    int iID = 1;
    sSoundTag = sSoundTag + IntToString(iID);

    AssignCommand(oPC, SpeakString("*medituje*"));
    PlaySound(sSoundTag);
    AssignCommand(oPC, ActionPlayAnimation (ANIMATION_LOOPING_MEDITATE, 1.0, 5.0));
}
