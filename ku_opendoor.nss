void main()
{
  object oDoor = GetNearestObject(OBJECT_TYPE_DOOR);
//  SpeakString("Trying to open door "+GetName(oDoor));
  AssignCommand(oDoor,ActionOpenDoor(oDoor));

  PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);

  DelayCommand(2.0,PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
}
