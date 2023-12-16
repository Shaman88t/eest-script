
//#include "cnr_recipe_utils"

void setRecipeLevelOnWeapon(object oDevice){
    int bOK = FALSE;
    int iBaseLevel =  GetLocalInt(oDevice, "RECIPE_LEVEL_BASE");
    object oItem = GetFirstItemInInventory(oDevice);
    itemproperty ipProperty = GetFirstItemProperty(oItem);
    while(GetIsItemPropertyValid(ipProperty)){
        if((GetItemPropertyType(ipProperty) == ITEM_PROPERTY_ENHANCEMENT_BONUS )){
            int ipCostValue = GetItemPropertyCostTableValue(ipProperty);
            if(ipCostValue == 1){
                SetLocalInt(oDevice, "RECIPE_LEVEL", iBaseLevel - 1);
                bOK = TRUE;
            }else if(ipCostValue == 2){
                SetLocalInt(oDevice, "RECIPE_LEVEL", iBaseLevel + 1);
                bOK = TRUE;
            }else if (ipCostValue == 3){
                SetLocalInt(oDevice, "RECIPE_LEVEL", iBaseLevel + 3);
                bOK = TRUE;
            }
        }
    ipProperty = GetNextItemProperty(oItem);
    }
    if(bOK == FALSE){
        SetLocalInt(oDevice, "RECIPE_LEVEL", iBaseLevel - 3);
    }
    return;
}

int propertyAllowedForTitaning(object oItem)
{
    itemproperty ipProperty = GetFirstItemProperty(oItem);
    while(GetIsItemPropertyValid(ipProperty)){
        int ipType = GetItemPropertyType(ipProperty);
        if(!((ipType == ITEM_PROPERTY_ENHANCEMENT_BONUS )||(ipType== ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION))){
            return FALSE;
        }
    ipProperty = GetNextItemProperty(oItem);
    }

    return TRUE;
}

int propertyAllowedForSilver(object oItem)
{
    itemproperty ipProperty = GetFirstItemProperty(oItem);
    while(GetIsItemPropertyValid(ipProperty)){
        int ipType = GetItemPropertyType(ipProperty);
        if(!((ipType == ITEM_PROPERTY_ENHANCEMENT_BONUS )||(ipType== ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION))){
            return FALSE;
        }
    ipProperty = GetNextItemProperty(oItem);
    }

    return TRUE;
}

int propertyAllowedForFire(object oItem)
{
    itemproperty ipProperty = GetFirstItemProperty(oItem);
    while(GetIsItemPropertyValid(ipProperty)){
        int ipType = GetItemPropertyType(ipProperty);
        if(!((ipType == ITEM_PROPERTY_ENHANCEMENT_BONUS )||(ipType== ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION)||(ipType==ITEM_PROPERTY_MASSIVE_CRITICALS))){
            return FALSE;
        }
    ipProperty = GetNextItemProperty(oItem);
    }

    return TRUE;
}

int propertyAllowedForAcid(object oItem)
{
    itemproperty ipProperty = GetFirstItemProperty(oItem);
    while(GetIsItemPropertyValid(ipProperty)){
        int ipType = GetItemPropertyType(ipProperty);
        if(!((ipType == ITEM_PROPERTY_ENHANCEMENT_BONUS )||(ipType== ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION)||(ipType==ITEM_PROPERTY_MASSIVE_CRITICALS))){
            return FALSE;
        }
    ipProperty = GetNextItemProperty(oItem);
    }

    return TRUE;
}

int propertyAllowedForLighting(object oItem)
{
    itemproperty ipProperty = GetFirstItemProperty(oItem);
    while(GetIsItemPropertyValid(ipProperty)){
        int ipType = GetItemPropertyType(ipProperty);
        if(!((ipType == ITEM_PROPERTY_ENHANCEMENT_BONUS )||(ipType== ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION)||(ipType==ITEM_PROPERTY_MASSIVE_CRITICALS))){
            return FALSE;
        }
    ipProperty = GetNextItemProperty(oItem);
    }

    return TRUE;
}

int propertyAllowedForCold(object oItem)
{
    itemproperty ipProperty = GetFirstItemProperty(oItem);
    while(GetIsItemPropertyValid(ipProperty)){
        int ipType = GetItemPropertyType(ipProperty);
        if(!((ipType == ITEM_PROPERTY_ENHANCEMENT_BONUS )
               ||(ipType== ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION)
               ||(ipType==ITEM_PROPERTY_MASSIVE_CRITICALS))
           ){
            return FALSE;
        }
    ipProperty = GetNextItemProperty(oItem);
    }

    return TRUE;
}

// zjisti jestli predmet nema jiz property, ktera znemoznuje dalsi upravu
int propertyAllowedForCraft(object oItem, object oDevice){
    int iRecipe = GetLocalInt(oDevice, "RECIPE");
        switch(iRecipe)
        {
            case 0:
                return FALSE; break;
            case 1: // titanovani
                return propertyAllowedForTitaning(oItem);break;
            case 2: // stribreni
                return propertyAllowedForSilver(oItem);break;
            case 3: // ocar ohen
                return propertyAllowedForFire(oItem);break;
            case 4: // ocar ohen
                return propertyAllowedForAcid(oItem);break;
            case 5: // ocar ohen
                return propertyAllowedForLighting(oItem);break;
            case 6: // ocar cold
                return propertyAllowedForCold(oItem);break;
            default:
                return FALSE;
        }
    return FALSE;
}

// predmet uvnitr muze byt pouze jeden a musi byt upgradovatelneho typu
int testOnItemIn(object oObject){
    // pouze jeden item
    object oItem = GetFirstItemInInventory(oObject);
    if (GetNextItemInInventory(oObject) != OBJECT_INVALID)
    {
      // jestlize je v placeablu vic nez jeden predmet
      SpeakString("Tak nevim, nevim. Radej po jednom.");
      return FALSE;
    }

    if ( propertyAllowedForCraft(oItem, oObject) == FALSE ) {
       SpeakString("Tato vec je jiz prilis dokonala...");
       return FALSE;
    }

    // item vyhovuje jednomu z itemtypu v promennych int ITEM_TYPE_X
    int iItemTypeBase = GetBaseItemType(oItem);
    int iTemType = -1;
    int iIndex = 0;      //000001002003004
    string sItemTypes = GetLocalString(oObject, "ITEM_TYPE_FOR_CRAFT");
    if( sItemTypes != "" ){
        while(iIndex <= (GetStringLength(sItemTypes) - 1) ){
            iTemType = StringToInt(GetSubString(sItemTypes, iIndex, 3));
            if (iItemTypeBase == iTemType){
                if (GetLocalInt(oObject,"ITEM_TYPE_BASE")==1){
                       setRecipeLevelOnWeapon(oObject);
                }
                return  TRUE;
            }
            iIndex += 3; //popojeti ve stringu na dalsi item type
        }
    }


    SpeakString("Tuhle vec upravit nedokazes...");
    return FALSE;
}

/////////////////////////////////////////////////////////
void testToStart(object oUser)
{

    // Note: A placeable will receive events in the following order...
    // OnOpen, OnUsed, OnDisturbed, OnClose, OnUsed.
    if (GetLocalInt(OBJECT_SELF, "bCnrDisturbed") != TRUE)
    {
      // Skip if the contents have not been altered.
      return;
    }

    SetLocalInt(OBJECT_SELF, "bCnrDisturbed", FALSE);

    // If the Bioware bug is in effect, simulate the closing
    if (GetIsOpen(OBJECT_SELF))
    {
      AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE));
    }

    object oItem = GetFirstItemInInventory(OBJECT_SELF);
    if (oItem == OBJECT_INVALID)
    {
      // Skip if empty.
     SpeakString("Hmm, tak co budem vyrabet");
     return;
    }

}




/////////////////////////////////////////////////////////
void main()
{
  object oUser = GetLastUsedBy();
  if (!GetIsPC(oUser))
  {
    return;
  }
  if (GetLocalInt(OBJECT_SELF, "bCnrDisturbed") != TRUE)
  {
      // Skip if the contents have not been altered.
     return;
  }
  testToStart(oUser);
  if (!(testOnItemIn(OBJECT_SELF)))
  {
    return ;
  }
  else
  {
    ActionStartConversation(oUser, "", TRUE, FALSE);
  }
  // wait until initialization is done before continuing
  //AssignCommand(OBJECT_SELF, testToStart(oUser));
}
