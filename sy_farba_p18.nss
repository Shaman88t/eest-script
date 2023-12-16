void main()
{
    CreateObject(OBJECT_TYPE_PLACEABLE,"sy_kresba18",GetLocation(GetPCSpeaker()),FALSE,"");
    DestroyObject(GetItemActivated(),0.0f);
}
