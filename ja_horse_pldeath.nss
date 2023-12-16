#include "aps_include"
#include "zep_inc_phenos"
#include "nwnx_creature"

void main()
{
    object oPC = OBJECT_SELF;
    object oHorse = GetLocalObject(oPC, "JA_HORSE_OBJECT");
    int bMounted = FALSE;
    if(GetIsObjectValid(GetItemPossessedBy(oPC,"ja_kun_getdown"))) {
      bMounted = TRUE;
    }

    zep_Dismount(oPC, "ja_kun_getdown");

    if(bMounted) {
      if(GetIsObjectValid(oHorse)) {
        NWNX_Creature_JumpToLimbo(oHorse);
      }
      WriteTimestampedLogEntry("Horse "+GetName(oHorse)+" died with player "+GetName(oPC));
      DeleteLocalObject(oPC, "JA_HORSE_OBJECT");
      DeletePersistentVariable( oPC, "HORSE", "pwhorses" );
    }
}
