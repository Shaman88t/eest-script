//pozriem vysledok

void main()
{
    int iPokusov    = 10 - GetLocalInt(OBJECT_SELF,"sy_pokusov");
    int iBodov      = GetLocalInt(OBJECT_SELF,"sy_bodov");
    string sStrelec = GetLocalString(OBJECT_SELF,"sy_strelec");

    object oPC = GetPCSpeaker();
    FloatingTextStringOnCreature(sStrelec + " zasahnul terc " +
        IntToString(iPokusov) + " ranami za " + IntToString(iBodov) + " bodu.",oPC);
}
