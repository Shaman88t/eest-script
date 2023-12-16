void main()
{
object oTarget = GetPCSpeaker();
effect eDis = EffectDisease(DISEASE_BLINDING_SICKNESS);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDis, oTarget);
}
