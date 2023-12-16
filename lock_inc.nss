//**///////////////////////////////////////////////////////////////////////////
//** LOCK(NESS) v1.0 - Include File
//**///////////////////////////////////////////////////////////////////////////
//**
//** This is the include which contains all the created functions for LOCK.
//** Do not modify unless you know what you are doing.
//**
//**///////////////////////////////////////////////////////////////////////////
//** Last modification: 08/01/2005
//** Created by Firya'nis & Ex Tempus.
//**///////////////////////////////////////////////////////////////////////////
/*
   * Kucik 27.05.2008 Pridano zapastovani dyn. lootu
   * Kucik 19.10.2008 Pridana promenna oznacujici dynamicky spawnute  NPC
   * Kucik 28. 03. 2010 Dynamic boss loot spawn. Bosses in Limbo.
*/

#include "ja_lib"
#include "ku_libtime"
#include "ku_persist_inc"
#include "nwnx_object"

const string LOCK_LOOT_DEFAULT_RESREF = "x0_tres_goldlow";

//**///////////////////////////////////////////////////////////////////////////
//** LOCK_SpawnCreature()
//**///////////////////////////////////////////////////////////////////////////
//** int RW           : Auto Random Walk.
//** int SD           : Auto Sit Down.
//** int AA           : Auto Animation.
//** location lLoc    : Location of the spawn WP.
//** string sTAG      : TAG of the creature to spawn.
//** string sNewTag   : Assign a new TAG to the creature after the spawn.
//** iDist            : ??
//** oFaction         : Faction to join
//** string sAutoConv : Resref of the dialog to execute after the spawn.
//**///////////////////////////////////////////////////////////////////////////
void LOCK_SpawnCreature(location lLoc, string sTAG, string sNewTag="", object oFaction=OBJECT_INVALID, int iDist=5);

//**///////////////////////////////////////////////////////////////////////////
//** LOCK_SpawnPlaceable()
//**///////////////////////////////////////////////////////////////////////////
//** location lLoc    : Location of the spawn WP.
//** string sTAG      : TAG of the placeable to spawn.
//** string sNewTag   : Assign a new TAG to the placeable after the spawn.
//**///////////////////////////////////////////////////////////////////////////
void LOCK_SpawnPlaceable(location lLoc, string sTAG, string sNewTag="");

//**///////////////////////////////////////////////////////////////////////////
//** LOCK_SpawnObject()
//**///////////////////////////////////////////////////////////////////////////
//** object oPC       : Player which is entering the area.
//** location lLoc    : Location of the spawn WP.
//** string sTAG      : TAG of the item to spawn.
//** string sNewTag   : Assign a new TAG to the item after the spawn.
//**///////////////////////////////////////////////////////////////////////////
void LOCK_SpawnObject(object oPC, location lLoc, string sTAG, string sNewTag="");

//**///////////////////////////////////////////////////////////////////////////
//** LOCK_CleanArea()
//**///////////////////////////////////////////////////////////////////////////
//**
//** This is used to clean the area when the timer reach its limit and nobody
//** entered the area before that.
//**
//**///////////////////////////////////////////////////////////////////////////
void LOCK_CleanArea(object oArea);

//**///////////////////////////////////////////////////////////////////////////
//** LOCK_CleaningTimer()
//**///////////////////////////////////////////////////////////////////////////
//**
//** This is used to countdown the time since the moment the last PC exit from
//** the area to the moment the despawn should occurs.
//**
//**///////////////////////////////////////////////////////////////////////////
void LOCK_CleaningTimer(object oArea, float fDelay=60.0);

//**///////////////////////////////////////////////////////////////////////////
//** LOCK_InitCleaningTimer()
//**///////////////////////////////////////////////////////////////////////////
//**
//** This is used to init the cleaning timer and to execute
//** the LOCK_CleaningTimer() function.
//**
//**///////////////////////////////////////////////////////////////////////////
void LOCK_InitCleaningTimer(object oArea, float fDelay=60.0);

//**///////////////////////////////////////////////////////////////////////////
//** LOCK_ResetCleaningTimer()
//**///////////////////////////////////////////////////////////////////////////
//**
//** This is used to reset the cleaning timer and not start it again.
//**
//**///////////////////////////////////////////////////////////////////////////
void LOCK_ResetCleaningTimer(object oArea);

//**///////////////////////////////////////////////////////////////////////////
//** LOCK_Debug()
//**///////////////////////////////////////////////////////////////////////////
//**
//** Activate/Deactivate Debug Mode (1 = Activated / 0 = Deactivated)
//**
//**///////////////////////////////////////////////////////////////////////////
void LOCK_Debug(string sDebug="");

//**///////////////////////////////////////////////////////////////////////////
//** GDSL_DaySpawns()
//**///////////////////////////////////////////////////////////////////////////
//**
//** This function is used to spawn ONLY if the time IG is on the day.
//**
//**///////////////////////////////////////////////////////////////////////////
void GDSL_DaySpawns();

//**///////////////////////////////////////////////////////////////////////////
//** GDSL_NightSpawns()
//**///////////////////////////////////////////////////////////////////////////
//**
//** This function is used to spawn ONLY if the time IG is on the night.
//**
//**///////////////////////////////////////////////////////////////////////////
void GDSL_NightSpawns();

//**///////////////////////////////////////////////////////////////////////////
//**
//** Return TRUE. if any PC is in area oArea
//**
//**///////////////////////////////////////////////////////////////////////////
int ku_GetIsPCInLocation(object oArea);


//**///////////////////////////////////////////////////////////////////////////
//**
//** This script suspend AI in location
//**
//**///////////////////////////////////////////////////////////////////////////
void ku_SleepArea(object oArea);

void lock_SetPlcOrigin(string sResRef, string sTag);

//**///////////////////////////////////////////////////////////////////////////
//**
//** Prepare bosses for spawn
//**
//**///////////////////////////////////////////////////////////////////////////
int lock_init_bosses(object oArea);

void lock_AppearBoss(object oTarget);


int lock_init_boss_loot(object oArea);

void lock_SpawnBossLoot(object oArea);
void lock_ClearBossLoot(object oArea);



int ku_ChooseTrap(int power, int type) {

  int nTrap = 0;

  switch(power) {

    // MINOR
    case 1: {
      switch(type) {
        case 1: nTrap = TRAP_BASE_TYPE_MINOR_ACID; break;
        case 2: nTrap = TRAP_BASE_TYPE_MINOR_ACID_SPLASH; break;
        case 3: nTrap = TRAP_BASE_TYPE_MINOR_ELECTRICAL; break;
        case 4: nTrap = TRAP_BASE_TYPE_MINOR_FIRE; break;
        case 5: nTrap = TRAP_BASE_TYPE_MINOR_FROST; break;
        case 6: nTrap = TRAP_BASE_TYPE_MINOR_GAS; break;
        case 7: nTrap = TRAP_BASE_TYPE_MINOR_HOLY; break;
        case 8: nTrap = TRAP_BASE_TYPE_MINOR_NEGATIVE; break;
        case 9: nTrap = TRAP_BASE_TYPE_MINOR_SONIC; break;
        case 10: nTrap = TRAP_BASE_TYPE_MINOR_SPIKE; break;
        case 11: nTrap = TRAP_BASE_TYPE_MINOR_TANGLE; break;
      }
      break;
    }

    // AVERAGE
    case 2: {
      switch(type) {
        case 1: nTrap = TRAP_BASE_TYPE_AVERAGE_ACID; break;
        case 2: nTrap = TRAP_BASE_TYPE_AVERAGE_ACID_SPLASH; break;
        case 3: nTrap = TRAP_BASE_TYPE_AVERAGE_ELECTRICAL; break;
        case 4: nTrap = TRAP_BASE_TYPE_AVERAGE_FIRE; break;
        case 5: nTrap = TRAP_BASE_TYPE_AVERAGE_FROST; break;
        case 6: nTrap = TRAP_BASE_TYPE_AVERAGE_GAS; break;
        case 7: nTrap = TRAP_BASE_TYPE_AVERAGE_HOLY; break;
        case 8: nTrap = TRAP_BASE_TYPE_AVERAGE_NEGATIVE; break;
        case 9: nTrap = TRAP_BASE_TYPE_AVERAGE_SONIC; break;
        case 10: nTrap = TRAP_BASE_TYPE_AVERAGE_SPIKE; break;
        case 11: nTrap = TRAP_BASE_TYPE_AVERAGE_TANGLE; break;
      }
      break;
    }

    // STRONG
    case 3: {
      switch(type) {
        case 1: nTrap = TRAP_BASE_TYPE_STRONG_ACID; break;
        case 2: nTrap = TRAP_BASE_TYPE_STRONG_ACID_SPLASH; break;
        case 3: nTrap = TRAP_BASE_TYPE_STRONG_ELECTRICAL; break;
        case 4: nTrap = TRAP_BASE_TYPE_STRONG_FIRE; break;
        case 5: nTrap = TRAP_BASE_TYPE_STRONG_FROST; break;
        case 6: nTrap = TRAP_BASE_TYPE_STRONG_GAS; break;
        case 7: nTrap = TRAP_BASE_TYPE_STRONG_HOLY; break;
        case 8: nTrap = TRAP_BASE_TYPE_STRONG_NEGATIVE; break;
        case 9: nTrap = TRAP_BASE_TYPE_STRONG_SONIC; break;
        case 10: nTrap = TRAP_BASE_TYPE_STRONG_SPIKE; break;
        case 11: nTrap = TRAP_BASE_TYPE_STRONG_TANGLE; break;
      }
      break;
    }

    // DEADLY
    case 4: {
      switch(type) {
        case 1: nTrap = TRAP_BASE_TYPE_DEADLY_ACID; break;
        case 2: nTrap = TRAP_BASE_TYPE_DEADLY_ACID_SPLASH; break;
        case 3: nTrap = TRAP_BASE_TYPE_DEADLY_ELECTRICAL; break;
        case 4: nTrap = TRAP_BASE_TYPE_DEADLY_FIRE; break;
        case 5: nTrap = TRAP_BASE_TYPE_DEADLY_FROST; break;
        case 6: nTrap = TRAP_BASE_TYPE_DEADLY_GAS; break;
        case 7: nTrap = TRAP_BASE_TYPE_DEADLY_HOLY; break;
        case 8: nTrap = TRAP_BASE_TYPE_DEADLY_NEGATIVE; break;
        case 9: nTrap = TRAP_BASE_TYPE_DEADLY_SONIC; break;
        case 10: nTrap =TRAP_BASE_TYPE_DEADLY_SPIKE ; break;
        case 11: nTrap =TRAP_BASE_TYPE_DEADLY_TANGLE ; break;
      }
      break;
    }

    // EPIC
    case 5: {
      switch(type) {
        case 1: nTrap = TRAP_BASE_TYPE_DEADLY_ACID; break;
        case 2: nTrap = TRAP_BASE_TYPE_DEADLY_ACID_SPLASH; break;
        case 3: nTrap = TRAP_BASE_TYPE_EPIC_ELECTRICAL; break;
        case 4: nTrap = TRAP_BASE_TYPE_EPIC_FIRE; break;
        case 5: nTrap = TRAP_BASE_TYPE_EPIC_FROST; break;
        case 6: nTrap = TRAP_BASE_TYPE_DEADLY_GAS; break;
        case 7: nTrap = TRAP_BASE_TYPE_DEADLY_HOLY; break;
        case 8: nTrap = TRAP_BASE_TYPE_DEADLY_NEGATIVE; break;
        case 9: nTrap = TRAP_BASE_TYPE_EPIC_SONIC; break;
        case 10: nTrap =TRAP_BASE_TYPE_DEADLY_SPIKE ; break;
        case 11: nTrap =TRAP_BASE_TYPE_DEADLY_TANGLE ; break;
      }
      break;
    }
  }

  return nTrap;
}

void ku_SetTrapDC(object oObject, int iTrapPower)
{
    SetTrapDetectDC(oObject,5 + 4*iTrapPower + d4());
    SetTrapDisarmDC(oObject,19 + 5*iTrapPower + Random(5));
}

void ku_SetRandomTrap(object oObject, int iTrapPower)
{
  CreateTrapOnObject(ku_ChooseTrap(iTrapPower,Random(11)+1),oObject);
  ku_SetTrapDC(oObject,iTrapPower);
}

void LOCK_SpawnGroup(object oWP, object oFaction=OBJECT_INVALID){
    int iSum = GetLocalInt(oWP, "JA_SP_SUM");
    int iMin = GetLocalInt(oWP, "JA_SP_MIN");
    int iMax = GetLocalInt(oWP, "JA_SP_MAX");
    int iDist = GetLocalInt(oWP, "JA_SP_DISTANCE");
    int iSpec = GetLocalInt(oWP, "JA_SP_SPECIAL");

    location lLoc = GetLocation(oWP);

    int i;
    for(i=0; i<iSpec; i++){
        string sResRef = GetLocalString(oWP, "JA_SP_CR"+IntToString(i));

        LOCK_SpawnCreature(lLoc, sResRef, "", oFaction,iDist);
    }

    int count = Random(iMax-iMin+1)+iMin;
    for(i=0; i<count; i++){
        int r = Random(iSum-iSpec)+1+iSpec;
        string sResRef = GetLocalString(oWP, "JA_SP_CR"+IntToString(r));

        LOCK_SpawnCreature(lLoc, sResRef, "", oFaction,iDist);
    }

}

void LOCK_SpawnCreature(location lLoc, string sTAG, string sNewTag="", object oFaction=OBJECT_INVALID, int iDist=5)
{
    // Spawn of the creature.
    string sResref = GetStringLowerCase(sTAG);
    float length = iDist*randomFloat();
    vector newVector = length*VectorNormalize(Vector(randomFloat(), randomFloat(), randomFloat()))+GetPositionFromLocation(lLoc);
    lLoc = Location(GetAreaFromLocation(lLoc), newVector, randomFloat()*360.0);

    object oObject = CreateObject(OBJECT_TYPE_CREATURE, sResref, lLoc, FALSE, sNewTag);

    if(GetIsObjectValid(oFaction)) {
      ChangeFaction(oObject,oFaction);
    }

    SetLocalInt(oObject,"KU_DYNAMICALY_SPAWNED",TRUE);

    // We assign variables on the creature for the Auto Respawn.
    SetLocalLocation(oObject, "LOCK_LOCATION", lLoc);
    SetLocalInt(oObject, "LOCK_RESPAWN", 1);

}

void LOCK_SpawnPlaceable(location lLoc, string sTAG, string sNewTag="")
{
    // Spawn of the placeable.
    string sResref = GetStringLowerCase(sTAG);
    object oObject = CreateObject(OBJECT_TYPE_PLACEABLE, sResref, lLoc, FALSE, sNewTag);

    // If the placeable is the GDSL manager waypoint, execute its heartbeat script immediately.
    if (sResref == "um_gdsl") ExecuteScript("lock_gdsl_hb", oObject);

    // If we don't mark it, it won't be destroyed on the cleaning.
    SetLocalInt(oObject, "LOCK_DESPAWN", 1);

    //Kucik traps set
    int iTrapsProb = GetLocalInt(GetArea(oObject),"traps_on");
    if(iTrapsProb == 0)
      return;

    int iTrapPower = GetLocalInt(GetArea(oObject),"loot") / 5 +1;

    if( (FindSubString(sResref,"corpse")>-1) && (Random(100)  < (15 * iTrapsProb /100) ) ) {
      iTrapPower--;
      CreateTrapOnObject(ku_ChooseTrap(iTrapPower,Random(11)+1),oObject);
    } else if( (FindSubString(sResref,"treasure")>-1) && (Random(100) < (5 * iTrapsProb /100)) )  {
      iTrapPower--;
      CreateTrapOnObject(ku_ChooseTrap(iTrapPower,Random(11)+1),oObject);
    } else if( (FindSubString(sResref,"barrel")>-1) && (Random(100) < (30 * iTrapsProb /100)) ) {
      CreateTrapOnObject(ku_ChooseTrap(iTrapPower,Random(11)+1),oObject);
    } else if( (FindSubString(sResref,"box")>-1) && (Random(100) < (50 * iTrapsProb /100)) ) {
      CreateTrapOnObject(ku_ChooseTrap(iTrapPower,Random(11)+1),oObject);
      if(Random(100) < 40)
        SetTrapOneShot(oObject,FALSE);
    } else if( (FindSubString(sResref,"chest")>-1) && (Random(100) < (70 * iTrapsProb /100)) ) {
      iTrapPower++;
      CreateTrapOnObject(ku_ChooseTrap(iTrapPower,Random(11)+1),oObject);
      if(Random(100) < 50)
        SetTrapOneShot(oObject,FALSE);
    } else {
       return;
    }
    SetTrapDetectDC(oObject,5 + 4*iTrapPower + d4());
    SetTrapDisarmDC(oObject,19 + 5*iTrapPower + Random(5));

}

void LOCK_SpawnObject(object oPC, location lLoc, string sTAG, string sNewTag="")
{
    // Spawn of the item.
    string sResref = GetStringLowerCase(sTAG);
    object oObject = CreateObject(OBJECT_TYPE_ITEM, sResref, lLoc, FALSE, sNewTag);

    // If we don't mark it, it won't be destroyed on the cleaning.
    SetLocalInt(oObject, "LOCK_DESPAWN", 1);
}

void LOCK_CleanArea(object oArea)
{
    int iObject;
    object oObject = GetFirstObjectInArea(oArea);
    while (GetIsObjectValid(oObject))
    {
        iObject = GetObjectType(oObject);
        if (GetIsPC(oObject))
        {
            WriteTimestampedLogEntry("**/!\** Joueur: " + GetName(oObject) + " present dans la zone" + GetName(OBJECT_SELF) + " lors du nettoyage **/!\**");
            return;
        }
        else if(GetIsDM(oObject)){
//            SendMessageToPC(oObject, "You are in this location - no despawn here!");
            return;
        }
        if (iObject == OBJECT_TYPE_CREATURE && GetLocalInt(oObject, "LOCK_NODESPAWN") == 0 && GetLocalInt(oObject, "LOCK_RESPAWN"))
        {
            LOCK_Debug("** Cr�ature effac�e: " + GetName(oObject));
            SetPlotFlag(oObject,0);
            AssignCommand(oObject, SetIsDestroyable(TRUE, FALSE));
            DestroyObject(oObject);
        }
        else if (iObject == OBJECT_TYPE_PLACEABLE && GetLocalInt(oObject, "LOCK_DESPAWN") == 1)
        {
            LOCK_Debug("** Plc effac�: " + GetName(oObject));
            SetPlotFlag(oObject,0);
            AssignCommand(oObject, SetIsDestroyable(TRUE, FALSE));
            DestroyObject(oObject);
        }
        else if (iObject == OBJECT_TYPE_PLACEABLE && GetTag(oObject) == "BodyBag")
        {
            if (GetHasInventory(oObject)) // security.
            {
                object oDelInv = GetFirstItemInInventory(oObject);
                while (GetIsObjectValid(oDelInv)) // Emptying the lootbag.
                {
                    LOCK_Debug("*** Contenu Lootbag effac�: " + GetName(oDelInv));
                    SetPlotFlag(oDelInv,0);
                    AssignCommand(oDelInv, SetIsDestroyable(TRUE, FALSE));
                    DestroyObject(oDelInv);
                    oDelInv = GetNextItemInInventory(oObject);
                }
            }
            LOCK_Debug("** Lootbag effac�");
            SetPlotFlag(oObject,0);   // Destroying the lootbag.
            AssignCommand(oObject, SetIsDestroyable(TRUE, FALSE));
            DestroyObject(oObject);
        }
        else if (iObject == OBJECT_TYPE_ITEM && GetLocalInt(oObject, "LOCK_DESPAWN") == 1)
        {
            SetPlotFlag(oObject,0);
            AssignCommand(oObject, SetIsDestroyable(TRUE, FALSE));
            DestroyObject(oObject);
        }
        else if (iObject == OBJECT_TYPE_DOOR){
            AssignCommand(oObject, ActionCloseDoor(oObject));
        }
        else if (iObject == OBJECT_TYPE_WAYPOINT){
            string s = GetStringLeft(GetTag(oObject), 6);

            if(s == "TOKEN_"){
                DeleteLocalInt(oObject, "JA_SP_CNT");
            }
        }

        oObject = GetNextObjectInArea(oArea);
    } // End of WHILE

    // The area has been cleaned.
    DeleteLocalInt(oArea, "LOCK_SPAWN_ENTER"); }

void LOCK_CleaningTimer(object oArea, float fDelay=60.0)
{
    int TIMER = GetLocalInt(oArea, "LOCK_TIMER");

/*    if (TIMER == -1) // One PC entered the area... no cleaning !
    {
        SetLocalInt(oArea, "LOCK_TIMER", 0);
        LOCK_Debug("* TIMER -1 => TIMER = 0");
    }
    else*/ if (TIMER == 1) // Time to clean area !
    {
        object oPC = GetFirstPC();
        while(GetIsObjectValid(oPC)){
         if(GetArea(oPC) == oArea){ //PC in location
          DelayCommand(30.0f, LOCK_CleaningTimer(oArea)); // w8 30 sec
          return;
         }
         oPC = GetNextPC();
        }
        LOCK_CleanArea(oArea);
        SetLocalInt(oArea, "LOCK_TIMER", 0);
        LOCK_Debug("* CleanArea()");
        LOCK_Debug("* TIMER = 0");
    }
    else // The countdown is running...
    {
        //SpeakString(IntToString(TIMER), TALKVOLUME_SHOUT);
        TIMER = TIMER - 1;
        SetLocalInt(oArea, "LOCK_TIMER", TIMER);
        DelayCommand(fDelay, LOCK_CleaningTimer(oArea, fDelay));
        LOCK_Debug("* DelayCommand(CleaningTimer())");
        LOCK_Debug("* TIMER = " + IntToString(TIMER));
    }
}

void LOCK_InitCleaningTimer(object oArea, float fDelay=60.0)
{
    SetLocalInt(oArea, "LOCK_TIMER", 5);
    DelayCommand(fDelay, LOCK_CleaningTimer(oArea, fDelay));
    LOCK_Debug("* InitCleaningTimer()");
    LOCK_Debug("* TIMER = 5");
}

void LOCK_ResetCleaningTimer(object oArea)
{
    SetLocalInt(oArea, "LOCK_TIMER", 5);
    LOCK_Debug("* ResetCleaningTimer()");
    LOCK_Debug("* TIMER = 5");
}

void LOCK_Debug(string sDebug="")
{
/*    int iDebug = 0; // Set to 1 to activate the debug mode.
    if (iDebug == 1) WriteTimestampedLogEntry(sDebug);*/
}

void GDSL_DaySpawns()
{
    object oWP = GetNearestObject(OBJECT_TYPE_WAYPOINT);
    int i = 1;

    while (GetIsObjectValid(oWP))
    {
        string sWP = GetStringLeft(GetTag(oWP), 5);
        if (sWP == "GDSL_")
        {
            location lLoc = GetLocation(oWP);

            sWP = GetTag(oWP);
            int iWP = GetStringLength(sWP);
            iWP = iWP - 5;
            string sResRef = GetStringRight(sWP, iWP);

            int DN            = GetLocalInt(oWP, "DN");
            int PLC           = GetLocalInt(oWP, "PLC");
            int RW            = GetLocalInt(oWP, "RW");
            int SD            = GetLocalInt(oWP, "SD");
            int AA            = GetLocalInt(oWP, "AA");
            string NEWTAG     = GetLocalString(oWP, "NEWTAG");
            string AUTOCONV   = GetLocalString(oWP, "AUTOCONV");
            object SPAWN_DONE = GetLocalObject(oWP, "LOCK_SPAWN_DONE");

            if (( DN == 1 || DN == 3 ) && (GetCurrentHitPoints(SPAWN_DONE) <= 0))
            {
                if (PLC == 1)
                {
                    sResRef = GetStringLowerCase(sResRef);
                    object oObject = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLoc, FALSE, NEWTAG);
                    SetLocalInt(oObject, "LOCK_DESPAWN", 1); // To allow despawn.
                    SetLocalObject(oWP, "LOCK_SPAWN_DONE", oObject);
                }
                else
                {
                    sResRef = GetStringLowerCase(sResRef);
                    object oObject = CreateObject(OBJECT_TYPE_CREATURE, sResRef, lLoc, FALSE, NEWTAG);
                    if (AUTOCONV != "") AssignCommand(oObject, SpeakOneLinerConversation(AUTOCONV));
                    SetLocalObject(oWP, "LOCK_SPAWN_DONE", oObject);

                    // Condition to activate Auto Random Walk.
                    if (RW == 1)
                    {
                        SetLocalInt(oObject, "LOCK_RW", 1);
                        AssignCommand(oObject, ActionRandomWalk());
                    }
                    // Condition to activate the Auto Sit Down. (Look for "Chair" TAG)
                    if (SD != 0)
                    {
                        AssignCommand(oObject, ActionSit(GetNearestObjectByTag("Chair", oObject)));
                        SetLocalInt(oObject, "LOCK_SD", 1);
                    }
                    // Condition to activate the Auto Animation. (Fixed lenght: 1h)
                    // Warning: FIRE&FORGET (100 and after...) animations do not last !
                    if (AA != 0)
                    {
                        SetLocalInt(oObject, "LOCK_AA", 1);
                        AssignCommand(oObject, ActionPlayAnimation(AA, 1.0, 3600.0));
                    }
                }
            }
            else if ( DN == 4 )
            {
                if(!GetIsDMPossessed(SPAWN_DONE))
                {
                    if (GetIsObjectValid(SPAWN_DONE) && PLC == 1)
                    {
                        DestroyObject(SPAWN_DONE);
                    }
                    else if (GetIsObjectValid(SPAWN_DONE))
                    {
                        AssignCommand(SPAWN_DONE, ActionSpeakString("It is time to leave..."));
                        SetPlotFlag(SPAWN_DONE,0);
                        AssignCommand(SPAWN_DONE, SetIsDestroyable(TRUE, FALSE));

                        object oDoor = GetNearestObject(OBJECT_TYPE_DOOR, SPAWN_DONE);

                        if (GetIsObjectValid(oDoor))
                        {
                            // ActionForceMoveToLocation() because ActionMoveToObject() is cheesy !
                            location lDoor = GetLocation(oDoor);
                            AssignCommand(SPAWN_DONE, ClearAllActions());
                            AssignCommand(SPAWN_DONE, ActionForceMoveToLocation(lDoor));
                            AssignCommand(SPAWN_DONE, ActionDoCommand(DestroyObject(SPAWN_DONE)));
                            AssignCommand(SPAWN_DONE, DelayCommand(30.0, DestroyObject(SPAWN_DONE)));
                        }
                        else
                        {
                            DestroyObject(SPAWN_DONE);
                        }
                    }
                    DeleteLocalObject(oWP, "SPAWN_DONE");
                }
            }
        }
        i++;
        oWP = GetNearestObject(OBJECT_TYPE_WAYPOINT, OBJECT_SELF, i);
    }
    ///////////////////////////////////////////////////////////////////////////
    //:: FOR THE DOORS (SHOPS, ...)
    ///////////////////////////////////////////////////////////////////////////
    object oDoor = GetNearestObject(OBJECT_TYPE_DOOR);
    i = 1;

    while (GetIsObjectValid(oDoor))
    {
        int nLock = GetLocalInt(oDoor, "GDSL_DOOR");
        if (nLock > 0) // If it exists, we open door on day...
        {
            if (GetLocked(oDoor))
            {
                SetLocked(oDoor, FALSE);
                AssignCommand(oDoor, PlaySound("gui_picklockopen"));
            }
        }
        i++;
        oDoor = GetNearestObject(OBJECT_TYPE_DOOR, OBJECT_SELF, i);
    }
}

void GDSL_NightSpawns()
{
    object oWP = GetNearestObject(OBJECT_TYPE_WAYPOINT);
    int i = 1;

    while (GetIsObjectValid(oWP))
    {
        string sWP = GetStringLeft(GetTag(oWP), 5);
        if (sWP == "GDSL_")
        {
            location lLoc = GetLocation(oWP);

            sWP = GetTag(oWP);
            int iWP = GetStringLength(sWP);
            iWP = iWP - 5;
            string sResRef = GetStringRight(sWP, iWP);

            int DN            = GetLocalInt(oWP, "DN");
            int PLC           = GetLocalInt(oWP, "PLC");
            int RW            = GetLocalInt(oWP, "RW");
            int SD            = GetLocalInt(oWP, "SD");
            int AA            = GetLocalInt(oWP, "AA");
            string NEWTAG     = GetLocalString(oWP, "NEWTAG");
            string AUTOCONV   = GetLocalString(oWP, "AUTOCONV");
            object SPAWN_DONE = GetLocalObject(oWP, "LOCK_SPAWN_DONE");

            if (( DN == 2 || DN == 4 ) && (GetCurrentHitPoints(SPAWN_DONE) <= 0) )
            {
                if (PLC == 1)
                {
                    sResRef = GetStringLowerCase(sResRef);
                    object oObject = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLoc, FALSE, NEWTAG);
                    SetLocalInt(oObject, "LOCK_DESPAWN", 1);
                    SetLocalObject(oWP, "LOCK_SPAWN_DONE", oObject);

                }
                else
                {
                    sResRef = GetStringLowerCase(sResRef);
                    object oObject = CreateObject(OBJECT_TYPE_CREATURE, sResRef, lLoc, FALSE, NEWTAG);
                    if (AUTOCONV != "") AssignCommand(oObject, SpeakOneLinerConversation(AUTOCONV));
                    SetLocalObject(oWP, "LOCK_SPAWN_DONE", oObject);

                    // Condition to activate Auto Random Walk.
                    if (RW == 1)
                    {
                        SetLocalInt(oObject, "LOCK_RW", 1);
                        AssignCommand(oObject, ActionRandomWalk());
                    }
                    // Condition to activate the Auto Sit Down. (Look for "Chair" TAG)
                    if (SD != 0)
                    {
                        SetLocalInt(oObject, "LOCK_SD", 1);
                        AssignCommand(oObject, ActionSit(GetNearestObjectByTag("Chair", oObject)));
                    }
                    // Condition to activate the Auto Animation. (Fixed lenght: 1h)
                    // Warning: FIRE&FORGET (100 and after...) animations do not last !
                    if (AA != 0)
                    {
                        SetLocalInt(oObject, "LOCK_AA", 1);
                        AssignCommand(oObject, ActionPlayAnimation(AA, 1.0, 3600.0));
                    }
                }
            }
            else if ( DN == 3 )
            {
                if(!GetIsDMPossessed(SPAWN_DONE))
                {
                    if (GetIsObjectValid(SPAWN_DONE) && PLC == 1)
                    {
                        DestroyObject(SPAWN_DONE);
                    }
                    else if (GetIsObjectValid(SPAWN_DONE))
                    {
                        AssignCommand(SPAWN_DONE, ActionSpeakString("It is time to leave..."));
                        SetPlotFlag(SPAWN_DONE,0);
                        AssignCommand(SPAWN_DONE, SetIsDestroyable(TRUE, FALSE));

                        object oDoor = GetNearestObject(OBJECT_TYPE_DOOR, SPAWN_DONE);

                        if (GetIsObjectValid(oDoor))
                        {
                            location lDoor = GetLocation(oDoor);
                            AssignCommand(SPAWN_DONE, ClearAllActions());
                            AssignCommand(SPAWN_DONE, ActionForceMoveToLocation(lDoor));
                            AssignCommand(SPAWN_DONE, ActionDoCommand(DestroyObject(SPAWN_DONE)));
                            AssignCommand(SPAWN_DONE, DelayCommand(30.0, DestroyObject(SPAWN_DONE)));
                        }
                        else
                        {
                            DestroyObject(SPAWN_DONE);
                        }
                    }
                    DeleteLocalObject(oWP, "SPAWN_DONE");
                }
            }
        }
        i++;
        oWP = GetNearestObject(OBJECT_TYPE_WAYPOINT, OBJECT_SELF, i);
    }

    ///////////////////////////////////////////////////////////////////////////
    //:: FOR THE DOORS (SHOPS, ...)
    ///////////////////////////////////////////////////////////////////////////
    object oDoor = GetNearestObject(OBJECT_TYPE_DOOR);
    i = 1;

    while (GetIsObjectValid(oDoor))
    {
        int nLock = GetLocalInt(oDoor, "GDSL_DOOR");
        if (nLock > 0) // If it exists, we close door on night...
        {
            if (!GetLocked(oDoor))
            {
                SetLocked(oDoor, TRUE);
                AssignCommand(oDoor, PlaySound("gui_picklockopen"));
            }
        }
        i++;
        oDoor = GetNearestObject(OBJECT_TYPE_DOOR, OBJECT_SELF, i);
    }
}


int ku_GetIsPCInLocation(object oArea) {

 object oPC = GetFirstPC();
 string sTag = GetTag(oArea);
 while(GetIsObjectValid(oPC)) {
   if(GetTag(GetArea(oPC)) == sTag)
     return TRUE;
   oPC = GetNextPC();
 }
 return FALSE;
}

void ku_SleepArea(object oArea) {


  /* Pokud v lokaci stale nekdo je */
  if(ku_GetIsPCInLocation(oArea))
    return;

  /* Pokud lokace neni dost dlouho opustena */
  if((GetLocalInt(oArea,"ku_last_exit") + 570) > ku_GetTimeStamp())
    return;

  SetLocalInt(OBJECT_SELF,"ku_notempty",FALSE);

  /* Let NPCs go to spawn location */

  if(GetLocalInt(OBJECT_SELF, "JA_MESTO") == 1) return;

  object oFirst = GetFirstObjectInArea();
  if(GetLocalInt(oFirst,"ku_loc_return"))
    AssignCommand(oFirst,ActionMoveToLocation(GetLocalLocation(oFirst,"ku_spawn_loc")));
  int i=1;
  object oNPC = GetNearestObject(OBJECT_TYPE_CREATURE,oFirst,i);
  while(GetIsObjectValid(oNPC)) {
    if(GetLocalInt(oNPC,"ku_loc_return"))
      AssignCommand(oNPC,ActionMoveToLocation(GetLocalLocation(oNPC,"ku_spawn_loc")));

    i++;
    oNPC = GetNearestObject(OBJECT_TYPE_CREATURE,oFirst,i);
  }
}

void ApplyIndoorHidePenalty(object oPC, int bApply = FALSE) {

//  SendMessageToPC(oPC,"Applying indoor penalty...");

  if(!GetIsPC(oPC))
    return;
  if(GetIsDM(oPC))
    return;

  object oArea = OBJECT_SELF;
//  int bInterior = GetIsAreaInterior(OBJECT_SELF);
  int iHide = GetLocalInt(oArea,"HIDE_PENALTY");

  // Remove previous penalty
  effect eff = GetFirstEffect(oPC);

  while(GetIsEffectValid(eff)) {
    if( (GetEffectCreator(eff) == oArea ) &&
        (GetEffectType(eff) == EFFECT_TYPE_SKILL_DECREASE) &&
        (GetEffectSubType(eff) == SUBTYPE_EXTRAORDINARY) &&
        (GetEffectDurationType(eff) == DURATION_TYPE_TEMPORARY ) ) {
      RemoveEffect(oPC,eff);
    }
    eff = GetNextEffect(oPC);
  }

  if((iHide > 0) && (bApply)) {
//    SendMessageToPC(oPC,"Applying ");
    eff = ExtraordinaryEffect(EffectSkillDecrease(SKILL_HIDE,iHide));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eff,oPC,6000.0);
  }
}

void lock_init_location() {
  int init = GetLocalInt(OBJECT_SELF,"ku_location_initialized");
  if(init)
    return;

  object oLoc = OBJECT_SELF;
  string sResRef = GetResRef(oLoc);
  string sTag = GetTag(oLoc);
  int ja_loc_type;
  int boss_spawn_time;


  string sSQL = "SELECT alive, spawn_disable, JA_LOC_TYPE, boss_spawn_time FROM location_property WHERE resref = '"+sResRef+"' AND tag = '"+sTag+"'; ";

  SQLExecDirect(sSQL);
  if (SQLFetch() == SQL_SUCCESS) {
    string sAlive = SQLGetData(1);
    SetLocalInt(oLoc,"KU_LOC_ALIVE",StringToInt(sAlive));
    SetLocalInt(oLoc,"KU_LOC_DISABLE_SPAWN",StringToInt(SQLGetData(2)));
    ja_loc_type = StringToInt(SQLGetData(3));
    if(ja_loc_type > 0) {
      SetLocalInt(oLoc,"JA_LOC_TYPE",ja_loc_type);
    }
    boss_spawn_time = StringToInt(SQLGetData(4));
    SetLocalInt(oLoc,"NEXT_BOSS_SPAWN_TIME",boss_spawn_time);
  }
  else {
    ja_loc_type = GetLocalInt(oLoc,"JA_LOC_TYPE");
    string sValues = "'"+sResRef+"',"+
                     "'"+sTag+"',"+
                     "'"+GetName(oLoc)+"',"+
                     "'0',"+
                     "'"+IntToString(ja_loc_type)+"'";
    sSQL = "INSERT INTO location_property (resref,tag,name,alive,JA_LOC_TYPE) VALUES ("+sValues+");";
    SQLExecDirect(sSQL);
    SetLocalInt(oLoc,"KU_LOC_ALIVE",FALSE);
  }
  if(ja_loc_type < 0) {
    ja_loc_type = GetLocalInt(oLoc,"JA_LOC_TYPE");
    sSQL = "UPDATE location_property SET JA_LOC_TYPE = '"+IntToString(ja_loc_type)+"' WHERE resref = '"+sResRef+"' AND tag = '"+sTag+"'; ";
    SQLExecDirect(sSQL);
  }


  lock_SetPlcOrigin(sResRef,sTag);

  // NPCs
  DelayCommand(0.3,Persist_LoadAddedPlaceables(OBJECT_SELF,OBJECT_TYPE_CREATURE));
  // Placeabels
  DelayCommand(1.5,Persist_LoadAddedPlaceables(OBJECT_SELF,OBJECT_TYPE_PLACEABLE));

  lock_init_bosses(OBJECT_SELF);

  SetLocalInt(OBJECT_SELF,"ku_location_initialized",TRUE);
}

void lock_SetPlcOrigin(string sResRef, string sTag) {
  object oArea = OBJECT_SELF;
  object oPlc = GetFirstObjectInArea(oArea);
  while(GetIsObjectValid(oPlc)) {
    switch(GetObjectType(oPlc)) {
      case OBJECT_TYPE_PLACEABLE:
//        SendMessageToPC(GetFirstPC(),"Nastavuji origin flag pro "+GetName(oPlc));
        SetLocalInt(oPlc,"ku_plc_origin",1); /* Created in toolset */
        break;
    }
    oPlc = GetNextObjectInArea(oArea);
  }
}

int lock_init_bosses(object oArea) {

  object oFirst = GetFirstObjectInArea(oArea);
  object oNPC = oFirst;
  int i = 1;
  int cnt = 0;

  while(GetIsObjectValid(oNPC)) {
    if(GetLocalInt(oNPC,"AI_BOSS") && !GetIsObjectValid(GetMaster(oNPC)) ) {
      cnt++;
      /* Make disappear BOSS */
/*      effect eInvisible = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
      effect eGhost = EffectCutsceneGhost();
      effect eDisApp = EffectDisappearAppear(GetLocation(oNPC));
      effect eLink = EffectLinkEffects(eInvisible,eGhost);
      eLink = EffectLinkEffects(eDisApp,eLink);
      AssignCommand(oNPC, ClearAllActions(TRUE));
      ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oNPC);
      */
      DelayCommand(1.0,NWNX_Creature_JumpToLimbo(oNPC));
/*      DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost,oNPC));
      DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDisApp,oNPC));*/
      /* Save boss reference to area */
      SetLocalObject(oArea,"SLEEPING_BOSS_"+IntToString(cnt),oNPC);
      SetLocalObject(oNPC,"KU_MY_AREA",oArea);
//      SendMessageToPC(GetFirstPC(),"Saved boss "+GetName(oNPC));
    }
    oNPC = GetNearestObject(OBJECT_TYPE_CREATURE, oFirst, i);
    i++;
  }
  SetLocalInt(oArea,"BOSS_COUNT",cnt);

  lock_init_boss_loot(oArea);

  return cnt;
}

int lock_SpawnBosses(object oArea) {

  int iBossCount = GetLocalInt(oArea,"BOSS_COUNT");
  int i;


//  SendMessageToPC(GetFirstPC(),"Spawning if "+IntToString(ku_GetTimeStamp())+"<"+IntToString(GetLocalInt(oArea,"NEXT_BOSS_SPAWN_TIME")));
  if(ku_GetTimeStamp() < GetLocalInt(oArea,"NEXT_BOSS_SPAWN_TIME"))
    return FALSE;
//  SendMessageToPC(GetFirstPC(),"Spawning ... 3");
  if(GetIsObjectValid(GetLocalObject(oArea,"ACTUAL_BOSS")))
    return FALSE;

  lock_SpawnBossLoot(oArea);

  if(iBossCount < 1)
    return FALSE;

//  SendMessageToPC(GetFirstPC(),"Spawning ... 4");

  object oNPC;
  object oBoss;
  int iNumOfBoss = GetLocalInt(oArea,"NUMBER_OF_BOSSES");
//  SendMessageToPC(GetFirstPC(),"Spawning from "+IntToString(iNumOfBoss)+"bosses");
  /* Spawn all bosses */
  if(GetLocalInt(oArea,"BOSS_SPAWN_ALL") ||
      iNumOfBoss == 0) {
//    SendMessageToPC(GetFirstPC(),"Spawn all "+IntToString(iBossCount));
    for(i=1;i<=iBossCount;i++) {
      oNPC = GetLocalObject(oArea,"SLEEPING_BOSS_"+IntToString(i));
      oBoss = CopyObject(oNPC,GetLocation(oNPC));
      ChangeFaction(oBoss,oNPC);
   //   lock_CopyVars(oBoss,oNPC);
      lock_AppearBoss(oBoss);
      SetLocalObject(oArea,"ACTUAL_BOSS",oBoss);
    }
    return iBossCount;
  }
  /* Choose random bosees */
  else {
    int cnt = iNumOfBoss;
    if(cnt == 0) {
      cnt = 1;
    }
//    SendMessageToPC(GetFirstPC(),"Spawn random "+IntToString(cnt));
    while(cnt>0) {
      /* Choose random boss */
      i = Random(iBossCount)+1;
      /* Spawn boss */
      oNPC = GetLocalObject(oArea,"SLEEPING_BOSS_"+IntToString(i));
      oBoss = CopyObject(oNPC,GetLocation(oNPC));
      ChangeFaction(oBoss,oNPC);
//      SendMessageToPC(GetFirstPC(),"Spawning "+GetName(oBoss));
 //     lock_CopyVars(oBoss,oNPC);
      lock_AppearBoss(oBoss);
      SetLocalObject(oArea,"ACTUAL_BOSS",oBoss);
      cnt--;
    }

    return 1;
  }

}

void lock_AppearBoss(object oTarget) {
  string sName = "";
  switch(GetRacialType(oTarget)) {
    case RACIAL_TYPE_HALFORC:
    case RACIAL_TYPE_GIANT:
    case RACIAL_TYPE_HUMANOID_GOBLINOID:
    case RACIAL_TYPE_HUMANOID_ORC:
      sName = RandomName(NAME_FIRST_HALFORC_MALE)+" "+RandomName(NAME_LAST_HALFORC);
      break;
  }

  if(sName != "") {
    SetName(oTarget,sName);
  }

/*  effect eff = GetFirstEffect(oTarget);
  while(GetIsEffectValid(eff)) {
    if(GetEffectType(eff) == EFFECT_TYPE_DEAF) {
      RemoveEffect(oTarget,eff);
    }
    eff = GetNextEffect(oTarget);
  }
*/
}



int lock_init_boss_loot(object oArea) {

  object oFirst = GetFirstObjectInArea(oArea);
  object oNPC = oFirst;
  int i = 1;
  int cnt = 0;

  /* Temporary unused */
//  return 0;

  if(GetLocalInt(oArea, "JA_MESTO"))
    return 0;
  if(!GetLocalInt(oArea, "TREASURE_VALUE"))
    return 0;

  string sEventScript,si;

  while(GetIsObjectValid(oNPC)) {
    int iBossLoot = GetLocalInt(oNPC,"BOSS_LOOT");
    if( GetObjectType(oNPC) == OBJECT_TYPE_PLACEABLE &&
        GetHasInventory(oNPC) &&
        GetUseableFlag(oNPC) &&
        iBossLoot > -1 ) {
      sEventScript = GetEventScript(oNPC,EVENT_SCRIPT_PLACEABLE_ON_OPEN);
      if(GetStringLength(sEventScript) > 0) {
        cnt++;
        si = IntToString(cnt);
        /* Save loot reference to area */
        SetLocalString(oArea,"BOSS_LOOT_RESREF_"+si,GetResRef(oNPC));
        SetLocalString(oArea,"BOSS_LOOT_EVENT_ONOPEN_"+si,sEventScript);
        SetLocalString(oArea,"BOSS_LOOT_NAME_"+si,GetName(oNPC));
        SetLocalInt(oArea,"BOSS_LOOT_APP_"+si,GetAppearanceType(oNPC));
        SetLocalLocation(oArea,"BOSS_LOOT_LOC_"+si,GetLocation(oNPC));
        SetLocalInt(oArea,"BOSS_LOOT_LOCKED_"+si,GetLocked(oNPC)*GetLockUnlockDC(oNPC));
        DestroyObject(oNPC,2.0);
//      SetLocalString(oNPC,"KU_MY_AREA",oArea);
//        SendMessageToPC(GetFirstPC(),"Saved loot "+GetName(oNPC)+" with script "+sEventScript);
      }
    }
    oNPC = GetNearestObject(OBJECT_TYPE_PLACEABLE, oFirst, i);
    i++;
  }
  SetLocalInt(oArea,"BOSS_LOOT_COUNT",cnt);

  return cnt;
}

void lock_SpawnBossLoot(object oArea) {

  /* Temporary unused */
//  return ;

  if(GetLocalInt(oArea, "JA_MESTO"))
    return;
  if(!GetLocalInt(oArea, "TREASURE_VALUE"))
    return;

  int iCnt = GetLocalInt(oArea,"BOSS_LOOT_COUNT");
  int i = 1;
  object oChest;
  string si;
  string sEvent;
  int iLockDC;

  lock_ClearBossLoot(oArea);


  //Kucik traps set
  int iTrapsProb = GetLocalInt(oArea,"traps_on");
  int iTREASURE_VALUE = GetLocalInt(oArea, "TREASURE_VALUE");
  if(iTREASURE_VALUE == 0) {
    iTREASURE_VALUE = GetLocalInt(oArea,"loot");
  }
  int iTrapPower = GetLocalInt(oArea,"loot") / 5 +2;

  while(i<=iCnt) {
    si = IntToString(i);
    oChest = CreateObject(OBJECT_TYPE_PLACEABLE,GetLocalString(oArea,"BOSS_LOOT_RESREF_"+si),GetLocalLocation(oArea,"BOSS_LOOT_LOC_"+si));
    if(!GetHasInventory(oChest)) {
      DestroyObject(oChest);
      oChest = CreateObject(OBJECT_TYPE_PLACEABLE,LOCK_LOOT_DEFAULT_RESREF,GetLocalLocation(oArea,"BOSS_LOOT_LOC_"+si));
      SetName(oChest,GetLocalString(oArea,"BOSS_LOOT_NAME_"+si));
//      SendMessageToPC(GetFirstPC(),"Spawned from baseloot "+GetName(oChest)+" with script "+sEvent+" HasInventory ?"+IntToString(GetHasInventory(oChest)));
    }
    NWNX_Object_SetAppearance(oChest,GetLocalInt(oArea,"BOSS_LOOT_APP_"+si));
    SetLocalInt(oChest,"SPAWNED_BOSS_LOOT",1);
    SetUseableFlag(oChest,1);
    sEvent = GetLocalString(oArea,"BOSS_LOOT_EVENT_ONOPEN_"+si);
//    SendMessageToPC(GetFirstPC(),"Spawned loot "+GetName(oChest)+" with script "+sEvent+" HasInventory ?"+IntToString(GetHasInventory(oChest)));
    SetEventScript(oChest,EVENT_SCRIPT_PLACEABLE_ON_OPEN,sEvent);
    SetEventScript(oChest,EVENT_SCRIPT_PLACEABLE_ON_DEATH,sEvent);

    //TRAPS
    if(iTrapsProb != 0) {
      CreateTrapOnObject(ku_ChooseTrap(iTrapPower,Random(11)+1),oChest);
      if(Random(100) < 50)
        SetTrapOneShot(oChest,FALSE);
      SetTrapDetectDC(oChest,5 + 4*iTrapPower + d4());
      SetTrapDisarmDC(oChest,19 + 5*iTrapPower + Random(5));
    }
    /* Locking */
    iLockDC = GetLocalInt(oArea,"BOSS_LOOT_LOCKED_"+si);
    if(iLockDC) {
      SetLocked(oChest,TRUE);
      SetLockKeyRequired(oChest,FALSE);
      SetLockUnlockDC(oChest,Random(iLockDC)+(iLockDC/2));
    }
    i++;
  }


}

void lock_ClearBossLoot(object oArea) {

  /* Temporary unused */
//  return ;

  object oFirst = GetFirstObjectInArea(oArea);
  object oNPC = oFirst;
  int i = 1;

  while(GetIsObjectValid(oNPC)) {
    int iBossLoot = GetLocalInt(oNPC,"SPAWNED_BOSS_LOOT");
    if( iBossLoot ) {
      SetPlotFlag(oNPC,0);
      DestroyObject(oNPC);
    }
    oNPC = GetNearestObject(OBJECT_TYPE_PLACEABLE, oFirst, i);
    i++;
  }
//  SetLocalInt(oArea,"BOSS_LOOT_COUNT",cnt);

  return;

}
