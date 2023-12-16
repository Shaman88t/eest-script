void main()
{
    object oPC     = GetPCSpeaker();
    int    iGender = GetGender(oPC);
    string sSoundTag;

    if (iGender==GENDER_MALE) sSoundTag = "as_pl_sneezingm1";
    else sSoundTag = "as_pl_sneezingf1";

    AssignCommand(oPC, SpeakString("*kychne*"));
    PlaySound(sSoundTag);
    AssignCommand(oPC, ActionPlayAnimation (ANIMATION_FIREFORGET_DODGE_DUCK, 1.0, 3.0));
}
