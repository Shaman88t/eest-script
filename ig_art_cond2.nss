int StartingConditional()
{
    int nStatus = GetLocalInt(OBJECT_SELF, "art_status");

    if (nStatus == 2) {
        return TRUE;
    }
    else {
        return FALSE;
    }

}
