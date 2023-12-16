void main()
{
    object oPC     = GetPCSpeaker();
    int    iGender = GetGender(oPC);
    string sSoundTag;

    if (iGender==GENDER_MALE) sSoundTag = "as_pl_snoringm1";
    else sSoundTag = "as_pl_snoringf1";

    AssignCommand(oPC, SpeakString("*chrape*"));
    PlaySound(sSoundTag);
    AssignCommand(oPC, ActionPlayAnimation (ANIMATION_LOOPING_DEAD_BACK, 1.0, 10000.0));
}
