//::///////////////////////////////////////////////
//:: Find Traps
//:: NW_S0_FindTrap
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Finds and removes all traps within 30m.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 29, 2001
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"

void DisableTrap(object oTrap, int iLvl, effect eVis){
  if( (5 + iLvl + d20(1)) >= GetTrapDisarmDC(oTrap) ){
     ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTrap));
     DelayCommand(2.0, SetTrapDisabled(oTrap));
  }
}

int DetectTrap(object oTrap, object oCaster){
  if( (10+GetCasterLevel(oCaster) + d20(1)) >= GetTrapDetectDC(oTrap) ){
     SetTrapDetectedBy(oTrap, oCaster);
     return TRUE;
  }
  else return FALSE;

}

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    effect eVis = EffectVisualEffect(VFX_IMP_KNOCK);
    int nCnt = 1;
    object oCaster = OBJECT_SELF;
    int iLvl = GetCasterLevel(oCaster);
    object oTrap = GetNearestObject(OBJECT_TYPE_TRIGGER | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nCnt);
    while(GetIsObjectValid(oTrap) && GetDistanceToObject(oTrap) <= 30.0)
    {
        if(GetIsTrapped(oTrap))
        {
            if( !GetTrapDetectedBy(oTrap, oCaster) ){
                if( DetectTrap(oTrap, oCaster) ){
                    DisableTrap(oTrap, iLvl, eVis);
                }
            }
            else DisableTrap(oTrap, iLvl, eVis);

        }
        nCnt++;
        oTrap = GetNearestObject(OBJECT_TYPE_TRIGGER | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nCnt);
    }
}

