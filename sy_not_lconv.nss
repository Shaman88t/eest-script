void main()
{
    if (GetListenPatternNumber() == 1001)
    {
        object oPC = GetLocalObject(OBJECT_SELF, "notes_currentpc");
        if (GetLastSpeaker() == oPC)
        {
            string sHeard = GetLocalString(OBJECT_SELF, "notes_heard");
            int nCount = GetMatchedSubstringsCount();
            int k = 0;
            while (k < nCount)
            {
                sHeard = sHeard + GetMatchedSubstring(k);
                k++;
            }
            sHeard = sHeard + " ";
            SetLocalString(OBJECT_SELF, "notes_heard", sHeard);
        }
    }
}
