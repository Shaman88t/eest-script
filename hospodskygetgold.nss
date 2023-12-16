void main()
{
    object oPC = GetPCSpeaker();
    if (GetGold(oPC) >= 20) {
        TakeGoldFromCreature(20, oPC);
        string sInnName = GetLocalString(OBJECT_SELF, "INN_NAME");
        SetLocalInt(oPC, sInnName, 1);
    }
    else{
        ClearAllActions();
        ActionSpeakString("Nemas ty penize.");
    }
}
