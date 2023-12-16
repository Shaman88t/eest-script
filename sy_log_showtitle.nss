int StartingConditional()
{
  // Get the name of the Log Book activator
  string sActivator = GetName(GetLocalObject(OBJECT_SELF, "oActivator"));

  // Get the Log Book object controlled by this avatar
  object oLogBook = GetLocalObject(OBJECT_SELF, "oLogBook");

  // Get the name of the Log Book author
  string sAuthor = GetLocalString(oLogBook, "sAuthor");

  if ((sAuthor != "") && (sActivator != sAuthor))
  {
    return FALSE;
  }

  return TRUE;
}
