void main()
{
object oObject = GetWaypointByTag("lib_ch_arenyAB");
location lLocation = GetLocation(oObject);
object oActivator = GetLastUsedBy();
AssignCommand(oActivator, ActionJumpToLocation(lLocation));
}
