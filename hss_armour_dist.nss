//::///////////////////////////////////////////////
//:: Name: Armour designer work container, on disturb
//:: FileName: hss_armour_dist
//:: Copyright Heed.
//:://////////////////////////////////////////////
/*
On disturb event handler for armour designer
work container.
*/
//:://////////////////////////////////////////////
//:: Created By:  Heed
//:: Created On:  March 16, 2006.
//:://////////////////////////////////////////////
//:: Last Update By: Heed
//:: Last Update On: April 23, 2006.


#include "hss_inc_armour"

void main()
{
    int nDist = GetInventoryDisturbType();
    object oItem = GetInventoryDisturbItem();
    object oPC = GetLastDisturbed();
    object oArmourer = GetNearestObjectByTag(HSS_PREFX + "ARMOUR_DESIGNER");
    object oFDummy = GetNearestObjectByTag(HSS_PREFX + "ARMOUR_DUMMY_F");
    object oMDummy = GetNearestObjectByTag(HSS_PREFX + "ARMOUR_DUMMY_M");
    object oModule = GetModule();
    int nBase = GetBaseItemType(oItem);
    string sNoID = GetLocalString(oArmourer, HSS_PREFX + "ARMOUR_UNIDENTIFIED");
    string sWrong = GetLocalString(oArmourer, HSS_PREFX + "ARMOUR_WRONG_TYPE");
    string sConvo = GetLocalString(oArmourer, HSS_PREFX + "ARMOUR_GO_CONVO");
    string sRobed = GetLocalString(oArmourer, HSS_PREFX + "ARMOUR_IS_ROBED");
    string sPCID = GetPCPlayerName(oPC) + "_" + GetName(oPC);
    object oNew;
    object oDummy;
    int nSlot;
    int nValue;
    int nGender;

    //item added to the armour work container
    if (nDist == INVENTORY_DISTURB_TYPE_ADDED)
       {
       //set a custom msg for locked feedback
       if (GetKeyRequiredFeedback(OBJECT_SELF) == "")
          {
          SetKeyRequiredFeedback(OBJECT_SELF, "Prosim nesnaste se narusit " +
                          "system. Tento objekt nebude nikdy odemknutelny.");
          }

       //we don't work on unidentified items -- give it back and exit.
       if (!GetIdentified(oItem))
          {
          AssignCommand(oArmourer, SpeakString(sNoID));
          oNew = CopyItem(oItem, oPC, TRUE);
          DestroyObject(oItem);
          return;
          }
       //do the check for individual excluded items.
       HSS_ArmourItemExclusionCheck(oItem, oArmourer);

       //setup gender based variables
       if (GetGender(oPC) == GENDER_FEMALE)
          {
          nGender = 2;
          oDummy = oFDummy;
          }
          else
          {
          nGender = 1;
          oDummy = oMDummy;
          }

       //we only do full work on armour or helms
       if (nBase == BASE_ITEM_ARMOR || nBase == BASE_ITEM_HELMET)
          {
          //build the armour part 2da indexes if not done yet.
          if (GetLocalString(oModule, HSS_PREFX + "ARMOUR_PART_COUNT_CACHE") == "" ||
             GetLocalString(oModule, HSS_PREFX + "ARMOUR_AC_CHEST_CACHE") == "" )
             {
             HSS_ArmourBuild2DAPartIndex(oModule);
             }
          //set a local so we know what kind of item we are working on
          if (nBase == BASE_ITEM_ARMOR)
             {
             //note we are working on a robe
             if (GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL,
                ITEM_APPR_ARMOR_MODEL_ROBE))
                {
                //set part type to begin with for equip routine
                SetLocalInt(oArmourer, HSS_PREFX + "ARMOUR_PART_TYPE", 19);
                SetLocalInt(oArmourer, HSS_PREFX + "ARMOUR_IS_ROBED", 1);
                }

             SetLocalInt(oArmourer, HSS_PREFX + "ARMOUR_ITEM_TYPE", HSS_TYPE_ARMOUR);
             nSlot = INVENTORY_SLOT_CHEST;
             }
             else
             {
             SetLocalInt(oArmourer, HSS_PREFX + "ARMOUR_PART_TYPE", 99);
             SetLocalInt(oArmourer, HSS_PREFX + "ARMOUR_ITEM_TYPE", HSS_TYPE_HELM);
             nSlot = INVENTORY_SLOT_HEAD;
             }
          //remove plot flag if necessary -- add it back upon finalizing
          //remove here because plot flag causes 0 gp value to return.
          if (GetPlotFlag(oItem))
             {
             SetLocalInt(oArmourer, HSS_PREFX + "ARMOUR_PLOT_FLAG", 1);
             SetPlotFlag(oItem, FALSE);
             }

          nValue = GetGoldPieceValue(oItem);
          SetLocalInt(oArmourer, HSS_PREFX + "ARMOUR_VALUE", nValue);

          oNew = CopyItem(oItem, oDummy, TRUE);

          HSS_ArmourDummyEquipItem(oDummy, oNew, nSlot, oArmourer);

          SetLocalInt(oArmourer, HSS_PREFX + "CUSTOMER_GENDER", nGender);

          AssignCommand(oArmourer, ClearAllActions());
          AssignCommand(oArmourer, ActionStartConversation(oPC,
                       sConvo, FALSE, FALSE));
          SetLocalObject(oArmourer, HSS_PREFX + "ARMOUR_CUSTOMER", oPC);
          SetLocalString(oArmourer, HSS_PREFX + "ARMOUR_CUSTOMER_ID", sPCID);
          SetLocked(OBJECT_SELF, TRUE);
          }
          //we will inscribe weapons or shields, though
          else
          if (HSS_ArmourIsWeapon(nBase) || HSS_ArmourIsShield(nBase))
          {
          //remove plot flag if necessary -- add it back upon finalizing
          //remove here because plot flag causes 0 gp value to return.
          if (GetPlotFlag(oItem))
             {
             SetLocalInt(oArmourer, HSS_PREFX + "ARMOUR_PLOT_FLAG", 1);
             SetPlotFlag(oItem, FALSE);
             }

          nValue = GetGoldPieceValue(oItem);
          SetLocalInt(oArmourer, HSS_PREFX + "ARMOUR_VALUE", nValue);

          if (HSS_ArmourIsWeapon(nBase))
             {
             SetLocalInt(oArmourer, HSS_PREFX + "ARMOUR_ITEM_TYPE", HSS_TYPE_WEAPON);
             nSlot = INVENTORY_SLOT_RIGHTHAND;
             }
             else
             {
             SetLocalInt(oArmourer, HSS_PREFX + "ARMOUR_ITEM_TYPE", HSS_TYPE_SHIELD);
             nSlot = INVENTORY_SLOT_LEFTHAND;
             }


          oNew = CopyItem(oItem, oDummy, TRUE);
          AssignCommand(oDummy, ActionEquipItem(oNew, nSlot));

          SetLocalInt(oArmourer, HSS_PREFX + "CUSTOMER_GENDER", nGender);

          AssignCommand(oArmourer, ClearAllActions());
          AssignCommand(oArmourer, ActionStartConversation(oPC,
                       sConvo, FALSE, FALSE));
          SetLocalObject(oArmourer, HSS_PREFX + "ARMOUR_CUSTOMER", oPC);
          SetLocalString(oArmourer, HSS_PREFX + "ARMOUR_CUSTOMER_ID", sPCID);
          SetLocked(OBJECT_SELF, TRUE);
          }
          else
          {
          //wrong item type -- give it back.
          AssignCommand(oArmourer, SpeakString(sWrong));
          oNew = CopyItem(oItem, oPC, TRUE);
          DestroyObject(oItem);
          return;
          }
       }

    //item removed from the armour work container
    if (nDist == INVENTORY_DISTURB_TYPE_REMOVED)
       {
       //whoa, we're locked and just had an item removed -- take it back
       if (GetLocked(OBJECT_SELF))
          {
          oNew = CopyItem(oItem, OBJECT_SELF, TRUE);
          DestroyObject(oItem);
          }
       }
}
