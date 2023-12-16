#include "aps_include"

void main()
{
    object oPC = GetPCSpeaker();

    SetLocalObject(OBJECT_SELF, "JA_HORSE_PC", GetModule());

    DeleteLocalObject(oPC, "JA_HORSE_OBJECT");
    DeletePersistentVariable( oPC, "HORSE", "pwhorses" );
}
