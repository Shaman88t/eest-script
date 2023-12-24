#include "citygate_inc"
void CloseAndLock(object oDoor)
{
    AssignCommand(oDoor, ActionCloseDoor(oDoor));
    SetLocked(oDoor,TRUE);
}

void UnlockAndOpen(object oDoor)
{
    SetLocked(oDoor,FALSE);
    AssignCommand(oDoor, ActionOpenDoor(oDoor));
}


void main()
{
    object oPC = GetClickingObject();
    object oGate = OBJECT_SELF;
    object oGuard = OBJECT_INVALID;
    string sGuard = GetLocalString(oGate,"guard");
    int iCity = GetLocalInt(oGate,"city");
    string sType = GetLocalString(oGate,"type");
    if (sType != "city_gate") return;
    if (iCity <= 0) return;

    if (sGuard != "")
    {
        oGuard = GetNearestObjectByTag(sGuard,oPC);
        if (GetIsObjectValid(oGuard))
        {
            if (GetDistanceBetween(oGuard,oPC) >= 16.0)
            {
                oGuard = OBJECT_INVALID;
            }
        }
    }
    int iPassResult = GetCityGateStatus(oPC,iCity);
    switch (iPassResult)
    {
        case CITYGATE_STATUS_OK: //Mùže vstoupit
        {
            //Validace
            if (GetIsObjectValid(oGuard))
            {
                AssignCommand(oGuard,ActionSpeakString("Mùžete vstoupit."));
            }
            DelayCommand(2.0,UnlockAndOpen(oGate));
            DelayCommand(15.0,CloseAndLock(oGate));
        }
        case CITYGATE_STATUS_SHOWHELMET:
        {
            AssignCommand(oGuard,ActionSpeakString("Ukažte oblièej."));
        }
        case CITYGATE_STATUS_INVALIDRACE:
        {
            AssignCommand(oGuard,ActionSpeakString("Táhni. Tudy neprojdeš."));
        }
    }
}
