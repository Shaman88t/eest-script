//::///////////////////////////////////////////////
//:: Name: Armourstand OnSpawn
//:: FileName: hss_astand_convo
//:: Copyright Heed.
//:://////////////////////////////////////////////
/*
Make the dummy a dummy.  Also setup listening.
*/
//:://////////////////////////////////////////////
//:: Created By:  Heed
//:: Created On:  March 16, 2006.
//:://////////////////////////////////////////////
//:: Last Update By: Heed
//:: Last Update On: April 23, 2006.

void main()
{
    effect eGhost = SupernaturalEffect(EffectCutsceneGhost());
    effect eFrz = SupernaturalEffect(EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION));
    effect eImmob = SupernaturalEffect(EffectCutsceneImmobilize());
    effect ePara = SupernaturalEffect(EffectCutsceneParalyze());

    //handle instances when we need to copy/destroy the dummy
    //i.e. when a robe is equipped (the supermodel switch doesn't respect
    //the freeze animation effect -- need to reapply on a fresh copy)
    if (GetIsEffectValid(GetFirstEffect(OBJECT_SELF)))
       {
       object oNew = CopyObject(OBJECT_SELF, GetLocation(OBJECT_SELF));

       //1.67 bug workaround.
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oNew);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFrz, oNew );
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eImmob, oNew );
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePara, oNew );

       DestroyObject(OBJECT_SELF);
       }

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFrz, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eImmob, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePara, OBJECT_SELF);

    SetListening(OBJECT_SELF, TRUE);
    SetListenPattern(OBJECT_SELF, "**otocit**", 1390);



}
