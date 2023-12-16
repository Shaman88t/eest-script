const float INTERVAL = 0.2;    //check interval in seconds
const string IN_HIDE = "JA_WAS_IN_HIDE";


//declaration
void sdRun();

void main()
{
    sdRun();
}

void sdRun(){
    object oPC = GetFirstPC();

    while( GetIsObjectValid(oPC)  ){
        if( GetLocalInt( oPC, IN_HIDE ) ){
             if (! GetActionMode(oPC, ACTION_MODE_STEALTH)){
                effect e = ExtraordinaryEffect(EffectSkillDecrease( SKILL_HIDE, 50 ));
                effect e2 = ExtraordinaryEffect(EffectSkillDecrease( SKILL_MOVE_SILENTLY, 50 ));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, e, oPC, 10.0f);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, e2, oPC, 10.0f);
                DeleteLocalInt( oPC, IN_HIDE );
             }
        }
        else if( GetActionMode(oPC, ACTION_MODE_STEALTH) ) {
            SetLocalInt( oPC, IN_HIDE, 1 );
        }

        oPC = GetNextPC();
    }

    DelayCommand(INTERVAL, sdRun());
}

