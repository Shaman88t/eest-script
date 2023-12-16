//vlozit sy_onbash do OnPhysicAttacked event placeablu alebo dveri ktore sa daju rozbit

#include "sy_item_decay"
void main()
{
    eqlBashWeaponDecay(GetLastAttacker(OBJECT_SELF)); //  do the basher's weapon decay
}
