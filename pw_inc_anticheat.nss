//::///////////////////////////////////////////////
//:: pw_inc_anticheat
//:: Written by EPOlson (eolson@cisco.com)
//:: Feb 2004   (for the pw scripts)
//:://////////////////////////////////////////////
// include file with functions that:
//   Stop logout/login cheats
//   Store HP, spells, & feats in local variables
//   then Restore them on login
// Notes:
//   * cleric domain only spells do not seem to be decrementable by script.
//   * maximized & quickened spells can't be decremented either
//   * most feats do not seem to be decrementable or countable
//   * some of these have been fixed in 1.64 & 1.65
const string CAMPAIGNDB = "PWHELPER";
// check spells 0..MAX_SPELLS
const int MAX_SPELLS = 804;
const int MAX_FEATS = 1071;
// Local vars to store data (append player name and character name)
const string PC_INFO_HP = "Pc_Hp_";      // int
const string PC_INFO_APPEAR = "Pc_Apr_"; // int
const string PC_INFO_SPELLS = "Pc_Spl_"; // string
const string PC_INFO_FEATS = "Pc_Fea_";  // string
const string PC_INFO_LOC = "Pc_Loc_";    // location
// Used to store the player's CD key in the OnClientEnter event.
//   (because it will not be available during OnClientExit - player is gone)
const string PERSISTANT_PLAYER_NAME = "Player_Name_";
const int AC_DEBUG = FALSE;
// store player info on exit (HPs, Spells, Feats)
// call upon exit (client exit or area exit)
void StorePlayerInfo(object oPC);
void StorePlayerInfo(object oPC)
{
  object oMod = GetModule();
  string sName = GetName(oPC);
  string sID = GetLocalString(oMod,PERSISTANT_PLAYER_NAME+sName)+sName;
  PrintString("PWH Info - StorePlayerInfo for "+sName+"{"+sID+"}");
  // Hit Points
  int nCHP=GetCurrentHitPoints(oPC);
  SetLocalInt(oMod,PC_INFO_HP+sID,nCHP);
  // SetCampaignInt(CAMPAIGNDB,PC_INFO_HP+sID,nCHP);
  // Store Location
  location lMyLoc = GetLocation(oPC);
  SetLocalLocation(oMod,PC_INFO_LOC+sID,lMyLoc);
  //SetCampaignLocation(CAMPAIGNDB,PC_INFO_LOC+sID,lMyLoc);
  // Spells - store only the spells we know (e.g.  13:2 15:1 )
  int nSpell;
  int nNumSpell;
  string sSpellList = " ";
  for(nSpell=0; nSpell<MAX_SPELLS; nSpell++) {
    if (nNumSpell = GetHasSpell(nSpell,oPC)) {
      sSpellList += IntToString(nSpell)+":"+IntToString(nNumSpell)+" ";
    }
  }
  SetLocalString(oMod,PC_INFO_SPELLS+sID,sSpellList);
  //SetCampaignString(CAMPAIGNDB,PC_INFO_SPELLS+sID,sSpellList);
  // Feats - store counts of feats we know
  int nFeat;
  int nNumFeat;
  string sFeatList = " ";
  for(nFeat=0; nFeat<MAX_FEATS; nFeat++) {
    if (nNumFeat = GetHasFeat(nFeat,oPC)) {
      sFeatList += IntToString(nFeat)+":"+IntToString(nNumFeat)+" ";
    }
  }
  SetLocalString(oMod,PC_INFO_FEATS+sID,sFeatList);
  //SetCampaignString(CAMPAIGNDB,PC_INFO_FEATS+sID,sFeatList);
  // debug
  if (AC_DEBUG) {
    PrintString(sName+" exiting with " + IntToString(nCHP) + "hp.");
    PrintString(sName+" exiting with spell list: " + sSpellList);
    PrintString(sName+" exiting with feat list: " + sFeatList);
  }
}
// restore player info from local vars (HPs, Spells, Feats)
// call during login
void LoadPlayerInfo(object oPC);
void LoadPlayerInfo(object oPC)
{
  if(!GetIsPC(oPC))return;
  object oMod = GetModule();
  string sID = GetPCPlayerName(oPC)+GetName(oPC);
  string sPC = GetName(oPC);
  SetLocalString(oMod, PERSISTANT_PLAYER_NAME+GetName(oPC), GetPCPlayerName(oPC));
  PrintString("PWH Info - LoadPlayerInfo for "+sPC+"{"+sID+"}");
  SendMessageToPC(oPC,"OOC: restoring previous HPs, spells, and feats");
  // Appearance - preserve original appearance
  int iOrigAppear = GetLocalInt(oMod,PC_INFO_APPEAR+sID);
  //if (iOrigAppear == 0) {
  //  iOrigAppear = GetCampaignInt(CAMPAIGNDB,PC_INFO_APPEAR+sID);
  //}
  if (iOrigAppear == 0){ // must be first time
     iOrigAppear = GetAppearanceType(oPC);
     SetLocalInt(oMod,PC_INFO_APPEAR+sID,iOrigAppear);
     //SetCampaignInt(CAMPAIGNDB,PC_INFO_APPEAR+sID,iOrigAppear);
  } else {
     if (iOrigAppear != GetAppearanceType(oPC)) {
       // change back
       SetCreatureAppearanceType(oPC,iOrigAppear);
     }
  }
  // HP
  int nHP = GetLocalInt(oMod,PC_INFO_HP+sID);
  //if (nHP == 0) { // try DB
     //nHP = GetCampaignInt(CAMPAIGNDB,PC_INFO_HP+sID);
  //}
  if (nHP == 0) nHP = GetCurrentHitPoints(oPC); // give them one HP the first time
  ApplyEffectToObject(DURATION_TYPE_PERMANENT,
      EffectDamage(GetCurrentHitPoints(oPC)-nHP,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_PLUS_FIVE), oPC);
  // Goto Location (use HP to see if a location would be valid)
  if (GetLocalInt(oMod,PC_INFO_HP+sID) != 0) {
    location lOldLoc = GetLocalLocation(oMod,PC_INFO_LOC+sID);
    AssignCommand(oPC,JumpToLocation(lOldLoc));
  } //else if (GetCampaignInt(CAMPAIGNDB,PC_INFO_HP+sID) != 0) {
    //location lOldLoc = GetCampaignLocation(CAMPAIGNDB,PC_INFO_LOC+sID);
    //AssignCommand(oPC,JumpToLocation(lOldLoc));
 // }
  // spells
  int nNumSpell;
  int nSpell;
  string sOldSpellList = GetLocalString(oMod,PC_INFO_SPELLS+sID);
  //if (sOldSpellList == "") { // try DB
    // sOldSpellList = GetCampaignString(CAMPAIGNDB,PC_INFO_SPELLS+sID);
  //}
  for(nSpell=0; nSpell<MAX_SPELLS; nSpell++) {
    if (nNumSpell = GetHasSpell(nSpell,oPC)) {
      string sLookfor = " "+IntToString(nSpell)+":";
      int nStart = FindSubString(sOldSpellList,sLookfor);
      if (nStart >= 0) {
         while (GetSubString(sOldSpellList,nStart,1) != ":") nStart++;
         int nEnd = nStart+1;
         while (GetSubString(sOldSpellList,nEnd,1) != " ") nEnd++;
         string sSub = GetSubString(sOldSpellList,nStart+1,nEnd-nStart);
         int nOldNumSpell= StringToInt( sSub);
         int nSpellDiff = nNumSpell - nOldNumSpell;
         int suse;
         for (suse=0;suse<nSpellDiff;suse++) {
            DecrementRemainingSpellUses(oPC,nSpell);
         }
         // check to see if it worked
         int nNewNumSpell = GetHasSpell(nSpell,oPC);
         if (nNewNumSpell != nOldNumSpell) {
           PrintString("PWH anticheat - could not restore spell #"+sLookfor+ " old:"+sSub+
               ",new:"+IntToString(nNewNumSpell));
           //SendMessageToPC(oPC,"Debug - can't restore spell #"+sLookfor+" old="+
           //       sSub+" new="+IntToString(nNewNumSpell));
         }
      } else {
        // wipe all uses
        int suse;
        for (suse=0;suse<nNumSpell;suse++) {
            DecrementRemainingSpellUses(oPC,nSpell);
        }
      }
    }
  }
  // Feats
  string sOldFeatList = GetLocalString(oMod,PC_INFO_FEATS+sID);
  //if (sOldFeatList == "") { // try DB
    // sOldFeatList = GetCampaignString(CAMPAIGNDB,PC_INFO_FEATS+sID);
 // }
  int nFeat;
  int nNumFeat;
  for(nFeat=0; nFeat<MAX_FEATS; nFeat++) {
    if (nNumFeat = GetHasFeat(nFeat,oPC)) {
      string sLookfor = " "+IntToString(nFeat)+":";
      int nStart = FindSubString(sOldFeatList,sLookfor);
      if (nStart >= 0) {
         while (GetSubString(sOldFeatList,nStart,1) != ":") nStart++;
         int nEnd = nStart+1;
         while (GetSubString(sOldFeatList,nEnd,1) != " ") nEnd++;
         string sSub = GetSubString(sOldFeatList,nStart+1,nEnd-nStart);
         int nOldNumFeat= StringToInt( sSub);
         int nFeatDiff = nNumFeat - nOldNumFeat;
         int suse;
         for (suse=0;suse<nFeatDiff;suse++) {
            DecrementRemainingFeatUses(oPC,nFeat);
         }
         // check to see if it worked
         int nNewNumFeat = GetHasFeat(nFeat,oPC);
         if (nNewNumFeat != nOldNumFeat) {
           PrintString("PWH anticheat - could not restore feat #"+sLookfor+ " old:"+sSub+
               ",new:"+IntToString(nNewNumFeat));
           //SendMessageToPC(oPC,"Debug - can't restore feat #"+sLookfor+" old="+
           //       sSub+" new="+IntToString(nNewNumFeat));
         }
      } else {
        // wipe all uses
        int suse;
        for (suse=0;suse<nNumFeat;suse++) {
            DecrementRemainingFeatUses(oPC,nFeat);
        }
      }
    }
  }
}

