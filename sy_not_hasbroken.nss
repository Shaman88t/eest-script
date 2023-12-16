int StartingConditional()
{
    int iResult;
    string sText = GetLocalString(GetLocalObject(OBJECT_SELF, "notes_currentobject"), "notes_seal");
    iResult = (sText == "broken");
    return iResult;
}
