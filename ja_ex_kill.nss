#include "raiseinc"
void main()
{
    object oPC = GetLastUsedBy();

    effect eKill = EffectDamage(10000);

    ApplyEffectToObject( DURATION_TYPE_INSTANT, eKill, oPC );

    DelayCommand(5.0, Raise(oPC));
}

