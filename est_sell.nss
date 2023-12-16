// Authors  : TondaLee (AV) - Antonin Vins
// Created  : 17/06/2005
// Modified : 17/06/2005

#include "_inc_config"
#include "_inc_db_estate"

void main()
{
    object oPlayer = GetPCSpeaker();
    object oEstateControl = OBJECT_SELF;
    string sEstateControlTag = GetTag(oEstateControl);

    SellEstate(sEstateControlTag, oPlayer);

    ExecuteScript("_action_getgold", OBJECT_SELF);
}
