void main()
{

object oPC = GetLastPerceived();

if (!GetIsPC(oPC)) return;

if (!GetLastPerceptionSeen()) return;
ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0f, 9999.0f);

}
