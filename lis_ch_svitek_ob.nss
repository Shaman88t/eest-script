//::///////////////////////////////////////////////
//:: FileName lis_ch_svitek_tr
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 13.2.2005 20:41:49
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Ujistit se, �e postava m� v invent��i tyto p�edm�ty
    if(!HasItem(GetPCSpeaker(), "liv_ch_svitek_obr"))
        return FALSE;

    return TRUE;
}
