// Authors  : TondaLee (AV) - Antonin Vins
// Created  : 17/06/2005
// Modified : 17/06/2005

#include "NW_I0_PLOT"

#include "_inc_config"
#include "_inc_db_estate"

void main()
{
    object oPlayer = GetPCSpeaker();
    object oEstateControl = OBJECT_SELF;
    string sEstateControlTag = GetTag(oEstateControl);

    int iGold = GetLocalInt(OBJECT_SELF, VARIABLE_PRICE);
    if (!HasGold(iGold, oPlayer))
    {
        SendMessageToPC(oPlayer, "Nemas potrebne penize!");
        return;
    }

    BuyEstate(sEstateControlTag, oPlayer);

    ExecuteScript("_action_paygold", OBJECT_SELF);
}
