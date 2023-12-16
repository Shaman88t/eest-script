void main()
{
object oWP = GetWaypointByTag("test");
object oLever = OBJECT_SELF;
object oHovna = GetObjectByTag("sm_hovna");
object oHovna2 = GetObjectByTag("sm1");
object oHovna3 = GetObjectByTag("sm2");
object oHovna4 = GetObjectByTag("sm3");
object oHovna5 = GetObjectByTag("sm4");
object oHovna6 = GetObjectByTag("sm5");
object oHovna7 = GetObjectByTag("sm6");
object oHovna8 = GetObjectByTag("sm7");
object oHovnainfo = GetObjectByTag("sm_hovnainfo");
object oSplouch1 = GetObjectByTag("sm_splouch");
object oSplouch2 = GetObjectByTag("sm_splouch2");

SetLocalInt(oHovna, "iSmrad", 0);
SetUseableFlag(oLever, 0);
DestroyObject(oHovna);
DestroyObject(oHovna2);
DestroyObject(oHovna3);
DestroyObject(oHovna4);
DestroyObject(oHovna5);
DestroyObject(oHovna6);
DestroyObject(oHovna7);
DestroyObject(oHovna8);
DestroyObject(oHovnainfo);
ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
SoundObjectPlay(oSplouch1);
SoundObjectPlay(oSplouch2);
}
