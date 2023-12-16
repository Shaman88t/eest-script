#include "zep_inc_phenos"
#include "aps_include"

void main()
{
    ClearAllActions();

    object oPC = GetPCSpeaker();
    zep_Mount(oPC, OBJECT_SELF, 0, fDEFAULT_SPEED, "ja_kun_getdown");

    DeletePersistentVariable( oPC, "LOCATION", "pwhorses");
}
