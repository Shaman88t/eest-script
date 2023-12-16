void main()
{
    object oPC = GetPCSpeaker();
    if (GetGold(oPC) >= 500) {
        TakeGoldFromCreature(500, oPC);
        object wpKel = GetObjectByTag("WP_KEL_KURT");
        AssignCommand(oPC, JumpToObject(wpKel));
    }
    else{
        ActionSpeakString("Vzdyt ty nemas tolik penez!");
    }
}
