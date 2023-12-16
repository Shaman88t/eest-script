/*
    Edited by : Sylmael
*/

#include "sy_main_lib"

void main()
{
    //normalne sa vyvola animal companion
    SummonAnimalCompanion();

    //zistim potrebne udaje , OBJECT_SELF je ten co volal script cize HRAC
    object oBeast     = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, OBJECT_SELF);
    object oSoulStone = sy_has_soulitem(OBJECT_SELF);
    int    nHP        = GetLocalInt(oSoulStone, "hp_ani");
    if(nHP >= GetCurrentHitPoints(oBeast))
      nHP = GetCurrentHitPoints(oBeast) - 2;

    //aplikujem dmg na animal companiona
    //je tu jeden future bug, ak zmenim animal companiona pocas lvl mal by sa HP
    //rozdiel na dusi bytosti zmazat
    effect eDmg = EffectDamage(nHP, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oBeast);
    SetLocalObject(OBJECT_SELF,"COMPANION",oBeast);
}
