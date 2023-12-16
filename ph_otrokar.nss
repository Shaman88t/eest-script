void main()
{

object oPC = GetLastPerceived();

if (!GetIsPC(oPC)) return;

if (!GetLastPerceptionSeen()) return;
ActionAttack(GetObjectByTag("ph_whippedslave"));

}
