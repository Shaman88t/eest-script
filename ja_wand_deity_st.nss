#include "ja_tokens"

int StartingConditional()
{
    object oTarget = GetLocalObject(GetPCSpeaker(), "JA_WAND_DEITY");

    SetCustomToken( t_Deity_Name, GetName(oTarget) );
    SetCustomToken( t_Deity_Deity, GetDeity(oTarget) );

    if(GetDeity(oTarget) == "")
        return FALSE;

    return TRUE;
}
