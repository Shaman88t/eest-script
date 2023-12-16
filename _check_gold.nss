// Authors  : TondaLee (AV) - Antonin Vins
// Created  : 12/06/2005
// Modified : 15/06/2005
// Zjisti zda ma hrac na zaplaceni urcite veci

#include "NW_I0_PLOT"
#include "_inc_config"

int StartingConditional()
{
    object oPlayer = GetPCSpeaker();

    int iGold = GetLocalInt(OBJECT_SELF, VARIABLE_PRICE);
    return HasGold(iGold, oPlayer);
}
