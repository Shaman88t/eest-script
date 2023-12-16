void main()
{
    //cierny pentagram
    CreateObject(OBJECT_TYPE_PLACEABLE,"sy_kresba01",GetLocation(GetPCSpeaker()),FALSE,"");
    DestroyObject(GetItemActivated(),0.0f);
}
