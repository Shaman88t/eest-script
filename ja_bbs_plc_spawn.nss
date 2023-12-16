void main()
{
    if(!GetLocalInt(OBJECT_SELF, "JA_SPAWNED")){
        SetLocalInt(OBJECT_SELF, "JA_SPAWNED", 1);
        ExecuteScript("bbs_scribe_spawn", OBJECT_SELF);
    }

}
