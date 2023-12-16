void main()
{
    object oPC = GetPCSpeaker();
    object oNote = GetLocalObject(oPC, "notes_currentobject");
    string sText = GetLocalString(oNote, "notes_seal");
    string sTag = GetTag(oNote);

    if (sTag == "notes_letter")
    {
        sText = "Tento dopis zapecatil " + sText;
    }
    else
    {
        sText = "Tento dokument zapecatil " + sText;
    }

    SendMessageToPC(oPC, sText);
}
