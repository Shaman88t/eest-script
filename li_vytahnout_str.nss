#include "nw_i0_plot"

void main()
{
    string sItem = GetLocalString(OBJECT_SELF, "Zbran");

    if(sItem == "")
        ActionEquipMostDamagingRanged();
    else if(HasItem(OBJECT_SELF, sItem))
        ActionEquipItem(GetObjectByTag(sItem), INVENTORY_SLOT_RIGHTHAND);
    else
        return;

    DelayCommand(60.0f, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND)));
}
