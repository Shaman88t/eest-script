/*
    Script je linknuty na trigger sy_beamtrigger. Staci ho polozit na zem
    a niekde hodit sosku s tagom sy_beamstatue. Ak hrac stupi na trigger
    z oci sochy vyslahne ladovy luc ktory hracovi pekne zmrzi usmev.
*/

void main()
{
    //zistim nejake premenne
    object oPC     = GetEnteringObject();
    object oStatue = GetNearestObjectByTag("sy_beamstatue");
    int    iElem   = GetLocalInt(oStatue,"sy_element");
    int    iPower  = GetLocalInt(oStatue,"sy_power");

    //zistim z premenej na objekte sochy o aky typ damage sa jedna
    int iBeamDmgType = DAMAGE_TYPE_NEGATIVE;
    int iBeamVfxType = VFX_BEAM_BLACK;
    switch (iElem)
    {
        case 1 : iBeamVfxType = VFX_BEAM_COLD;  iBeamDmgType = DAMAGE_TYPE_COLD; break;
        case 2 : iBeamVfxType = VFX_BEAM_EVIL;  iBeamDmgType = DAMAGE_TYPE_NEGATIVE; break;
        case 3 : iBeamVfxType = VFX_BEAM_FIRE;  iBeamDmgType = DAMAGE_TYPE_FIRE; break;
        case 4 : iBeamVfxType = VFX_BEAM_HOLY;  iBeamDmgType = DAMAGE_TYPE_DIVINE; break;
        case 5 : iBeamVfxType = VFX_BEAM_CHAIN; iBeamDmgType = DAMAGE_TYPE_PIERCING; break;
        case 6 : iBeamVfxType = VFX_BEAM_MIND;  iBeamDmgType = DAMAGE_TYPE_SONIC; break;
        case 7 : iBeamVfxType = VFX_BEAM_LIGHTNING; iBeamDmgType = DAMAGE_TYPE_ELECTRICAL; break;
    }

    if (iPower<1) iPower = 1;
    //nastavim efekt a jeho silu podla premenych sochy
    effect eBeam   = EffectBeam(iBeamVfxType,oStatue,BODY_NODE_HAND,FALSE);
    effect eDMG    = EffectDamage( d6(iPower) ,iBeamDmgType);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oPC,1.0);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDMG,oPC,0.0);
}

