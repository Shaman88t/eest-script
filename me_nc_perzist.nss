// This function sets a string directly on the tag of a token.
// This is useful for storing names/tags/resref's or for your own
// string parsing system.
void SetTokenString(object oPC, int iTokenNum, string sNewTokenString);

// This function returns a string value stored directly on the token.
// This is useful for storing names/tags/resref's or for your own
// string parsing system.
string GetTokenString(object oPC, int iTokenNum);

// This function returns the integer value of a pair of ascii characters
int GetPairValue(string sFlagPair);

// This function returns the value (0-1023) stored on a PairToken.
int GetTokenPair(object oPC, int iTokenNum, int iPairPosition);

// This function will set the pair value on the specified token to a new value.
void SetTokenPair(object oPC, int iTokenNum, int iPairPosition, int iPairValue);

// Returns current flag value of iTokenNum from iTokenPosition
// within the token tag sequence.  Returns 1 or 0 (TRUE or FALSE)
int GetTokenFlag(object oPC, int iTokenNum, int iTokenPosition, int iFlagPosition);

// Sets the flag value (bitwise flip of value) on iTokenNum from
// iTokenPosition within the tag, setting iFlagPosition 'bit' to 1 or 0
void SetTokenFlag(object oPC, int iTokenNum, int iTokenPosition, int iFlagPosition, int iValue);

// clears all non-token items from the token box and places all missing tokens
// from PC's inventory base into the box if they were removed.
// This function will possibly create new tokens if any are completely missing.
void ValidateTokenBox(object oPC, object oTokenBox);

// This function searches inside the token box for the requested token by resref
// returns OBJECT_INVALID on error.
object FindToken(object oPC, object oTokenBox, string sTokenResRef);

// This function is a basic custom lookup table for converting ASCII to INT
int ParseFlag(string sTokenTag);

// This function converts a standard int into a bit-on or bit-off value based on bit #iFlagPosition
int GetFlagBit(int iFlagValue, int iFlagPosition);

// This function returns a modified ascii value based on the ascii char sent to it after setting the flag bit
// specified either on or off.
string SetFlag (string sTokenTag2, int iFlagPosition, int iValue);


//void main()
//{
//}

int GetTokenFlag(object oPC, int iTokenNum, int iTokenPosition, int iFlagPosition)
{
 int iReturnThisFlag = 0;
 object oTokenBox = GetFirstItemInInventory(oPC);
 string sTokenResRef = "flagtoken0";   // this is the resref of the token requested
 string sTokenTag = "";
 string sTokenTag2;
 if (iTokenNum >9)
   {
    sTokenResRef = sTokenResRef+"10";
   }
  else
   {
    sTokenResRef = sTokenResRef+"0"+IntToString(iTokenNum);
   }


 if (oTokenBox == OBJECT_INVALID)
  {
   //SendMessageToPC(oPC,"TOKEN ERROR - NO INVENTORY");
   return 2;
  }
 if (GetResRef(oTokenBox) != "gafforthiatokenb")
  {
   while (GetResRef(oTokenBox) != "gafforthiatokenb")
    {
     oTokenBox = OBJECT_INVALID;
     oTokenBox = GetNextItemInInventory(oPC);
     if (oTokenBox == OBJECT_INVALID)
      {
       //SendMessageToPC(oPC,"TOKEN ERROR - TOKEN BOX MISSING");
       return 3;
      }
     }
  }
  ValidateTokenBox(oPC, oTokenBox);
  object oFlagToken = FindToken(oPC,oTokenBox,sTokenResRef);
  if (oFlagToken == OBJECT_INVALID)
   {
    //SendMessageToPC(oPC,"TOKEN ERROR - TOKEN NOT FOUND ON PC OR IN TOKEN BOX");
    return 4;
   }

  // Trim off the beginning of the tag, the 'TOKEN_' part
  sTokenTag = GetStringRight(GetTag(oFlagToken),GetStringLength(GetTag(oFlagToken))-6);
  // Trim off everything after the requested position within the tag
  sTokenTag2 = GetStringLeft(sTokenTag,iTokenPosition);
  // Return the last letter in the tag (this is the requested one)
  sTokenTag = GetStringRight(sTokenTag2,1);

  // Now parse the value of the variable via a lookup table
  int iFlagValue = ParseFlag(sTokenTag);
  //SendMessageToPC(oPC,"iFlagValue = "+IntToString(iFlagValue));
  //SendMessageToPC(oPC,"iFlagPosition: "+IntToString(iFlagPosition));
  iReturnThisFlag = GetFlagBit(iFlagValue,iFlagPosition);
  return iReturnThisFlag;
}

void SetTokenFlag(object oPC, int iTokenNum, int iTokenPosition, int iFlagPosition, int iValue)
{
 object oTokenBox = GetFirstItemInInventory(oPC);
 string sTokenResRef = "flagtoken0";   // this is the resref of the token requested
 string sTokenTag = "";
 string sTokenTag2;
 string sTokenTag3;
 if (iTokenNum >9)
   {
    sTokenResRef = sTokenResRef+"10";
   }
  else
   {
    sTokenResRef = sTokenResRef+"0"+IntToString(iTokenNum);
   }


 if (oTokenBox == OBJECT_INVALID)
  {
   //SendMessageToPC(oPC,"TOKEN ERROR - NO INVENTORY");
   return;
  }
 if (GetResRef(oTokenBox) != "gafforthiatokenb")
  {
   while (GetResRef(oTokenBox) != "gafforthiatokenb")
    {
     oTokenBox = OBJECT_INVALID;
     oTokenBox = GetNextItemInInventory(oPC);
     if (oTokenBox == OBJECT_INVALID)
      {
       //SendMessageToPC(oPC,"TOKEN ERROR - TOKEN BOX MISSING");
       return;
      }
     }
  }
  ValidateTokenBox(oPC, oTokenBox);
  object oFlagToken = FindToken(oPC,oTokenBox,sTokenResRef);
  //SendMessageToPC(GetFirstPC(),"Returned token : "+GetName(oFlagToken));
  if (oFlagToken == OBJECT_INVALID)
   {
    //SendMessageToPC(oPC,"TOKEN ERROR - TOKEN NOT FOUND ON PC OR IN TOKEN BOX");
    return;
   }
  // Trim off the beginning of the tag, the 'TOKEN_' part and all characters up to the needed character
  sTokenTag = GetStringLeft(GetTag(oFlagToken),iTokenPosition+5);
  // Trim off everything after the requested position within the tag
  sTokenTag2 = GetStringRight(GetTag(oFlagToken),GetStringLength(GetTag(oFlagToken))-(6+iTokenPosition));
  // Return the actual needed character
  sTokenTag3 = GetStringLeft(GetStringRight(GetTag(oFlagToken),GetStringLength(GetTag(oFlagToken))-(5+iTokenPosition)),1);

  //Set the new value of sTokenTag3 so tag can be reconstructed w/new value
  sTokenTag = sTokenTag+SetFlag(sTokenTag3,iFlagPosition,iValue)+sTokenTag2;
  object oNewToken1 = CopyObject(oFlagToken,GetLocation(oPC),oTokenBox,sTokenTag);
  DestroyObject(oFlagToken,1.0);
  //SendMessageToPC(oPC,sTokenTag);
  //SendMessageToPC(oPC,GetTag(oNewToken1));
}





void ValidateTokenBox(object oPC, object oTokenBox)
 {
  // First, clear all non-token objects from the token box
  object oSearchForJunk = GetFirstItemInInventory(oTokenBox);
  if (oSearchForJunk == OBJECT_INVALID)
    {
     //SendMessageToPC(oPC,"TOKEN BOX IS EMPTY");
    }
   else
    {
     while (oSearchForJunk != OBJECT_INVALID)
      {
       if (GetStringLeft(GetTag(oSearchForJunk),6) != "TOKEN_")
        {
         CopyObject(oSearchForJunk,GetLocation(oPC),oPC,GetTag(oSearchForJunk));
         DestroyObject(oSearchForJunk);
         //SendMessageToPC(oPC,"REMOVING JUNK");
        }
        oSearchForJunk = OBJECT_INVALID;
        oSearchForJunk = GetNextItemInInventory(oTokenBox);
      }
    }
  // oSearchForJunk = GetFirstItemInInventory(oPC);
  // while (oSearchForJunk != OBJECT_INVALID)
  //  {
  //   if (GetStringLeft(GetTag(oSearchForJunk),6) == "TOKEN_")
  //    {
  //     CopyObject(oSearchForJunk,GetLocation(oPC),oTokenBox,GetTag(oSearchForJunk));
  //     SendMessageToPC(oPC,"REMOVING JUNK222");
  //     DestroyObject(oSearchForJunk);
  //    }
  //   oSearchForJunk = OBJECT_INVALID;
  //   oSearchForJunk = GetNextItemInInventory(oPC);
  //  }

 }


object FindToken(object oPC, object oTokenBox, string sTokenResRef)
{
// This function searches inside the token box for the requested token by resref
// returns OBJECT_INVALID on error.
  //SendMessageToPC(GetFirstPC(),sTokenResRef);
  object oTokenSearch = GetFirstItemInInventory(oTokenBox);
  //SendMessageToPC(GetFirstPC(),"First search object: "+GetResRef(oTokenSearch));
  if (oTokenSearch == OBJECT_INVALID)
    return OBJECT_INVALID;
  if (GetResRef(oTokenSearch) != sTokenResRef)
   {
    while (GetResRef(oTokenSearch) != sTokenResRef)
     {
      oTokenSearch = OBJECT_INVALID;
      oTokenSearch = GetNextItemInInventory(oTokenBox);
      //SendMessageToPC(GetFirstPC(),"Next search object: "+GetResRef(oTokenSearch));
      if (oTokenSearch == OBJECT_INVALID)break;
     }
   }
  if (oTokenSearch==OBJECT_INVALID)
   {
    oTokenSearch = GetFirstItemInInventory(oPC);
    if (GetResRef(oTokenSearch) != sTokenResRef)
     {
      while (GetResRef(oTokenSearch) != sTokenResRef)
       {
        oTokenSearch = OBJECT_INVALID;
        oTokenSearch = GetNextItemInInventory(oPC);
        //SendMessageToPC(GetFirstPC(),"Next search object: "+GetResRef(oTokenSearch));
        if (oTokenSearch == OBJECT_INVALID)
         {
          PrintString("TOKEN: "+GetName(oPC)+" has lost token:  "+sTokenResRef);
          SendMessageToAllDMs("TOKEN: "+GetName(oPC)+" has lost token: "+ sTokenResRef);
          break;
         }
       }
     }
   }

  return oTokenSearch;
}

int ParseFlag(string sTokenTag)
{
 string sFlagTempString = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_";
 string sTempFlagValue;
 int iWillReturnThis;
 for (iWillReturnThis =0; iWillReturnThis<63; iWillReturnThis++)
  {
   sTempFlagValue = GetStringLeft(sFlagTempString,1);
   //SendMessageToPC(GetFirstPC(),sTokenTag+" : "+sTempFlagValue);
   if (sTokenTag == sTempFlagValue)
     {
      //SendMessageToPC(GetFirstPC(),"Found Flag : " +sTempFlagValue);
      return iWillReturnThis;
      break;
     }
    else
     {
      sFlagTempString = GetStringRight(sFlagTempString,GetStringLength(sFlagTempString)-1);
      //SendMessageToPC(GetFirstPC(),sFlagTempString);
     }
   }
 return iWillReturnThis;
}

int GetFlagBit(int iFlagValue, int iFlagPosition)
 {
  int iTestForThisValue;
  switch (iFlagPosition)
   {
    case 1:
     {
      iTestForThisValue = 1;
      break;
     }
    case 2:
     {
      iTestForThisValue = 2;
      break;
     }
    case 3:
     {
      iTestForThisValue = 4;
      break;
     }
    case 4:
     {
      iTestForThisValue = 8;
      break;
     }
    default:
     {
      iTestForThisValue = 16;
      break;
     }
   }
   //SendMessageToPC(GetFirstPC(),IntToString(iFlagValue)+" = "+IntToString(iTestForThisValue)+"?");
   if ((iFlagValue & iTestForThisValue) == iTestForThisValue)
     {
      iTestForThisValue = 1;
     }
    else
     {
      iTestForThisValue = 0;
     }

   return iTestForThisValue;

 }


string SetFlag (string sTokenTag3, int iFlagPosition, int iValue)
{
  //check the current state of the flag bit
  int iFlagCurrentValue = ParseFlag(sTokenTag3);
  int iFlagBitOnOrOff= GetFlagBit(iFlagCurrentValue,iFlagPosition);

  //SendMessageToPC(GetFirstPC(),"Current Flag Bit State : "+IntToString(iFlagBitOnOrOff));
  // if flag is already set, return the original ascii character, as no change is needed
  if (iFlagBitOnOrOff == iValue)
    {
     //SendMessageToPC(GetFirstPC(),"Value is same");
     return sTokenTag3;
    }
  int iNewFlagValue = ParseFlag(sTokenTag3);  //<- redundant can remove it I think
  //SendMessageToPC(GetFirstPC(),"sTokenTag3="+sTokenTag3);
  //SendMessageToPC(GetFirstPC(),"current value: "+IntToString(iNewFlagValue));
  int iFlagCounter;
  switch (iFlagPosition)
   {
    case 1:
     {
      iFlagCounter =1;
      break;
     }
    case 2:
     {
      iFlagCounter =2;
      break;
     }
    case 3:
     {
      iFlagCounter =4;
      break;
     }
    case 4:
     {
      iFlagCounter =8;
      break;
     }
    default:
    {
      iFlagCounter =16;
      break;
     }
   }

  if (iValue ==0)
    {
     iNewFlagValue = iNewFlagValue - iFlagCounter;
     //SendMessageToPC(GetFirstPC(),"Turned Bit Off");
     //turn off the flag bit
    }
   else
    {
     // turn on the flag bit
     iNewFlagValue = iNewFlagValue+iFlagCounter;

     //SendMessageToPC(GetFirstPC(),"Turned Bit On : "+IntToString(iNewFlagValue));
     //SendMessageToPC(GetFirstPC(),"iFlagCounter  : "+IntToString(iFlagCounter));
    }
  //SendMessageToPC(GetFirstPC(),"Looking for the value stored to the right 'X' spaces - X = "+IntToString(iNewFlagValue));
  string sFlagTempString = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_";
  int iWillReturnThisFlag;

  for (iWillReturnThisFlag=0;iWillReturnThisFlag < iNewFlagValue+1;iWillReturnThisFlag++)
  {
   //SendMessageToPC(GetFirstPC(),"LOOP EXECUTING");
   sTokenTag3 = GetStringLeft(sFlagTempString,1);
   if (iWillReturnThisFlag == iNewFlagValue)
    {
     //SendMessageToPC(GetFirstPC(),"VALUE HERE : "+sTokenTag3);
     return sTokenTag3;
    }
   //SendMessageToPC(GetFirstPC(),sTokenTag3);
   sFlagTempString = GetStringRight(sFlagTempString,GetStringLength(sFlagTempString)-1);
  }

  return sTokenTag3;

}

int GetTokenPair(object oPC, int iTokenNum, int iPairPosition)
 {
  int iReturnThisFlag = 0;
  object oTokenBox = GetFirstItemInInventory(oPC);
  string sTokenResRef = "pairtoken0";   // this is the resref of the token requested
  string sTokenTag = "";
  string sTokenTag2;
  string sTokenTag3;
  if (iTokenNum >9)
    {
     sTokenResRef = sTokenResRef+IntToString(iTokenNum);
    }
   else
    {
     sTokenResRef = sTokenResRef+"0"+IntToString(iTokenNum);
    }


  if (oTokenBox == OBJECT_INVALID)
   {
    //SendMessageToPC(oPC,"TOKEN ERROR - NO INVENTORY");
    return 2;
   }
  if (GetResRef(oTokenBox) != "gafforthiatokenb")
   {
    while (GetResRef(oTokenBox) != "gafforthiatokenb")
     {
      oTokenBox = OBJECT_INVALID;
      oTokenBox = GetNextItemInInventory(oPC);
      if (oTokenBox == OBJECT_INVALID)
       {
        //SendMessageToPC(oPC,"TOKEN ERROR - TOKEN BOX MISSING");
        return 3;
       }
      }
   }
   ValidateTokenBox(oPC, oTokenBox);
   object oFlagToken = FindToken(oPC, oTokenBox,sTokenResRef);
   if (oFlagToken == OBJECT_INVALID)
    {
     //SendMessageToPC(oPC,"TOKEN ERROR - TOKEN NOT FOUND ON PC OR IN TOKEN BOX");
     return 4;
    }

   // Trim off the beginning of the tag, the 'TOKEN_' part
   sTokenTag = GetStringRight(GetTag(oFlagToken),GetStringLength(GetTag(oFlagToken))-6);
   // Trim off everything after the requested position within the tag
   sTokenTag2 = GetStringLeft(sTokenTag,(iPairPosition*2));
   // Return the last two letters in the tag (this is the requested one)
   sTokenTag3 = GetStringRight(sTokenTag2,2);

  // Now parse the value of the variable via a lookup table
  int iFlagValue = GetPairValue(sTokenTag3);

  //SendMessageToPC(oPC,"iPairValue = "+IntToString(iFlagValue));
  //SendMessageToPC(oPC,"iPairPosition: "+IntToString(iPairPosition));
//  iReturnThisFlag = GetFlagBit(iFlagValue,iPairPosition);
  return iFlagValue;




 }

int GetPairValue(string sFlagPair)
 {
  int iPairValueLeft = ParseFlag(GetStringLeft(sFlagPair,1));
  int iPairValueRight = ParseFlag(GetStringRight(sFlagPair,1));
  //SendMessageToPC(GetFirstPC(),"Pair Values (l & r) : "+IntToString(iPairValueLeft)+" __ "+IntToString(iPairValueRight));
  int iPairTempValue = 0;
  int iPairTotalValue = 0;
  if ((iPairValueLeft & 1)==1)
   iPairTempValue = iPairTempValue+32;
  if ((iPairValueLeft & 2)==2)
   iPairTempValue = iPairTempValue+64;
  if ((iPairValueLeft & 4)==4)
   iPairTempValue = iPairTempValue+128;
  if ((iPairValueLeft & 8)==8)
   iPairTempValue = iPairTempValue+256;
  if ((iPairValueLeft & 16)==16)
   iPairTempValue = iPairTempValue+512;
  iPairTempValue=iPairTempValue+iPairValueRight;
  return iPairTempValue;
 }

void SetTokenPair(object oPC, int iTokenNum, int iPairPosition, int iPairValue)
 {
  int iReturnThisFlag = 0;
  object oTokenBox = GetFirstItemInInventory(oPC);
  string sTokenResRef = "pairtoken0";   // this is the resref of the token requested
  string sTokenTag = "";
  string sTokenTag2;
  string sTokenTag3;
  if (iTokenNum >9)
    {
     sTokenResRef = sTokenResRef+IntToString(iTokenNum);
    }
   else
    {
     sTokenResRef = sTokenResRef+"0"+IntToString(iTokenNum);
    }


  if (oTokenBox == OBJECT_INVALID)
   {
    //SendMessageToPC(oPC,"TOKEN ERROR - NO INVENTORY");
   }
  if (GetResRef(oTokenBox) != "gafforthiatokenb")
   {
    while (GetResRef(oTokenBox) != "gafforthiatokenb")
     {
      oTokenBox = OBJECT_INVALID;
      oTokenBox = GetNextItemInInventory(oPC);
      if (oTokenBox == OBJECT_INVALID)
       {
        //SendMessageToPC(oPC,"TOKEN ERROR - TOKEN BOX MISSING");
       }
      }
   }
   ValidateTokenBox(oPC, oTokenBox);
   object oFlagToken = FindToken(oPC, oTokenBox,sTokenResRef);
   if (oFlagToken == OBJECT_INVALID)
    {
     //SendMessageToPC(oPC,"TOKEN ERROR - TOKEN NOT FOUND ON PC OR IN TOKEN BOX");
    }

   //Get the left side of the token tag, up to (but not including) the pair in question
   sTokenTag = GetStringLeft(GetTag(oFlagToken),(iPairPosition*2)+4);
   // Get the right side of the token tag, after the requested pair
   sTokenTag2 = GetStringRight(GetTag(oFlagToken),GetStringLength(GetTag(oFlagToken))-(GetStringLength(sTokenTag)+2));

   // Set the pair value to insert vetween sTokenTag and sTokenTag2
   int iTempPairValue = 0;
   if (iPairValue>=512)
    {
     iPairValue = iPairValue - 512;
     iTempPairValue = iTempPairValue+16;
    }
   if (iPairValue>=256)
    {
     iPairValue = iPairValue - 256;
     iTempPairValue = iTempPairValue+8;
    }
   if (iPairValue>=128)
    {
     iPairValue = iPairValue - 128;
     iTempPairValue = iTempPairValue+4;
    }
   if (iPairValue>=64)
    {
     iPairValue = iPairValue - 64;
     iTempPairValue = iTempPairValue+2;
    }
   if (iPairValue>=32)
    {
     iPairValue = iPairValue - 32;
     iTempPairValue = iTempPairValue+1;
    }
   string sFlagTempString = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_";
   string sFlagTempString2 = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_";
   string sFlagPairValueLeft;
   string sFlagPairValueRight;
   int iSetPairIndex = 0;
   for (iSetPairIndex = 0; iSetPairIndex<iTempPairValue+1; iSetPairIndex++)
    {
     sFlagPairValueLeft = GetStringLeft(sFlagTempString,1);
     sFlagTempString = GetStringRight(sFlagTempString,GetStringLength(sFlagTempString)-1);
    }
   for (iSetPairIndex = 0; iSetPairIndex<iPairValue+1; iSetPairIndex++)
    {
     sFlagPairValueRight = GetStringLeft(sFlagTempString2,1);
     sFlagTempString2 = GetStringRight(sFlagTempString2,GetStringLength(sFlagTempString2)-1);
    }
   sTokenTag3 = sTokenTag+sFlagPairValueLeft+sFlagPairValueRight+sTokenTag2;
   object oNewToken1 = CopyObject(oFlagToken,GetLocation(oPC),oTokenBox,sTokenTag3);
   DestroyObject(oFlagToken,1.0);
   //SendMessageToPC(oPC,sTokenTag);
   //SendMessageToPC(oPC,GetTag(oNewToken1));
   //SendMessageToPC(oPC, "Left Character  : "+sFlagPairValueLeft);
   //SendMessageToPC(oPC, "Right Character : "+sFlagPairValueRight);
   //SendMessageToPC(oPC, "Token Left : "+sTokenTag);
   //SendMessageToPC(oPC, "Token Right: "+sTokenTag2);
 }

string GetTokenString(object oPC, int iTokenNum)
{
  int iReturnThisFlag = 0;
  object oTokenBox = GetFirstItemInInventory(oPC);
  string sTokenResRef = "stringtoken0";   // this is the resref of the token requested
  string sTokenTag = "";
  if (iTokenNum >9)
    {
     sTokenResRef = sTokenResRef+IntToString(iTokenNum);
    }
   else
    {
     sTokenResRef = sTokenResRef+"0"+IntToString(iTokenNum);
    }


  if (oTokenBox == OBJECT_INVALID)
   {
    //SendMessageToPC(oPC,"TOKEN ERROR - NO INVENTORY");
   }
  if (GetResRef(oTokenBox) != "gafforthiatokenb")
   {
    while (GetResRef(oTokenBox) != "gafforthiatokenb")
     {
      oTokenBox = OBJECT_INVALID;
      oTokenBox = GetNextItemInInventory(oPC);
      if (oTokenBox == OBJECT_INVALID)
       {
       // SendMessageToPC(oPC,"TOKEN ERROR - TOKEN BOX MISSING");
       }
      }
   }
   ValidateTokenBox(oPC, oTokenBox);
   object oFlagToken = FindToken(oPC, oTokenBox,sTokenResRef);
   if (oFlagToken == OBJECT_INVALID)
    {
     //SendMessageToPC(oPC,"TOKEN ERROR - TOKEN NOT FOUND ON PC OR IN TOKEN BOX");
    }

   // Trim off the beginning of the tag, the 'TOKEN_' part
   sTokenTag = GetStringRight(GetTag(oFlagToken),GetStringLength(GetTag(oFlagToken))-6);
   return sTokenTag;
}

void SetTokenString(object oPC, int iTokenNum, string sNewTokenString)
 {
  int iReturnThisFlag = 0;
  object oTokenBox = GetFirstItemInInventory(oPC);
  string sTokenResRef = "stringtoken0";   // this is the resref of the token requested
  string sTokenTag = "";
  if (iTokenNum >9)
    {
     sTokenResRef = sTokenResRef+IntToString(iTokenNum);
    }
   else
    {
     sTokenResRef = sTokenResRef+"0"+IntToString(iTokenNum);
    }


  if (oTokenBox == OBJECT_INVALID)
   {
    //SendMessageToPC(oPC,"TOKEN ERROR - NO INVENTORY");
   }
  if (GetResRef(oTokenBox) != "gafforthiatokenb")
   {
    while (GetResRef(oTokenBox) != "gafforthiatokenb")
     {
      oTokenBox = OBJECT_INVALID;
      oTokenBox = GetNextItemInInventory(oPC);
      if (oTokenBox == OBJECT_INVALID)
       {
        //SendMessageToPC(oPC,"TOKEN ERROR - TOKEN BOX MISSING");
       }
      }
   }
   ValidateTokenBox(oPC, oTokenBox);
   object oFlagToken = FindToken(oPC, oTokenBox,sTokenResRef);
   if (oFlagToken == OBJECT_INVALID)
    {
     //SendMessageToPC(oPC,"TOKEN ERROR - TOKEN NOT FOUND ON PC OR IN TOKEN BOX");
    }

   // Trim off the beginning of the tag, the 'TOKEN_' part
   sTokenTag = "TOKEN_"+sNewTokenString;
   object oNewToken1 = CopyObject(oFlagToken,GetLocation(oPC),oTokenBox,sTokenTag);
   DestroyObject(oFlagToken,1.0);
   //SendMessageToPC(oPC,sTokenTag);
   //SendMessageToPC(oPC,GetTag(oNewToken1));

}


