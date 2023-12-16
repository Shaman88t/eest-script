#include "ja_lib"

int StartingConditional()
{

    string sName = GetLocalString(OBJECT_SELF, v_Name);

    if(sName == ""){
        sName = GetRandName(OBJECT_SELF);
        SetLocalString(OBJECT_SELF, v_Name, sName);
    }

    SetCustomToken( t_Name, sName );

    return TRUE;

}
