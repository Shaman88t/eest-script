#include "nw_i0_plot"

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    return ( GetGold(oPC) >= 1000 ) && AutoDC(DC_HARD, SKILL_PERSUADE, oPC);

}
