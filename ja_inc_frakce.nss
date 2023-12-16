/*
 * rev. Kucik 06.01.2008 funkce pro zjisteni frakce
 */

#include "ja_lib"
#include "subraces"

// Get penguin member of this faction
object GetFactionMember(string sFaction);

// Override faction if variable FACTION_OVERRIDE is set on OBJECT SELF
// or on Area.
int OverrideFaction(object oNPC);

void SetFactionReputation(object oPC, object oFirst, int reputation){

   object oMember = GetFirstFactionMember(oFirst, FALSE);
   while (GetIsObjectValid(oMember))
   {
       int now = GetReputation(oPC, oMember);
       SendMessageToPC(oPC, "Adjusting " +GetName(oMember)+" to "+IntToString(reputation));
       AdjustReputation(oPC, oMember, reputation-now);

       oMember = GetNextFactionMember(oFirst, FALSE);
   }
}

/*
void setFactionsToPC(object oPC, int frakce){
   //SendMessageToPC(oPC, "Prave updatuji tvoje frakce");

   SetLocalInt(GetSoulStone(oPC),"KU_SPEC_FACTIONS",frakce);
   string col;

   switch(frakce){
       case 0: col = "Povrch"; break;
       case 1: col = "Podtemnan"; break;
       case 2: col = "Pritel"; break;
       case 3: col = "Otrok"; break;
       default: return;
   }

   int i;
   for( i = 0; i <= 30 ; i++ ){ //nastav frakce
       string sMember = Get2DAString("factions", "FactionMember", i);
       int reputation = StringToInt(Get2DAString("factions", col, i));
       object oMember = GetObjectByTag(sMember);

       SendMessageToPC(oPC, sMember+ ": "+IntToString(reputation)+" Object: "+ ObjectToString(oMember));
       SetFactionReputation(oPC, oMember, reputation);
   }
}
*/

void setFactionsToPC(object oPC, int frakce){
   //SendMessageToPC(oPC, "Prave updatuji tvoje frakce");

   SetLocalInt(GetSoulStone(oPC),"KU_SPEC_FACTIONS",frakce);
   string col;
   object oMod = GetModule();

   switch(frakce){
       case 0: col = "Povrch"; break;
       case 1: col = "Podtemnan"; break;
       case 2: col = "Pritel"; break;
       case 3: col = "Otrok"; break;
       default: return;
   }

   int i=1;
   int row=0;
   int reputation = 100;
   string cachename;
   object oNullFaction = GetLocalObject(OBJECT_SELF,"KU_FACTION_NULLFACTION_NPC");
   if(!GetIsObjectValid(oNullFaction)) {
     oNullFaction = GetObjectByTag("ku_faction_null_creature");
     SetLocalObject(OBJECT_SELF,"KU_FACTION_NULLFACTION_NPC",oNullFaction);
   }
   object oNPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_NOT_PC,oPC,i);
   while(GetIsObjectValid(oNPC)) {
//     SendMessageToPC(oPC,GetName(oNPC));
     row = GetReputation(oNullFaction,oNPC);

     // Ted zjistime, jestli mame frakci cachenutou, nebo ji musime tahat z .2da
     cachename = "KU_FACTIONCACHE_"+ col +"x"+IntToString(row);
     reputation = GetLocalInt(oMod,cachename);
     if(reputation==0) {
       reputation = StringToInt(Get2DAString("factions", col, row));
       SetLocalInt(oMod,cachename,reputation+1);
//       SendMessageToPC(oPC,"cached:"+cachename);
     }
     else
       reputation--;

     ClearPersonalReputation(oPC,oNPC);
     AdjustReputation(oPC, oNPC, reputation - 50);
//     AdjustReputation(oNPC, oPC, reputation);
//     SetFactionReputation(oPC, oNPC, reputation);
//     SendMessageToPC(oPC,"string="+Get2DAString("factions", "FactionMember", row)+"; row="+IntToString(row)+" reputation = "+IntToString(reputation));
     i++;
     oNPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_NOT_PC,oPC,i);

   }
}

int getFaction(object oPC){
   int iFaction = GetLocalInt(GetSoulStone(oPC),"KU_SPEC_FACTIONS");

   // To je pekne na picu, zes dal pevninanovi frakci 0. Ted nepoznam,
   // jestli je to pevninan, nebo se frakce ztratila
   // Takze ted, pokud nevim o tom ze by byl otrok nebo pritel, urcim frakci podle subrasy
   if(iFaction < 1) {
     // Vypada to sice divne, ale hodnoty frakci a podtemno/povrch spolu koresponduji
     iFaction = Subraces_GetIsCharacterFromUnderdark(oPC );
   }
   return iFaction;
}

void updateAllPCs(){
   object oPC = GetFirstPC();

   while(GetIsObjectValid(oPC)){

       if(!GetIsDM(oPC))
           setFactionsToPC(oPC, getFaction(oPC));

       oPC = GetNextPC();
   }

}


object GetFactionMember(string sFaction) {
  object oMod = GetModule();

  string sFac = "FACTION_"+sFaction;
  object oFac = GetLocalObject(oMod,sFac);
  if(GetIsObjectValid(oFac)) {
    return oFac;
  }

  oFac = GetObjectByTag(sFac);
  if(GetIsObjectValid(oFac)) {
    SetLocalObject(oMod,sFac,oFac);
    return oFac;
  }

  return OBJECT_INVALID;

}

int OverrideFaction(object oNPC) {
  string sFac = GetLocalString(OBJECT_SELF,"FACTION_OVERRIDE");
  if(GetStringLength(sFac) == 0) {
    sFac = GetLocalString(GetArea(OBJECT_SELF),"FACTION_OVERRIDE");
  }
  if(GetStringLength(sFac) == 0) {
    return FALSE;
  }

  object oFaction = GetFactionMember(sFac);
  if(GetIsObjectValid(oFaction)) {
      ChangeFaction(oNPC,oFaction);
      return TRUE;
  }

  return FALSE;
}
