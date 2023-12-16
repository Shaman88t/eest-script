void main()
{
    object oPC = GetPCSpeaker();
    if (GetGold(oPC) >= 500) {
        TakeGoldFromCreature(500, oPC);
        object wpKaratha = GetObjectByTag("WP_KARATHA_ALW");
        AssignCommand(oPC, JumpToObject(wpKaratha));
    }
    else{
        ActionSpeakString("Vzdyt ty nemas tolik penez!");
    }
}

