void main()
{
    object oNecromancer = GetNearestObjectByTag("JA_URG_NEKROMANT");

    if(!GetIsObjectValid(oNecromancer)){
        SpeakString("*Pentagram mizi*");
        DestroyObject(OBJECT_SELF, 0.5f);
    }

    object oSpawnling = GetNearestObjectByTag("ja_urg_stvura");

    if(!GetIsObjectValid(oSpawnling)){
        location lLoc = GetLocation(OBJECT_SELF);
        effect eEff = EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEff, lLoc);
        CreateObject(OBJECT_TYPE_CREATURE, "ja_urg_stvura", lLoc);
    }
}
