#include "x2_inc_itemprop"

// CONSTANTS /////////////////////////////////////////////////////////////////////
const int nITEMDAMAGECHANCE = 40;   // The % chance of the item to get damaged
const int nITEMDAMAGEAMOUNT = 1;    // How much damage gets done each time
const int nPOCETBODOVNAVEC  = 200;  // cez toto sa rata kolko bodov ma dana vec nez sa rozpadne (dat 2 pre test, 200 je normal)
//////////////////////////////////////////////////////////////////////////////////

//zisti podla poskodenia kolko bude stat oprava veci
int sy_ZistiCenuOpravy(object oItem)
{
    int iBonus  = 1 + IPGetWeaponEnhancementBonus(oItem,ITEM_PROPERTY_ENHANCEMENT_BONUS);
    int iMaxDur = (3*nPOCETBODOVNAVEC+nPOCETBODOVNAVEC)*iBonus;
    int iDur    = GetLocalInt(oItem,"sy_dur");
    int iPrice  = GetGoldPieceValue(oItem);
    float fPom  = IntToFloat(iPrice) * (IntToFloat(iDur) / IntToFloat(iMaxDur));
    int iCena   = FloatToInt(fPom);
    //if (iCena<0) iCena = 0;
    return iCena;
}

//Obnovi stav veci, a je ako nova!
void sy_OpravVec(object oItem)
{
    SetLocalInt(oItem,"sy_pen",0);
    SetLocalInt(oItem,"sy_dur",0);
    SetLocalInt(oItem,"sy_mdur",0);

    if (IPGetIsMeleeWeapon(oItem) ||
        GetBaseItemType(oItem)==BASE_ITEM_BRACER ||
        GetBaseItemType(oItem)==BASE_ITEM_GLOVES)
    {
        IPRemoveMatchingItemProperties(oItem,ITEM_PROPERTY_DECREASED_ATTACK_MODIFIER,DURATION_TYPE_PERMANENT);
    }
    else
    {
        IPRemoveMatchingItemProperties(oItem,ITEM_PROPERTY_DECREASED_AC,DURATION_TYPE_PERMANENT);
    }
}

//vyratam novu hranicu v stupni ponicenia
void sy_VypocitajHranicu(object oItem)
{
  int iBonus   = 1 + IPGetWeaponEnhancementBonus(oItem,ITEM_PROPERTY_ENHANCEMENT_BONUS);
  int iPenalty = GetLocalInt(oItem,"sy_pen");
  int iMaxDur  = (iPenalty*nPOCETBODOVNAVEC+nPOCETBODOVNAVEC)*iBonus;
  SetLocalInt(oItem,"sy_mdur",iMaxDur);
}

// Function to damage and/or break an item  //////////////////////////////////////
void eqlDecayItem(object oItem,object oOwner, int bIsWeapon)                                   // Pass the item to be damaged & who it belongs to
{
  if (!GetIsPC(oOwner)) return; //ak to nieje hrac nebudem mu nicit veci

  if (GetLocalInt(oItem,"sy_mdur")==0)                                     // Has the item quality been previously set
  {
    sy_VypocitajHranicu(oItem);                                                 // If it hasnt then call the function to set it
    return;
  }

  int nItemCondition = GetLocalInt(oItem,"sy_dur");                     // Get the current condition of the item
  nItemCondition = nItemCondition + nITEMDAMAGEAMOUNT;                          // Damage it by a set amount
  SetLocalInt(oItem,"sy_dur",nItemCondition);

  //debug msg.
  //object oPC = GetFirstPC();
  //SendMessageToPC(oPC,"kto:"+GetName(oOwner)+" vec:"+GetName(oItem)+" stav:"+IntToString(nItemCondition)+"/"+IntToString(GetLocalInt(oItem,"sy_mdur")));

  if (nItemCondition>=GetLocalInt(oItem,"sy_mdur"))
  {
    int iPenalty = GetLocalInt(oItem,"sy_pen") + 1;
    if (iPenalty==4)
    {
        DestroyObject(oItem);                                                         // If so, destroy the object...
        if (GetIsPC(oOwner))                                                        // and if it belongs to a pc
        {
            SendMessageToPC(oOwner, "Your " + GetName(oItem) +" has broken!");        // notify them of the breakage
        }
        return;
    }
    SetLocalInt(oItem,"sy_pen",iPenalty);
    sy_VypocitajHranicu(oItem);

    //rozdelit na penaltu zbran - brnenie cez premennu vo funkcii
    if (bIsWeapon==1)   // zbran ab dole //if (IPGetIsMeleeWeapon(oItem)==TRUE)
    {
        IPSafeAddItemProperty(oItem, ItemPropertyAttackPenalty(iPenalty) ,0.0f ,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        return;
    }
    if (bIsWeapon==2)   //brnco ac dole
    {
        IPSafeAddItemProperty(oItem, ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_ARMOR ,iPenalty)    ,0.0f ,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        return;
    }
    if (bIsWeapon==3)   //stit ac dole
    {
        IPSafeAddItemProperty(oItem, ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,iPenalty)    ,0.0f ,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
        return;
    }
  }
}

// function to damage an attackers weapon  ///////////////////////////////////////
void eqlAttackerWeaponDecay(object oAttacker)                                   // pass the object causing damage using * getLastDamager() *
{
    int nChanceRoll1 = d100(1);                                                     // roll a d100
    if (nChanceRoll1 >= nITEMDAMAGECHANCE) return;                                  // see whether the object is unlucky enough to get damaged
    if (GetObjectType(oAttacker) != OBJECT_TYPE_CREATURE) return ;                  // only creature to creature damage is supported at the moment    //not sure if this is really needed?
    if (GetDamageDealtByType(DAMAGE_TYPE_BASE_WEAPON) <= 1) return ;                // only physical combat damage is supported at the moment
    object oWeapon = GetLastWeaponUsed(oAttacker);                                  // get the weapon used in the attack
    if (GetBaseItemType(oWeapon)==BASE_ITEM_BRACER) return;//ked nema zbran,tak sa zameraju rukavice(zrejme monk bug :P )
    //zbrane na dialku sa neposkodzuju v boji
    if (IPGetIsRangedWeapon(oWeapon)==TRUE) return;
    if (oWeapon != OBJECT_INVALID) eqlDecayItem( oWeapon, oAttacker, 1);               // if it is a proper weapon not a punch, claw, bite etc then do damage to it
}

// Function to damage a defenders armour  ////////////////////////////////////////
void eqlDefenderArmourDecay(object oDefender)
{
    int nChanceRoll2 = d100(1);
    if (nChanceRoll2 >= nITEMDAMAGECHANCE) return;                                       // see whether the object is unlucky enough to get damaged
    int nChance = Random(2);//d6(1);                                                            // See which item gets it
    object oArmour;

    //debug msg.
    //object oPC = GetFirstPC();
    //SendMessageToPC(oPC,"kto:"+GetName(oDefender)+" chance:"+IntToString(nChance));

    //tu by mohol poskodzovat zbran na dialku ked stoji pri nom
    if (nChance == 0)                                                               // Chest
    {
        oArmour = GetItemInSlot(INVENTORY_SLOT_CHEST,OBJECT_SELF);                    // check to see if there is an item in the slot
        if(GetIsObjectValid(oArmour)) eqlDecayItem(oArmour,oDefender, 2);                // if so damage it
        return;
    }

    if (nChance == 1)                                                              // Arms
    {
        oArmour = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);                     // check to see if there is an item in the slot
        if(GetIsObjectValid(oArmour)) eqlDecayItem(oArmour,oDefender, 3);                // if so damage it
        return;
    }
}

// function to damage an attackers weapon when bashing doors or placeaables //////
void eqlBashWeaponDecay(object oAttacker)                                       // pass the object causing damage using * getLastDamager() *
{
    int nChanceRoll = d100(1);                                                     // roll a d100
    if (nChanceRoll >= nITEMDAMAGECHANCE) return;                                  // see whether the object is unlucky enough to get damaged
    object oWeapon = GetLastWeaponUsed(oAttacker);                                  // get the weapon used in the attack
    if (oWeapon != OBJECT_INVALID) eqlDecayItem( oWeapon, oAttacker, 1);               // if it is a proper weapon not a punch, claw, bite etc then do damage to it
}

/*
void main()
{

}
*/
