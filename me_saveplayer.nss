#include "ja_lib"
#include "ja_inc_stamina"
#include "aps_include"
#include "persistence"

void main()
{
    object oPC = OBJECT_SELF;

    SavePlayer(oPC);
    SendMessageToPC(oPC, "Postava byla ulozena.");

}
