#include "ku_gemroad_inc"

void main()
{
  object oWaypoint = OBJECT_SELF;
  if(GetLocalInt(oWaypoint, "KU_PILGRIM_SET_UP"))
    return;

  SetLocalInt(oWaypoint,"KU_PILGRIM_SET_UP",TRUE);

  float fTime = IntToFloat(Random(KU_PILGRIM_MAX_SETUP_TIME));
  DelayCommand(fTime, ku_gemroad_add(oWaypoint));
}
