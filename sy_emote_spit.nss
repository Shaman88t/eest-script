void main()
{
    object oPC       = GetPCSpeaker();
    string sSoundTag = "as_pl_spittingm";
    int iID          = Random(2) + 1;
    sSoundTag        = sSoundTag + IntToString(iID);
    AssignCommand(oPC, SpeakString("*plivne*"));
    PlaySound(sSoundTag);
    AssignCommand(oPC, ActionPlayAnimation (ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 1.0, 2.0));
}
