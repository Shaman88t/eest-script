#include "ja_lib"

int StartingConditional()
{

    string sDeity = GetLocalString(OBJECT_SELF, v_Deity);

    if(sDeity == ""){
        sDeity = GetRandDeity(OBJECT_SELF);
        SetLocalString(OBJECT_SELF, v_Deity, sDeity);
    }

    SetCustomToken( t_Deity, sDeity );

    return TRUE;

}

