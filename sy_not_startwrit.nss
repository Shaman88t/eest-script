void main()
{
    object oPC = GetPCSpeaker();
    object oListener = CreateObject(OBJECT_TYPE_CREATURE, "sy_not_listener", GetLocation(oPC));
    SetLocalObject(oPC, "notes_currentlistener", oListener);
    SetLocalObject(oListener, "notes_currentpc", oPC);
    SetLocalInt(oPC, "notes_iswriting", 1);
}
