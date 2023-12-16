void main()
{
  // Get the Log Book object controlled by this avatar
  object oLogBook = GetLocalObject(OBJECT_SELF, "oLogBook");

  // Get the Activator of the Log Book
  object oActivator = GetLocalObject(OBJECT_SELF, "oActivator");

  // Lock the Log Book
  SetLocalInt(oLogBook, "nLocked", TRUE);

  // Set the owner tag
  SetLocalObject(oLogBook, "oLocker", oActivator);
}
