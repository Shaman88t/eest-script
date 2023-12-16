//::///////////////////////////////////////////////
//:: Name: Armour designer conversation condition
//:: FileName: hss_armour_cc_4
//:: Copyright Heed.
//:://////////////////////////////////////////////
/*
Returns true if the armourer has not been cleared
of a previous transaction and the previous customer
is no longer around. (is OBJECT_INVALID, so has left
the module or has crashed). We store the last customer's
item in the lost and found so it can be retrieved when he/she
joins again and then we clear the armourer.
*/
//:://////////////////////////////////////////////
//:: Created By:  Heed
//:: Created On:  April 4, 2006.
//:://////////////////////////////////////////////
//:: Last Update By: Heed
//:: Last Update On: May 7th, 2006.

#include "hss_inc_armour"

int StartingConditional()
{
    int nResult = FALSE;
    object oPC = GetPCSpeaker();
    object oCustomer = GetLocalObject(OBJECT_SELF, HSS_PREFX + "ARMOUR_CUSTOMER");
    string sCustomerPCName = GetPCPlayerName(oCustomer);
    string sCustomerName = GetName(oCustomer);

    //we stil have the item type local set, so we still have a customer
    if (GetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_ITEM_TYPE"))
       {
       //but the customer cannot be found, so we should reset
       if (!GetIsObjectValid(oCustomer))
          {
          nResult = TRUE;

          if (HSS_LOST_FOUND == TRUE)
             {
             HSS_ArmourLostAndFound();
             }

          DelayCommand(1.0, HSS_ArmourFinishRoutine(OBJECT_INVALID, 3));
          }
          //customer is online but not in the shop
          else
          if (GetArea(oPC) != GetArea(OBJECT_SELF))
          {
          //message the PC to come get his stuff
          SendMessageToPC(oCustomer, "Zapomels predmet pri uprave " +
          "u kovare.  Toto narusi system upravy pro ostatni hrace " +
          "DOKUD SI PREDMET NEVEZMES. Prosim vrat se a vezmi si svuj predmet. " +
          "Mohlo byt to byt povazovano za narusovani hry. Tato zprava byla zapsana. Dekuji.");

          //log the information in case we have deliberate abuse
          WriteTimestampedLogEntry("HSS_ARMOUR_DESIGNER: Hrac: " +
          sCustomerPCName + " hrajici postavu: " + sCustomerName + " zanechala " +
          "kovarovu upravnu predmetu v rozdelanem stavu. Dalsi operace " +
          "nejsou mozne. PC byl o tomto informovan.");

          //inform DM's in case they want to check if the PC is correcting
          //the problem.
          SendMessageToAllDMs("HSS_ARMOUR_DESIGNER: Hrac: " +
          sCustomerPCName + " hrajici postavu: " + sCustomerName + " zanechala " +
          "kovarovu upravnu predmetu v rozdelanem stavu. Dalsi operace " +
          "nejsou mozne. PC byl o tomto informovan.");

          //let the poor guy who is waiting know what's up.
          SendMessageToPC(oPC, "Posledni zakaznik tu nechal vec. " +
          "Hrac je online a byl informovan ze se to stalo. " +
          "Musite pockat az si pro ni hrac prijde. " +
          "DM byli informovani a tato sprava byla zapsana. " +
          "Dekuji za trpelivost.");
          }
       }

    return nResult;
}
