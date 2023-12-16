/************************ [On Percieve] ****************************************
    Filename: j_ai_onpercieve or nw_c2_default2
************************* [On Percieve] ****************************************
    If the target is an enemy, attack
    Will determine combat round on that person, is an enemy, basically.
    Includes shouting for a big radius - if the spawn in condition is set to this.

    NOTE: Debug strings in this file will be uncommented for speed by default.
          - It is one of the most intensive scripts as it runs so often.
          - Attempted to optimise as much as possible.
************************* [History] ********************************************
    1.3 - We include j_inc_other_ai to initiate combat (or go into combat again)
                - j_inc_other_ai holds all other needed functions/integers ETC.
        - Turn off hide things.
        - Added "Only attack if attacked"
        - Removed special conversation things. Almost no one uses them, and the taunt system is easier.
        - Should now search around if they move to a dead body, and only once they get there.
************************* [Workings] *******************************************
    It fires:

    - When a creature enters it perception range (Set in creature properties) and
      is seen or heard.
    - When a creature uses invisiblity/leaves the area in the creatures perception
      range
    - When a creature appears suddenly, already in the perception range (not
      the other way round, normally)
    - When a creature moves out of the creatures perception range, and therefore
      becomes unseen.
************************* [Arguments] ******************************************
    Arguments: GetLastPerceived, GetLastPerceptionSeen, GetLastPerceptionHeard,
               GetLastPerceptionVanished, GetLastPerceptionInaudible.
************************* [On Percieve] ***************************************/

#include "j_inc_other_ai"
#include "ja_lib"

// Watch person oPerceived every time seconds and check, if is too close
void __WaitToCheck(object oPerceived, int close, float time);
void CheckCaught();
void Warn();
void AreaCheck();
void Clear();


int __GetIsBaneddCreature(object oPerceived,object oGuard) {

  /* Mulu nech na pokoji */
//  SendMessageToPC(GetFirstPC(),"kontrola tagu: "+GetStringLeft(GetTag(oPerceived),7)+" - sy_mula");
  if(GetStringLeft(GetTag(oPerceived),7) == "sy_mula") {
    return 0;
//    SendMessageToPC(GetFirstPC(),"Mula");
  }

  object oMod = GetModule();

  int mesto = GetLocalInt(oMod,"KU_STRAZ_"+GetTag(oGuard));

  return GetLocalInt(oMod,"KU_BAN_RACES_"+IntToString(mesto)+"_"+IntToString(GetRacialType(oPerceived)));
}


void __WaitToCheck(object oPerceived, int close, float time) {
   int iDistance = FloatToInt(GetDistanceToObject(oPerceived));
//   SendMessageToPC(oPerceived,"Vzdalenost "+IntToString(iDistance));

   /* Zmizel z dosahu - zrus sledovani */
   if( (iDistance == -1) || (iDistance > 20)) {
//      SendMessageToPC(oPerceived,"zmizel");
      return;
   }
   /* Nekoho kontroluju, nebo nekdo kontroluje tohodle */
   else if( GetIsObjectValid(GetLocalObject( OBJECT_SELF, "JA_GUARD_TARGET")) ||
            ( GetLocalInt( oPerceived, "JA_GUARD_CAUGHT" ) != 0 )             ) {
//      SendMessageToPC(oPerceived,"chycen jinym");
      return;
   }
   /* Prisel dost blizko zacnem s kontrolou*/
   else if(iDistance <= close) {
     /* Zjistime, jestli ma zakrytou tvar */
     if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_HEAD,oPerceived))) {
       SetAIOff();
       ClearAllActions();

       SetActionMode( OBJECT_SELF, ACTION_MODE_DETECT, FALSE );
       SetActionMode( OBJECT_SELF, ACTION_MODE_STEALTH, FALSE );

       FloatingTextStringOnCreature("Straz na tebe vola aby jsi se zastavil!", oPerceived, FALSE);
       SetLocalLocation( OBJECT_SELF, "JA_GUARD_SPOT", GetLocation(OBJECT_SELF) );
       SpeakString("Hej ty, stuj!");
       PlayVoiceChat(VOICE_CHAT_HOLD,OBJECT_SELF);
       SetLocalInt( oPerceived, "JA_GUARD_CAUGHT", 1);
       SetLocalObject( OBJECT_SELF, "JA_GUARD_TARGET", oPerceived );
       SetLocalObject( OBJECT_SELF, "JA_GUARD_OLD_AREA", GetArea(oPerceived) );
       DelayCommand( 2.0, AreaCheck() );
       DelayCommand( 15.0, Warn() );
       DelayCommand( 30.0, CheckCaught() );
       DelayCommand( 300.0, Clear() );
       ActionStartConversation(oPerceived, "ku_guard_check_1");
     }
     /* Pokud je mu videt do ksichtu */
     else {
       SetAIOff();
       ClearAllActions();

       SetActionMode( OBJECT_SELF, ACTION_MODE_DETECT, FALSE );
       SetActionMode( OBJECT_SELF, ACTION_MODE_STEALTH, FALSE );

       FloatingTextStringOnCreature("Straz na tebe vola aby jsi se zastavil!", oPerceived, FALSE);
       SetLocalLocation( OBJECT_SELF, "JA_GUARD_SPOT", GetLocation(OBJECT_SELF) );
       SpeakString("Hej ty, stuj!");
       PlayVoiceChat(VOICE_CHAT_HOLD,OBJECT_SELF);
       SetLocalInt( oPerceived, "JA_GUARD_CAUGHT", 1);
       SetLocalObject( OBJECT_SELF, "JA_GUARD_TARGET", oPerceived );
       SetLocalObject( OBJECT_SELF, "JA_GUARD_OLD_AREA", GetArea(oPerceived) );
       DelayCommand( 2.0, AreaCheck() );
       DelayCommand( 15.0, Warn() );
       DelayCommand( 30.0, CheckCaught() );
       DelayCommand( 300.0, Clear() );
       ActionStartConversation(oPerceived, "ku_guard_check_3");
     }
   }
   /* Dal sledovat a cekat */
   else {
//     SendMessageToPC(oPerceived,"executing next check");
     DelayCommand(time,__WaitToCheck(oPerceived,close,time));
   }

}

void CheckCaught(){
    object oPC = GetLocalObject( OBJECT_SELF, "JA_GUARD_TARGET" );
    SetAIOn();

    if( !GetIsObjectValid(oPC) )
        return;

    location lLoc = GetLocalLocation( OBJECT_SELF, "JA_GUARD_SPOT2");
    int iCaught = GetLocalInt( oPC, "JA_GUARD_CAUGHT" );
    if( iCaught == 1 && GetDistanceBetweenLocations(lLoc, GetLocation(OBJECT_SELF)) < 5.0 ){
        SpeakString("*zastavi se* Ksakru. Ale co, snad to neni ostrovan.");
        SendMessageToAllDMs("Straz kontrolujici "+GetName(oPC)+" se pravdepodobne zasekla, zastavuje stihani");
        DeleteLocalObject( OBJECT_SELF, "JA_GUARD_TARGET");
        SetLocalInt( oPC, "JA_GUARD_CAUGHT", 0 );
    }
    else if ( iCaught == 1 ) {
        SpeakString("Chytte ho!!");
        SetIsTemporaryEnemyInSphere( oPC );
    }

//    DeleteLocalObject( OBJECT_SELF, "JA_GUARD_TARGET");
}

void Warn(){
    object oPC = GetLocalObject( OBJECT_SELF, "JA_GUARD_TARGET" );

    if(GetLocalInt( oPC, "JA_GUARD_CAUGHT" ) == 1){
        SpeakString("Stuj!! Nebo vyhlasim poplach!");
    }

    SetLocalLocation( OBJECT_SELF, "JA_GUARD_SPOT2", GetLocation(OBJECT_SELF) );
}

void AreaCheck(){
    object oPC = GetLocalObject( OBJECT_SELF, "JA_GUARD_TARGET" );
    object oOldArea = GetLocalObject( OBJECT_SELF, "JA_GUARD_OLD_AREA" );

    if(GetArea(oPC) != oOldArea){
        DeleteLocalObject( OBJECT_SELF, "JA_GUARD_TARGET");
        SetLocalInt( oPC, "JA_GUARD_CAUGHT", 0 );
    }
}

void Clear(){
    object oPC = GetLocalObject( OBJECT_SELF, "JA_GUARD_TARGET" );

    DeleteLocalObject( OBJECT_SELF, "JA_GUARD_TARGET" );
    DeleteLocalObject( oPC, "JA_GUARD_CAUGHT");
    ActionMoveToLocation( GetLocalLocation(OBJECT_SELF, "JA_GUARD_SPOT") );
}

void main()
{
    if(!GetLocalInt(GetArea(OBJECT_SELF),"ku_notempty"))
      return;

    object oPerceived = GetLastPerceived();


    if(proceedMaster()){
        ExecuteScript("nw_ch_ac2", OBJECT_SELF);
        return;
    }

    // Percieve pre event.
    if(FireUserEvent(AI_FLAG_UDE_PERCIEVE_PRE_EVENT, EVENT_PERCIEVE_PRE_EVENT))
        // We may exit if it fires
        if(ExitFromUDE(EVENT_PERCIEVE_PRE_EVENT)) return;

    // AI status check. Is the AI on?
    if(GetAIOff()) return;

    // Declare main things.
    // - We declare OUTSIDE if's JUST IN CASE!
    oPerceived = GetLastPerceived();
    object oAttackTarget = GetAttackTarget();
    int bSeen = GetLastPerceptionSeen();
    int bHeard = GetLastPerceptionHeard();


    // Need to be valid and not ignorable.
    if(GetIsObjectValid(oPerceived) &&
      !GetIsDM(oPerceived) &&
      !GetIgnore(oPerceived))
    {
        // First, easy enemy checks.
        if(GetIsEnemy(oPerceived) && !GetFactionEqual(oPerceived))
        {
            // Turn of hiding, a timer to activate Hiding in the main file. This is
            // done in each of the events, with the opposition checking seen/heard.
            TurnOffHiding(oPerceived);

            // Well, are we both inaudible and vanished?
            // * the GetLastPerception should only say what specific event has fired!
            if(GetLastPerceptionInaudible() || GetLastPerceptionVanished())
            {
                // If they just became invisible because of the spell
                // invisiblity, or improved invisiblity...we set a local object.
                // - Beta: Added in ethereal as well.
                if(GetHasEffect(EFFECT_TYPE_INVISIBILITY, oPerceived) ||
                   GetHasEffect(EFFECT_TYPE_ETHEREAL, oPerceived) ||
                   GetStealthMode(oPerceived) == STEALTH_MODE_ACTIVATED)
                {
                    // Set object, AND the location they went invisible!
                    SetAIObject(AI_LAST_TO_GO_INVISIBLE, oPerceived);
                    // We also set thier location for AOE dispelling - same name
                    SetLocalLocation(OBJECT_SELF, AI_LAST_TO_GO_INVISIBLE, GetLocation(oPerceived));
                }

                // If they were our target, follow! >:-D
                // - Optional, on spawn option, for following through areas.
                if(oAttackTarget == oPerceived)
                {
                    // This means they have exited the area! follow!
                    if(GetArea(oPerceived) != GetArea(OBJECT_SELF))
                    {
                        ClearAllActions();
                        // 51: "[Perception] Our Enemy Target changed areas. Stopping, moving too...and attack... [Percieved] " + GetName(oPerceived)
                        DebugActionSpeakByInt(51, oPerceived);
                        // Call to stop silly moving to enemies if we are fleeing
                        ActionMoveToEnemy(oPerceived);
                    }
                    // - Added check for not casting a spell. If we are, we finnish
                    //  (EG: AOE spell) and automatically carry on.
                    else if(GetCurrentAction() != ACTION_CASTSPELL)
                    {
                        ClearAllActions();
                        // 52: "[Perception] Enemy Vanished (Same area) Retargeting/Searching [Percieved] " + GetName(oPerceived)
                        DebugActionSpeakByInt(52, oPerceived);
                        DetermineCombatRound(oPerceived);
                    }
                }
            }// End if just gone out of perception
            // ELSE they have been SEEN or HEARD. We don't check specifics.
            else //if(bSeen || bHeard)
            {
                // If they have been made seen, and they are our attack target,
                // we must re-do combat round - unless we are casting a spell.
                if(bSeen && GetCurrentAction() != ACTION_CASTSPELL &&
                  (oAttackTarget == oPerceived || !GetObjectSeen(oAttackTarget)))
                {
                    //SpeakString("Seen");
                    AISpeakString(I_WAS_ATTACKED);
                    // 53: "[Perception] Enemy seen, and was old enemy/cannot see current. Re-evaluating (no spell) [Percieved] " + GetName(oPerceived)
                    DebugActionSpeakByInt(53, oPerceived);
                    DetermineCombatRound(oPerceived);
                }
                // Else We check if we are already attacking.
                else if(!CannotPerformCombatRound() &&
                        !GetSpawnInCondition(AI_FLAG_OTHER_ONLY_ATTACK_IF_ATTACKED, AI_OTHER_MASTER))
                {
                    // Special shout, d1000 though!
                    SpeakArrayString(AI_TALK_ON_PERCIEVE_ENEMY, TRUE);

                    // Stop stuff because of facing point - New enemy
                    HideOrClear();

                    // Face the person (this helps stops sneak attacks if we then
                    // cast something on ourselves, ETC).
                    SetFacingPoint(GetPosition(oPerceived));

                    // Get all allies in 60M to come to thier aid. Talkvolume silent
                    // shout does not seem to work well.
                    // - void function. Checks for the spawn int. in it.
                    // - Turns it off in it too
                    // - Variable range On Spawn
                    ShoutBossShout(oPerceived);

                    // Warn others
                    AISpeakString(I_WAS_ATTACKED);
                    // 54: "[Perception] Enemy Seen. Not in combat, attacking. [Percieved] " + GetName(oPerceived)
                    DebugActionSpeakByInt(54, oPerceived);
                    // Note: added ActionDoCommand, so that SetFacingPoint is not
                    // interrupted.
                    ActionDoCommand(DetermineCombatRound(oPerceived));
                }
            }
        }
        // Else, they are an equal faction, or not an enemy (or both)
        else
        {
            // If they are dead, say we saw something on waypoints, we charge in
            // to investigate.
            // * Higher intelligence will buff somewhat as well!
            if(GetIsDead(oPerceived) && (bSeen || bHeard))
            {
                // Warn others
                AISpeakString(I_WAS_ATTACKED);
                // Check if we can attack
                if(!CannotPerformCombatRound())
                {
                    // Hide or clear actions
                    HideOrClear();
                    // 55: "[Perception] Percieved Dead Friend! Moving and Searching [Percieved] " + GetName(oPerceived)
                    DebugActionSpeakByInt(55, oPerceived);
                    ActionMoveToLocation(GetLocation(oPerceived), TRUE);
                    ActionDoCommand(DetermineCombatRound());
                }
            }
            else if(GetIsInCombat(oPerceived) && (bSeen || bHeard))
            {
                // Warn others
                AISpeakString(I_WAS_ATTACKED);
                // Only if we can attack.
                if(!CannotPerformCombatRound())
                {
                    // Hide or clear actions
                    HideOrClear();
                    // 56: "[Perception] Percieved Alive Fighting Friend! Moving to and attacking. [Percieved] " + GetName(oPerceived)
                    DebugActionSpeakByInt(56, oPerceived);
                    ActionMoveToLocation(GetLocation(oPerceived), TRUE);
                    ActionDoCommand(DetermineCombatRound());
                }
            }
/*melviktest  else if( GetIsGuard(OBJECT_SELF) ) {
              if( bSeen && GetIsPC(oPerceived) && !GetIsInCombat() ){      //are we guards in state for check?
//              SendMessageToPC(oPerceived,"Checking you");
              // Pokud uz nekoho nekontroluju
                if(!GetIsObjectValid(GetLocalObject( OBJECT_SELF, "JA_GUARD_TARGET"))){
                  if( GetLocalInt( oPerceived, "JA_GUARD_CAUGHT" ) == 0 ){

                      // Kontrola hledanych osob
                       int check = 0;
                      // Zakrytej ksicht
                       if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_HEAD,oPerceived)))
                         check = 1;
                      // Noc
                       if(GetIsNight())
                         check = check + 2;
                       switch(check) {
                       // Den, odkrytej ksicht
                         case 0:
                             if( Random(150) < GetWantedPerson(oPerceived,OBJECT_SELF) )
                               __WaitToCheck(oPerceived,10,1.0);
                           break;
                        // Den, helma
                         case 1:
                             if( Random(100) < 5 )
                               __WaitToCheck(oPerceived,10,1.0);
                           break;
                        // Noc, odkrytej ksicht
                         case 2:
                             if( Random(200) < GetWantedPerson(oPerceived,OBJECT_SELF) )
                                __WaitToCheck(oPerceived,6,1.0);
                           break;
                         // Noc, helma
                         case 3:
                             if( Random(100) < 20 )
                             __WaitToCheck(oPerceived,6,1.0);
                           break;
                       }

 */

/*                        SetAIOff();
                        ClearAllActions();

                        SetActionMode( OBJECT_SELF, ACTION_MODE_DETECT, FALSE );
                        SetActionMode( OBJECT_SELF, ACTION_MODE_STEALTH, FALSE );

                        FloatingTextStringOnCreature("Straz na tebe vola aby jsi se zastavil!", oPerceived, FALSE);
                        SetLocalLocation( OBJECT_SELF, "JA_GUARD_SPOT", GetLocation(OBJECT_SELF) );
                        SpeakString("Hej ty, stuj!");
                        PlayVoiceChat(VOICE_CHAT_HOLD,OBJECT_SELF);
                        SetLocalInt( oPerceived, "JA_GUARD_CAUGHT", 1);
                        SetLocalObject( OBJECT_SELF, "JA_GUARD_TARGET", oPerceived );
                        SetLocalObject( OBJECT_SELF, "JA_GUARD_OLD_AREA", GetArea(oPerceived) );
                        DelayCommand( 2.0, AreaCheck() );
                        DelayCommand( 15.0, Warn() );
                        DelayCommand( 30.0, CheckCaught() );
                        DelayCommand( 300.0, Clear() );
                        ActionStartConversation(oPerceived, "ja_guard_check");
*/
//                    }
/*melviktest                  }
                }
              } else {
                int bancr = __GetIsBaneddCreature(oPerceived,OBJECT_SELF);
                if( (bancr) && (GetIsPC(GetMaster(oPerceived))) ){
                  object oPC = GetMaster(oPerceived);
                  if(GetObjectSeen(oPC) && bancr == 1) {
                     FloatingTextStringOnCreature("Straz na tebe vola!", oPC, FALSE);
                     SpeakString("Hej! Okamzite tu potvoru odsud odved!");
                     PlayVoiceChat(VOICE_CHAT_HOLD,OBJECT_SELF);
                   }
                   else if(bancr == 2){
                     int nowalk=GetLocalInt(OBJECT_SELF,"AI_NOWALK");
                     SetLocalLocation( OBJECT_SELF, "JA_GUARD_SPOT", GetLocation(OBJECT_SELF) );
                     SpeakString("Pozor! Zabte to!");
                     PlayVoiceChat(VOICE_CHAT_ATTACK,OBJECT_SELF);
                     SetAIOn();
                     SetIsTemporaryEnemyInSphere( oPerceived );
                     DelayCommand( 300.0, Clear() );
                     DelayCommand( 310.0, SetLocalInt(OBJECT_SELF,"AI_NOWALK",nowalk) );
                   }
                   else {
                     FloatingTextStringOnCreature("Straz na tebe vola!", oPC, FALSE);
                     SpeakString("Hej! Okamzite tu potvoru odsud odved!");
                     PlayVoiceChat(VOICE_CHAT_HOLD,OBJECT_SELF);
//                     if(GetDistanceBetween(oPC,oPerceived) > 10.0) {
//                       DelayCommand(10.0__DelayKillFamiliar(oPerceived,oPC));
//                     }
                   }


                }

              }
            }*/
        }
    }

    // Fire End of Percieve event
    FireUserEvent(AI_FLAG_UDE_PERCIEVE_EVENT, EVENT_PERCIEVE_EVENT);
}
