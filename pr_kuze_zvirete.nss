int StartingConditional()
{
    int iResult = 0;

    object oPC = GetPCSpeaker();

    if( GetIsObjectValid(GetItemPossessedBy(oPC, "kuze_zvirete") ) ) iResult = 1;
    else
    if( GetIsObjectValid(GetItemPossessedBy(oPC, "cnrSkinWhiteStag") ) ) iResult = 1;
    else
    if( GetIsObjectValid(GetItemPossessedBy(oPC, "cnrSkinBlkBear") ) ) iResult = 1;
    else
    if( GetIsObjectValid(GetItemPossessedBy(oPC, "cnrSkinGrizBear") ) ) iResult = 1;
    else
    if( GetIsObjectValid(GetItemPossessedBy(oPC, "cnrSkinJaguar") ) ) iResult = 1;
    else
    if( GetIsObjectValid(GetItemPossessedBy(oPC, "cnrSkinDeer") ) ) iResult = 1;
    else
    if( GetIsObjectValid(GetItemPossessedBy(oPC, "cnrSkinBadger") ) ) iResult = 1;
    else
    if( GetIsObjectValid(GetItemPossessedBy(oPC, "cnrSkinCragCat") ) ) iResult = 1;
    else
    if( GetIsObjectValid(GetItemPossessedBy(oPC, "cnrSkinPolarBear") ) ) iResult = 1;
    else
    if( GetIsObjectValid(GetItemPossessedBy(oPC, "cnrSkinLeopard") ) ) iResult = 1;
    else
    if( GetIsObjectValid(GetItemPossessedBy(oPC, "cnrSkinTiger") ) ) iResult = 1;
    else
    if( GetIsObjectValid(GetItemPossessedBy(oPC, "cnrSkinLion") ) ) iResult = 1;
    else
    if( GetIsObjectValid(GetItemPossessedBy(oPC, "cnrSkinMalar") ) ) iResult = 1;
    else
    if( GetIsObjectValid(GetItemPossessedBy(oPC, "cnrSkinBat") ) ) iResult = 1;
    else
    if( GetIsObjectValid(GetItemPossessedBy(oPC, "cnrSkinPanther") ) ) iResult = 1;
    else
    if( GetIsObjectValid(GetItemPossessedBy(oPC, "cnrSkinBoar") ) ) iResult = 1;
    else
    if( GetIsObjectValid(GetItemPossessedBy(oPC, "cnrSkinCougar") ) ) iResult = 1;
    else
    if( GetIsObjectValid(GetItemPossessedBy(oPC, "cnrSkinWolf") ) ) iResult = 1;
    else
    if( GetIsObjectValid(GetItemPossessedBy(oPC, "cnrSkinWorg") ) ) iResult = 1;
    else
    if( GetIsObjectValid(GetItemPossessedBy(oPC, "cnrSkinOx") ) ) iResult = 1;
    else
    if( GetIsObjectValid(GetItemPossessedBy(oPC, "cnrSkinWinWolf") ) ) iResult = 1;



    return iResult;
}
