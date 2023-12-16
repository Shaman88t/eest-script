#include "nw_i0_plot"

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    return ( GetGold(oPC) >= 10000 ) && AutoDC(DC_MEDIUM, SKILL_PERSUADE, oPC);
}

