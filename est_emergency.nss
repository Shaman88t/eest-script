// Authors  : TondaLee (AV) - Antonin Vins
// Created  : 17/06/2005
// Modified : 17/06/2005

#include "nw_i0_plot"

#include "_inc_config"
#include "_inc_db_estate"

void main()
{
    object oPlayer = GetPCSpeaker();
    object oEstateControl = OBJECT_SELF;
    string sEstateControlTag = GetTag(oEstateControl);

    string sEstateEmergencyWayTag = GetEstateEmergencyWay(sEstateControlTag);

    object oEstateEmergencyWay = GetObjectByTag(sEstateEmergencyWayTag);

    if (oEstateEmergencyWay != OBJECT_INVALID)
    {
        location lLocation = GetLocation(oEstateEmergencyWay);
        if (GetIsEstateOwner(sEstateControlTag, oPlayer) != 1 && !GetIsDM(oPlayer)) TakeGold(GetGold(oPlayer), oPlayer);

        AssignCommand(oPlayer, JumpToLocation(lLocation));
    }
}
