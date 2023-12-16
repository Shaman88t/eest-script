#include "NW_I0_PLOT"

int StartingConditional()
{
    int iHar =  GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(), "Tetovaniostrovana"));

    int iInt = CheckIntelligenceNormal();

    return iHar && iInt;
}
