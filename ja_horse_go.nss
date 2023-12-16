#include "aps_include"

void main()
{
    object oPC = GetPCSpeaker();

    ClearAllActions();
    ActionForceFollowObject(oPC);

//    DeletePersistentVariable( oPC, "LOCATION", "pwhorses");
}
