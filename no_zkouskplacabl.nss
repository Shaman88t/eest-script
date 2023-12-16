
void no_znic(string no_nazev);
void no_efekt(int no_cislo);

void no_znic(string no_nazev)
{
object no_plamen = CreateObject(OBJECT_TYPE_PLACEABLE, "ShaftofLightBlue",GetLocation(OBJECT_SELF),FALSE);
if (GetPlaceableIllumination(no_plamen)) SendMessageToPC(GetFirstPC(),"svetlo uz je on");
SetPlaceableIllumination(no_plamen,TRUE);
RecomputeStaticLighting(GetArea(OBJECT_SELF));
}

void no_efekt(int no_cislo)
{
effect no_effekt =  EffectVisualEffect(no_cislo,FALSE);
ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, no_effekt,GetLocation(OBJECT_SELF),1000.0);
RecomputeStaticLighting(GetArea(OBJECT_SELF));
SendMessageToPC(GetFirstPC(),"cislo je :" + IntToString(no_cislo));
}

void main()
{
/////////////pridavaem grafickej efekt plamene
object no_plamen = CreateObject(OBJECT_TYPE_PLACEABLE, "x3_plc_flame001",GetLocation(OBJECT_SELF),FALSE);


if (GetPlaceableIllumination(no_plamen)==TRUE) SendMessageToPC(GetFirstPC(),"svetlo uz je on");
if (GetPlaceableIllumination(no_plamen)==FALSE) SendMessageToPC(GetFirstPC(),"svetlo bylo off");

SetPlaceableIllumination(no_plamen,TRUE);
no_plamen = CreateObject(OBJECT_TYPE_PLACEABLE, "x3_plc_flame001",GetLocation(GetFirstPC()),FALSE);
SetPlaceableIllumination(no_plamen,TRUE);
DelayCommand(10.0,no_znic("baf"));
RecomputeStaticLighting(GetArea(OBJECT_SELF));

float no_delay = 0.0;
int integer = 1;
while (no_delay < 150.0 ){
DelayCommand(no_delay,no_efekt(integer));
no_delay = no_delay + 4.0;
integer = integer +1;

}
}
