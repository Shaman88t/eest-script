void TimeFix();


void main()
{
  PlaySound("al_an_bees1");
  object oSelf = OBJECT_SELF;

  // The next 2 lines check to make sure honey/honeycomb does not get created twice
  // by multiple players opening same beehive, or a failure of the 'OnClose' event firing.
  object oTemp = GetFirstItemInInventory(oSelf);
  if (oTemp != OBJECT_INVALID) return;

  TimeFix();
  int iDay = GetLocalInt(oSelf,"iLastDay");
  int iHour = GetLocalInt(oSelf,"iLastHour");
  int iHoneyComb = GetLocalInt(oSelf,"iHoneyComb");
  int iHoney = GetLocalInt(oSelf,"iHoney");
  int iCurrentDay = GetCalendarDay();
  int iCurrentHour = GetTimeHour();
  int iTemp = 0;

  //object oPC = GetLastOpenedBy();
  //SendMessageToPC(oPC,"========OPENING============");
  //SendMessageToPC(oPC,"        iDay = "+IntToString(iDay));
  //SendMessageToPC(oPC,"       iHour = "+IntToString(iHour));
  //SendMessageToPC(oPC,"  iHoneycomb = "+IntToString(iHoneyComb));
  //SendMessageToPC(oPC,"      iHoney = "+IntToString(iHoney));
  //SendMessageToPC(oPC," iCurrentDay = "+IntToString(iCurrentDay));
  //SendMessageToPC(oPC,"iCurrentHour = "+IntToString(iCurrentHour));

  if (iDay==0)
   {
    iDay = iCurrentDay;
    iHoneyComb = d4(5);
    iHoney = iHoneyComb/2;
    SetLocalInt(oSelf,"iLastDay",iCurrentDay);
    SetLocalInt(oSelf,"iHoney",iHoney);
    SetLocalInt(oSelf,"iHoneyComb",iHoneyComb);
    SetLocalInt(oSelf,"iLastHour",iCurrentHour);
   }

  if (iDay != iCurrentDay)
   {
    iHoneyComb++;
   }
  if (iHour != iCurrentHour)
    {
     //SendMessageToPC(oPC,"iHour != iCurrentHour");
     if (iHoneyComb >0)
      {
       iHoney = iHoneyComb/2;
       if (GetIsDay()==FALSE) iHoney = iHoney/2; //
       iTemp = iHoney;
       for (iTemp; iTemp>0; iTemp--)
        {
         CreateItemOnObject("menchoney",oSelf,1);
        }
      }
    }
   else  // iHour == iCurrentHour
    {
     if (iHoney>0)
      {
       if (iDay != iCurrentDay)  // same hour but different day = reset max#
        {
         //SendMessageToPC(oPC,"iHour = iCurrentHour but iDay != iCurrentDay");
         iHoney = iHoneyComb/2;
         iDay =iCurrentDay;
        }
       iTemp = iHoney;
       if (GetIsDay()==FALSE)  // If it is night, only 1/2 honey available
        {
         if (iHoneyComb/2 <iHoney) iHoney = iHoneyComb/2;  //Max honey = 1/2 current honeycomb
        }
       if (iHoney>0)
        {
         iTemp = iHoney;
         for (iTemp; iTemp>0; iTemp--)
          {
           CreateItemOnObject("menchoney",oSelf,1);
          }
        }
      }
    }

  iTemp = iHoneyComb;
  if (iHoneyComb >0)
   {
    for (iTemp; iTemp>0; iTemp--)
     {
      CreateItemOnObject("honeycomb",oSelf,1);
     }
   }

  if (GetIsDawn() == TRUE)
   {
    if (iHoneyComb>0) CreateItemOnObject("beeswax",oSelf,1);
   }

  SetLocalInt(oSelf,"iLastDay",iCurrentDay);
  SetLocalInt(oSelf,"iHoneyComb",iHoneyComb);
  SetLocalInt(oSelf,"iHoney",iHoney);
  SetLocalInt(oSelf,"iLastHour",iCurrentHour);

 // SendMessageToPC(oPC,"========END OPEN============");
 // SendMessageToPC(oPC,"        iDay = "+IntToString(iDay));
 // SendMessageToPC(oPC,"       iHour = "+IntToString(iHour));
 // SendMessageToPC(oPC,"  iHoneycomb = "+IntToString(iHoneyComb));
 // SendMessageToPC(oPC,"      iHoney = "+IntToString(iHoney));
 // SendMessageToPC(oPC," iCurrentDay = "+IntToString(iCurrentDay));
 // SendMessageToPC(oPC,"iCurrentHour = "+IntToString(iCurrentHour));
 // SendMessageToPC(oPC,"*****************************");
 // SendMessageToPC(oPC,"*****************************");
}

void TimeFix()
 {
  // Due to the BeeHive OnOpen script relying on ingame time for its functions
  // and the fact that in larger modules, the clock in the bottom right corner
  // of the player client fails to update properly, this function has been
  // included in the beehive OnOpen script to ensure that the player has
  // accurate time/date information for the respawning of the honey/honeycomb.
  //
  // Optionally, you can remove this script (and the call from the above OnOpen script
  // and move it into your module-level OnHeartbeat script, so that this function
  // works at all times, rather than just when a player opens the beehive.
  //
  // Credit for this script function goes to the posters on the Bioware forums.
  int iYear = GetCalendarYear();
  int iMonth = GetCalendarMonth();
  int iDay = GetCalendarDay();
  int iHour =GetTimeHour();
  int iMinute = GetTimeMinute();
  int iSecond = GetTimeSecond();
  int iMillisecond = GetTimeMillisecond();
  // Set Calendar & Time
  SetCalendar(iYear,iMonth,iDay);
  SetTime(iHour,iMinute,iSecond,iMillisecond);

  // Search for and destroy any hidden 'body bags' from prior incarnations of this placeable
 object oSearchForBag = GetNearestObjectByTag("Body Bag",OBJECT_SELF,1);
 if (oSearchForBag == OBJECT_INVALID)return;
 object oBagItem = OBJECT_INVALID;
 if (GetDistanceToObject(oSearchForBag)<= 0.2)
  {
   //SendMessageToPC(GetFirstPC(),"Body bag found.. destroying contents..");
   oBagItem = GetFirstItemInInventory(oSearchForBag);
   while (oBagItem != OBJECT_INVALID)
    {
     //SendMessageToPC(GetFirstPC(),"Destroying : "+GetName(oBagItem));
     DestroyObject(oBagItem);
     oBagItem = GetNextItemInInventory(oSearchForBag);
    }
   DestroyObject(oSearchForBag,1.0);
  }

 }

