void main()
{
    object oPC     = GetPCSpeaker();
    int    iGender = GetGender(oPC);
    string sSoundTag;

    if (iGender==GENDER_MALE) sSoundTag = "as_pl_coughm";
    else sSoundTag = "as_pl_coughf";

    int iID = Random(6) + 2;
    sSoundTag = sSoundTag + IntToString(iID);

    AssignCommand(oPC, SpeakString("*kasle*"));
    PlaySound(sSoundTag);
    AssignCommand(oPC, ActionPlayAnimation (ANIMATION_LOOPING_TALK_PLEADING, 1.0, 2.0));
}
