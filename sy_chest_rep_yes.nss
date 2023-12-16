#include "sy_item_decay"

void main()
{
    //doplnit o skillcheck co znizuje cenu v obchode tusim barter
    int    iObjCnt = 0;
    int    iCena   = 0;
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

    object oPC = GetPCSpeaker();
//    int iCena  = GetLocalInt(OBJECT_SELF,"sy_cena");
    if (GetGold(oPC)<iCena)
    {
        SendMessageToPC(oPC,"Nemas dost penazi na zaplatenie.");
        return;
    }
    TakeGoldFromCreature(iCena,oPC,TRUE);

    int    nCnt = 0;
    oItem = GetFirstItemInInventory();
    while (oItem!=OBJECT_INVALID)
    {
        sy_OpravVec(oItem);
        oItem = GetNextItemInInventory();
        nCnt++;
    }

    if (nCnt!=0) SendMessageToPC(oPC,"Tvoje veci su opravene.Mozes si ich vziat.");
}
