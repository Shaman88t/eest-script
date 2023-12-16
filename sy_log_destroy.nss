//objekt zapisovatela nacuva a ked hrac nieje v dialogu zmaze sa

void main()
{
    object oPC = GetLocalObject(OBJECT_SELF,"oActivator");
    SendMessageToPC(oPC,"<cx  >Zatvoril si knihu</c>");
    SetListening(OBJECT_SELF,FALSE);
    SetCommandable(FALSE,OBJECT_SELF);
    DestroyObject(OBJECT_SELF);
}
