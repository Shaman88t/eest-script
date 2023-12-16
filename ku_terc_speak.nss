void main()
{
  string sSaid = GetMatchedSubstring(0);

  if(GetDistanceBetween(OBJECT_SELF,GetLastSpeaker()) > 4.0 )
    return;

  if (FindSubString(GetStringLowerCase(sSaid),"vymazat")>-1) {

    SetLocalInt(OBJECT_SELF,"shots",0);
    SetLocalInt(OBJECT_SELF,"hits",0);
    DeleteLocalObject(OBJECT_SELF,"strelec");
    string name = GetLocalString(OBJECT_SELF,"name");
    SetName(OBJECT_SELF,name);
    SpeakString("Vymazano");
    SetDescription(OBJECT_SELF,GetLocalString(OBJECT_SELF,"desc"));
  }

}
