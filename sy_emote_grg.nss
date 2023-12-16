void main()
{
    object oPC       = GetPCSpeaker();
    string sSoundTag = "as_pl_x2rghtav";
    int iID          = Random(3) + 1;
    sSoundTag        = sSoundTag + IntToString(iID);
    AssignCommand(oPC, SpeakString("*grgne*"));
    PlaySound(sSoundTag);
}
