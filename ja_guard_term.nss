#include "ja_lib"

void main()
{

    object oPC = GetPCSpeaker();

    ClearAllActions();

    if( GetDistanceBetween(oPC, OBJECT_SELF) > 5.0 ){
        SetAIOn();
        SpeakString("Stuj!");
        SetIsTemporaryEnemyInSphere( oPC );
        //DeleteLocalObject( OBJECT_SELF, "JA_GUARD_TARGET");

    }
    else{
        ActionStartConversation( oPC, "ja_guard_check2" );
    }
}
