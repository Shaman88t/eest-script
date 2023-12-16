int StartingConditional()
{
  object oLogBook = GetLocalObject(OBJECT_SELF, "oLogBook");
  return (GetLocalInt(oLogBook, "nCurrentPage") > 0);
}
