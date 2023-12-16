//zaznamenam vysledky strelby

int ZistiSancu(int iPoz,object oPC,int iSancaCelkova)
{
    int iSanca = 0;
    switch (GetClassByPosition(iPoz,oPC)) {
        //najlepsi
        case CLASS_TYPE_ARCANE_ARCHER:  iSanca+=5;break;
        case CLASS_TYPE_RANGER:         iSanca+=4;break;
        case CLASS_TYPE_ROGUE:          iSanca+=4;break;
        //dobry
        case CLASS_TYPE_ASSASSIN:       iSanca+=1;break;
        case CLASS_TYPE_BARBARIAN:      iSanca+=2;break;
        case CLASS_TYPE_BARD:           iSanca+=2;break;
        case CLASS_TYPE_BLACKGUARD:     iSanca+=2;break;
        case CLASS_TYPE_CLERIC:         iSanca+=2;break;
        case CLASS_TYPE_DRUID:          iSanca+=2;break;
        case CLASS_TYPE_DWARVENDEFENDER:iSanca+=1;break;
        case CLASS_TYPE_FIGHTER:        iSanca+=2;break;
        case CLASS_TYPE_HARPER:         iSanca+=2;break;
        case CLASS_TYPE_MONK:           iSanca+=1;break;
        case CLASS_TYPE_PALADIN:        iSanca+=2;break;
        case CLASS_TYPE_WEAPON_MASTER:  iSanca+=2;break;
        //smejdi
        case CLASS_TYPE_PALE_MASTER:    iSanca+=1;break;
        case CLASS_TYPE_SHADOWDANCER:   iSanca+=1;break;
        case CLASS_TYPE_SHIFTER:        iSanca+=0;break;
        case CLASS_TYPE_WIZARD:         iSanca+=1;break;
        case CLASS_TYPE_SORCERER:       iSanca+=1;break;
    }

    int iLevel = GetLevelByPosition(iPoz,oPC);
    iSanca = iSancaCelkova + iSanca*iLevel;
    return iSanca;
}

void main()
{
    int    iBodov   = GetLocalInt(OBJECT_SELF,"sy_bodov");
    int    iPokusov = GetLocalInt(OBJECT_SELF,"sy_pokusov");
    string sStrelec = GetLocalString(OBJECT_SELF,"sy_strelec");
    object oPC      = GetLastAttacker(OBJECT_SELF);
    string sMeno    = GetName(oPC,TRUE);
    object oItem    = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);

    //zakladne testy ci ma povolene strielat, ci ma municiu atd
    if (oItem==OBJECT_INVALID) return;      //ak buchal rukami a nohami
    if (!GetWeaponRanged(oItem)) return;    //ak nemal luk/kusu

    //zistim typ zbrane a podla toho zistim typ sipov co pouziva
    object oSip;
    if ((GetBaseItemType(oItem)==BASE_ITEM_SHORTBOW) || (GetBaseItemType(oItem)==BASE_ITEM_LONGBOW)) {
        oSip = GetItemInSlot(INVENTORY_SLOT_ARROWS,oPC);    //pre luky
    } else
    {
        oSip = GetItemInSlot(INVENTORY_SLOT_BOLTS,oPC);     //pre kuse
    }

    //ak nepouziva sutazne sipy oznamim to
    if ((GetTag(oSip)!="sy_sutazny_sip") && GetTag(oSip)!="sy_sutazny_bolt") {
        SendMessageToPC(oPC,"Na terc muzes strilet pouze Sutazne sipy!");
        return;
    }

    //zaznacim si na terc kto striela
    if (sStrelec=="nikto") {
        SetLocalString(OBJECT_SELF,"sy_strelec",sMeno);
        sStrelec = sMeno;
    }

    //ak terc uz ma ineho strelca oznamim to
    if (sMeno!=sStrelec) {
        FloatingTextStringOnCreature("Neni to tvuj terc!",oPC);
        return;
    }

    //najhorsia cast, zistit AB luku/kuse
    int iItemAB = 0;
    if (GetItemHasItemProperty(oItem,ITEM_PROPERTY_ATTACK_BONUS)) {
        itemproperty iProp = GetFirstItemProperty(oItem);
        while (GetIsItemPropertyValid(iProp)) {
            if (GetItemPropertyType(iProp)==ITEM_PROPERTY_ATTACK_BONUS) break;
            iProp = GetNextItemProperty(oItem);
        }
        iItemAB = GetItemPropertyCostTableValue(iProp);
    }

    //zistim modifikatory dex a wis
    int iPCDex  = GetAbilityModifier(ABILITY_DEXTERITY,oPC);
    //int iPCWis  = GetAbilityModifier(ABILITY_WISDOM,oPC);

    //ak ma feat ZEN ARCHERY a mod. wis je vacsi nez mod. dex
    //tak sa upravi BAB pomocou mod. wis
    //je to blud TODO - wisdom nesuvisi s presnostou ako dex
    //if ((GetHasFeat(FEAT_ZEN_ARCHERY,oPC)) && (iPCWis>iPCDex)) {
    //    iPCDex = iPCWis;
    //}
    int iBAB    = iPCDex + iItemAB + GetBaseAttackBonus(oPC);

    /*vyratam ci terc trafil a kde ho trafil
    //rata sa vonkajsi okruh 10 bodov
    //vnutorny okruh 50 bodov
    //stred 100 bodov
    //sanca ze trafi terc zavisi do lvl, povolania a AB hraca
    //vyrata sa kde trafil sip
        2 hody :
        1 - ci trafil terc,suvisi s BAB
        2 - kam ho trafil, 3 polia, suvisi s povolanim a lvl postavy
    */
    /*
    int iDamage = d20() + iBAB;
    SendMessageToPC(oPC,"iDamage="+IntToString(iDamage));
    iDamage = FloatToInt(IntToFloat(iDamage)/2.85);
    int iBod = 0;
    iBod = iDamage * 10;
    if (iDamage<2) iBod = 0;
    if (iDamage>7) iBod = 100;
    SpeakString("AB=" + IntToString(GetBaseAttackBonus(oPC)) + " MOD=" + IntToString(iPCDex) + " itemAB=" + IntToString(iItemAB) + "Trefil si terc za "+IntToString(iBod)+" bodu.",TALKVOLUME_TALK);
    */

    int iSanca = ZistiSancu(1,oPC,iSanca);
    iSanca     = ZistiSancu(2,oPC,iSanca);
    iSanca     = iSanca + d20() + iBAB;
    if (iSanca>95) iSanca = 95; //maximum
    if (iSanca<10) iSanca = 10; //minimum
    SendMessageToPC(oPC,IntToString(iSanca));
    int iD100Hod = d100();
    if (iD100Hod > iSanca) {
        FloatingTextStringOnCreature("Netrafil si",oPC);
        return;
    } else
    {
        FloatingTextStringOnCreature("Trafil si",oPC);
    }

    //body zistim tak ze porovnam ako blizko som bol pri hode
    //d100 a iSanca
    int iBod = 10;                      //vonkajsi kruh
    int iKam = (iSanca - iD100Hod)/30;  //rozdiel v hode
    if (iKam==1) iBod = 100;            //stred
    if (iKam==2) iBod = 50;             //vnutorny
    SpeakString(IntToString(iBod)+" bodov",TALKVOLUME_TALK);

    //zaznacim body na terc a pocet zasahov
    iBodov = iBodov + iBod;
    SetLocalInt(OBJECT_SELF,"sy_bodov",iBodov);
    iPokusov--;
    SetLocalInt(OBJECT_SELF,"sy_pokusov",iPokusov);
}
