void main()
{
    object oPC = GetPCSpeaker();
    if (GetGold(oPC) >= 1000) {
        string sRing = GetLocalString(OBJECT_SELF, "JA_HAR_RING");
        TakeGoldFromCreature(1000, oPC);
        CreateItemOnObject(sRing, oPC);
    }
    else{
        ClearAllActions();
        ActionSpeakString("Hmm, nemas dost penez.");
    }
}
