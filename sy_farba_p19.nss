void main()
{
    CreateObject(OBJECT_TYPE_PLACEABLE,"sy_kresba19",GetLocation(GetPCSpeaker()),FALSE,"");
    DestroyObject(GetItemActivated(),0.0f);
}
