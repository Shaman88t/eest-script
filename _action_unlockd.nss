// Authors  : TondaLee (AV) - Antonin Vins
// Create   : 18/06/2005
// Modified : 18/06/2005
// Zamkne po urcite dobe dvere

#include "_inc_config"

void main()
{
   DelayCommand(TIME_TO_LOCK_DOOR, SetLocked(OBJECT_SELF, TRUE));
}
