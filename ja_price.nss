#include "ja_lib"

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    float fAl = GetGoodEvilValue(oPC)/100.0f;
    float fMod = GetLocalFloat(OBJECT_SELF, v_PriceMod);

    int iPrice = FloatToInt(fMod*(100 + fAl*500));

    SetLocalInt(oPC, v_Price, iPrice);

    SetCustomToken(t_Price, IntToString(iPrice));

    return 1;
}
