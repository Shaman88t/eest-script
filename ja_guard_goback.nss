#include "j_inc_other_ai"

void main()
{
    SetAIOn();
//    DeleteLocalObject( OBJECT_SELF, "JA_GUARD_TARGET");

    if(!GetLocalInt( OBJECT_SELF, "JA_GUARD_STOP" )){
        ActionMoveToLocation( GetLocalLocation(OBJECT_SELF, "JA_GUARD_SPOT") );
    }
}
