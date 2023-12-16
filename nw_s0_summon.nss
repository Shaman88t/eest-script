//::///////////////////////////////////////////////
//:: Summon Creature Series
//:: NW_S0_Summon
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Carries out the summoning of the appropriate
    creature for the Summon Monster Series of spells
    1 to 9
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 8, 2002
//:://////////////////////////////////////////////
#include "x2_inc_spellhook"
#include "cnr_persist_inc"
// melvik upava na novy zpusob nacitani soulstone 16.5.2009
#include "me_lib"

string sSumoned;
int iSpell(int SpellID);
effect SetSummonEffectDruid(int nSpellID);
effect SetSummonEffectMage(int nSpellID);
effect SetSummonEffectAll(int nSpellID);
string HasChoosenSpell(int SpellID, object oCaster);
void UseSummoningSkill(int nSpellID, object oCaster, string sMonster, int nDuration,location lTar);
void CreateNonSummonMonster(string sResRef, int iPenalty, int iSkill,location lTar);
//void UseSummoningSkill();

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    int oClass = GetLastSpellCastClass();
    int nSpellID = GetSpellId();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    if(nDuration == 1)
    {
        nDuration = 2;
    }

   /* switch(oClass){
        case CLASS_TYPE_DRUID:
        case CLASS_TYPE_RANGER:
            eSummon = SetSummonEffectDruid(nSpellID);
            break;
        default: eSummon = SetSummonEffectMage(nSpellID);
    }                       */

    //Make metamagic check for extend
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    // nDuration
    //Apply the VFX impact and summon effect
    string sSummonByBook = HasChoosenSpell(nSpellID, OBJECT_SELF);
    if (sSummonByBook != ""){
        UseSummoningSkill(nSpellID, OBJECT_SELF, sSummonByBook, nDuration, GetSpellTargetLocation());
    }
    else{
        effect eSummon = SetSummonEffectAll(nSpellID);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), TurnsToSeconds(nDuration));
        object oMonster = GetObjectByTag(sSumoned);
        if (oMonster != OBJECT_INVALID) SetName(oMonster, "Povolany");
    }
}

effect SetSummonEffectDruid(int nSpellID)
{
    int nFNF_Effect;
    int per;
    string sSummon;

        if(nSpellID == SPELL_SUMMON_CREATURE_I)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            per = Random(3);
            switch (per){
             case 0: sSummon = "zep_eagle"; break;
             case 1: sSummon = "nw_wolf"; break;
             case 2: sSummon = "zep_dogwild"; break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_II)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            per = Random(7);
            switch (per){
             case 0: sSummon = "nw_bearblck"; break;
             case 1: sSummon = "nw_boar"; break;
             case 2: sSummon = "zep_elemfires"; break;
             //case 3: sSummon = "zep_elemwaters"; break;
             case 3: sSummon = "zep_elemairs"; break;
             case 4: sSummon = "zep_elemearths"; break;
             case 5: sSummon = "nw_cat"; break;
             case 6: sSummon = "zep_medforestvi"; break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_III)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            per = Random(7);
            switch (per){
             case 0: sSummon = "nw_lion"; break;
             case 1: sSummon = "nw_boardire"; break;
             case 2: sSummon = "zep_hugeforestvi"; break;
             case 3: sSummon = "zep_cattiger"; break;
             case 4: sSummon = "obrivosa"; break;
             case 5: sSummon = "nw_spidgiant"; break;
             case 6: sSummon = "zep_salaflamebro"; break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            per = Random(4);
            switch (per){
             case 0: sSummon = "nw_direwolf"; break;
             case 1: sSummon = "zep_owlbear_up"; break;
             case 2: sSummon = "nw_bearbrwn"; break;
             case 3: sSummon = "zep_spidbloodbak"; break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_V)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            per = Random(7)+1;
            switch (per){
       //    case 0: sSummon = "zep_elemwaterm"; break;
             case 1: sSummon = "zep_elemearthm"; break;
             case 2: sSummon = "zep_elemairm"; break;
             case 3: sSummon = "zep_elemfirem"; break;
             case 4: sSummon = "nw_bearkodiak"; break;
             case 5: sSummon = "nw_spiddire"; break;
             case 6: sSummon = "nw_btlstag"; break;
             case 7: sSummon = "zep_sala"; break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            per = Random(4);
            switch (per){
             case 0: sSummon = "nw_beardire"; break;
             case 1: sSummon = "zep_treant"; break;
             case 2: sSummon = "zep_barghestg"; break;
             case 3: sSummon = "nw_wolfdireboss"; break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            per = Random(5)+1;
            switch (per){
      //       case 0: sSummon = "zep_elemwaterl"; break;
             case 1: sSummon = "zep_elemearthl"; break;
             case 2: sSummon = "zep_elemairl"; break;
             case 3: sSummon = "zep_elemfirel"; break;
             case 4: sSummon = "nw_diretiger"; break;
             case 5: sSummon = "zep_salanob"; break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            per = Random(3)+1;
            switch (per){
//             case 0: sSummon = "nw_waterhuge"; break;
             case 1: sSummon = "nw_airhuge"; break;
             case 2: sSummon = "nw_firehuge"; break;
             case 3: sSummon = "nw_earthhuge"; break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IX)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            per = Random(4)+1;
            switch (per){
             case 1: sSummon = "nw_fireelder"; break;
             //case 1: sSummon = "nw_watelder"; break;
             case 2: sSummon = "nw_eartheld"; break;
             case 3: sSummon = "nw_airgreat"; break;
             case 4: sSummon = "nw_beardireboss"; break;
            }
        }
    //effect eVis = EffectVisualEffect(nFNF_Effect);
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
    effect eSummonedMonster = EffectSummonCreature(sSummon, nFNF_Effect);
    return eSummonedMonster;
}

effect SetSummonEffectMage(int nSpellID)
{
    int nFNF_Effect;
    int per;
    int Alignment = GetAlignmentGoodEvil(OBJECT_SELF);
    string sSummon;
    if(GetHasFeat(FEAT_ANIMAL_DOMAIN_POWER)) //WITH THE ANIMAL DOMAIN
    {
        if(nSpellID == SPELL_SUMMON_CREATURE_I)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            per = Random(7);
            switch (per){
             case 0: sSummon = "nw_bearblck"; break;
             case 1: sSummon = "nw_boar"; break;
             case 2: sSummon = "nw_direbadg"; break;
             case 3: sSummon = "zep_elemfires"; break;
            // case 4: sSummon = "zep_elemwaters"; break;
             case 4: sSummon = "zep_elemairs"; break;
             case 5: sSummon = "zep_elemearths"; break;
             case 6: sSummon = "nw_cat"; break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_II)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            if(Alignment == ALIGNMENT_GOOD){
                per = Random(7);
                switch (per){
                 case 0: sSummon = "nw_lion"; break;
                 case 1: sSummon = "nw_boardire"; break;
                 case 2: sSummon = "zep_cattiger"; break;
                 case 3: sSummon = "x0_wyrmling_red"; break;
                 case 4: sSummon = "x0_wyrmling_wht"; break;
                 case 5: sSummon = "x0_wyrmling_blk"; break;
                 case 6: sSummon = "x0_wyrmling_grn"; break;
                }
            }
            else if(Alignment == ALIGNMENT_EVIL || Alignment == ALIGNMENT_NEUTRAL){
                per = Random(12);
                switch (per){
                 case 0: sSummon = "nw_lion"; break;
                 case 1: sSummon = "nw_boardire"; break;
                 case 2: sSummon = "zep_cattiger"; break;
                 case 3: sSummon = "x0_wyrmling_red"; break;
                 case 4: sSummon = "x0_wyrmling_wht"; break;
                 case 5: sSummon = "x0_wyrmling_blk"; break;
                 case 6: sSummon = "x0_wyrmling_grn"; break;
                 case 7: sSummon = "nw_imp"; break;
                 case 8: sSummon = "nw_dmquasit"; break;
                 case 9: sSummon = "nw_mepair"; break;
                 case 10: sSummon = "nw_mepfire"; break;
                 case 11: sSummon = "nw_mepearth"; break;
                }
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_III)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
             if(Alignment == ALIGNMENT_GOOD){
                per = Random(6);
                switch (per){
                 case 0: sSummon = "nw_direwolf"; break;
                 case 1: sSummon = "nw_ettercap"; break;
                 case 2: sSummon = "nw_shmastif"; break;
                 case 3: sSummon = "x0_form_warrior"; break;
                 case 4: sSummon = "zep_manticore"; break;
                 case 5: sSummon = "zep_lupinal6"; break;
                }
            }
            else if(Alignment == ALIGNMENT_EVIL){
                per = Random(6);
                switch (per){
                 case 0: sSummon = "nw_direwolf"; break;
                 case 1: sSummon = "nw_ettercap"; break;
                 case 2: sSummon = "nw_shmastif"; break;
                 case 3: sSummon = "x0_form_warrior"; break;
                 case 4: sSummon = "zep_manticore"; break;
                 case 5: sSummon = "nw_hellhound"; break;
                }
            }
            else{
                per = Random(7);
                switch (per){
                 case 0: sSummon = "nw_direwolf"; break;
                 case 1: sSummon = "nw_ettercap"; break;
                 case 2: sSummon = "nw_shmastif"; break;
                 case 3: sSummon = "x0_form_warrior"; break;
                 case 4: sSummon = "zep_manticore"; break;
                 case 5: sSummon = "zep_lupinal6"; break;
                 case 6: sSummon = "nw_hellhound"; break;
                }
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
             if(Alignment == ALIGNMENT_GOOD){
                per = Random(6)+1;
                switch (per){
           //      case 0: sSummon = "zep_elemwaterm"; break;
                 case 1: sSummon = "zep_elemearthm"; break;
                 case 2: sSummon = "zep_elemairm"; break;
                 case 3: sSummon = "zep_elemfirem"; break;
                 case 4: sSummon = "nw_slaadred"; break;
                 case 5: sSummon = "zep_belker"; break;
                 case 6: sSummon = "nw_chound01"; break;
                }
            }
            else if(Alignment == ALIGNMENT_EVIL){
                per = Random(6)+1;
                switch (per){
                // case 0: sSummon = "zep_elemwaterm"; break;
                 case 1: sSummon = "zep_elemearthm"; break;
                 case 2: sSummon = "zep_elemairm"; break;
                 case 3: sSummon = "zep_elemfirem"; break;
                 case 4: sSummon = "nw_slaadred"; break;
                 case 5: sSummon = "zep_belker"; break;
                 case 6: sSummon = "nw_beastxvim"; break;
                }
            }
            else{
                per = Random(7)+1;
                switch (per){
               //  case 0: sSummon = "zep_elemwaterm"; break;
                 case 1: sSummon = "zep_elemearthm"; break;
                 case 2: sSummon = "zep_elemairm"; break;
                 case 3: sSummon = "zep_elemfirem"; break;
                 case 4: sSummon = "nw_slaadred"; break;
                 case 5: sSummon = "zep_belker"; break;
                 case 6: sSummon = "nw_beastxvim"; break;
                 case 7: sSummon = "nw_chound01"; break;
                }
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_V)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
             if(Alignment == ALIGNMENT_GOOD){
                per = Random(6);
                switch (per){
                 case 0: sSummon = "nw_beardire"; break;
                 case 1: sSummon = "nw_slaadgrn"; break;
                 case 2: sSummon = "nw_grayrend"; break;
                 case 3: sSummon = "nw_minogon"; break;
                 case 4: sSummon = "nw_rakshasa"; break;
                 case 5: sSummon = "nw_halfcel001"; break;
                }
            }
            else if(Alignment == ALIGNMENT_EVIL){
                per = Random(6);
                switch (per){
                 case 0: sSummon = "nw_beardire"; break;
                 case 1: sSummon = "nw_slaadgrn"; break;
                 case 2: sSummon = "nw_grayrend"; break;
                 case 3: sSummon = "nw_minogon"; break;
                 case 4: sSummon = "nw_rakshasa"; break;
                 case 5: sSummon = "nw_halffnd001"; break;
                }
            }
            else{
                per = Random(7);
                switch (per){
                 case 0: sSummon = "nw_beardire"; break;
                 case 1: sSummon = "nw_slaadgrn"; break;
                 case 2: sSummon = "nw_grayrend"; break;
                 case 3: sSummon = "nw_minogon"; break;
                 case 4: sSummon = "nw_rakshasa"; break;
                 case 5: sSummon = "nw_halffnd001"; break;
                 case 6: sSummon = "nw_halfcel001"; break;
                }
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            per = Random(5)+1;
            switch (per){
           //  case 0: sSummon = "zep_elemwaterl"; break;
             case 1: sSummon = "zep_elemearthl"; break;
             case 2: sSummon = "zep_elemairl"; break;
             case 3: sSummon = "zep_elemfirel"; break;
             case 4: sSummon = "nw_diretiger"; break;
             case 5: sSummon = "nw_slaadgray"; break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            per = Random(4)+1;
            switch (per){
          //   case 0: sSummon = "nw_waterhuge"; break;
             case 1: sSummon = "nw_airhuge"; break;
             case 2: sSummon = "nw_firehuge"; break;
             case 3: sSummon = "nw_earthhuge"; break;
             case 4: sSummon = "nw_bathorror"; break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            per = Random(4)+1;
            switch (per){
             case 1: sSummon = "nw_fireelder"; break;
             //case 1: sSummon = "nw_watelder"; break;
             case 2: sSummon = "nw_eartheld"; break;
             case 3: sSummon = "nw_airgreat"; break;
             case 4: sSummon = "nw_slaaddeth"; break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IX)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            per = Random(4)+1;
            switch (per){
             case 1: sSummon = "nw_fireelder"; break;
            // case 1: sSummon = "nw_watelder"; break;
             case 2: sSummon = "nw_eartheld"; break;
             case 3: sSummon = "nw_airgreat"; break;
             case 4: sSummon = "nw_slaaddeth"; break;
            }
        }
    }
    else  //WITOUT THE ANIMAL DOMAIN
    {
        if(nSpellID == SPELL_SUMMON_CREATURE_I)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            if(Alignment == ALIGNMENT_GOOD || Alignment == ALIGNMENT_NEUTRAL){
                per = Random(6);
                switch (per){
                 case 0: sSummon = "zep_eagle"; break;
                 case 1: sSummon = "nw_wolf"; break;
                 case 2: sSummon = "zep_dogwild"; break;
                 case 3: sSummon = "zep_stirge"; break;
                 case 4: sSummon = "x0_dragon_pseudo"; break;
                 case 5: sSummon = "zep_pixie"; break;
                }
            }
            else if(Alignment == ALIGNMENT_EVIL){
                per = Random(5);
                switch (per){
                 case 0: sSummon = "zep_eagle"; break;
                 case 1: sSummon = "nw_wolf"; break;
                 case 2: sSummon = "zep_dogwild"; break;
                 case 3: sSummon = "zep_stirge"; break;
                 case 4: sSummon = "x0_dragon_pseudo"; break;
                }
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_II)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            per = Random(7);
            switch (per){
             case 0: sSummon = "nw_bearblck"; break;
             case 1: sSummon = "nw_boar"; break;
             case 2: sSummon = "nw_direbadg"; break;
             case 3: sSummon = "zep_elemfires"; break;
             //case 4: sSummon = "zep_elemwaters"; break;
             case 4: sSummon = "zep_elemairs"; break;
             case 5: sSummon = "zep_elemearths"; break;
             case 6: sSummon = "nw_cat"; break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_III)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            if(Alignment == ALIGNMENT_GOOD){
                per = Random(7);
                switch (per){
                 case 0: sSummon = "nw_lion"; break;
                 case 1: sSummon = "nw_boardire"; break;
                 case 2: sSummon = "zep_cattiger"; break;
                 case 3: sSummon = "x0_wyrmling_red"; break;
                 case 4: sSummon = "x0_wyrmling_wht"; break;
                 case 5: sSummon = "x0_wyrmling_blk"; break;
                 case 6: sSummon = "x0_wyrmling_grn"; break;
                }
            }
            else if(Alignment == ALIGNMENT_EVIL || Alignment == ALIGNMENT_NEUTRAL){
                per = Random(12);
                switch (per){
                 case 0: sSummon = "nw_lion"; break;
                 case 1: sSummon = "nw_boardire"; break;
                 case 2: sSummon = "zep_cattiger"; break;
                 case 3: sSummon = "x0_wyrmling_red"; break;
                 case 4: sSummon = "x0_wyrmling_wht"; break;
                 case 5: sSummon = "x0_wyrmling_blk"; break;
                 case 6: sSummon = "x0_wyrmling_grn"; break;
                 case 7: sSummon = "nw_imp"; break;
                 case 8: sSummon = "nw_dmquasit"; break;
                 case 9: sSummon = "nw_mepair"; break;
                 case 10: sSummon = "nw_mepfire"; break;
                 case 11: sSummon = "nw_mepearth"; break;
                }
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
             if(Alignment == ALIGNMENT_GOOD){
                per = Random(6);
                switch (per){
                 case 0: sSummon = "nw_direwolf"; break;
                 case 1: sSummon = "nw_ettercap"; break;
                 case 2: sSummon = "nw_shmastif"; break;
                 case 3: sSummon = "x0_form_warrior"; break;
                 case 4: sSummon = "zep_manticore"; break;
                 case 5: sSummon = "zep_lupinal6"; break;
                }
            }
            else if(Alignment == ALIGNMENT_EVIL){
                per = Random(6);
                switch (per){
                 case 0: sSummon = "nw_direwolf"; break;
                 case 1: sSummon = "nw_ettercap"; break;
                 case 2: sSummon = "nw_shmastif"; break;
                 case 3: sSummon = "x0_form_warrior"; break;
                 case 4: sSummon = "zep_manticore"; break;
                 case 5: sSummon = "nw_hellhound"; break;
                }
            }
            else{
                per = Random(7);
                switch (per){
                 case 0: sSummon = "nw_direwolf"; break;
                 case 1: sSummon = "nw_ettercap"; break;
                 case 2: sSummon = "nw_shmastif"; break;
                 case 3: sSummon = "x0_form_warrior"; break;
                 case 4: sSummon = "zep_manticore"; break;
                 case 5: sSummon = "zep_lupinal6"; break;
                 case 6: sSummon = "nw_hellhound"; break;
                }
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_V)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
             if(Alignment == ALIGNMENT_GOOD){
                per = Random(6)+1;
                switch (per){
           //    case 0: sSummon = "zep_elemwaterm"; break;
                 case 1: sSummon = "zep_elemearthm"; break;
                 case 2: sSummon = "zep_elemairm"; break;
                 case 3: sSummon = "zep_elemfirem"; break;
                 case 4: sSummon = "nw_slaadred"; break;
                 case 5: sSummon = "zep_belker"; break;
                 case 6: sSummon = "nw_chound01"; break;
                }
            }
            else if(Alignment == ALIGNMENT_EVIL){
                per = Random(6)+1;
                switch (per){
//                 case 0: sSummon = "zep_elemwaterm"; break;
                 case 1: sSummon = "zep_elemearthm"; break;
                 case 2: sSummon = "zep_elemairm"; break;
                 case 3: sSummon = "zep_elemfirem"; break;
                 case 4: sSummon = "nw_slaadred"; break;
                 case 5: sSummon = "zep_belker"; break;
                 case 6: sSummon = "nw_beastxvim"; break;
                }
            }
            else{
                per = Random(7)+1;
                switch (per){
            //     case 0: sSummon = "zep_elemwaterm"; break;
                 case 1: sSummon = "zep_elemearthm"; break;
                 case 2: sSummon = "zep_elemairm"; break;
                 case 3: sSummon = "zep_elemfirem"; break;
                 case 4: sSummon = "nw_slaadred"; break;
                 case 5: sSummon = "zep_belker"; break;
                 case 6: sSummon = "nw_beastxvim"; break;
                 case 7: sSummon = "nw_chound01"; break;
                }
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
             if(Alignment == ALIGNMENT_GOOD){
                per = Random(5);
                switch (per){
                 case 0: sSummon = "nw_beardire"; break;
                 case 1: sSummon = "nw_slaadgrn"; break;
                 case 2: sSummon = "nw_grayrend"; break;
                 case 3: sSummon = "nw_minogon"; break;
                 case 4: sSummon = "nw_halfcel001"; break;
                }
            }
            else if(Alignment == ALIGNMENT_EVIL){
                per = Random(5);
                switch (per){
                 case 0: sSummon = "nw_beardire"; break;
                 case 1: sSummon = "nw_slaadgrn"; break;
                 case 2: sSummon = "nw_grayrend"; break;
                 case 3: sSummon = "nw_minogon"; break;
                 case 4: sSummon = "nw_halffnd001"; break;
                }
            }
            else{
                per = Random(6);
                switch (per){
                 case 0: sSummon = "nw_beardire"; break;
                 case 1: sSummon = "nw_slaadgrn"; break;
                 case 2: sSummon = "nw_grayrend"; break;
                 case 3: sSummon = "nw_minogon"; break;
                 case 4: sSummon = "nw_halffnd001"; break;
                 case 5: sSummon = "nw_halfcel001"; break;
                }
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            per = Random(5)+1;
            switch (per){
            // case 0: sSummon = "zep_elemwaterl"; break;
             case 1: sSummon = "zep_elemearthl"; break;
             case 2: sSummon = "zep_elemairl"; break;
             case 3: sSummon = "zep_elemfirel"; break;
             case 4: sSummon = "nw_diretiger"; break;
             case 5: sSummon = "nw_slaadgray"; break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            per = Random(4)+1;
            switch (per){
            // case 0: sSummon = "nw_waterhuge"; break;
             case 1: sSummon = "nw_airhuge"; break;
             case 2: sSummon = "nw_firehuge"; break;
             case 3: sSummon = "nw_earthhuge"; break;
             case 4: sSummon = "nw_bathorror"; break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IX)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            per = Random(4)+1;
            switch (per){
             case 1: sSummon = "nw_fireelder"; break;
            // case 1: sSummon = "nw_watelder"; break;
             case 2: sSummon = "nw_eartheld"; break;
             case 3: sSummon = "nw_airgreat"; break;
             case 4: sSummon = "nw_slaaddeth"; break;
            }
        }
    }
    //effect eVis = EffectVisualEffect(nFNF_Effect);
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
    effect eSummonedMonster = EffectSummonCreature(sSummon, nFNF_Effect);
    return eSummonedMonster;
}



string HasChoosenSpell(int SpellID, object oCaster){
    string sSumon = "";

    switch (SpellID){
     case SPELL_SUMMON_CREATURE_I :  sSumon = "MESUMMON1sRefMon"; break;
     case SPELL_SUMMON_CREATURE_II:  sSumon = "MESUMMON2sRefMon"; break;
     case SPELL_SUMMON_CREATURE_III: sSumon = "MESUMMON3sRefMon"; break;
     case SPELL_SUMMON_CREATURE_IV: sSumon = "MESUMMON4sRefMon"; break;
     case SPELL_SUMMON_CREATURE_V: sSumon = "MESUMMON5sRefMon"; break;
     case SPELL_SUMMON_CREATURE_VI: sSumon = "MESUMMON6sRefMon"; break;
     case SPELL_SUMMON_CREATURE_VII: sSumon = "MESUMMON7sRefMon"; break;
     case SPELL_SUMMON_CREATURE_VIII: sSumon = "MESUMMON8sRefMon"; break;
     case SPELL_SUMMON_CREATURE_IX: sSumon = "MESUMMON9sRefMon"; break;
    }
    sSumon = GetLocalString(GetSoulStone(oCaster), sSumon);
    return sSumon;
}

int iSpell(int SpellID){
    int sSumon = 0;

    switch (SpellID){
     case SPELL_SUMMON_CREATURE_I :  sSumon = 1; break;
     case SPELL_SUMMON_CREATURE_II:  sSumon = 2; break;
     case SPELL_SUMMON_CREATURE_III: sSumon = 3; break;
     case SPELL_SUMMON_CREATURE_IV: sSumon = 4; break;
     case SPELL_SUMMON_CREATURE_V: sSumon = 5; break;
     case SPELL_SUMMON_CREATURE_VI: sSumon = 6; break;
     case SPELL_SUMMON_CREATURE_VII: sSumon = 7; break;
     case SPELL_SUMMON_CREATURE_VIII: sSumon = 8; break;
     case SPELL_SUMMON_CREATURE_IX: sSumon = 9; break;
    }
    return sSumon;
}

void UseSummoningSkill(int nSpellID, object oCaster, string sMonster, int nDuration, location lTar)
{
    string sPrefix = "MESUMMON" + IntToString(iSpell(nSpellID));
    int iSpellLVL = iSpell(nSpellID);
    // vyuziti ingredienci
    string sIngredience = GetLocalString(oCaster, sPrefix + "sRefIng");
    if (sIngredience != "")
    {
        object oItem = GetItemPossessedBy(oCaster, sIngredience);
        if (oItem != OBJECT_INVALID)
        {
            if (GetNumStackedItems(oItem) > 1)
            {
                SetItemStackSize(oItem, GetNumStackedItems(oItem) - 1);
            }
            else
            {
                DestroyObject(oItem);
            }
        }
        else
        {
            SendMessageToPC(oCaster,"Nemas potrebnou ingredienci pro seslani kouzla.");
        }
    }

    // nastaveni uspesnosti
    int iBonusToSkill = 0;
    if(GetHasFeat(FEAT_ANIMAL_DOMAIN_POWER, oCaster)) iBonusToSkill = 300;//WITH THE ANIMAL DOMAIN

    int iSummonSkill = CnrGetPersistentInt(oCaster,"iSummonSkill");

    object oSoulStone = GetSoulStone(oCaster);
    int iPenalty = GetLocalInt(oSoulStone, sPrefix + "iPen") * 10;


    int OK = FALSE;
    if(Random(1000) < (1000 + iSummonSkill - iPenalty + iBonusToSkill)) OK = TRUE;
    //SendMessageToPC(oCaster,"skill>" + IntToString(iSummonSkill));
    //SendMessageToPC(oCaster,"penalty>" + IntToString(iPenalty));

    if(OK)
    {
        SendMessageToPC(oCaster,"Povedlo se");
        effect eSummonedMonster = EffectSummonCreature(sMonster, VFX_FNF_SUMMON_MONSTER_1);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummonedMonster, lTar, TurnsToSeconds(nDuration));
        object oMonster = GetObjectByTag(sMonster);
        if (oMonster != OBJECT_INVALID) SetName(oMonster, "Povolany");
      if (Random(1000) > iSummonSkill)
       {
        string sOldSkill = "";
        string sOldSkill2 = "";
        iSummonSkill++;
        sOldSkill2 = IntToString(iSummonSkill);
        sOldSkill = "."+GetStringRight(sOldSkill2,1);
        if (iSummonSkill > 9)
          {
           sOldSkill = GetStringLeft(sOldSkill2,GetStringLength(sOldSkill2)-1)+sOldSkill;
          }
         else
          {
           sOldSkill = "0"+sOldSkill;
          }
        string sAreaTag = GetTag(GetArea(oCaster));
        //ARENA
        int iArena = GetLocalInt(GetArea(oCaster),"ARENA");
        // sAreaTag != "ry_karakv2") && (sAreaTag != "ry_hgarena"
        if ((iSummonSkill <= 1000) && (iArena == 0) && ( iSummonSkill <= (iSpellLVL*100 + 100)) )
         {
          //DelayCommand(6.0,SetTokenPair(oPC,13,1,iBeeSkill));
          CnrSetPersistentInt(oCaster,"iSummonSkill",iSummonSkill);
          SendMessageToPC(oCaster,"=====================================");
          SendMessageToPC(oCaster,"Tvoje umeni POVOLANI se zvysilo!");
          SendMessageToPC(oCaster,"Tvoje aktualni umeni je : "+ sOldSkill+"%");
          SendMessageToPC(oCaster,"=====================================");
         }
       }
    }
 if(OK == FALSE ) {
          SendMessageToPC(oCaster,"Nepovedlo se");
          CreateNonSummonMonster(sMonster,iPenalty,iSummonSkill, lTar);
       }
}


void CreateNonSummonMonster(string sResRef,int iPenalty, int iSkill,location lTar){

    int iFaction;
    if (Random(10) < 8) {   // ve vetsine pripadu se povolani povede s nejakym monstre (nasrany / nenasrany)
        if ((iSkill - iPenalty) < 0)
        {
            iFaction =  STANDARD_FACTION_HOSTILE;
        }else{
            iFaction =  STANDARD_FACTION_COMMONER;
        }
        object oMonster = CreateObject(OBJECT_TYPE_CREATURE, sResRef, lTar );;
        SetName(oMonster, "Povolany");
        ChangeToStandardFaction(oMonster, iFaction);
        }
    }
    //STANDARD_FACTION_HOSTILE  STANDARD_FACTION_COMMONER

effect SetSummonEffectAll(int nSpellID)
{
    int nFNF_Effect;
    int per;
    int Alignment = GetAlignmentGoodEvil(OBJECT_SELF);
    string sSummon;
    //if(GetHasFeat(FEAT_ANIMAL_DOMAIN_POWER)) //WITH THE ANIMAL DOMAIN
    nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;

    {
        if(nSpellID == SPELL_SUMMON_CREATURE_I)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            if(Alignment == ALIGNMENT_GOOD){
                per = Random(2);
                switch (per){
                 case 0: sSummon = "ry_sum_1_b"; break;
                 case 1: sSummon = "ry_sum_1_c"; break;
                }
            }
            else if(Alignment == ALIGNMENT_EVIL){
                per = Random(2);
                switch (per){
                 case 0: sSummon = "ry_sum_1_d"; break;
                 case 1: sSummon = "ry_sum_1_a"; break;
                }
            }
            else if(Alignment == ALIGNMENT_NEUTRAL){
                per = Random(2);
                switch (per){
                 case 0: sSummon = "ry_sum_1_f"; break;
                 case 1: sSummon = "ry_sum_1_e"; break;
                }
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_II)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            if(Alignment == ALIGNMENT_GOOD){
                per = Random(2);
                switch (per){
                 case 0: sSummon = "ry_sum_2_e"; break;
                 case 1: sSummon = "ry_sum_2_c"; break;
                }
            }
            else if(Alignment == ALIGNMENT_EVIL){
                per = Random(2);
                switch (per){
                 case 0: sSummon = "ry_sum_2_a"; break;
                 case 1: sSummon = "ry_sum_2_b"; break;
                }
            }
            else if(Alignment == ALIGNMENT_NEUTRAL){
                per = Random(2);
                switch (per){
                 case 0: sSummon = "ry_sum_2_d"; break;
                 case 1: sSummon = "ry_sum_2_f"; break;
                }
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_III)
        {
            if(Alignment == ALIGNMENT_GOOD){
                per = Random(2);
                switch (per){
                 case 0: sSummon = "ry_sum_3_f"; break;
                 case 1: sSummon = "ry_sum_3_e"; break;
                }
            }
            else if(Alignment == ALIGNMENT_EVIL){
                per = Random(2);
                switch (per){
                 case 0: sSummon = "ry_sum_3_a"; break;
                 case 1: sSummon = "ry_sum_3_b"; break;
                }
            }
            else if(Alignment == ALIGNMENT_NEUTRAL){
                per = Random(2);
                switch (per){
                 case 0: sSummon = "ry_sum_3_c"; break;
                 case 1: sSummon = "ry_sum_3_d"; break;
                }
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            if(Alignment == ALIGNMENT_GOOD){
                per = Random(2);
                switch (per){
                 case 0: sSummon = "ry_sum_4_b"; break;
                 case 1: sSummon = "ry_sum_4_a"; break;
                }
            }
            else if(Alignment == ALIGNMENT_EVIL){
                per = Random(2);
                switch (per){
                 case 0: sSummon = "ry_sum_4_e"; break;
                 case 1: sSummon = "ry_sum_4_f"; break;
                }
            }
            else if(Alignment == ALIGNMENT_NEUTRAL){
                per = Random(2);
                switch (per){
                 case 0: sSummon = "ry_sum_4_d"; break;
                 case 1: sSummon = "ry_sum_4_c"; break;
                }
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_V)
        {
            if(Alignment == ALIGNMENT_GOOD){
                per = Random(2);
                switch (per){
                 case 0: sSummon = "ry_sum_5_f"; break;
                 case 1: sSummon = "ry_sum_5_a"; break;
                }
            }
            else if(Alignment == ALIGNMENT_EVIL){
                per = Random(2);
                switch (per){
                 case 0: sSummon = "ry_sum_5_c"; break;
                 case 1: sSummon = "ry_sum_5_b"; break;
                }
            }
            else if(Alignment == ALIGNMENT_NEUTRAL){
                per = Random(2);
                switch (per){
                 case 0: sSummon = "ry_sum_5_d"; break;
                 case 1: sSummon = "ry_sum_5_e"; break;
                }
            }        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            if(Alignment == ALIGNMENT_GOOD){
                per = Random(2);
                switch (per){
                 case 0: sSummon = "ry_sum_6_f"; break;
                 case 1: sSummon = "ry_sum_6_e"; break;
                }
            }
            else if(Alignment == ALIGNMENT_EVIL){
                per = Random(2);
                switch (per){
                 case 0: sSummon = "ry_sum_6_b"; break;
                 case 1: sSummon = "ry_sum_6_a"; break;
                }
            }
            else if(Alignment == ALIGNMENT_NEUTRAL){
                per = Random(2);
                switch (per){
                 case 0: sSummon = "ry_sum_6_d"; break;
                 case 1: sSummon = "ry_sum_6_c"; break;
                }
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            if(Alignment == ALIGNMENT_GOOD){
                per = Random(2);
                switch (per){
                 case 0: sSummon = "ry_sum_7_a"; break;
                 case 1: sSummon = "ry_sum_7_e"; break;
                }
            }
            else if(Alignment == ALIGNMENT_EVIL){
                per = Random(2);
                switch (per){
                 case 0: sSummon = "ry_sum_7_c"; break;
                 case 1: sSummon = "ry_sum_7_b"; break;
                }
            }
            else if(Alignment == ALIGNMENT_NEUTRAL){
                per = Random(2);
                switch (per){
                 case 0: sSummon = "ry_sum_7_f"; break;
                 case 1: sSummon = "ry_sum_7_d"; break;
                }
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            if(Alignment == ALIGNMENT_GOOD){
                per = Random(2);
                switch (per){
                 case 0: sSummon = "ry_sum_8_d"; break;
                 case 1: sSummon = "ry_sum_8_a"; break;
                }
            }
            else if(Alignment == ALIGNMENT_EVIL){
                per = Random(2);
                switch (per){
                 case 0: sSummon = "ry_sum_8_b"; break;
                 case 1: sSummon = "ry_sum_8_e"; break;
                }
            }
            else if(Alignment == ALIGNMENT_NEUTRAL){
                per = Random(2);
                switch (per){
                 case 0: sSummon = "ry_sum_8_c"; break;
                 case 1: sSummon = "ry_sum_8_g"; break;
                }
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IX)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            if(Alignment == ALIGNMENT_GOOD){
                per = Random(2);
                switch (per){
                 case 0: sSummon = "ry_sum_9_g"; break;
                 case 1: sSummon = "ry_sum_9_i"; break;
                }
            }
            else if(Alignment == ALIGNMENT_EVIL){
                per = Random(2);
                switch (per){
                 case 0: sSummon = "ry_sum_9_f"; break;
                 case 1: sSummon = "ry_sum_9_h"; break;
                }
            }
            else if(Alignment == ALIGNMENT_NEUTRAL){
                per = Random(2);
                switch (per){
                 case 0: sSummon = "ry_sum_9_b"; break;
                 case 1: sSummon = "ry_sum_9_a"; break;
                }
            }
        }
    }
    sSumoned = sSummon;
    //effect eVis = EffectVisualEffect(nFNF_Effect);
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
    effect eSummonedMonster = EffectSummonCreature(sSummon, nFNF_Effect);
    return eSummonedMonster;
}
