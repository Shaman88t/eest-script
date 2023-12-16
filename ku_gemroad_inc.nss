#include "subraces"

const int KU_PILGRIM_MAX_SETUP_TIME = 300;
const int DEBUG = FALSE;
const float KU_GEMROAD_ACTIVE_TIME = 60.0;

void ku_gemroadGetTarget(object oPortal);

void ku_gemroadAim(object oPortal, object oPC, int countdown);

void ku_gemroad_disturbed();

void ku_gemroadJump(object oPortal, object oPC);

void __dispell(object oTarget);

object ku_gemroadGetHolder() {
  object oModule = GetModule();
  object oHolder = GetLocalObject(oModule,"KU_GEMROAD_HOLDER");
  if(GetIsObjectValid(oHolder))
    return oHolder;

  oHolder = GetObjectByTag("ku_gemroad_holder");
  if(!GetIsObjectValid(oHolder)) {
   WriteTimestampedLogEntry("ERROR! Cannot get gemroad holder!");
   return OBJECT_INVALID;
  }
  SetLocalObject(oModule,"KU_GEMROAD_HOLDER",oHolder);

  /* Set gems */
  SetLocalString(oHolder,"KU_GEMROAD_GEM_1","ku_gem_024");
  SetLocalString(oHolder,"KU_GEMROAD_GEM_2","ku_gem_035");
  SetLocalString(oHolder,"KU_GEMROAD_GEM_3","ku_gem_010");
  SetLocalInt(oHolder,"KU_GEMROAD_"+"ku_gem_024",1);
  SetLocalInt(oHolder,"KU_GEMROAD_"+"ku_gem_035",2);
  SetLocalInt(oHolder,"KU_GEMROAD_"+"ku_gem_010",3);

  return oHolder;

}

void ku_gemroad_add(object oWaypoint) {
  object oHolder = ku_gemroadGetHolder();
  int iRoad = GetLocalInt(oWaypoint,"KU_GEMROAD");
  int iWeight = GetLocalInt(oWaypoint,"KU_GEMROAD_WEIGHT");
  int iLocType = GetLocalInt(GetArea(oWaypoint),"JA_LOC_TYPE");
  if(iLocType == 0)
    iLocType = 1;
  string sLocType = IntToString(iLocType);
  string sRoad = IntToString(iRoad);

  if(iWeight == 0)
    iWeight = 10;

  int iWaipoints = GetLocalInt(oHolder, "KU_GEMROADS_NUM_"+sRoad+"_"+sLocType) + 1;
  SetLocalInt(oHolder, "KU_GEMROADS_NUM_"+sRoad+"_"+sLocType, iWaipoints);
  SetLocalInt(oHolder, "KU_GEMROADS_NUM_"+sRoad+"_"+sLocType+"_WEIGHT", GetLocalInt(oHolder, "KU_GEMROADS_NUM_"+sRoad+"_"+sLocType+"_WEIGHT") + iWeight);
  SetLocalInt(oHolder, "KU_GEMROADS_WEIGHT_"+sRoad+"_"+sLocType+"_"+IntToString(iWaipoints), iWeight);
  SetLocalLocation(oHolder,"KU_GEMROADS_"+sRoad+"_"+sLocType+"_"+IntToString(iWaipoints), GetLocation(oWaypoint));

  if(DEBUG) {
    SpeakString("Initialized road #"+sRoad+"/"+sLocType+" #"+IntToString(iWaipoints)+"; TotalWeight="+IntToString(GetLocalInt(oHolder, "KU_GEMROADS_NUM_"+sRoad+"_"+sLocType+"_WEIGHT")));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_BEAM_EVIL), GetLocation(oWaypoint), 1.0);
  }

  DestroyObject(oWaypoint, 2.0);
}

void ku_gemroad_activate(object oPortal) {
  string sResref = "ku_gemvfx_"+IntToString(GetLocalInt(oPortal,"KU_GEMROAD"));

  object oVisual = CreateObject(OBJECT_TYPE_PLACEABLE, sResref, GetLocation(oPortal));
  DestroyObject(oVisual, KU_GEMROAD_ACTIVE_TIME);
  SetLocked(oPortal, TRUE);
  DelayCommand(KU_GEMROAD_ACTIVE_TIME, SetLocked(oPortal, FALSE));
  DelayCommand(KU_GEMROAD_ACTIVE_TIME, DeleteLocalInt(oPortal, "KU_GEMROAD_ACTIVATED"));
}

void ku_gemroad_disturbed() {
  object oPortal = OBJECT_SELF;
  object oItem = GetInventoryDisturbItem();
  object oPC = GetLastDisturbed();
  if( GetInventoryDisturbType() != INVENTORY_DISTURB_TYPE_ADDED )
    return;

  object oHolder = ku_gemroadGetHolder();
  int iRoad = GetLocalInt(oPortal,"KU_GEMROAD");
  string sRoad = IntToString(iRoad);
 /* if(GetTag(oItem) != GetLocalString(oHolder,"KU_GEMROAD_GEM_"+sRoad))
    return;
    */
  int iStone = GetLocalInt(oHolder,"KU_GEMROAD_"+GetTag(oItem));
  if(iStone <= 0)
    return;

  SetLocalInt(oPortal, "KU_GEMROAD_ACTIVATED",iStone);

  DestroyObject(oItem,0.5);

  ku_gemroad_activate(oPortal);
  AssignCommand(oPC, ActionInteractObject(oPortal));

  DelayCommand(0.5, ku_gemroadGetTarget(oPortal));
}

void ku_gemroadGetTarget(object oPortal) {
  if(!GetLocked(oPortal))
    return;

  if(GetIsObjectValid(GetLocalObject(oPortal,"KU_GEMROAD_AIM"))) {
    DelayCommand(2.0, ku_gemroadGetTarget(oPortal));
    return;
  }

  object oPC = GetNearestObject(OBJECT_TYPE_CREATURE, oPortal);

  if(GetIsObjectValid(oPC) && GetDistanceBetween(oPortal, oPC) < 2.0) {
    SetLocalObject(oPortal,"KU_GEMROAD_AIM", oPC);
    ku_gemroadAim(oPortal, oPC, 5);

  }

  DelayCommand(2.0, ku_gemroadGetTarget(oPortal));
}

void ku_gemroadAim(object oPortal, object oPC, int countdown) {
  if(!GetLocked(oPortal)) {
    DeleteLocalObject(oPortal, "KU_GEMROAD_AIM");
    return;
  }

  if(!GetIsObjectValid(oPC)) {
    DeleteLocalObject(oPortal, "KU_GEMROAD_AIM");
    return;
  }

  if(GetDistanceBetween(oPortal, oPC) > 3.0) {
    DeleteLocalObject(oPortal, "KU_GEMROAD_AIM");
    return;
  }
  countdown--;
  if(countdown == 0) {
    effect eVfx = EffectVisualEffect(472);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVfx, oPC);
    DelayCommand(1.5, ku_gemroadJump(oPortal, oPC));
  }
  else {
    if(DEBUG)
      SpeakString("Aiming "+GetName(oPC));

    effect eBeamVfx = EffectBeam(312 - countdown, oPortal, BODY_NODE_CHEST);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamVfx, oPC, 2.0);
    DelayCommand(1.0, ku_gemroadAim(oPortal, oPC, countdown));
  }
}

void ku_gemroadJump(object oPortal, object oPC) {
  object oHolder = ku_gemroadGetHolder();
//  int iRoad = GetLocalInt(oPortal,"KU_GEMROAD");
  int iRoad = GetLocalInt(oPortal, "KU_GEMROAD_ACTIVATED");
  int iLocType = GetLocalInt(GetArea(oPortal),"JA_LOC_TYPE");

  __dispell(oPC);

  if(iLocType == 0)
    iLocType = 1;

  /* Switch LocType */
  iLocType = 3 - iLocType;

  string sLocType = IntToString(iLocType);
  string sRoad = IntToString(iRoad);

  int iWeight = GetLocalInt(oHolder, "KU_GEMROADS_NUM_"+sRoad+"_"+sLocType+"_WEIGHT");
  int iRand = Random(iWeight);
  int iWaypoints =GetLocalInt(oHolder, "KU_GEMROADS_NUM_"+sRoad+"_"+sLocType);

  if(DEBUG)
    SpeakString("Random("+IntToString(iWeight)+")="+IntToString(iRand)+" going through "+IntToString(iWaypoints)+" waypoints");

  int i = 1;
  while(i <= iWaypoints) {
    iWeight = GetLocalInt(oHolder, "KU_GEMROADS_WEIGHT_"+sRoad+"_"+sLocType+"_"+IntToString(i));
    if(DEBUG)
      SpeakString("#"+IntToString(i)+" Compare "+IntToString(iRand)+" < "+IntToString(iWeight));

    if(iRand < iWeight) {
      if(DEBUG)
        SpeakString("Jump to #"+IntToString(i));

      AssignCommand(oPC, JumpToLocation( GetLocalLocation(oHolder,"KU_GEMROADS_"+sRoad+"_"+sLocType+"_"+IntToString(i))));
      DeleteLocalObject(oPortal, "KU_GEMROAD_AIM");
      return;
    }
    iRand = iRand - iWeight;
    i++;
  }

}

void __dispell(object oTarget)
{
//  object oTarget = GetEnteringObject();
  effect eff = EffectDispelMagicAll(40);

    int nType;
    int bValid = FALSE;
    effect eParal = GetFirstEffect(oTarget);
    effect eVis = EffectVisualEffect(VFX_IMP_REMOVE_CONDITION);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_REMOVE_DISEASE, FALSE));
    //Get the first effect on the target
    while(GetIsEffectValid(eParal))
    {
        //Check if the current effect is of correct type
        int effType = GetEffectType(eParal);
        int bRemove = FALSE;
        switch(effType) {
          case EFFECT_TYPE_ABILITY_INCREASE:
          case EFFECT_TYPE_AC_INCREASE:
          case EFFECT_TYPE_ATTACK_INCREASE:
          case EFFECT_TYPE_CONCEALMENT:
          case EFFECT_TYPE_DAMAGE_IMMUNITY_INCREASE:
          case EFFECT_TYPE_DAMAGE_REDUCTION:
          case EFFECT_TYPE_DAMAGE_RESISTANCE:
          case EFFECT_TYPE_ELEMENTALSHIELD:
          case EFFECT_TYPE_ETHEREAL:
          case EFFECT_TYPE_HASTE:
          case EFFECT_TYPE_IMPROVEDINVISIBILITY:
          case EFFECT_TYPE_INVISIBILITY:
          case EFFECT_TYPE_POLYMORPH:
          case EFFECT_TYPE_SANCTUARY:
            bRemove = TRUE;
            break;
          default:
            bRemove = FALSE;
            break;
        }

        if (bRemove)
        {
            // podminka pro subrasy
            if( (Subraces_GetIsSubraceEffect(eParal) == FALSE) ) {
              //Remove the effect
              RemoveEffect(oTarget, eParal);
              bValid = TRUE;
            }
        }
        //Get the next effect on the target
        eParal = GetNextEffect(oTarget);
    }
    if (bValid)
    {
        //Apply VFX Impact
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    }

}
