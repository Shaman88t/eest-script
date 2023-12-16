void main()
{
    object oPC = GetPCSpeaker();
    object oNote = GetLocalObject(oPC, "notes_currentobject");
    string sSeal = GetName(oPC);
    SetLocalString(oNote, "notes_seal", sSeal);
}
