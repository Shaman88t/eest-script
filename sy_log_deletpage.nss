#include "sy_log_include"

void main()
{
  // Delete the current page in the Log Book
  log_delete_page(GetLocalObject(OBJECT_SELF, "oLogBook"));
}

