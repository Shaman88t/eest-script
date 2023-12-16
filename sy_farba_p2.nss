void main()
{
    //cerveny pentagram
    CreateObject(OBJECT_TYPE_PLACEABLE,"sy_kresba02",GetLocation(GetPCSpeaker()),FALSE,"");
    DestroyObject(GetItemActivated(),0.0f);
}
