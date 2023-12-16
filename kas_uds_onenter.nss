void main()
{

    object oCreature = GetEnteringObject();
    if( (GetIsPC(oCreature))  && (!GetLocalInt(OBJECT_SELF,"isShaker")) )
    {
        SetLocalInt(OBJECT_SELF, "iPCsIn", GetLocalInt(OBJECT_SELF, "iPCsIn") + 1);
        SignalEvent(OBJECT_SELF, EventUserDefined(701));
//        SendMessageToPC(GetFirstPC(),"signal sent");
    }
}
