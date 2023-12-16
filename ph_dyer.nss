
void dyer_createlight(location lTarget,int n)
{
  if(n>100)
    CreateObject(OBJECT_TYPE_PLACEABLE, "plc_flamelarge", lTarget,FALSE,"ku_dyer_light"+IntToString(n-100));
  else
    CreateObject(OBJECT_TYPE_PLACEABLE, "plc_solwhite", lTarget,FALSE,"ku_dyer_light"+IntToString(n));

}

void dyer_destroylights()
{
  int i;

  if(GetIsObjectValid(GetLocalObject(OBJECT_SELF,"CUSTOMER")))
    return;

  for(i = 1; i <= 8 ; i++) {
    DestroyObject(GetNearestObjectByTag("ku_dyer_light"+IntToString(i)));

  }

  DeleteLocalInt(OBJECT_SELF,"DYER_MACHINE_ACTIVATED");

}

void main()
{
object oApp = GetNearestObjectByTag("ph_dyers_apparat");
location lHome = GetLocation(OBJECT_SELF);

ActionMoveToObject(oApp);

ActionInteractObject(oApp);

DelayCommand(3.0,ActionMoveToLocation(lHome));


location lTarget1 = GetLocation(GetNearestObjectByTag("ph_svetlo_dyer"));
location lTarget2 = GetLocation(GetNearestObjectByTag("ph_svetlo_dyer1"));


DelayCommand(2.0, dyer_createlight(lTarget1,1));
DelayCommand(4.0, dyer_createlight(lTarget1,2));
DelayCommand(6.0, dyer_createlight(lTarget1,3));


DelayCommand(3.0, dyer_createlight(lTarget2,4));
DelayCommand(5.0, dyer_createlight(lTarget2,5));
DelayCommand(7.0, dyer_createlight(lTarget2,6));
if(GetLocalInt(OBJECT_SELF,"ph_hagol")) {
  DelayCommand(5.0, dyer_createlight(GetLocation(GetNearestObjectByTag("ph_dyerh_fire")),107));
  DelayCommand(6.0, dyer_createlight(GetLocation(GetNearestObjectByTag("ph_dyerh_fire1")),108));


}

SetLocalInt(OBJECT_SELF,"DYER_MACHINE_ACTIVATED",1);

//DelayCommand(5.0,ExecuteScript("ku_dyer_equip",OBJECT_SELF));

//DelayCommand(30.0, dyer_destroylights());
}


