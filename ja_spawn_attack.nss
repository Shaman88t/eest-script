void main()
{
    string sTarget = GetLocalString(OBJECT_SELF, "AI_SPAWN_ATTACK_TARGET");

    object oTarget = GetNearestObjectByTag(sTarget);

    ActionAttack(oTarget);
}
