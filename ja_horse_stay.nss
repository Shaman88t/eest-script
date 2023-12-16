#include "aps_include"

void main()
{
    ClearAllActions();

    object oPC = GetPCSpeaker();
    SetPersistentLocation( oPC, "LOCATION", GetLocation(OBJECT_SELF), 0, "pwhorses");
}
