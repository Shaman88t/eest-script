// the familiar heals itself fully (no effects)
void main()
{
    object oPlayer = GetMaster();
    SendMessageToPC(oPlayer, "Feeding familiars is forbidden");
    /*
    int nHeal = GetMaxHitPoints();
    effect eHeal = EffectHeal(nHeal);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,OBJECT_SELF);
    */
}
