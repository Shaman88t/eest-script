#include "aps_include"

void main()
{
    object oPC = GetPCSpeaker();
    int iPrice = GetLocalInt(OBJECT_SELF, "JA_HORSE_PRICE");

    object oHorse = GetLocalObject(oPC, "JA_HORSE_OBJECT");

    if(GetIsObjectValid(oHorse)){
        SpeakString("*uz jednoho kone mas*");
        return;
    }

    if(GetGold(oPC) >= iPrice){
        TakeGoldFromCreature(iPrice, oPC, TRUE);
        SetLocalObject(OBJECT_SELF, "JA_HORSE_PC", oPC);
        SetLocalObject(oPC, "JA_HORSE_OBJECT", OBJECT_SELF);
        SetPersistentString( oPC, "HORSE", GetResRef(OBJECT_SELF), 0, "pwhorses" );
    }
    else{
        SpeakString("*tohoto kone si nemuzes dovolit*");
    }
}
