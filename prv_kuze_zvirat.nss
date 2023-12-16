void main()
{
    object oPC = GetPCSpeaker();
    object oItem;

    if( GetIsObjectValid(oItem = GetItemPossessedBy(oPC, "kuze_zvirete") ) ) 1;
    else
    if( GetIsObjectValid(oItem = GetItemPossessedBy(oPC, "cnrSkinWhiteStag") ) ) 1;
    else
    if( GetIsObjectValid(oItem = GetItemPossessedBy(oPC, "cnrSkinBlkBear") ) ) 1;
    else
    if( GetIsObjectValid(oItem = GetItemPossessedBy(oPC, "cnrSkinGrizBear") ) ) 1;
    else
    if( GetIsObjectValid(oItem = GetItemPossessedBy(oPC, "cnrSkinJaguar") ) ) 1;
    else
    if( GetIsObjectValid(oItem = GetItemPossessedBy(oPC, "cnrSkinDeer") ) ) 1;
    else
    if( GetIsObjectValid(oItem = GetItemPossessedBy(oPC, "cnrSkinBadger") ) ) 1;
    else
    if( GetIsObjectValid(oItem = GetItemPossessedBy(oPC, "cnrSkinCragCat") ) ) 1;
    else
    if( GetIsObjectValid(oItem = GetItemPossessedBy(oPC, "cnrSkinPolarBear") ) ) 1;
    else
    if( GetIsObjectValid(oItem = GetItemPossessedBy(oPC, "cnrSkinLeopard") ) ) 1;
    else
    if( GetIsObjectValid(oItem = GetItemPossessedBy(oPC, "cnrSkinTiger") ) ) 1;
    else
    if( GetIsObjectValid(oItem = GetItemPossessedBy(oPC, "cnrSkinLion") ) ) 1;
    else
    if( GetIsObjectValid(oItem = GetItemPossessedBy(oPC, "cnrSkinMalar") ) ) 1;
    else
    if( GetIsObjectValid(oItem = GetItemPossessedBy(oPC, "cnrSkinBat") ) ) 1;
    else
    if( GetIsObjectValid(oItem = GetItemPossessedBy(oPC, "cnrSkinPanther") ) ) 1;
    else
    if( GetIsObjectValid(oItem = GetItemPossessedBy(oPC, "cnrSkinBoar") ) ) 1;
    else
    if( GetIsObjectValid(oItem = GetItemPossessedBy(oPC, "cnrSkinCougar") ) ) 1;
    else
    if( GetIsObjectValid(oItem = GetItemPossessedBy(oPC, "cnrSkinWolf") ) ) 1;
    else
    if( GetIsObjectValid(oItem = GetItemPossessedBy(oPC, "cnrSkinWorg") ) ) 1;
    else
    if( GetIsObjectValid(oItem = GetItemPossessedBy(oPC, "cnrSkinOx") ) ) 1;
    else
    if( GetIsObjectValid(oItem = GetItemPossessedBy(oPC, "cnrSkinWinWolf") ) ) 1;
    else return;

    DestroyObject(oItem);
    GiveGoldToCreature(oPC, 6);
}
