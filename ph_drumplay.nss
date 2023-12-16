void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = GetObjectByTag("ph_wardrum");

SoundObjectPlay(oTarget);

oTarget = GetObjectByTag("ph_wardrum1");

SoundObjectPlay(oTarget);

}
