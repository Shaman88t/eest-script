#include "NW_I0_PLOT"

int StartingConditional()
{
    int iALI = GetAlignmentGoodEvil(GetPCSpeaker());

    int iAl  = ( iALI == ALIGNMENT_GOOD );
    int iInt = CheckIntelligenceNormal();

    return iAl && iInt;
}

