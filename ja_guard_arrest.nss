void main()
{
    object oPrison = GetWaypointByTag("JA_PRISON");
    object oPC = GetPCSpeaker();

    AssignCommand( oPC, ClearAllActions(TRUE) );
    AssignCommand( oPC, JumpToObject(oPrison) );
}
