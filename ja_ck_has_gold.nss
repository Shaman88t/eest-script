#include "ja_variables"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iReq = GetLocalInt(oPC, v_Price);
    int iGold = GetGold(oPC);

    return iGold >= iReq;
}
