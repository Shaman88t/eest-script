void main()
{
    object oPC = GetPCSpeaker();
    if (GetGold(oPC) >= 300) {
        TakeGoldFromCreature(300, oPC);
        object wpTo = GetObjectByTag("WP_ALW_KEL");
        AssignCommand(oPC, JumpToObject(wpTo));
    }
    else{
        ActionSpeakString("Vzdyt ty nemas tolik penez!");
    }
}


