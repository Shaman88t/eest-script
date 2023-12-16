#include "sy_item_decay"

void main()
{
    int    iObjCnt = 0;
    int    iCena   = 0;
    object oPC     = GetLastOpenedBy();
    object oItem   = GetFirstItemInInventory(OBJECT_SELF);
    int    bPlot;

    while (oItem!=OBJECT_INVALID)
    {
        iObjCnt++;
        bPlot = GetPlotFlag(oItem);
        SetPlotFlag(oItem,0);
        iCena = iCena + sy_ZistiCenuOpravy(oItem);
        SetPlotFlag(oItem,bPlot);
        oItem = GetNextItemInInventory(OBJECT_SELF);
    }

    if (iObjCnt==0)
    {
        SendMessageToPC(oPC,"Nedal si do truhly ziadnu vec");
        return;
    }

    SetCustomToken(22000,IntToString(iCena));
    SetLocalInt(OBJECT_SELF,"sy_cena",iCena);

    ActionStartConversation(oPC,"sy_chest_rep_dlg",TRUE,FALSE);
}
