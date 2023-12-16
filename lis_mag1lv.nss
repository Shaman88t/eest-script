//::///////////////////////////////////////////////
//:: FileName lis_mag1lv
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 17.2.2005 2:43:51
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Omezení založená na povolání hráèe
    int iPassed = 0;
    if(GetLevelByClass(CLASS_TYPE_WIZARD, GetPCSpeaker()) >= 1)
        iPassed = 1;
    if(iPassed == 0)
        return FALSE;

    return TRUE;
}
