//This is an include file. Ignore compile errors.


// * Token Constants
int nBookTitleToken         = 6660;
int nByToken                = 6661;
int nAuthorToken            = 6662;
int nPageToken              = 6663;
int nCurrentPageToken       = 6664;
int nOfToken                = 6665;
int nTotalPagesToken        = 6666;
int nEditedByToken          = 6667;
int nCurrentPageAuthorToken = 6668;
int nOnToken                = 6669;
int nCurrentPageDateToken   = 6670;
int nCurrentPageTextToken   = 6671;

void log_initialize(object oObject=OBJECT_SELF);
void log_update_tokens(object oObject=OBJECT_SELF);
string log_current_date();
string log_truncate_string(string sString, int MaxLength);
void log_new_booktitle(object oLogBook, string sTitle, string sAuthor);
void log_new_page(object oLogBook, string sPageText, string sPageAuthor);
void log_delete_page(object oLogBook);
void log_turnpage(object oLogBook, int nPageTurn);

//::///////////////////////////////////////////////
//:: Function: log_reset
//:://////////////////////////////////////////////
/*
    This function will reset the Log Book locals.
*/
//:://////////////////////////////////////////////
//:: Created By:  Zaddix
//:: Created On: July 13, 2002
//:://////////////////////////////////////////////
void log_reset(object oObject=OBJECT_SELF)
{
  int nTotalPages = GetLocalInt(oObject, "nTotalPages");

  SetLocalString(oObject, "sBookTitle", "");
  SetLocalString(oObject, "sAuthor", "");
  SetLocalInt(oObject, "nTotalPages", 0);
  SetLocalInt(oObject, "nCurrentPage", 0);

  int nCurrentPage;
  for (nCurrentPage = 1; nCurrentPage <= nTotalPages; nCurrentPage++)
  {
    SetLocalString(oObject, "sCurrentPageAuthor" + IntToString(nCurrentPage), "");
    SetLocalString(oObject, "sCurrentPageDate" + IntToString(nCurrentPage), "");
    SetLocalString(oObject, "sCurrentPageText" + IntToString(nCurrentPage), "");
  }

  // Update the tokens with the locals
  log_update_tokens(oObject);
} // end function


//::///////////////////////////////////////////////
//:: Function: log_update_tokens
//:://////////////////////////////////////////////
/*
    This function will updates tokens with the
    Log Book locals.
*/
//:://////////////////////////////////////////////
//:: Created By:  Zaddix
//:: Created On: July 13, 2002
//:://////////////////////////////////////////////
void log_update_tokens(object oObject=OBJECT_SELF)
{
  string sBookTitle = GetLocalString(oObject, "sBookTitle");
  string sAuthor = GetLocalString(oObject, "sAuthor");
  int nTotalPages = GetLocalInt(oObject, "nTotalPages");
  int nCurrentPage = GetLocalInt(oObject, "nCurrentPage");
  string sCurrentPageAuthor = GetLocalString(oObject, "sCurrentPageAuthor" + IntToString(nCurrentPage));
  string sCurrentPageDate = GetLocalString(oObject, "sCurrentPageDate" + IntToString(nCurrentPage));
  string sCurrentPageText = GetLocalString(oObject, "sCurrentPageText" + IntToString(nCurrentPage));

  if (sBookTitle == "")
  {
    SetCustomToken(nBookTitleToken, "");
    SetCustomToken(nByToken, "");
    SetCustomToken(nAuthorToken, "");
  }
  else
  {
    SetCustomToken(nBookTitleToken, sBookTitle + "\n");
    SetCustomToken(nByToken, "autor" + "\n");
    SetCustomToken(nAuthorToken, sAuthor + "\n\n");
  }

  if ((nCurrentPage > 0) && (nCurrentPage <= nTotalPages))
  {
    SetCustomToken(nPageToken, "List ");
    SetCustomToken(nCurrentPageToken, IntToString(nCurrentPage));
    SetCustomToken(nOfToken, " z ");
    SetCustomToken(nTotalPagesToken, IntToString(nTotalPages) + "\n");
    SetCustomToken(nEditedByToken, "Upravil:");
    SetCustomToken(nCurrentPageAuthorToken, sCurrentPageAuthor + "\n");
    SetCustomToken(nOnToken, "dna ");
    SetCustomToken(nCurrentPageDateToken, sCurrentPageDate + "\n\n");
    SetCustomToken(nCurrentPageTextToken, sCurrentPageText);
  }
  else
  {
    SetCustomToken(nPageToken, "");
    SetCustomToken(nCurrentPageToken, "");
    SetCustomToken(nOfToken, "");
    SetCustomToken(nTotalPagesToken, "");
    SetCustomToken(nEditedByToken, "");
    SetCustomToken(nCurrentPageAuthorToken, "");
    SetCustomToken(nOnToken, "");
    SetCustomToken(nCurrentPageDateToken, "");
    SetCustomToken(nCurrentPageTextToken, "");
  }

} // end function


//::///////////////////////////////////////////////
//:: Function: log_current_date
//:://////////////////////////////////////////////
/*
    This function will get the current date/time
    as a string.
*/
//:://////////////////////////////////////////////
//:: Created By:  Zaddix
//:: Created On: July 13, 2002
//:://////////////////////////////////////////////
string log_current_date()
{
  string sDate = IntToString(GetTimeMinute());
  if (GetStringLength(sDate) == 1)
  {
    sDate = "0" + sDate;
  }
  sDate = IntToString(GetCalendarMonth()) + "/" + IntToString(GetCalendarDay()) + "/" + IntToString(GetCalendarYear()) + " " + IntToString(GetTimeHour()) + ":" + sDate;
  return sDate;
} // end function


//::///////////////////////////////////////////////
//:: Function: log_truncate_string
//:://////////////////////////////////////////////
/*
    This function will truncate a string if
    it's length is greater then the length
    specified.
*/
//:://////////////////////////////////////////////
//:: Created By:  Zaddix
//:: Created On: July 13, 2002
//:://////////////////////////////////////////////
string log_truncate_string(string sString, int MaxLength)
{
  if (GetStringLength(sString) > MaxLength)
  {
    sString = GetStringLeft(sString, MaxLength);
  }

  return sString;

} // end function


//::///////////////////////////////////////////////
//:: Function: log_new_booktitle
//:://////////////////////////////////////////////
/*
    This function will set the title, author,
    and updated date for the Log Book.  It will
    also update the creation date if it hasn't
    already been set.
*/
//:://////////////////////////////////////////////
//:: Created By:  Zaddix
//:: Created On: July 13, 2002
//:://////////////////////////////////////////////
void log_new_booktitle(object oLogBook, string sTitle, string sAuthor)
{
  sTitle = log_truncate_string(sTitle, 50);
  sAuthor = log_truncate_string(sAuthor, 50);

  SetLocalString(oLogBook, "sBookTitle", sTitle);
  SetLocalString(oLogBook, "sAuthor", sAuthor);
  SetName(oLogBook,"Knizka - <cx  >" + sTitle + "</c>");

  // Update the tokens with the locals
  log_update_tokens(oLogBook);
} // end function


//::///////////////////////////////////////////////
//:: Function: log_new_page
//:://////////////////////////////////////////////
/*
    This function will add a new page to the
    Log Book.
*/
//:://////////////////////////////////////////////
//:: Created By:  Zaddix
//:: Created On: July 13, 2002
//:://////////////////////////////////////////////
void log_new_page(object oLogBook, string sPageText, string sPageAuthor)
{
  sPageAuthor = log_truncate_string(sPageAuthor, 50);

  int nTotalPages = GetLocalInt(oLogBook, "nTotalPages") + 1;
  int nCurrentPage = GetLocalInt(oLogBook, "nCurrentPage") + 1;

  SetLocalInt(oLogBook, "nTotalPages", nTotalPages);
  SetLocalInt(oLogBook, "nCurrentPage", nCurrentPage);

  int iPage;
  string sTemp;
  for (iPage = nTotalPages; iPage > nCurrentPage; iPage--)
  {
     sTemp = GetLocalString(oLogBook, "sCurrentPageAuthor" + IntToString(iPage-1));
     SetLocalString(oLogBook, "sCurrentPageAuthor" + IntToString(iPage), sTemp);
     sTemp = GetLocalString(oLogBook, "sCurrentPageDate" + IntToString(iPage-1));
     SetLocalString(oLogBook, "sCurrentPageDate" + IntToString(iPage), sTemp);
     sTemp = GetLocalString(oLogBook, "sCurrentPageText" + IntToString(iPage-1));
     SetLocalString(oLogBook, "sCurrentPageText" + IntToString(iPage), sTemp);
  }

  SetLocalString(oLogBook, "sCurrentPageAuthor" + IntToString(nCurrentPage), sPageAuthor);
  SetLocalString(oLogBook, "sCurrentPageDate" + IntToString(nCurrentPage), log_current_date());
  SetLocalString(oLogBook, "sCurrentPageText" + IntToString(nCurrentPage), sPageText);

  // Update the tokens with the locals
  log_update_tokens(oLogBook);
} // end function


//::///////////////////////////////////////////////
//:: Function: log_delete_page
//:://////////////////////////////////////////////
/*
    This function will delete the current page
    in the Log Book.
*/
//:://////////////////////////////////////////////
//:: Created By:  Zaddix
//:: Created On: July 13, 2002
//:://////////////////////////////////////////////
void log_delete_page(object oLogBook)
{
  int nTotalPages = GetLocalInt(oLogBook, "nTotalPages");
  int nCurrentPage = GetLocalInt(oLogBook, "nCurrentPage");

  int iPage;
  string sTemp;
  for (iPage = nCurrentPage; iPage < nTotalPages; iPage++)
  {
     sTemp = GetLocalString(oLogBook, "sCurrentPageAuthor" + IntToString(iPage+1));
     SetLocalString(oLogBook, "sCurrentPageAuthor" + IntToString(iPage), sTemp);
     sTemp = GetLocalString(oLogBook, "sCurrentPageDate" + IntToString(iPage+1));
     SetLocalString(oLogBook, "sCurrentPageDate" + IntToString(iPage), sTemp);
     sTemp = GetLocalString(oLogBook, "sCurrentPageText" + IntToString(iPage+1));
     SetLocalString(oLogBook, "sCurrentPageText" + IntToString(iPage), sTemp);
  }

  SetLocalString(oLogBook, "sCurrentPageAuthor" + IntToString(nTotalPages), "");
  SetLocalString(oLogBook, "sCurrentPageDate" + IntToString(nTotalPages), "");
  SetLocalString(oLogBook, "sCurrentPageText" + IntToString(nTotalPages), "");

  SetLocalInt(oLogBook, "nTotalPages", nTotalPages-1);

  if (nCurrentPage > nTotalPages-1)
  {
    SetLocalInt(oLogBook, "nCurrentPage", nCurrentPage-1);
  }

  // Update the tokens with the locals
  log_update_tokens(oLogBook);
}


//::///////////////////////////////////////////////
//:: Function: log_turnpage
//:://////////////////////////////////////////////
/*
    This function will turn the page of the
    Log Book by nPageTurn.
*/
//:://////////////////////////////////////////////
//:: Created By:  Zaddix
//:: Created On: July 13, 2002
//:://////////////////////////////////////////////
void log_turnpage(object oLogBook, int nPageTurn)
{
  int nCurrentPage = GetLocalInt(oLogBook, "nCurrentPage") + nPageTurn;
  SetLocalInt(oLogBook, "nCurrentPage", nCurrentPage);

  // Update the tokens with the locals
  log_update_tokens(oLogBook);
}

//void main(){}
