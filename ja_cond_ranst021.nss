int StartingConditional()
{
    int iRan = Random(21)+1;

    SetLocalInt(OBJECT_SELF, "JA_CONV_GEN", iRan);

    return (iRan == 1);
}
