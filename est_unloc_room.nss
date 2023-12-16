// Authors  : TondaLee (AV) - Antonin Vins
// Created  : 17/06/2005
// Modified : 17/06/2005

#include "_inc_config"
#include "_inc_db_estate"

void main()
{
    object oPlayer = GetPCSpeaker();
    object oEstateControl = OBJECT_SELF;
    string sEstateControlTag = GetTag(oEstateControl);

    string sDoorTag = GetEstateRoomDoor(sEstateControlTag);

    object oDoor = GetObjectByTag(sDoorTag);

    if (GetLocked(oDoor))
    {
        SetLocked(oDoor, FALSE);
    }
    else
    {
        SetLocked(oDoor, TRUE);
    }
}
