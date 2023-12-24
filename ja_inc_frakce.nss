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

