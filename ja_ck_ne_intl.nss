#include "NW_I0_PLOT"

int StartingConditional()
{
    int iALI = GetAlignmentGoodEvil(GetPCSpeaker());

    int iAl  = ( iALI == ALIGNMENT_EVIL || iALI == ALIGNMENT_NEUTRAL);
    int iInt = CheckIntelligenceLow();

    return iAl && iInt;
}


