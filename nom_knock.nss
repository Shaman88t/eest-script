void main()
{
object oTarget = GetPCSpeaker();
effect eKno = EffectKnockdown();






ApplyEffectToObject(DURATION_TYPE_INSTANT, eKno, oTarget);

}

