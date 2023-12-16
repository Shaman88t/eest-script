#include "aps_include"

void main()
{
    object oPC = GetLocalObject(OBJECT_SELF, "JA_HORSE_PC");
    object oKiller = GetLastKiller();
    object oHorse = OBJECT_SELF;
    WriteTimestampedLogEntry(GetName(oPC)+"s horse "+GetName(oHorse)+" killed by "+GetName(oKiller)+" loc "+GetName(GetArea(oHorse)));

    DeleteLocalObject(oPC, "JA_HORSE_OBJECT");
    DeletePersistentVariable( oPC, "HORSE", "pwhorses" );
}
