#include "aps_include"
#include "zep_inc_phenos"

void main()
{
    object oPC = GetPCSpeaker();
    object oHorse = GetLocalObject(oPC, "JA_HORSE_OBJECT");

    zep_Dismount(oPC, "ja_kun_getdown");

    SetLocalObject(oHorse, "JA_HORSE_PC", OBJECT_INVALID);

    DeleteLocalObject(oPC, "JA_HORSE_OBJECT");
    DeletePersistentVariable( oPC, "HORSE", "pwhorses" );

    GiveGoldToCreature(oPC, GetLocalInt(oHorse, "JA_HORSE_PRICE")/2);
}
