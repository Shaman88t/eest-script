#include "ja_lib"

void main()
{
    string sJmeno = GetLocalString(OBJECT_SELF,"sy_majitel");

    if(sJmeno == "" || sJmeno == "nikto") return;

    object oPC = FindPCByName(sJmeno);

    if (!GetIsObjectValid(oPC)) return;

    DeleteLocalObject(oPC, "ja_mula");
}
