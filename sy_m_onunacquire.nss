//script sa aktivuje ak PC odhodi veci na zem
//tento script patri do modules->OnPlayerUnAcquire

#include "x2_inc_switches"
#include "sy_main_lib"

void main()
{
    object oItem = GetModuleItemLost();
    object oPC = GetModuleItemLostBy();

    sy_on_unacquire(oPC, oItem);
}
