// Authors  : TondaLee (AV) - Antonin Vins
// Created  : 17/06/2005
// Modified : 17/06/2005

#include "_inc_config"
#include "_inc_db_estate"

// zjisti o jakou nemovitost se jedna dle nejblizsiho tagu
// podle toho nastavi lokalni promenou a tokeny
int StartingConditional()
{
    object oPlayer = GetPCSpeaker();
    object oEstateControl = OBJECT_SELF;
    string sEstateControlTag = GetTag(oEstateControl);

    SetCustomToken(TOKEN_ESTATE_NAME, GetEstateName(sEstateControlTag));
    SetCustomToken(TOKEN_ESTATE_OWNER, GetEstateOwnerCharacterName(sEstateControlTag));

    if (GetIsEstateOwner(sEstateControlTag, oPlayer) || GetIsDM(oPlayer))
    {
        string sDoorTag = GetEstateOuterMainDoor(sEstateControlTag);
        object oDoor = GetObjectByTag(sDoorTag);
        if (oDoor != OBJECT_INVALID)
            if (GetLocked(oDoor))
                SetCustomToken(TOKEN_ESTATE_MAIN_DOOR, "zamcene");
            else
                SetCustomToken(TOKEN_ESTATE_MAIN_DOOR, "odemcene");
        else SetCustomToken(TOKEN_ESTATE_MAIN_DOOR, "nejsou");

        sDoorTag = GetEstateWorkDoor(sEstateControlTag);
        oDoor = GetObjectByTag(sDoorTag);
        if (oDoor != OBJECT_INVALID)
            if (GetLocked(oDoor))
                SetCustomToken(TOKEN_ESTATE_WORK_DOOR, "zamcene");
            else
                SetCustomToken(TOKEN_ESTATE_WORK_DOOR, "odemcene");
        else SetCustomToken(TOKEN_ESTATE_WORK_DOOR, "nejsou");

        sDoorTag = GetEstateRoomDoor(sEstateControlTag);
        oDoor = GetObjectByTag(sDoorTag);
        if (oDoor != OBJECT_INVALID)
            if (GetLocked(oDoor))
                SetCustomToken(TOKEN_ESTATE_ROOM_DOOR, "zamcene");
            else
                SetCustomToken(TOKEN_ESTATE_ROOM_DOOR, "odemcene");
        else SetCustomToken(TOKEN_ESTATE_ROOM_DOOR, "nejsou");
    }
    else
    {
        SetCustomToken(TOKEN_ESTATE_MAIN_DOOR, "nemate opravneni");
        SetCustomToken(TOKEN_ESTATE_WORK_DOOR, "nemate opravneni");
        SetCustomToken(TOKEN_ESTATE_ROOM_DOOR, "nemate opravneni");
    }
    return 1;
}

