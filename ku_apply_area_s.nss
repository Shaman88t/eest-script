/*
 * Kucik 05.01.2008 pridana ochranna pojistka spanku
 */

#include "subraces"

void main()
{
 if(SUBRACE_DEBUG)
   SendMessageToPC(GetFirstPC(),"Spusten script pro nastaveni prostredi na postavu.");
 object a_oCharacter = GetLocalObject(OBJECT_SELF,"KU_CHARAKTER");
 object oArea = GetLocalObject(OBJECT_SELF,"KU_AREA");
 int a_nSettings = GetLocalInt(OBJECT_SELF,"KU_AREA_SETTINGS");

 if(SUBRACE_DEBUG) {
   SendMessageToPC(a_oCharacter,"Spusten na tobe");
   SendMessageToPC(a_oCharacter,"pro lokaci" + GetTag(oArea));
   SendMessageToPC(a_oCharacter,"s nastavenim" + IntToString(a_nSettings));
 }
// KU_Subraces_OnEnterArea( a_oCharacter, oArea );
// SEI_ApplyAreaSettings( a_oCharacter, oArea, a_nSettings );
 SEI_EnterArea( a_oCharacter, oArea, a_nSettings );
 SetLocalInt(a_oCharacter,"ku_sleeping",0); // ochranna pojistka spanku
}
