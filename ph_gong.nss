void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = GetObjectByTag("ph_gongring");

SoundObjectPlay(oTarget);

oTarget = GetObjectByTag("ph_gongring1");

SoundObjectPlay(oTarget);

}
