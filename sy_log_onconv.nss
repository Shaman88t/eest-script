void main()
{
   int nListenPattern = GetListenPatternNumber();
   object oSpeaker = GetLastSpeaker();

   if (nListenPattern == -1 && GetCommandable(OBJECT_SELF))
   {
     ClearAllActions();
     BeginConversation();
   }
   else
   if(nListenPattern == 666 && GetIsObjectValid(oSpeaker) && GetIsPC(oSpeaker))
   {
     if (oSpeaker == GetLocalObject(OBJECT_SELF, "oActivator"))
     {
       // Get the spoken text so far
       string sSpokenText = GetLocalString(OBJECT_SELF, "sSpokenText");

       // Append the new text to the spoken text so far
       sSpokenText = sSpokenText + GetMatchedSubstring(0) + " ";

       // Save the spoken text
       SetLocalString(OBJECT_SELF, "sSpokenText", sSpokenText);
     }
   }
}
