/*
    Sem pojde skript na premenu suroveho masa na pecene
*/

void main()
{
    object oPC   = GetLastClosedBy();
    object oItem = GetFirstItemInInventory();
    while (oItem!=OBJECT_INVALID)
    {
        if ((GetTag(oItem)=="Masokraba") ||
            (GetTag(oItem)=="cnrAnimalMeat")||
            (GetStringLeft(GetTag(oItem),7)=="ry_maso") ||
            (GetStringLeft(GetTag(oItem),7)=="ry_ryba") ||
            (GetTag(oItem)=="ry_rak"))
        {
            DestroyObject(oItem);
            CreateItemOnObject("sy_maso_pecene",oPC,1);
        }

        oItem = GetNextItemInInventory();
    }
}
