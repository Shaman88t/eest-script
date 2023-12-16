//::///////////////////////////////////////////////
//:: Name Area clean-up system
//:: FileName  ld_area_enter.nss
//:://////////////////////////////////////////////
/*
    Place this script in the area onenter event
*/
//:://////////////////////////////////////////////
//:: Created By:  Lord Delekhan
//:: Created On:  June 14, 2002
//:: Updated On:  September 19, 2004
//:://////////////////////////////////////////////

#include "_inc_db_characte"
#include "_inc_config"

void main()
{
    object oArea    = GetArea(OBJECT_SELF);
    object oEntering = GetEnteringObject();
    object oPCArea = GetArea(oEntering);

    int nHurt = GetLocalInt(oEntering, LVS_ONENTER_HURT);

    if (nHurt)
    {
        SetPlayerHitPoints(oEntering, LoadCharacterHP(oEntering));
        SetLocalInt(oEntering, LVS_ONENTER_HURT, FALSE);
    }

    GetIsCharacterLegal(oEntering);

    GiveXpFromExploring(oPCArea, oEntering);

    if (!GetIsDM(oEntering))
        IlegalCharacterMoveToTemporaryLocation(oEntering);

    if(GetIsPC(oEntering))
    {
        SetLocalInt(oArea,"InPlay",TRUE);
        SetLocalInt(oEntering,"IsPC",TRUE);
        string sAreaTag = GetTag(oArea);
        if(GetIsObjectValid(GetItemPossessedBy(oEntering, sAreaTag + "_MAP")))
        {
            ExploreAreaForPlayer(OBJECT_SELF,oEntering);
        }
    }

    if (GetIsDM(oEntering))
    {
        SendMessageToPC(oEntering, "<c Lú>Si v oblasti divociny!</c>");
    }
}
