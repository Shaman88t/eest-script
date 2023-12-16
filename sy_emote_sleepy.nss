void main()
{
    object oPC     = GetPCSpeaker();
    int    iGender = GetGender(oPC);
    string sSoundTag;

    if (iGender==GENDER_MALE) sSoundTag = "as_pl_yawningm1";
    else sSoundTag = "as_pl_yawningf1";

    AssignCommand(oPC, SpeakString("*ziva*"));
    PlaySound(sSoundTag);
    AssignCommand(oPC, ActionPlayAnimation (ANIMATION_LOOPING_PAUSE_TIRED, 1.0, 3.0));
}
