#include "sy_log_include"

void main()
{
  // Get the text the PC spoke to the avatar
  string sSpokenText = GetLocalString(OBJECT_SELF, "sSpokenText");

  if (sSpokenText != "")
  {
    // Get the PC who activated the Log Book
    object oActivator = GetLocalObject(OBJECT_SELF, "oActivator");

    // Set a new title, author, and date information
    log_new_booktitle(GetLocalObject(OBJECT_SELF, "oLogBook"), sSpokenText, GetName(oActivator));

    // Clear out the text the PC spoke
    SetLocalString(OBJECT_SELF, "sSpokenText", "");
  }
}

