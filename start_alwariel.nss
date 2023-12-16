#include "raiseinc"
#include "persistence"
#include "aps_include"

void main()
{
   object oPC = GetPCSpeaker();
   Raise(oPC);

   string sChram = "CHRAM_LOTHIAN_ALWARIEL";
   SetLocalString(oPC, "CHRAM", sChram);
   SetPersistentString( oPC, "CHRAM", sChram);
   if(Subrace_DMOnlyAllowed(oPC)) {
     return;
   }
   AssignCommand(oPC, JumpToObject(GetWaypointByTag("START_ALWARIEL")));
}

