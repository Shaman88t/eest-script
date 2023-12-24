void main()
{
    string sMainType = GetScriptParam("MAIN_TYPE");
    if (sMainType != "")
    {
        SetLocalString(OBJECT_SELF,"MAIN_TYPE",sMainType);
    }
    string sMode     = GetScriptParam("MODE");
    if (sMode != "")
    {
        SetLocalString(OBJECT_SELF,"MODE",sMode);
    }
    string sSubMode = GetScriptParam("SUB_MODE");
    if (sSubMode != "")
    {
        SetLocalString(OBJECT_SELF,"SUB_MODE",sSubMode);
    }
    string sSubMode2 = GetScriptParam("SUB_MODE2");
    if (sSubMode2 != "")
    {
        SetLocalString(OBJECT_SELF,"SUB_MODE2",sSubMode2);
    }
}
