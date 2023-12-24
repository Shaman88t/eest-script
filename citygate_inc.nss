#include "city_const"



const int CITYGATE_STATUS_OK = 1;
const int CITYGATE_STATUS_SHOWHELMET = -1;
const int CITYGATE_STATUS_INVALIDRACE= -2;



int GetCityGateStatus(object oPC, int iCity);
int GetCityGateStatus(object oPC, int iCity)
{
    object oHelmet = GetItemInSlot(INVENTORY_SLOT_HEAD,oPC);
    if (GetIsObjectValid(oHelmet))
    {
        return CITYGATE_STATUS_SHOWHELMET;
    }
    switch (iCity)
    {
        case CITY_KARATHA:
        {
            //return CITYGATE_STATUS_SHOWHELMET;
        }
    }
    return CITYGATE_STATUS_OK;
}
