//::///////////////////////////////////////////////
//:: FileName lis_mag3lv
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 17.2.2005 2:45:34
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Omezen� zalo�en� na povol�n� hr��e
    int iPassed = 0;
    if(GetLevelByClass(CLASS_TYPE_WIZARD, GetPCSpeaker()) >= 11)
        iPassed = 1;
    if(iPassed == 0)
        return FALSE;

    return TRUE;
}
