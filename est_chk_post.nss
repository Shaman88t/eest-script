// Authors  : TondaLee (AV) - Antonin Vins
// Created  : 17/06/2005
// Modified : 17/06/2005

#include "_inc_config"
#include "_inc_db_estate"

int StartingConditional()
{
    object oPlayer = GetPCSpeaker();
    object oEstateControl = OBJECT_SELF;
    string sEstateControlTag = GetTag(oEstateControl);

    if (GetIsEstateOwner(sEstateControlTag, oPlayer) || GetIsDM(oPlayer)) return 1;
    return 0;
}
