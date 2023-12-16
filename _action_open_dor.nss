//
// $Id$
//
// Authors  : TondaLee (AV) - Antonin Vins
// Create   : 05/05/2005
// Modified : 05/05/2005
// Zavre po urcite dobe dvere

#include "_inc_config"

void ActionCloseDoorFix(object oDoor)
{
    if (GetIsOpen(oDoor))
    {
        ActionCloseDoor(oDoor);
    }
}

void main()
{
   DelayCommand(TIME_TO_CLOSE_DOOR, ActionCloseDoorFix(OBJECT_SELF));
}
