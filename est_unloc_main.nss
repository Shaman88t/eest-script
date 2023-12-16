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

    string sInnerDoorTag = GetEstateInnerMainDoor(sEstateControlTag);
    string sOuterDoorTag = GetEstateOuterMainDoor(sEstateControlTag);

    object oInnerDoor = GetObjectByTag(sInnerDoorTag);
    object oOuterDoor = GetObjectByTag(sOuterDoorTag);

    object oDoor;
    if (oInnerDoor == OBJECT_INVALID) oDoor = oOuterDoor;
    else oDoor = oInnerDoor;
    if(oDoor == OBJECT_INVALID) return;

    if (GetLocked(oDoor))
    {
        if (oInnerDoor != OBJECT_INVALID) SetLocked(oInnerDoor, FALSE);
        if (oOuterDoor != OBJECT_INVALID) SetLocked(oOuterDoor, FALSE);
    }
    else
    {
        if (oInnerDoor != OBJECT_INVALID) SetLocked(oInnerDoor, TRUE);
        if (oOuterDoor != OBJECT_INVALID) SetLocked(oOuterDoor, TRUE);
    }
}
