int StartingConditional()
{
    int nStatus = GetLocalInt(OBJECT_SELF, "art_status");

    if (nStatus == 0) {
        return TRUE;
    }
    else {
        return FALSE;
    }

}
