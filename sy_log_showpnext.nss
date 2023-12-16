int StartingConditional()
{
  object oLogBook = GetLocalObject(OBJECT_SELF, "oLogBook");
  int nCurrentPage = GetLocalInt(oLogBook, "nCurrentPage");
  int nTotalPages = GetLocalInt(oLogBook, "nTotalPages");
  return (nCurrentPage < nTotalPages);
}
