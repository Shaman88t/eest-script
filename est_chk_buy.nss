// Authors  : TondaLee (AV) - Antonin Vins
// Created  : 17/06/2005
// Modified : 17/06/2005
// hrac nesmi vlastnit vice jak jednu nemovitost

#include "_inc_config"
#include "_inc_db_estate"

int StartingConditional()
{
    object oEstateControl = OBJECT_SELF;
    string sEstateControlTag = GetTag(oEstateControl);

    if (!GetIsEstateFree(sEstateControlTag)) return 0;

    object oPlayer = GetPCSpeaker();

    if (GetNumbersEstatesOwning(oPlayer) >= 1) return 0;
    return 1;
}
