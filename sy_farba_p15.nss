void main()
{
    CreateObject(OBJECT_TYPE_PLACEABLE,"sy_kresba15",GetLocation(GetPCSpeaker()),FALSE,"");
    DestroyObject(GetItemActivated(),0.0f);
}
