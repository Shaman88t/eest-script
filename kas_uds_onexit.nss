void main()
{
    object oCreature = GetExitingObject();
    if(GetIsPC(oCreature))
    {
        SetLocalInt(OBJECT_SELF, "iPCsIn", GetLocalInt(OBJECT_SELF, "iPCsIn") - 1);
        SignalEvent(OBJECT_SELF, EventUserDefined(702));
    }
}
