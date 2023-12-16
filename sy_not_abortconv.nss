void main()
{
    object oPC = GetPCSpeaker();
    if (GetLocalInt(oPC, "notes_iswriting")== 1)
    {
        object oListener = GetLocalObject(OBJECT_SELF, "notes_currentlistener");
        DestroyObject(oListener);
    }
}
