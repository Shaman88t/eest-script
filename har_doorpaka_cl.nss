// do OnClose eventu dveri co sa otvaraju pakou

void main()
{
     string sPaka = GetLocalString(OBJECT_SELF, "liv_cvp_pakaport");
     AssignCommand(GetObjectByTag(sPaka) ,ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
}
