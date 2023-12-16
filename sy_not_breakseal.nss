void main()
{
    object oPC = GetPCSpeaker();
    object oNote = GetLocalObject(oPC, "notes_currentobject");
    SetLocalString(oNote, "notes_seal", "broken");
}
