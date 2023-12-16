// Authors  : TondaLee (AV) - Antonin Vins
// Created  : 05/2005
// Modified : 12/06/2005

// pomocne metody, pouzivane v celem modulu

#include "_inc_config"
#include "_inc_messages"
#include "_inc_db_characte"
#include "_inc_db_skills"

// Prida skusenost za zvyseni skillu, podle globalniho nastaveni
void AddXPForSkill(object oPlayer, int iSkillIncrease);

// prace s inventarem
// pridani predmetu do inventare
// pred samotnym pridanim se nejprve overi zda jiz neni predmet v inventari
// v pripade ze tam jiz predmet je, neni vytvoren
void CreateItemOnPlayer(object oPlayers, string sREF);
void RemoveItemsOnPlayer(object oPlayer, string sTag);

// prace s charakterem
// ulozeni postavy
void SaveCharacter(object oPlayer);
// vytvori objekt v urcene lokaci, pouzivane pro delaycommand
void CreateObjectOnLocation(int nObjectType, string sTemplate, location lLocation, string sTag);
// odstrani urceny pocet predmetu (dle tagu) u inventare postavy
void RemoveItemsFromPlayer(object oPlayer, string sItemTag, int iItemNumbers);

// zjisti zda ma hrac predmet s urcitym mnozstvim v inventari
int HasPlayerItems(object oPlayer, string sItemTag, int iItemNumbers);
void ChangeSkillDMWand(object oPlayer, string sDmSkillType, int iZmena);
void MakeDrunk(object oTarget, int nPoints);
void HealCharacter(object oPlayer, int iNumber);
void SendMessageToAllPC(string sMessage);
void BootAllPlayers();
int IsPlayerUndead(object oPlayer);
void DiseaseCharacter(object oPlayer, int iType);
void PoisonCharacter(object oPlayer, int iType);


// Prace s charakterem
// Prida skusenost za zvyseni skillu
void   AddXPForSkill(object oPlayer, int iSkillIncrease)
{
    int iXPToGive = XP_FOR_SKILL * iSkillIncrease;
    if (iXPToGive > 0) GiveXPToCreature(oPlayer, iXPToGive);
    else
    {
        int iNewXP = GetXP(oPlayer) - iXPToGive;
        SetXP(oPlayer, iNewXP);
    }
}
//ulozi charakter (postavu) do DB
void SaveCharacter(object oPlayer)
{
    ExportSingleCharacter(oPlayer);
    StandardPlayerMessage(oPlayer, "Postava ulozena.");
}
// prace s inventarem
// vytvori predmet v inventari postavy
void CreateItemOnPlayer(object oPlayer, string sREF)
{
    object oMagicBox = GetItemPossessedBy(oPlayer, sREF);

    if(GetIsObjectValid(oMagicBox)== FALSE)
    {
        object createdObject = CreateItemOnObject(sREF, oPlayer);
    }
}
// smaze vsechny predmety z daneho hrace, daneho tagu
void RemoveItemsOnPlayer(object oPlayer, string sTag)
{
    int iNum = 0;
    object oObjectToDestroy = GetObjectByTag(sTag, iNum++);

    while(oObjectToDestroy != OBJECT_INVALID)
    {
        if(GetItemPossessor(oObjectToDestroy) == oPlayer) DestroyObject(oObjectToDestroy);
        oObjectToDestroy = GetObjectByTag(sTag, iNum++);
    }
}
// vytvori objekt v urcene lokaci, pouzivane pro delaycommand
void CreateObjectOnLocation(int nObjectType, string sTemplate, location lLocation, string sTag)
{
    CreateObject(nObjectType, sTemplate, lLocation, FALSE, sTag);
}
// odstrani urceny pocet predmetu (dle tagu) u inventare postavy
void RemoveItemsFromPlayer(object oPlayer, string sItemTag, int iItemNumbers)
{
    object oCurrentItem = GetFirstItemInInventory(oPlayer);
    int iStackSize = GetItemStackSize(oCurrentItem);

    while (oCurrentItem != OBJECT_INVALID)
    {
        if (GetTag(oCurrentItem) == sItemTag)
        {
            iStackSize = GetItemStackSize(oCurrentItem);
            if (iItemNumbers > 0)
            {
                if (iStackSize <= iItemNumbers)
                {
                    DestroyObject(oCurrentItem);
                    iItemNumbers-= iStackSize;
                }
                else
                {
                    iStackSize-= iItemNumbers;
                    SetItemStackSize(oCurrentItem, iStackSize);
                    iItemNumbers = 0;
                }
            }
        }
        if (iItemNumbers == 0) return;
        oCurrentItem = GetNextItemInInventory(oPlayer);
    }
}
// zjisti zda ma hrac predmet s urcitym mnozstvim v inventari
int HasPlayerItems(object oPlayer, string sItemTag, int iItemNumbers)
{
    object oCurrentItem = GetFirstItemInInventory(oPlayer);
    int iStackSize = GetItemStackSize(oCurrentItem);

    while (oCurrentItem != OBJECT_INVALID)
    {
        if (GetTag(oCurrentItem) == sItemTag)
        {
            iStackSize = GetItemStackSize(oCurrentItem);
            if (iItemNumbers > 0)
            {
                if (iStackSize <= iItemNumbers)
                {
                    iItemNumbers-= iStackSize;
                }
                else
                {
                    iStackSize-= iItemNumbers;
                    iItemNumbers = 0;
                }
            }
        }
        if (iItemNumbers == 0) return 1;
        oCurrentItem = GetNextItemInInventory(oPlayer);
    }
    if (iItemNumbers == 0) return 1;
    else return 0;
}
void ChangeSkillDMWand(object oPlayer, string sDmSkillType, int iZmena)
{
    int iSkill;
    if (sDmSkillType == "Karma")
    {
        iSkill = GetCharacterKarma(oPlayer);
        iSkill+= iZmena;

        SetCharacterKarma(oPlayer, iSkill);
        SendMessageToPC(oPlayer, "Byla Vam zmenena karma o: " + IntToString(iZmena));
    }
    else
    {
        iSkill = GetCharacterSkill(oPlayer, sDmSkillType);
        if (iSkill < 1 && iZmena < 1) return;
        if ((iSkill + iZmena) < 0) iZmena = -iSkill;

        iSkill+= iZmena;
        if (iSkill < 1)
        {
            DeleteCharacterSkill(oPlayer, sDmSkillType);
            SendMessageToPC(oPlayer, "Ztratil jste schopnost: "  + GetSkillName(sDmSkillType));
        }
        else
        {
            SetCharacterSkill(oPlayer, sDmSkillType, iSkill);
            SendMessageToPC(oPlayer, "Zmena stavu Vasi schopnosti: " + GetSkillName(sDmSkillType) + "(" +  IntToString(iZmena) +  ")");
        }
        AddXPForSkill(oPlayer, iZmena);
    }
}
void MakeDrunk(object oTarget, int nPoints)
{
    if (Random(100) + 1 < 40)
        AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING));
    else
        AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK));

    effect eDumb = EffectAbilityDecrease(ABILITY_INTELLIGENCE, nPoints);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDumb, oTarget, 360.0);
    //AssignCommand(oTarget, SpeakString(IntToString(GetAbilityScore(oTarget,ABILITY_INTELLIGENCE))));
}
void HealCharacter(object oPlayer, int iNumber)
{
    if (IsPlayerUndead(oPlayer)) return;

    effect eHeal = EffectHeal(iNumber);

    // Create the visual portion of the effect. This is instantly
    // applied and not persistant with wether or not we have the
    // above effect.
    effect eVis = EffectVisualEffect(VFX_IMP_HEALING_G);

    // Apply the visual effect to the target
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPlayer);
    // Apply the effect to the object
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPlayer);
}
void SendMessageToAllPC(string sMessage)
{
    object oPlayer = GetFirstPC();
    while (oPlayer != OBJECT_INVALID)
    {
        SendMessageToPC(oPlayer, sMessage);
        oPlayer = GetNextPC();
    }
}
void BootAllPlayers()
{
    object oPlayer = GetFirstPC();
    while (oPlayer != OBJECT_INVALID)
    {
        BootPC(oPlayer);
        oPlayer = GetNextPC();
    }
}
int IsPlayerUndead(object oPlayer)
{
    if (GetStringLowerCase(GetSubRace(oPlayer)) == "vampire") return 1;
    return 0;
}
void DiseaseCharacter(object oPlayer, int iType)
{
    if (IsPlayerUndead(oPlayer))
    {
        return;
    }

    effect eDis = EffectDisease(iType);

    // Create the visual portion of the effect. This is instantly
    // applied and not persistant with wether or not we have the
    // above effect.
    effect eVis = EffectVisualEffect(VFX_IMP_DISEASE_S);

    // Apply the visual effect to the target
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPlayer);
    // Apply the effect to the object
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDis, oPlayer);
}
void PoisonCharacter(object oPlayer, int iType)
{
    if (IsPlayerUndead(oPlayer))
    {
        return;
    }

    effect eDis = EffectPoison(iType);

    // Create the visual portion of the effect. This is instantly
    // applied and not persistant with wether or not we have the
    // above effect.
    effect eVis = EffectVisualEffect(VFX_IMP_POISON_S);

    // Apply the visual effect to the target
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPlayer);
    // Apply the effect to the object
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDis, oPlayer);
}
