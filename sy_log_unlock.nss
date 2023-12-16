void main()
{
  // Get the Log Book object controlled by this avatar
  object oLogBook = GetLocalObject(OBJECT_SELF, "oLogBook");

  // Lock the Log Book
  SetLocalInt(oLogBook, "nLocked", FALSE);
}
