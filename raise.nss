//EDIT Sylm : osetrenie cheatovania uniku z podsvetia cez Thaala

#include "aps_include"
#include "raiseinc"
#include "sy_main_lib"
#include "ja_lib"

void ApplyPenalty(object oDead)
{
    int nXP = GetXP(oDead);
    int nPenalty = nXP * 5 / 100;
    int nHD = GetHitDice(oDead);
    // * You can not lose a level with this respawning under 4th level
    int nMin;
    if(nHD < 4)
        nMin = ((nHD * (nHD - 1)) / 2) * 1000;
    else
        nMin = 0;

    int nNewXP = nXP - nPenalty;
    if (nNewXP < nMin)
       nNewXP = nMin;

    nPenalty = nXP - nNewXP;
    object oSoul = GetSoulStone(oDead);
    int xpk = GetLocalInt(oSoul,"ku_XPbyKill");
    if(xpk < nPenalty )
      nPenalty = xpk;
    SetLocalInt(oSoul,"ku_XPbyKill",xpk - nPenalty);

    SetXP(oDead, nNewXP);


     int nGoldToTake = 0;
    if(nHD > 5)
    nGoldToTake = FloatToInt(0.5 * GetGold(oDead));
    if(nHD > 10)
    nGoldToTake = GetGold(oDead);
    AssignCommand(oDead, TakeGoldFromCreature(nGoldToTake, oDead, TRUE));
}

void main()
{
   object oPC = GetPCSpeaker();

   if(GetLocalInt(oPC,"RELEVELING")) {
     SendMessageToAllDMs("BUG!!! Postava"+GetName(oPC)+" hrac "+GetPCPlayerName(oPC)+" pokus o bug - revelup pri oziveni.");
     WriteTimestampedLogEntry("BUG!!! Postava"+GetName(oPC)+" hrac "+GetPCPlayerName(oPC)+" pokus o bug - revelup pri oziveni.");
     return;
   }

   DeleteLocalInt(oPC, "LastHourRest");
   DeleteLocalInt(oPC, "LastDayRest");
   DeleteLocalInt(oPC, "LastYearRest");
   DeleteLocalInt(oPC, "LastMonthRest");


   string sCorpseTag = GetLocalString(oPC, "CORPSETAG");
   object oCorpse = GetObjectByTag(sCorpseTag);

   DestroyObject(oCorpse, 1.0f);
   object wpRaise = GetWaypointByTag(GetLocalString(oPC, "CHRAM"));
   if(!GetIsObjectValid(wpRaise)){
    SendMessageToPC(oPC, "Nemas svazanou dusi s zadnym chramem. Zkus relog, pote DM.");
    SendMessageToAllDMs("Hrac "+GetName(oPC)+" nema svazanou dusi s zadnym chramem (utok pri startu na Thala?).");
    return;
   }
   SetLocalLocation(oPC, "LOCATION", GetLocation(wpRaise));
   //string ID = GetLocalString(oPC, "ID");
   SetPersistentLocation(oPC, "LOCATION", GetLocation(wpRaise));

   Raise(oPC);
   ApplyPenalty(oPC);

   //edit Sylm : pri uspesnom oziveni cez Astarotha odstranim priznak smrti z duse bytosti
   object oSoulItem = sy_has_soulitem(oPC);
   DeleteLocalInt(oSoulItem,"isDead");
   //end Sylm

   AssignCommand(oPC, ClearAllActions(TRUE));
   AssignCommand(oPC, JumpToObject(wpRaise));
}
