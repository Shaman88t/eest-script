int StartingConditional()
{
    int iResult;
    string sText = GetLocalString(GetLocalObject(OBJECT_SELF, "notes_currentobject"), "notes_text");
    iResult = (sText != "");
    return iResult;
}
