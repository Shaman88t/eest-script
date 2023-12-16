int StartingConditional()
{
  // Get the name of the Log Book activator
  string sActivator = GetName(GetLocalObject(OBJECT_SELF, "oActivator"));

  // Get the Log Book object controlled by this avatar
  object oLogBook = GetLocalObject(OBJECT_SELF, "oLogBook");

  // Get the name of the Log Book author
  string sAuthor = GetLocalString(oLogBook, "sAuthor");

  if (sAuthor == "")
  {
    return FALSE;
  }

  if (sActivator == sAuthor)
  {
    return TRUE;
  }

  // Get whether the Log Book is locked or not
  int nLocked = GetLocalInt(oLogBook, "nLocked");

  if (nLocked == TRUE)
  {
    return FALSE;
  }
  return TRUE;
}
