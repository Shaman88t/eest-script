// Authors  : TondaLee (AV) - Antonin Vins
// Created  : 23/07/2005
// Modified : 23/07/2005

#include "_inc_config"
#include "_inc_db_post"

void main()
{
    object oPlayer = GetPCSpeaker();
    object oTable = GetNearestObjectByTag(PLACEABLE_POST_TABLE);

    ShowPostedObjectInfo(oPlayer);
    GetPostObjects(oPlayer, oTable);

}
