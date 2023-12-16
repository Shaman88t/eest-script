void main()
{
    effect eDam = EffectDamage( 50 );

    ApplyEffectToObject( DURATION_TYPE_INSTANT, eDam, OBJECT_SELF );
}
