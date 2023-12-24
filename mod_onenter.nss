#include "aps_include"
#include "persistence"
#include "zep_inc_phenos"
#include "ja_inc_stamina"
#include "me_pcneeds_inc"
#include "ku_libbase"
#include "subraces"
#include "nwnx_item"
// kuly alchymii


void SetPCPlayed(object oPC) {
  object oSoul = GetSoulStone(oPC);
  SetLocalInt(oSoul,"PLAYED",TRUE);
}

void SafeJump(object oPC, location lLoc){
    string sAre = GetTag(GetArea(oPC));
    if(sAre == "VitejtevThalii"){
        zep_Dismount(oPC, "ja_kun_getdown");
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, JumpToLocation(lLoc));
    }
}

void __saveAllPlayers() {
  object oPC = GetFirstPC();

  while(GetIsObjectValid(oPC)) {
    if(!GetIsDM(oPC))
      SavePlayer(oPC,0);

    oPC = GetNextPC();
  }

}

void UnspellItems(object oPC){
     object oItem = GetFirstItemInInventory(oPC);
     int iGold, iWeight;

    //ohen na zbrani
    itemproperty prop = GetFirstItemProperty(oItem);
    //Search for properties
    while(GetIsItemPropertyValid(prop))
    {
       if(GetItemPropertyDurationType(prop) == DURATION_TYPE_TEMPORARY)
           RemoveItemProperty(oItem, prop);
       prop = GetNextItemProperty(oItem);
    }

    // Vaha a cena predmetu
    iGold = GetLocalInt(oItem,"GOLDPIECEVALUE");
    iWeight = GetLocalInt(oItem,"WEIGHT");
    if(iGold > 0 && iGold != GetGoldPieceValue(oItem))
      NWNX_Item_SetBaseGoldPieceValue(oItem,iGold);
    if(iWeight > 0 && iWeight != GetWeight(oItem))
      NWNX_Item_SetWeight(oItem,iWeight);

    oItem = GetNextItemInInventory(oPC);

    //~ohen na zbrani

}

void AddPlayerToDump(object oPC){
    string sPC = SQLEncodeSpecialChars(GetName(oPC));
    int iID    = GetLocalInt(GetModule(), "JA_DUMP_ID");

    SetLocalInt(GetModule(), "JA_DUMP_ID", iID+1);
    SetLocalInt(oPC, "JA_DUMP_ID", iID);
    string sPortrait = GetPortraitResRef(oPC);

    string sql = "INSERT INTO dump (id, name, portrait) VALUES ("+IntToString(iID)+", '"+sPC+"', '"+sPortrait+"');";
    SQLExecDirect(sql);
}

void CheckHasSpecialItems(object oPC){

    //SendMessageToPC(oPC, "DAVAM PREDMETY");
    if(!GetIsObjectValid(GetItemPossessedBy(oPC, "dmfi_pc_follow"))){
       CreateItemOnObject("dmfi_pc_follow", oPC);
    }
    if(!GetIsObjectValid(GetItemPossessedBy(oPC, "dmfi_pc_dicebag"))){
       CreateItemOnObject("dmfi_pc_dicebag", oPC);
    }
    if(!GetIsObjectValid(GetItemPossessedBy(oPC, "dmfi_pc_emote"))){
       CreateItemOnObject("dmfi_pc_emote", oPC);
    }
    if(!GetIsObjectValid(GetSoulStone(oPC))){
       CreateItemOnObject("sy_soulstone", oPC);
    }
}

void UpdateLoginIP(object oPC) {

     if(!GetIsObjectValid(oPC))
       return;

     string Player = SQLEncodeSpecialChars(GetPCPlayerName(oPC));
     string IP     = GetPCIPAddress(oPC);
     string sql = "UPDATE pwplayers SET ip_last_logged = '"+IP+"' WHERE login='"+Player+"';";
     SQLExecDirect(sql);
}

void main()
{
 object oPC = GetEnteringObject();

//safety

    string Player = SQLEncodeSpecialChars(GetPCPlayerName(oPC));
    string IP     = GetPCIPAddress(oPC);
    string CDKEY  = GetPCPublicCDKey(oPC);
  /*  WriteTimestampedLogEntry("Try to login: Player "+Player+" from "+IP+":"+IntToString(GetPCPort(oPC))+" CDKEY:"+CDKEY+", with character: "+GetName(oPC)+".");

    string sql = "SELECT IP, CDKEY, NOIPCHECK, privilegies FROM pwplayers WHERE login='"+Player+"';";
    SQLExecDirect(sql);
    if (SQLFetch() == SQL_SUCCESS){
        string n_IP = SQLDecodeSpecialChars(SQLGetData(1));
        string n_CDKEY = SQLDecodeSpecialChars(SQLGetData(2));
        int n_NOIPCHECK = StringToInt(SQLGetData(3));
        int n_priv = StringToInt(SQLGetData(4));

        SetLocalInt(oPC, "KU_PLAYER_PRIVILEGIES",n_priv);

        if( (n_IP != IP && n_NOIPCHECK == 0) || n_CDKEY != CDKEY ){
         BootPC(oPC);
         WriteTimestampedLogEntry("UNAUTHORIZED LOGIN: Player "+Player+" from "+IP+" CDKEY:"+CDKEY+", should be "+n_IP+", "+n_CDKEY);
         return;
        }

        if( GetIsDM(oPC) && (n_priv < 1) ) {
          BootPC(oPC);
          WriteTimestampedLogEntry("UNAUTHORIZED DM LOGIN: Player "+Player+" from "+IP+" CDKEY:"+CDKEY+", should be "+n_IP+", "+n_CDKEY+" Don't have  DM privilegies");
          return;
        }
        if( (n_priv < 0) ) {
          BootPC(oPC);
          WriteTimestampedLogEntry("BANNED OR NOT AUTHORIZED LOGIN: Player "+Player+" from "+IP+" CDKEY:"+CDKEY+", should be "+n_IP+", "+n_CDKEY+" Don't have  DM privilegies");
          return;
        }
    }
    else{
         BootPC(oPC);
         WriteTimestampedLogEntry("UNAUTHORIZED LOGIN: Player "+Player+" from "+IP+" CDKEY:"+CDKEY+", he has no registration.");
         return;
    }
         */
    /* IP bany */
  /* int iFrom=0, iTo;
    string ip_1, ip_2, ip_3, ip_4;
    int iBaned = FALSE;
    string sBanIP = "";
    iTo = FindSubString(IP,".",iFrom);
    ip_1 = GetSubString(IP,iFrom,iTo - iFrom);
    iFrom = iTo + 1;
    iTo = FindSubString(IP,".",iFrom);
    ip_2 = GetSubString(IP,iFrom,iTo - iFrom);
    iFrom = iTo + 1;
    iTo = FindSubString(IP,".",iFrom);
    ip_3 = GetSubString(IP,iFrom,iTo - iFrom);
    iFrom = iTo + 1;
    ip_4 = GetSubString(IP,iFrom,3);

    sql = "SELECT id, ip FROM IP_BANS WHERE IP IN ('"+IP+"','"+ip_1+"."+ip_2+"."+ip_3+"','"+ip_1+"."+ip_2+"','"+ip_1+"');";
    SQLExecDirect(sql);
    if (SQLFetch() == SQL_SUCCESS){
      iBaned = TRUE;
      sBanIP = SQLGetData(2);
    }   */

    /* IF this IP is BANNED */
   /* if (iBaned){
      sql = "SELECT id FROM IP_BANS WHERE excludes='"+Player+"';";
      SQLExecDirect(sql);
      if (SQLFetch() != SQL_SUCCESS){
         BootPC(oPC);
         WriteTimestampedLogEntry("BANNED LOGIN: Player "+Player+" from "+IP+" CDKEY:"+CDKEY+", tried to login from BANNED IP '"+sBanIP+"'");
         return;
      }
    }    */
    /* ~IP bany */

//~safety*/


 /* Remember last logged IP */
 DelayCommand(120.0,UpdateLoginIP(oPC));

 AddPlayerToDump(oPC);

 ku_OnClientEnter(oPC); // Inicializace eXPiciho systemu pri loginu hrace.
 Subraces_InitSubrace( oPC ); //Inicializace subrasy

 object oSoul = GetSoulStone(oPC);
 SetLocalInt(oPC,"SUBDUAL_MODE",GetLocalInt(oSoul,"SUBDUAL_MODE"));

 int iPlayed = GetPersistentInt(oPC, "PLAYED");
 if(!iPlayed)
   iPlayed = GetPersistentInt(oPC, "PLAYED","pwchars");

 /* Check for bad duplicit characters */
 if(iPlayed && !GetLocalInt(oSoul,"PLAYED") && GetXP(oPC) < 100) {
   SendMessageToAllDMs("Player "+Player+" logged with duplicit character "+GetName(oPC)+"!!!");
   return;
 }

 if(iPlayed){
    int iHP = GetPersistentInt(oPC, "HP");
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(GetCurrentHitPoints(oPC)-iHP,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_PLUS_FIVE), oPC);
 }
 else{ //is first
    SetPersistentInt(oPC, "PLAYED", 1,0,"pwchars");
    SetPersistentInt(oPC, "PLAYED", 1);
    SetPersistentInt(oPC, "HP", GetCurrentHitPoints(oPC));
 }
 SetLocalInt(oSoul,"PLAYED",TRUE);
 DelayCommand(1.0,SetPCPlayed(oPC));
 DelayCommand(5.0,SetPCPlayed(oPC));

 SetLocalInt(oPC, "HP", GetCurrentHitPoints(oPC));

// string spells = GetPersistentString(oPC, "SPELLS");
// string feats  = GetPersistentString(oPC, "FEATS");
 string sChram = GetPersistentString(oPC, "CHRAM");

 location lLoc = GetPersistentLocation(oPC, "LOCATION");

 SetLocalString(oPC, "CHRAM", sChram);
 SetLocalLocation(oPC, "LOCATION", lLoc);

 SetLocalString(oPC, "NAME", GetName(oPC));
 SetLocalString(oPC, "PLAYERNAME", GetPCPlayerName(oPC));

// pSetSpells(oPC, spells);
// pSetFeats(oPC, feats);

 UnspellItems(oPC);

//horses
 object oTest = GetLocalObject(oPC, "JA_HORSE_OBJECT");

 if(!GetIsObjectValid(oTest)){
     string sResRef = GetPersistentString( oPC, "HORSE", "pwhorses" );
     if( sResRef != "" ){
         location lHorseLoc = GetPersistentLocation( oPC, "LOCATION", "pwhorses");
         if(!GetIsObjectValid(GetAreaFromLocation(lHorseLoc)))
            lHorseLoc = lLoc;
         object oHorse = CreateObject( OBJECT_TYPE_CREATURE, sResRef, lHorseLoc );
         SetLocalObject(oHorse, "JA_HORSE_PC", oPC);
         SetLocalObject(oPC, "JA_HORSE_OBJECT", oHorse);
         /* Horse name */
         string sName = GetPersistentString( oPC, "HORSE_NAME", "pwhorses");
         if(GetStringLength(sName) > 0) {
           SetName(oHorse,sName);
         }
     }
 }
//~horses

//stamina
 float fStamina = GetPersistentFloat( oPC, "STAMINA" );
 if( fStamina <= 0.0 )
    fStamina = getMaxStamina(oPC);
 if( fStamina > getMaxStamina(oPC))
    fStamina = getMaxStamina(oPC);

 SetLocalFloat(oPC, "JA_STAMINA", fStamina);
//~stamina

//needs
    float fWaterR = GetPersistentFloat(oPC, VARNAME_WATER);
    float fAlcoholR = GetPersistentFloat(oPC, VARNAME_ALCOHOL);
    float fFoodR = GetPersistentFloat(oPC, VARNAME_FOOD);
    if (fWaterR <= 0.0) fWaterR = MAX_WATER;
    if (fFoodR <= 0.0) fFoodR = MAX_FOOD;
    SetLocalFloat(oPC, VARNAME_FOOD  ,fFoodR);
    SetLocalFloat(oPC, VARNAME_WATER ,fWaterR);
    SetLocalFloat(oPC, VARNAME_ALCOHOL  ,fAlcoholR);
//~needs

//Alchymie
    object oSoulStone = GetSoulStone(oPC);
    SetLocalObject(oPC, "oSoulStone", oSoulStone);

//~Alchymie

//skill sbirani
    SetLocalInt(oPC,"iAmDigging",0);
//~skill sbirani

 if(iPlayed){
  DelayCommand(5.0f, SafeJump(oPC, lLoc));
  DelayCommand(10.0f, SafeJump(oPC, lLoc));
  DelayCommand(20.0f, SafeJump(oPC, lLoc));
  DelayCommand(40.0f, SafeJump(oPC, lLoc));
  DelayCommand(80.0f, SafeJump(oPC, lLoc));
 }
 else{
    if(GetHitDice(oPC)==1){    //je tu poprvy
     object oItem = GetFirstItemInInventory(oPC);
     while(GetIsObjectValid(oItem)){
        DestroyObject(oItem);
        oItem = GetNextItemInInventory(oPC);
     }
     DestroyObject(GetItemInSlot(INVENTORY_SLOT_CHEST, oPC));
     DestroyObject(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC));

     TakeGoldFromCreature(GetGold(oPC), oPC, TRUE);
     GiveGoldToCreature(oPC, 2000);
     //SendMessageToPC(oPC, "SMAZANY PREDMETY");
    }
 }

// Get XP and GOLD backup from DB
 if(GetLocalInt(oSoul,"LOGED_OUT") == 0) {
   int iXP = GetPersistentInt(oPC,"XP_BACKUP");
   if(iXP > GetXP(oPC))
     SetXP(oPC,iXP);
   int iGold = GetPersistentInt(oPC,"GOLD_BACKUP");
   if(iGold > GetGold(oPC))
     GiveGoldToCreature(oPC,iGold - GetGold(oPC));

 }
 SetLocalInt(oSoul,"LOGED_OUT",0);
//~Get XP and GOLD backup from DB

 DelayCommand(1.0, CheckHasSpecialItems(oPC));

// ExecuteScript("cnr_module_oce", OBJECT_SELF);

  /* Bugfixy */
  DeleteLocalInt(oPC,"ku_sleeping");
  DeleteLocalInt(oPC,"KU_DEATH_NOLOG");
}
