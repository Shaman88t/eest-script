//::///////////////////////////////////////////////
//:: Name Area clean-up system
//:: FileName  ld_area_exit.nss
//:://////////////////////////////////////////////
/*
    Place this script in the area onexit event
*/
//:://////////////////////////////////////////////
//:: Created By:  Lord Delekhan
//:: Created On:  June 14, 2002
//:: Updated On:  September 19, 2004
//:://////////////////////////////////////////////

#include "_inc_utils"

void main()
{
    object oArea    = GetArea(OBJECT_SELF);
    object oExiting = GetExitingObject();
    event mEvent = EventUserDefined(3000);
    if(GetIsPC(oExiting) || GetLocalInt(oExiting,"IsPC"))
    {
        SaveCharacter(oExiting);
        DelayCommand(10.0,SignalEvent(oArea,mEvent));
        SetLocalInt(oArea,"InPlay",FALSE);
    }
}
