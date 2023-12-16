/*
    Aktivaciou itemu "Ocilka a trud" vznikne na zameranom mieste placeable
    ohniste s kotlikom, tam sa bude dat upiect maso
    po 20 minutach ohniste zmizne
*/

#include "x2_inc_switches"

void main()
{
    int iEvent = GetUserDefinedEventNumber();
    if (iEvent == X2_ITEM_EVENT_ACTIVATE)
    {
        object   oPC   = GetItemActivator();
        location vPoz  = GetItemActivatedTargetLocation();
//        object   oOcilka = CreateObject(OBJECT_TYPE_ITEM,"ka_podpal1",vPoz);
        CreateItemOnObject("ka_podpal1",oPC,1,"ka_podpal1");
    }
}

