const int MAXMODEL = 255;
#include "nwnx_item"

int GetNextDirectionId(int AType, int AForward, int ACurrent);
void ProcessCopyToNPC(object APC, object ANPC, int AItemSlot, string AMainType);
void ProcessCopyToPC(object APC, object ANPC, int AItemSlot, string AMainType);
void ProcessShieldModelChange(object APC, object ANPC, int AItemSlot,int AForward,int AUseCustomValue, int ACustomValue);
void ProcessSimpleModelChange(object APC, object ANPC, int AItemSlot,int AForward,int AUseCustomValue, int ACustomValue);
void ProcessWeaponColor(object APC,object ANPC,int AItemSlot,int AForward,string ASubMode);
void ProcessWeaponStyle(object APC,object ANPC,int AItemSlot,int AForward,string ASubMode);
void ProcessSimpleColor(object APC,object ANPC,int AItemSlot,int AForward,string ASubMode,int AUseCustomValue, int ACustomValue);
void ProcessAmorModelChange(object APC,object ANPC,int AItemSlot,int AForward,string ASubMode,int AUseCustomValue, int ACustomValue);
void ProcessAmorModelChangePerPart(object APC,object ANPC,int AItemSlot,int AForward,string ASubMode, string ASubMode2, int AReset,int AUseCustomValue, int ACustomValue);





void main()
{
    object oPC = GetPCSpeaker();
    object oNPC = OBJECT_SELF;
    string sMainType = GetLocalString(OBJECT_SELF,"MAIN_TYPE");
    string sMode     = GetLocalString(OBJECT_SELF,"MODE");                                  //change,copytonpc, copytopc
    if (GetScriptParam("MODE")!="")
    {
        sMode = GetScriptParam("MODE");
    }
    string sSubMode     = GetLocalString(OBJECT_SELF,"SUB_MODE");                                  //change,copytonpc, copytopc
    if (GetScriptParam("SUB_MODE")!="")
    {
        sSubMode = GetScriptParam("SUB_MODE");
    }
    string sSubMode2     = GetLocalString(OBJECT_SELF,"SUB_MODE2");                                  //change,copytonpc, copytopc
    if (GetScriptParam("SUB_MODE2")!="")
    {
        sSubMode2 = GetScriptParam("SUB_MODE2");
    }

    string sDir = GetScriptParam("DIRECTION");
    string sDirection = GetScriptParam("FORWARD");                              //1-DOPØEDU NEBO 0-DOZADU
    int iForward = (sDirection=="true");
    int iReset   = (sDir=="reset");
    int iUseCustomValue = (sDir=="-1");
    int iCustomValue = GetLocalInt(oPC,"IVALUE");

    SendMessageToPC(oPC,sMainType+"|"+sMode+"|"+sSubMode+"|"+sSubMode2+"|"+sDirection+"|"+sDir);
    int iItemSlot = 0;
    if (sMainType == "armor")
    {
        iItemSlot = INVENTORY_SLOT_CHEST;
    }
    else if (sMainType == "weapon")
    {
        iItemSlot = INVENTORY_SLOT_RIGHTHAND;
    }
    else if (sMainType == "shield")
    {
        iItemSlot = INVENTORY_SLOT_LEFTHAND;
    }
    else if (sMainType == "helmet")
    {
        iItemSlot = INVENTORY_SLOT_HEAD;
    }
    else if (sMainType == "cloak")
    {
        iItemSlot = INVENTORY_SLOT_CLOAK;
    }
    else
    {
        SendMessageToPC(oPC,"ERROR - Neplatný typ pøedmìtu");
        return;
    }
    if (sMode == "copytonpc")
    {
        ProcessCopyToNPC(oPC,oNPC,iItemSlot,sMainType);
    }
    else if (sMode == "copytopc")
    {
        ProcessCopyToPC(oPC,oNPC,iItemSlot,sMainType);
    }
    else if (sMode == "change")
    {
        if (sMainType == "shield")
        {
            ProcessShieldModelChange(oPC,oNPC,iItemSlot,iForward,iUseCustomValue,iCustomValue);
        }
        else if ((sMainType == "helmet") || (sMainType == "cloak"))
        {
            ProcessSimpleModelChange(oPC,oNPC,iItemSlot,iForward,iUseCustomValue,iCustomValue);
        }
        else if (sMainType == "armor")
        {
            ProcessAmorModelChange(oPC,oNPC,iItemSlot,iForward,sSubMode,iUseCustomValue,iCustomValue);
        }
        else
        {
            SendMessageToPC(oPC,"ERROR - Neplatný typ pøedmìtu");
            return;
        }
    }
    else if (sMode == "changeweaponcolor")
    {
        ProcessWeaponColor(oPC,oNPC,iItemSlot,iForward,sSubMode);
    }
    else if (sMode == "changeweaponstyle")
    {
        ProcessWeaponStyle(oPC,oNPC,iItemSlot,iForward,sSubMode);
    }
    else if (sMode == "simplecolor")
    {
        if ((sMainType == "helmet") || (sMainType == "cloak") || (sMainType == "armor"))
        {
            ProcessSimpleColor(oPC,oNPC,iItemSlot,iForward,sSubMode,iUseCustomValue,iCustomValue);
        }
        else
        {
            SendMessageToPC(oPC,"ERROR - Neplatný typ pøedmìtu");
            return;
        }
    }
    else if (sMode == "perpartcoloring")
    {
        if (sMainType == "armor")
        {
            ProcessAmorModelChangePerPart(oPC,oNPC,iItemSlot,iForward,sSubMode, sSubMode2,iReset,iUseCustomValue,iCustomValue);
        }
        else
        {
            SendMessageToPC(oPC,"ERROR - Neplatný typ pøedmìtu");
            return;
        }
    }



}

void ProcessCopyToNPC(object APC, object ANPC, int AItemSlot, string AMainType)
{
    //zkontroluju base item
    object oPCItem = GetItemInSlot(AItemSlot,APC);             //off-hand
    if (GetIsObjectValid(oPCItem)==FALSE) return;
    if (AMainType=="shield")
    {
        int iBaseItem =GetBaseItemType(oPCItem);
        if ((iBaseItem== BASE_ITEM_LARGESHIELD) || (iBaseItem== BASE_ITEM_SMALLSHIELD) || (iBaseItem== BASE_ITEM_TOWERSHIELD))
        {
           ;
        }
        else
        {
            return;
        }
    }
    object oItem = GetItemInSlot(AItemSlot,ANPC);             //off-hand
    if (GetIsObjectValid(oItem))
    {
        DestroyObject(oItem,0.5);
    }
    object oNewItem = CopyItem(oPCItem,ANPC,FALSE);
    DelayCommand(0.1,AssignCommand(ANPC,ActionEquipItem(oNewItem,AItemSlot)));
}

void ProcessCopyToPC(object APC, object ANPC, int AItemSlot, string AMainType)
{
    //zkontroluju base item
    object oPCItem = GetItemInSlot(AItemSlot,APC);             //off-hand
    if (GetIsObjectValid(oPCItem)==FALSE) return;
    object oItem = GetItemInSlot(AItemSlot,ANPC);             //off-hand
    if (GetIsObjectValid(oItem)==FALSE) return;
    if ((GetBaseItemType(oPCItem))==(GetBaseItemType(oItem)))
    {
        string sModel = NWNX_Item_GetEntireItemAppearance(oItem);
        NWNX_Item_RestoreItemAppearance(oPCItem,sModel);

        int iModel = GetItemAppearance(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, -1);
        object oNewItem = CopyItem(oPCItem,APC,TRUE);
        if (GetIsObjectValid(oNewItem))
        {
            DestroyObject(oPCItem,0.1);
            DelayCommand(0.2,AssignCommand(APC,ActionEquipItem(oNewItem,AItemSlot)));
        }
    }
}

void ProcessShieldModelChange(object APC, object ANPC, int AItemSlot,int AForward,int AUseCustomValue, int ACustomValue)
{
    object oItem = GetItemInSlot(AItemSlot,ANPC);             //off-hand
    if (GetIsObjectValid(oItem)==FALSE) return;
    int iBaseItem =GetBaseItemType(oItem);
    if ((iBaseItem== BASE_ITEM_LARGESHIELD) || (iBaseItem== BASE_ITEM_SMALLSHIELD) || (iBaseItem== BASE_ITEM_TOWERSHIELD))
    {
        ;
    }
    else
    {
            return;
    }
    int iModel = GetItemAppearance(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, -1);
    int iNewModel = GetNextDirectionId(ITEM_APPR_TYPE_SIMPLE_MODEL,AForward,iModel);
    if (AUseCustomValue)
    {
        iNewModel = ACustomValue;
    }
    object oNewItem = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL,-1,iNewModel);
    if (GetIsObjectValid(oNewItem))
    {
        SendMessageToPC(APC,"Model: " +IntToString(iNewModel));
        DelayCommand(0.1,AssignCommand(ANPC,ActionEquipItem(oNewItem,AItemSlot)));
        DestroyObject(oItem,0.2);
    }
}

void ProcessSimpleModelChange(object APC, object ANPC, int AItemSlot,int AForward,int AUseCustomValue, int ACustomValue)
{
    object oItem = GetItemInSlot(AItemSlot,ANPC);             //off-hand
    if (GetIsObjectValid(oItem)==FALSE) return;
    int iModel = GetItemAppearance(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, -1);
    int iNewModel = GetNextDirectionId(ITEM_APPR_TYPE_SIMPLE_MODEL,AForward,iModel);
    if (AUseCustomValue)
    {
        iNewModel = ACustomValue;
    }
    object oNewItem = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL,-1,iNewModel);
    if (GetIsObjectValid(oNewItem))
    {
        SendMessageToPC(APC,"Model: " +IntToString(iNewModel));
        DelayCommand(0.1,AssignCommand(ANPC,ActionEquipItem(oNewItem,AItemSlot)));
        DestroyObject(oItem,0.2);
    }
}

int GetNextDirectionId(int AType, int AForward, int ACurrent)
{
    int iCurrent = ACurrent;
    //if (AType==ITEM_APPR_TYPE_SIMPLE_MODEL)
    {
        if (AForward)
        {
            iCurrent = iCurrent +1;
        }
        else
        {
            iCurrent = iCurrent -1;
        }
        if (iCurrent > MAXMODEL)
        {
            iCurrent = 0;
        }
        if (iCurrent == 0)
        {
            iCurrent = MAXMODEL;
        }
    }
    return iCurrent;
}

void ProcessWeaponColor(object APC,object ANPC,int AItemSlot,int AForward,string ASubMode)
{
    object oItem = GetItemInSlot(AItemSlot,ANPC);             //off-hand
    if (GetIsObjectValid(oItem)==FALSE) return;
    int iPartConst = 0;
    if (ASubMode=="bottom")
    {
        iPartConst = ITEM_APPR_WEAPON_COLOR_BOTTOM;
    }
    else if (ASubMode=="middle")
    {
        iPartConst= ITEM_APPR_WEAPON_COLOR_MIDDLE;
    }
    else if (ASubMode=="top")
    {
        iPartConst= ITEM_APPR_WEAPON_COLOR_TOP;
    }
    else
    {
        return;
    }
    int iModel = GetItemAppearance(oItem, ITEM_APPR_TYPE_WEAPON_COLOR, iPartConst);
    int iNewModel = GetNextDirectionId(ITEM_APPR_TYPE_WEAPON_COLOR,AForward,iModel);
    object oNewItem = CopyItemAndModify(oItem,ITEM_APPR_TYPE_WEAPON_COLOR,iPartConst,iNewModel);
    if (GetIsObjectValid(oNewItem))
    {
        SendMessageToPC(APC,"Barva: " +IntToString(iNewModel));
        DelayCommand(0.1,AssignCommand(ANPC,ActionEquipItem(oNewItem,AItemSlot)));
        DestroyObject(oItem,0.2);
    }
}
void ProcessWeaponStyle(object APC,object ANPC,int AItemSlot,int AForward,string ASubMode)
{
    object oItem = GetItemInSlot(AItemSlot,ANPC);             //off-hand
    if (GetIsObjectValid(oItem)==FALSE) return;
    int iPartConst = 0;
    if (ASubMode=="bottom")
    {
        iPartConst = ITEM_APPR_WEAPON_MODEL_BOTTOM;
    }
    else if (ASubMode=="middle")
    {
        iPartConst= ITEM_APPR_WEAPON_MODEL_MIDDLE;
    }
    else if (ASubMode=="top")
    {
        iPartConst= ITEM_APPR_WEAPON_MODEL_TOP;
    }
    else
    {
        return;
    }
    int iModel = GetItemAppearance(oItem, ITEM_APPR_TYPE_WEAPON_MODEL, iPartConst);
    int iNewModel = GetNextDirectionId(ITEM_APPR_TYPE_WEAPON_MODEL,AForward,iModel);
    object oNewItem = CopyItemAndModify(oItem,ITEM_APPR_TYPE_WEAPON_MODEL,iPartConst,iNewModel);
    if (GetIsObjectValid(oNewItem))
    {
        SendMessageToPC(APC,"Model: " +IntToString(iNewModel));
        DelayCommand(0.1,AssignCommand(ANPC,ActionEquipItem(oNewItem,AItemSlot)));
        DestroyObject(oItem,0.2);
    }
}

void ProcessSimpleColor(object APC,object ANPC,int AItemSlot,int AForward,string ASubMode,int AUseCustomValue, int ACustomValue)
{
    object oItem = GetItemInSlot(AItemSlot,ANPC);             //off-hand
    if (GetIsObjectValid(oItem)==FALSE) return;
    int iPartConst = 0;
    if (ASubMode=="cloth1")
    {
        iPartConst = ITEM_APPR_ARMOR_COLOR_CLOTH1;
    }
    else if (ASubMode=="cloth2")
    {
        iPartConst= ITEM_APPR_ARMOR_COLOR_CLOTH2;
    }
    else if (ASubMode=="leather1")
    {
        iPartConst= ITEM_APPR_ARMOR_COLOR_LEATHER1;
    }
    else if (ASubMode=="leather2")
    {
        iPartConst= ITEM_APPR_ARMOR_COLOR_LEATHER2;
    }
    else if (ASubMode=="metal1")
    {
        iPartConst= ITEM_APPR_ARMOR_COLOR_METAL1;
    }
    else if (ASubMode=="metal2")
    {
        iPartConst= ITEM_APPR_ARMOR_COLOR_METAL2;
    }
    else
    {
        return;
    }
    int iModel = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_COLOR, iPartConst);
    int iNewModel = GetNextDirectionId(ITEM_APPR_TYPE_ARMOR_COLOR,AForward,iModel);
    if (AUseCustomValue)
    {
        iNewModel = ACustomValue;
    }
    object oNewItem = CopyItemAndModify(oItem,ITEM_APPR_TYPE_ARMOR_COLOR,iPartConst,iNewModel);
    if (GetIsObjectValid(oNewItem))
    {
        SendMessageToPC(APC,"Barva: " +IntToString(iNewModel));
        DelayCommand(0.1,AssignCommand(ANPC,ActionEquipItem(oNewItem,AItemSlot)));
        DestroyObject(oItem,0.2);
    }
}

void ProcessAmorModelChange(object APC,object ANPC,int AItemSlot,int AForward,string ASubMode,int AUseCustomValue, int ACustomValue)
{
    object oItem = GetItemInSlot(AItemSlot,ANPC);
    if (GetIsObjectValid(oItem)==FALSE) return;
    int iPartConst = -1;
    int iPartConst2 = -1;
    if (ASubMode=="leftbicep")             //leve predlokti
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LBICEP;
    }
    else if (ASubMode=="rightbicep")            //prave predlokti
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_RBICEP;
    }
    else if (ASubMode=="bothbicep")             //obe predlokti
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LBICEP;
        iPartConst2 = ITEM_APPR_ARMOR_MODEL_RBICEP;
    }
    else if (ASubMode=="leftfoot")             //leve chodidlo
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LFOOT;
    }
    else if (ASubMode=="rightfoot")           //prave chodidlo
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_RFOOT;
    }
    else if (ASubMode=="bothfoot")             //obe chodidla
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LFOOT;
        iPartConst2 = ITEM_APPR_ARMOR_MODEL_RFOOT;
    }
    else if (ASubMode=="leftforearm")         //leva paze
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LFOREARM;
    }
    else if (ASubMode=="rightforearm")       //prava paze
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_RFOREARM;
    }
    else if (ASubMode=="bothforearm")             //obe paze
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LFOREARM;
        iPartConst2 = ITEM_APPR_ARMOR_MODEL_RFOREARM;
    }
    else if (ASubMode=="lefthand")             //leva ruka
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LHAND;
    }
    else if (ASubMode=="righthand")           //prava ruka
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_RHAND;
    }
    else if (ASubMode=="bothhand")             //obe ruce
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LHAND;
        iPartConst2 = ITEM_APPR_ARMOR_MODEL_RHAND;
    }
    else if (ASubMode=="leftshin")           //leva holen
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LSHIN;
    }
    else if (ASubMode=="rightshin")         //prava holen
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_RSHIN;
    }
    else if (ASubMode=="bothshin")             //obe holene
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LSHIN;
        iPartConst2 = ITEM_APPR_ARMOR_MODEL_RSHIN;
    }
    else if (ASubMode=="leftshoulder")      //leve rameno
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LSHOULDER;
    }
    else if (ASubMode=="rightshoulder")          //prave rameno
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_RSHOULDER;
    }
    else if (ASubMode=="bothshoulder")             //obe ramena
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LSHOULDER;
        iPartConst2 = ITEM_APPR_ARMOR_MODEL_RSHOULDER;
    }
    else if (ASubMode=="leftthigh")             //leve stehno
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LTHIGH;
    }
    else if (ASubMode=="rightthigh")               //prave stehno
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_RTHIGH;
    }
    else if (ASubMode=="boththigh")             //obe stehna
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LTHIGH;
        iPartConst2 = ITEM_APPR_ARMOR_MODEL_RTHIGH;
    }
    else if (ASubMode=="belt")                   //opasek
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_BELT;
    }
    else if (ASubMode=="neck")                   //krk
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_NECK;
    }
    else if (ASubMode=="pelvis")                //panev
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_PELVIS;
    }
    else if (ASubMode=="robe")                 //roba
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_ROBE;
    }
    else if (ASubMode=="torso")               //torzo
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_TORSO;
    }
    else
    {
        return;
    }

    int iModel = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, iPartConst);
    int iNewModel = GetNextDirectionId(ITEM_APPR_TYPE_ARMOR_MODEL,AForward,iModel);
    if (AUseCustomValue)
    {
        iNewModel = ACustomValue;
    }
    if (iPartConst2 > 0)
    {
        NWNX_Item_SetItemAppearance(oItem,ITEM_APPR_TYPE_ARMOR_MODEL,iPartConst2,iNewModel);
    }
    object oNewItem = CopyItemAndModify(oItem,ITEM_APPR_TYPE_ARMOR_MODEL,iPartConst,iNewModel);
    if (GetIsObjectValid(oNewItem))
    {
        SendMessageToPC(APC,"Model: " +IntToString(iNewModel));
        DelayCommand(0.1,AssignCommand(ANPC,ActionEquipItem(oNewItem,AItemSlot)));
        DestroyObject(oItem,0.2);
    }

/*
    if (ASubMode=="robe")                 //roba
    {

    }
         */
}

void ProcessAmorModelChangePerPart(object APC,object ANPC,int AItemSlot,int AForward,string ASubMode, string ASubMode2, int AReset,int AUseCustomValue, int ACustomValue)
{
    object oItem = GetItemInSlot(AItemSlot,ANPC);
    if (GetIsObjectValid(oItem)==FALSE) return;
    int iPartConst = -1;
    int iPartConst2 = -1;
    if (ASubMode=="leftbicep")             //leve predlokti
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LBICEP;
    }
    else if (ASubMode=="rightbicep")            //prave predlokti
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_RBICEP;
    }
    else if (ASubMode=="bothbicep")             //obe predlokti
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LBICEP;
        iPartConst2 = ITEM_APPR_ARMOR_MODEL_RBICEP;
    }
    else if (ASubMode=="leftfoot")             //leve chodidlo
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LFOOT;
    }
    else if (ASubMode=="rightfoot")           //prave chodidlo
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_RFOOT;
    }
    else if (ASubMode=="bothfoot")             //obe chodidla
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LFOOT;
        iPartConst2 = ITEM_APPR_ARMOR_MODEL_RFOOT;
    }
    else if (ASubMode=="leftforearm")         //leva paze
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LFOREARM;
    }
    else if (ASubMode=="rightforearm")       //prava paze
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_RFOREARM;
    }
    else if (ASubMode=="bothforearm")             //obe paze
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LFOREARM;
        iPartConst2 = ITEM_APPR_ARMOR_MODEL_RFOREARM;
    }
    else if (ASubMode=="lefthand")             //leva ruka
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LHAND;
    }
    else if (ASubMode=="righthand")           //prava ruka
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_RHAND;
    }
    else if (ASubMode=="bothhand")             //obe ruce
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LHAND;
        iPartConst2 = ITEM_APPR_ARMOR_MODEL_RHAND;
    }
    else if (ASubMode=="leftshin")           //leva holen
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LSHIN;
    }
    else if (ASubMode=="rightshin")         //prava holen
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_RSHIN;
    }
    else if (ASubMode=="bothshin")             //obe holene
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LSHIN;
        iPartConst2 = ITEM_APPR_ARMOR_MODEL_RSHIN;
    }
    else if (ASubMode=="leftshoulder")      //leve rameno
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LSHOULDER;
    }
    else if (ASubMode=="rightshoulder")          //prave rameno
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_RSHOULDER;
    }
    else if (ASubMode=="bothshoulder")             //obe ramena
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LSHOULDER;
        iPartConst2 = ITEM_APPR_ARMOR_MODEL_RSHOULDER;
    }
    else if (ASubMode=="leftthigh")             //leve stehno
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LTHIGH;
    }
    else if (ASubMode=="rightthigh")               //prave stehno
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_RTHIGH;
    }
    else if (ASubMode=="boththigh")             //obe stehna
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_LTHIGH;
        iPartConst2 = ITEM_APPR_ARMOR_MODEL_RTHIGH;
    }
    else if (ASubMode=="belt")                   //opasek
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_BELT;
    }
    else if (ASubMode=="neck")                   //krk
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_NECK;
    }
    else if (ASubMode=="pelvis")                //panev
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_PELVIS;
    }
    else if (ASubMode=="robe")                 //roba
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_ROBE;
    }
    else if (ASubMode=="torso")               //torzo
    {
        iPartConst= ITEM_APPR_ARMOR_MODEL_TORSO;
    }
    else
    {
        return;
    }
    int iPartConstColor = 0;
    if (ASubMode2=="cloth1")
    {
        iPartConstColor = ITEM_APPR_ARMOR_COLOR_CLOTH1;
    }
    else if (ASubMode2=="cloth2")
    {
        iPartConstColor= ITEM_APPR_ARMOR_COLOR_CLOTH2;
    }
    else if (ASubMode2=="leather1")
    {
        iPartConstColor= ITEM_APPR_ARMOR_COLOR_LEATHER1;
    }
    else if (ASubMode2=="leather2")
    {
        iPartConstColor= ITEM_APPR_ARMOR_COLOR_LEATHER2;
    }
    else if (ASubMode2=="metal1")
    {
        iPartConstColor= ITEM_APPR_ARMOR_COLOR_METAL1;
    }
    else if (ASubMode2=="metal2")
    {
        iPartConstColor= ITEM_APPR_ARMOR_COLOR_METAL2;
    }
    else
    {
        return;
    }
    int iModel = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_COLOR, iPartConst);
    int iNewModel = 0;
    if (AReset)
    {
        iNewModel = 255;
    }
    else
    {
        iNewModel = GetNextDirectionId(ITEM_APPR_TYPE_ARMOR_COLOR,AForward,iModel);
        if (AUseCustomValue)
        {
            iNewModel = ACustomValue;
        }
    }
    int iIndex = 0;
    if (iPartConst2 > 0)
    {
        iIndex = ITEM_APPR_ARMOR_NUM_COLORS + (iPartConst2 * ITEM_APPR_ARMOR_NUM_COLORS) + iPartConstColor;
        NWNX_Item_SetItemAppearance(oItem,ITEM_APPR_TYPE_ARMOR_COLOR,iIndex,iNewModel);
    }
    iIndex = ITEM_APPR_ARMOR_NUM_COLORS + (iPartConst * ITEM_APPR_ARMOR_NUM_COLORS) + iPartConstColor;
    object oNewItem = CopyItemAndModify(oItem,ITEM_APPR_TYPE_ARMOR_COLOR,iIndex,iNewModel);
    if (GetIsObjectValid(oNewItem))
    {
        SendMessageToPC(APC,"Model: " +IntToString(iNewModel));
        DelayCommand(0.1,AssignCommand(ANPC,ActionEquipItem(oNewItem,AItemSlot)));
        DestroyObject(oItem,0.2);
    }
}
