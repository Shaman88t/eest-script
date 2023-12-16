//ku_terc_spawn
void main()
{

      SetListenPattern(OBJECT_SELF, "**", 777); //listen to all text
      SetListening(OBJECT_SELF, TRUE);          //be sure NPC is listening

      SetLocalString(OBJECT_SELF,"name",GetName(OBJECT_SELF));
      SetLocalString(OBJECT_SELF,"nl",GetStringLeft(GetDescription(OBJECT_SELF),1));
      SetLocalString(OBJECT_SELF,"desc",GetDescription(OBJECT_SELF));

}

