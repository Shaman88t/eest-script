#include "subraces"

void main()
{
  object oTarget = GetEnteringObject();
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
