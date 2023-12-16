// Authors  : TondaLee (AV) - Antonin Vins
// Created  : 17/06/2005
// Modified : 17/06/2005

#include "_inc_config"
#include "_inc_db_estate"

void main()
{
    object oEstateControl = OBJECT_SELF;
    string sEstateControlTag = GetTag(oEstateControl);

    int iPrice = GetEstatePrice(sEstateControlTag);
    SetCustomToken(TOKEN_PRICE, IntToString(iPrice));
    SetLocalInt(oEstateControl, VARIABLE_PRICE, iPrice);
}
