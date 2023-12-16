//script pre placeable deka - onUse

void main()
{
    object oPlayer = GetLastUsedBy();
    string sVyzor = GetLocalString(OBJECT_SELF, "Vyzor");
    CreateItemOnObject(sVyzor, oPlayer);
    FloatingTextStringOnCreature("*Zlozi deku do batohu*",oPlayer,TRUE);
    DestroyObject(OBJECT_SELF,0.0f);
}
