void main()
{
    object oPC       = GetPCSpeaker();
    string sSoundTag = "as_pl_whistle";
    int iID          = Random(2) + 1;
    sSoundTag        = sSoundTag + IntToString(iID);
    AssignCommand(oPC, SpeakString("*piska si*"));
    PlaySound(sSoundTag);
}
