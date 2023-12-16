int StartingConditional()
{
    int nStatus = GetLocalInt(OBJECT_SELF, "art_status");

    if (nStatus == 1) {
        return TRUE;
    }
    else {
        return FALSE;
    }

}
