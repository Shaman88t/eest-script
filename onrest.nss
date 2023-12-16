/*Basics/Inspiration: Johan (Simple Balance System) and Jay Barnson and The Dungeon Master and Forest Zachman and Timo "Lord Gsox" Bischoff and the HCR Team
Combined/Customized/Modified by Bhaerau

Bug: Multiple pcs resting is possible if pressing r-button twice
Find way to lessen damage after rest due to regeneration

Features:
- Players are limited to resting once per 8 hours and in multiplayer games players must rest in shifts.
- Players will have their handheld items unequipped when resting, become blind (to simulate darknesss), and emitt a snooring sound unless they are elves.
- Dms will be notified of players who is resting.

- Unless being in a safe resting zone, there is a 40 % chance of encountering one enemy (33 % chance of two enemies, 33 % chance of three), which is chosen from the nearest enemy
- Players, familars/animal companions and henchmen will heal their level in hit points when resting.
- If aborting the rest for some reason, the hit points will become as before the rest was started.
*/
#include "j_inc_constants"
#include "ja_inc_stamina"
#include "me_pcneeds_inc"

void main()
{
    object oPlayer = GetLastPCRested();
    object oRight = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPlayer);
    object oLeft = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPlayer);
    effect eEffect = GetFirstEffect(oPlayer);

    object oArea = GetArea(oPlayer);
    string sInn = GetLocalString(oArea, "INN");
    int iSafe = GetLocalInt(oPlayer, sInn);
    if( !iSafe ){
     iSafe = GetLocalInt(oArea, "SAFE");
    }

    if (GetLastRestEventType() == REST_EVENTTYPE_REST_STARTED)
    {
        int iLastHourRest = GetLocalInt(oPlayer, "LastHourRest");
        int iLastDayRest = GetLocalInt(oPlayer, "LastDayRest");
        int iLastYearRest = GetLocalInt(oPlayer, "LastYearRest");
        int iLastMonthRest = GetLocalInt(oPlayer, "LastMonthRest");
        int iHour = GetTimeHour(); int iDay  = GetCalendarDay();
        int iYear = GetCalendarYear(); int iMonth = GetCalendarMonth();
        int iHowLong = 0;
        int iSum = iLastHourRest + iLastDayRest + iLastYearRest + iLastMonthRest;

        if (iLastYearRest != iYear)
            iMonth = iMonth + 12;
        if (iLastMonthRest != iMonth)
            iDay = iDay + 28;
        if (iDay != iLastDayRest)
            iHour = iHour + 24 * (iDay - iLastDayRest);


        iHowLong = iHour - iLastHourRest;
        int iLenght = FloatToInt(sqrt(IntToFloat(GetHitDice(oPlayer))));

        /*DEBUG*/
            //SendMessageToPC(oPlayer, "iHowLong="+IntToString(iHowLong)+";iLenght="+IntToString(iLenght)+";iSum="+IntToString(iSum)+";iSafe="+IntToString(iSafe) );
        /*~DEBUG*/

        if ((iHowLong < iLenght) && (iSum != 0) && (!iSafe))
        {
            AssignCommand(oPlayer, ClearAllActions());
            SendMessageToPC(oPlayer, "Opetovne muzes spat za " + IntToString(iLenght-iHowLong) + " hodiny.");
            SetLocalInt(oPlayer, "RestedHpStart", GetCurrentHitPoints(oPlayer));
        }
        else
        {
            DeleteLocalInt( oPlayer, VARNAME_ALCOHOL + "needlvl" );
            DeleteLocalInt( oPlayer, VARNAME_FOOD + "needlvl");
            DeleteLocalInt( oPlayer, VARNAME_WATER + "needlvl");
            DeleteLocalInt( oPlayer, "JA_STAMINA_SLOWED" );
            SetLocalInt(oPlayer, "RestedHpStart", GetCurrentHitPoints(oPlayer));
            SetLocalInt(oPlayer, "RestedHpDamage", (GetMaxHitPoints(oPlayer) - GetCurrentHitPoints(oPlayer)));

            if (GetIsObjectValid(oRight) || GetIsObjectValid(oLeft))
            {
                AssignCommand(oPlayer, ClearAllActions());
                AssignCommand(oPlayer, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPlayer)));
                AssignCommand(oPlayer, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPlayer)));
                DelayCommand(0.01, AssignCommand(oPlayer, ActionRest()));
                return; //fixed by Jaara
            }

            if ((GetRacialType(oPlayer) != RACIAL_TYPE_ELF))
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_IMP_SLEEP), oPlayer, 7.0);
            }

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ExtraordinaryEffect(EffectBlindness()), oPlayer, 29.0);


            object oCreature = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oPlayer);
            if ((d10() <= 4) && (sInn == "") && GetIsObjectValid(oCreature))
            {
                if(!GetLocalInt(oCreature, "AI_BOSS")){
                    float fX; float fY;

                    switch (d4())
                    {
                        case 1: fX = 0.0; fY = 10.0; break; case 2: fX = 10.0; fY = 0.0; break;
                        case 3: fX = 0.0; fY = -10.0; break; case 4: fX = -10.0; fY = 0.0; break;
                    }

                    DelayCommand(4.0f, SendMessageToPC(oPlayer, "Byl jsi probuzen neprateli!!"));
                    SendMessageToAllDMs("Hrac " + GetName(oPlayer) + " (" + GetPCPlayerName(oPlayer) + ") " + "byl ze spanku probuzen neprateli.");

                    switch (d3())
                    {
                        case 1: DelayCommand(3.0f, AssignCommand(CreateObject(OBJECT_TYPE_CREATURE, GetResRef(oCreature), Location(GetArea(oPlayer), (GetPosition(oPlayer) + Vector(fX, fY)), GetFacing(oPlayer)), FALSE), DelayCommand(1.0, DetermineCombatRound(oPlayer))));
                                break;
                        case 2: DelayCommand(3.0f, AssignCommand(CreateObject(OBJECT_TYPE_CREATURE, GetResRef(oCreature), Location(GetArea(oPlayer), (GetPosition(oPlayer) + Vector(fX, fY)), GetFacing(oPlayer)), FALSE), DelayCommand(1.0, DetermineCombatRound(oPlayer))));
                                DelayCommand(3.0f, AssignCommand(CreateObject(OBJECT_TYPE_CREATURE, GetResRef(oCreature), Location(GetArea(oPlayer), (GetPosition(oPlayer) + Vector(fX, fY)), GetFacing(oPlayer)), FALSE), DelayCommand(1.0, DetermineCombatRound(oPlayer))));
                                break;
                        case 3: DelayCommand(3.0f, AssignCommand(CreateObject(OBJECT_TYPE_CREATURE, GetResRef(oCreature), Location(GetArea(oPlayer), (GetPosition(oPlayer) + Vector(fX, fY)), GetFacing(oPlayer)), FALSE), DelayCommand(1.0, DetermineCombatRound(oPlayer))));
                                DelayCommand(3.0f, AssignCommand(CreateObject(OBJECT_TYPE_CREATURE, GetResRef(oCreature), Location(GetArea(oPlayer), (GetPosition(oPlayer) + Vector(fX, fY)), GetFacing(oPlayer)), FALSE), DelayCommand(1.0, DetermineCombatRound(oPlayer))));
                                DelayCommand(3.0f, AssignCommand(CreateObject(OBJECT_TYPE_CREATURE, GetResRef(oCreature), Location(GetArea(oPlayer), (GetPosition(oPlayer) + Vector(fX, fY)), GetFacing(oPlayer)), FALSE), DelayCommand(1.0, DetermineCombatRound(oPlayer))));
                                break;
                    }
                    DelayCommand(4.0, AssignCommand(oPlayer, ClearAllActions()));
                }
            }
        }
    }
    if (GetLastRestEventType() == REST_EVENTTYPE_REST_FINISHED)
    {
      if(!iSafe){
        int iDamage = GetLocalInt(oPlayer, "RestedHpDamage") - GetHitDice(oPlayer);
        if( iDamage < 0 ) iDamage = 0;

        ApplyEffectToObject(DURATION_TYPE_INSTANT, ExtraordinaryEffect(EffectDamage(iDamage, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE)), oPlayer);
        PC_NeedsOnRest(oPlayer);
        restoreStamina(oPlayer, getMaxStamina(oPlayer)/2.0);
/*
        if ((GetMaxHitPoints(oPlayer) > GetLocalInt(oPlayer, "RestedHpStart") && GetLocalInt(oPlayer, "RestedHpDamage") > GetHitDice(oPlayer)))
        {
                     ApplyEffectToObject(DURATION_TYPE_INSTANT, ExtraordinaryEffect(EffectDamage(GetLocalInt(oPlayer, "RestedHpDamage") - GetHitDice(oPlayer), DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE)), oPlayer);
        }

        if (GetCurrentHitPoints(oPlayer) > GetMaxHitPoints(oPlayer))
            ApplyEffectToObject(DURATION_TYPE_INSTANT, ExtraordinaryEffect(EffectDamage(GetCurrentHitPoints(oPlayer) - GetMaxHitPoints(oPlayer), DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE)), oPlayer);*/
      }
      else{
        int iDamage = GetLocalInt(oPlayer, "RestedHpDamage") - 2*GetHitDice(oPlayer);
        if( iDamage < 0 ) iDamage = 0;

        ApplyEffectToObject(DURATION_TYPE_INSTANT, ExtraordinaryEffect(EffectDamage(iDamage, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE)), oPlayer);
        SendMessageToPC(oPlayer, "Dobre jsi si odpocinul");
        DeleteLocalInt(oPlayer, sInn);
        PC_NeedsOnRest(oPlayer);
        restoreStamina(oPlayer, 3.0*getMaxStamina(oPlayer)/4.0);
      }
        SetLocalInt(oPlayer, "LastHourRest", GetTimeHour());
        SetLocalInt(oPlayer, "LastDayRest", GetCalendarDay());
        SetLocalInt(oPlayer, "LastMonthRest", GetCalendarMonth());
        SetLocalInt(oPlayer, "LastYearRest", GetCalendarYear());
        DeleteLocalInt(oPlayer, "RestedHpStart");
        DeleteLocalInt(oPlayer, "RestedHpDamage");
    }
    if ((GetLastRestEventType() == REST_EVENTTYPE_REST_CANCELLED) || (GetLastRestEventType() == REST_EVENTTYPE_REST_INVALID))
    {
        if (GetLocalInt(oPlayer, "RestedHpStart") < GetMaxHitPoints(oPlayer))
            ApplyEffectToObject(DURATION_TYPE_INSTANT, ExtraordinaryEffect(EffectDamage(GetCurrentHitPoints(oPlayer) - GetLocalInt(oPlayer, "RestedHpStart"), DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE)), oPlayer);

        DeleteLocalInt(oPlayer, "RestedHpStart");
        DeleteLocalInt(oPlayer, "RestedHpDamage");
    }
}
