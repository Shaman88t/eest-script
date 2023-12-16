#include "zep_inc_phenos"
#include "aps_include"

void main(){
    object oItem = GetItemActivated();
    object oPC   = GetItemActivator();

    if(GetTag(oItem) == "ja_kun_getdown"){
        zep_Dismount(oPC, "ja_kun_getdown");
        SetPersistentLocation( oPC, "LOCATION", GetLocation(oPC), 0, "pwhorses");
    }
}
