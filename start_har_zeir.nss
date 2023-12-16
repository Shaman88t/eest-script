#include "raiseinc"
#include "persistence"
#include "aps_include"

void main()
{
   object oPC = GetPCSpeaker();
   Raise(oPC);

   string sChram = "CHRAM_ZEIR_HAR";
   SetLocalString(oPC, "CHRAM", sChram);
   SetPersistentString( oPC, "CHRAM", sChram);
   if(Subrace_DMOnlyAllowed(oPC)) {
     return;
   }
   AssignCommand(oPC, JumpToObject(GetWaypointByTag(sChram)));
}


