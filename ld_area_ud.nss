//::///////////////////////////////////////////////
//:: Name Area clean-up system
//:: FileName  ld_area_ud.nss
//:://////////////////////////////////////////////
/*
    Place this script in the area user defined event
*/
//:://////////////////////////////////////////////
//:: Created By:  Lord Delekhan
//:: Created On:  June 14, 2002
//:: Updated On:  May 17, 2005
//:://////////////////////////////////////////////

void main()
{
    int nUser=GetUserDefinedEventNumber();
    switch(nUser)
        {
        case 3000:
            {
            object oArea = GetArea(OBJECT_SELF);
            object oChk = GetFirstObjectInArea(oArea);
            int nDelete = 0;
            while(GetIsObjectValid(oChk))
                {
                if(GetIsPC(oChk) || GetLocalInt(oArea,"InPlay"))
                    {return;}
                oChk = GetNextObjectInArea(oArea);
                }
            oChk = GetFirstObjectInArea(oArea);
            while(GetIsObjectValid(oChk))
                {
                if(GetIsPC(oChk) || GetLocalInt(oArea,"InPlay"))
                    {return;}
                else if(GetObjectType(oChk) == OBJECT_TYPE_CREATURE)
                {
                    nDelete = TRUE;
                    if (GetLocalInt(oChk,"NPC") || GetIsObjectValid(GetMaster(oChk)) || GetLocalInt(oChk,"NoRemove"))
                    {
                        nDelete = FALSE;
                    }
                    if (nDelete)
                        DestroyObject(oChk);
                }
                else if(GetObjectType(oChk) == OBJECT_TYPE_ITEM)
                        {if(!GetLocalInt(oChk,"IsOwned"))DestroyObject(oChk);}
                else if(GetStringLowerCase(GetName(oChk)) == "remains" || GetStringLowerCase(GetName(oChk)) == "pozùstatky" || GetStringLowerCase(GetName(oChk)) == "pozustatky")
                    {
                    object oItem = GetFirstItemInInventory(oChk);
                    while(GetIsObjectValid(oItem))
                        {
                        DestroyObject(oItem);
                        oItem = GetNextItemInInventory(oChk);
                        }
                    AssignCommand(oChk,SetIsDestroyable(TRUE));
                    DestroyObject(oChk);
                    }
                oChk = GetNextObjectInArea(oArea);
                }
            break;}
        case 3100:
            {
            object oArea = GetArea(OBJECT_SELF);
            object oChk = GetFirstObjectInArea(oArea);
            while(GetIsObjectValid(oChk))
                {
                if(GetIsPC(oChk))
                    {return;}
                oChk = GetNextObjectInArea(oArea);
                }
            oChk = GetFirstObjectInArea(oArea);
            while(GetIsObjectValid(oChk))
                {
                if(GetIsPC(oChk))
                    {return;}
                else if(GetObjectType(oChk) == OBJECT_TYPE_ITEM)
                        {if(!GetLocalInt(oChk,"IsOwned"))DestroyObject(oChk);}
                else if(GetStringLowerCase(GetName(oChk)) == "remains" || GetStringLowerCase(GetName(oChk)) == "pozùstatky" || GetStringLowerCase(GetName(oChk)) == "pozustatky")
                    {
                    object oItem = GetFirstItemInInventory(oChk);
                    while(GetIsObjectValid(oItem))
                        {
                        DestroyObject(oItem);
                        oItem = GetNextItemInInventory(oChk);
                        }
                    AssignCommand(oChk,SetIsDestroyable(TRUE));
                    DestroyObject(oChk);
                    }
                oChk = GetNextObjectInArea(oArea);
                }
            break;}
        }
}


