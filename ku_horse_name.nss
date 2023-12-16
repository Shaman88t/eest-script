#include "ku_libchat"
//#include "sy_main_lib"
#include "aps_include"

void main()
{
  object oHorse = OBJECT_SELF;
  object oPC = GetPCSpeaker();
  int i = GetLocalInt(oPC,"KU_CHAT_CACHE_INDEX");
  string sStr = GetLocalString(oPC,KU_CHAT_CACHE+IntToString(i));
  sStr = GetStringLeft(sStr,15);
  SetName(oHorse,sStr);
  SetPersistentString( oPC, "HORSE_NAME", sStr, 0, "pwhorses");

}
