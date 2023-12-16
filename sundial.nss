void main()
{
 if(GetIsDay())
    ActionSpeakString("*Stin dopada na cislo "+IntToString(GetTimeHour())+".*");
 else
    ActionSpeakString("*Nesviti slunce*");


}
