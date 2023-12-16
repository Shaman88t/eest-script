void main()
{
    object oPC = GetPCSpeaker();
    object oNote = GetLocalObject(oPC, "notes_currentobject");
    string sText = GetLocalString(oNote, "notes_text");
    string sTag = GetTag(oNote);

    if (sTag == "notes_document")
    {
        sText = "Na dokumente je napisane: " + sText;
    }
    else if (sTag == "notes_letter")
    {
        sText = "Na dopise je napisane: " + sText;
    }
    else
    {
        sText = "Na papieri je napisane: " + sText;
    }

    SendMessageToPC(oPC, sText);
}
