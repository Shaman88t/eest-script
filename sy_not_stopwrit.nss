void main()
{
    object oPC = GetPCSpeaker();
    object oNote = GetLocalObject(OBJECT_SELF, "notes_currentobject");
    object oListener = GetLocalObject(OBJECT_SELF, "notes_currentlistener");
    string sHeard = GetLocalString(oListener, "notes_heard");
    string sText = GetLocalString(oNote, "notes_text");
    sText = sText + sHeard;
    SetLocalString(oNote, "notes_text", sText);
    SetLocalInt(oPC, "notes_iswriting", 0);
    DestroyObject(oListener);
}
