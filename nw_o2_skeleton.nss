//::///////////////////////////////////////////////
//:: NW_O2_SKELETON.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
   Turns the placeable into a skeleton
   if a player comes near enough.
*/
//:://////////////////////////////////////////////
//:: Created By:   Brent
//:: Created On:   January 17, 2002
//:://////////////////////////////////////////////
#include "ja_inc_frakce"

void ActionCreate(string sCreature, location lLoc)
{
    object oNPC = CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLoc);
    OverrideFaction(oNPC);

}
void main()
{
   object oCreature = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
   if (GetIsObjectValid(oCreature) == TRUE && GetDistanceToObject(oCreature) < 10.0)
   {
    effect eMind = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    string sCreature = "skelwarr006";
    // * 10% chance of a skeleton chief instead
    int iRand = Random(100);
    if (iRand > 90)
    {
        sCreature = "skelchief001";
    }
    else if(iRand > 40)
        sCreature = "skelwarr007";

    location lLoc = GetLocation(OBJECT_SELF);
    DelayCommand(0.3, ActionCreate(sCreature, lLoc));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eMind, GetLocation(OBJECT_SELF));
    SetPlotFlag(OBJECT_SELF, FALSE);
    DestroyObject(OBJECT_SELF, 0.5);
   }
}
