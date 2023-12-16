void main()
{
 int i = 1;
 string sArea = GetLocalString(OBJECT_SELF,"area_"+IntToString(i));
 string sSound = GetLocalString(OBJECT_SELF,"sound");
 string sMessage = GetLocalString(OBJECT_SELF,"message");
 object oArea;
 object oPC;
 int j;

 while(GetStringLength(sArea) > 0) {
   oArea = GetFirstObjectInArea(GetObjectByTag(sArea));

   j=1;
   oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC,oArea,j);
   while(GetIsObjectValid(oPC)) {
     SendMessageToPC(oPC,sMessage);
     AssignCommand(oPC,PlaySound(sSound));
     j++;
     oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC,oArea,j);
   }

   i++;
   sArea = GetLocalString(OBJECT_SELF,"area_"+IntToString(i));
 }

}
