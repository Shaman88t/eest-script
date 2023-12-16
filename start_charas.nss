#include "raiseinc"
#include "persistence"
#include "aps_include"

void main()
{
   object oPC = GetPCSpeaker();
   Raise(oPC);
   string sChram;
   if(GetDeity(oPC) == "Zeir")
     sChram = "CHRAM_ZEIR_CHARAS";
   else
     sChram = "CHRAM_XIAN_CHARAS";
   SetLocalString(oPC, "CHRAM", sChram);
   SetPersistentString( oPC, "CHRAM", sChram);
   if(Subrace_DMOnlyAllowed(oPC)) {
     return;
   }
   AssignCommand(oPC, JumpToObject(GetWaypointByTag(sChram)));
}


