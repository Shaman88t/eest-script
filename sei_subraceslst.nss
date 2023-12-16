
//
//  NWSubracesList
//
//  Function that creates a list defining all available subraces.
//
//  (c) Shir'le E. Illios, 2002 (shirle@drowwanderer.com)
//
////////////////////////////////////////////////////////
/*
 * rev. 19.01.2008 Kucik uprava svirfneblina a duergara
 * rev. 23.01.2008 Kucik upravy podtemna, aasimara a vocasa
 * rev. 27.01.2008 Kucik oprava black goblina
 *
 */

 // **************************************************************
// ** Constants
// **********************

// Enum of the supported subraces
int SUBRACE_NONE                    =   0;  // No Subrace set yet
int SUBRACE_MONSTER                 =   1;  // For monsters, etc. without subrace
int SUBRACE_DWARF_GOLD              =   2;  // used
int SUBRACE_DWARF_SHIELD            =   3;  // used
int SUBRACE_ELF_SUN                 =   4;  // used
int SUBRACE_ELF_WILD                =   5;  // used
int SUBRACE_ELF_WOOD                =   6;  // used
int SUBRACE_HALFELF                 =   7;  // used
int SUBRACE_HUMAN                   =   8;  // used
//  ADDED BY KUCIK
                                            // defaultni "sub"rasy
int SUBRACE_GNOME                   =   9;  // used
int SUBRACE_HALFLING_CITY           =  10;  // used
int SUBRACE_HALFORC_LOWLAND         =  11;  // used

int SUBRACE_ELF_GREY                =  12;  // used
int SUBRACE_ELF_WINGED              =  13;  // used
int SUBRACE_HALFLING_WOOD           =  14;  // used
int SUBRACE_HALFLING_WILD           =  15;  // used
int SUBRACE_HALFORC_NORDIC          =  16;  // used
int SUBRACE_HUMAN_DESERT            =  17;  // used
const int SUBRACE_HUMAN_AASIMAR           =  18;  // used
const int SUBRACE_HUMAN_TIEFLING          =  19;  // used
int SUBRACE_ELF_DROW_ARISTOCRAT     =  20;  // used
int SUBRACE_ELF_DROW                =  21;  // used
int SUBRACE_GNOME_SVIRFNEBLIN       =  22;  // used
int SUBRACE_HALFLING_DEEP           =  23;  // used
int SUBRACE_DWARF_DUERGAR           =  24;  // used
int SUBRACE_HALFORC_BLACK_GOBLIN    =  25;  // used
int SUBRACE_HUMAN_NORDIC            =  26;  // used
int SUBRACE_HALFORC_HALFOGRE        =  27;  // used
int SUBRACE_HALFORC_BLACK_HALFOGRE  =  28;  // used
int SUBRACE_HALFLING_KOBOLD         =  29;  // used


// This file contains the data defining the subraces. In this way it is very
// easy to change existing subraces or add new ones. Below follows an
// explanation of the functions and fields available to set the subrace data.
//
//
// SEI_CreateSubrace( Subrace, Base race, Description )
//
//  This function creates a new subrace. The first parameter must be a unique
//  ID number to define the subrace (best would be to add to the SUBRACE_ enum
//  list). The second parameter is the base race on which the subrace is based
//  and the third parameter is a textual descriptive name for the subrace.
//
//
// SEI_AddFieldText( subrace struct, Text )
//
//  This function adds a text that the subrace will recognize. When a character
//  of the subrace's base race has this text somewhere in their "Subrace" field
//  (on their character sheet) the character will be seen as a character of this
//  subrace. Multiple texts can be added to allow for maximum compatibility.
//
//
// SEI_AddTrait( subrace struct, "<trait>" )
//
//  This function adds a subrace trait (as represented by an effect) to the
//  character. Each trait consists of a string that the script will interpret
//  and translate to the correct effect. For this a strict syntax must be
//  followed. Below is a list of all the texts it recognizes. Everything between
//  angular brackets "<>" has it's own section with tokens to put there. Thus a
//  trait can be 'constructed'.
//
//
// trait:
// - "ac_inc <amount>"                      = AC Increase by amount
// - "ac_dec <amount>"                      = AC decrease by amount
// - "attack_inc <amount>"                  = Attack increase by amount
// - "attack_dec <amount>"                  = Attack decrease by amount
// - "immune <immunity-type>"               = Immunity to immunity-type
// - "speed_inc <amount>"                   = Increase movement speed by amount in %
// - "speed_dec <amount>"                   = Decrease movement speed by amount in %
// - "ex <trait>"                           = Make trait extraordinary
// - "su <trait>"                           = Make trait supernatural
// - "m <trait>"                            = Only males characters get this trait
// - "f <trait>"                            = Only females characters get this trait
// - "ability_inc <ability> <amount>"       = Increase ability by amount
// - "ability_dec <ability> <amount>"       = Decrease ability by amount
// - "skill_inc <skill> <amount>"           = Increase skill by amount
// - "skill_dec <skill> <amount>"           = Decrease skill by amount
// - "damage_im_inc <type> <amount>"        = Increase damage imunity by amount in %
// - "damage_im_dec <type> <amount>"        = Decrease damage imunity by amount in %
// - "vs <race> <trait>"                    = Make trait against race
// - "save_inc <save> <amount> <save-type>" = Increase saving throws of save and save-type by amount
// - "save_dec <save> <amount> <save-type>" = Decrease saving throws of save and save-type by amount
// - "vsa <nLawChaos> <nGoodEvil> <trait>"  = Make trait against alignment
// - "dmg_res <nDmgType> <amount> <limit>"  = Create dammge resistance effect of nDmgType by amount up to limit (0 = no limit)
//
// ability:
// - "0" = ABILITY_STRENGTH
// - "1" = ABILITY_DEXTERITY
// - "2" = ABILITY_CONSTITUTION
// - "3" = ABILITY_INTELLIGENCE
// - "4" = ABILITY_WISDOM
// - "5" = ABILITY_CHARISMA
//
// immunity-type:
// -  "0" = IMMUNITY_TYPE_NONE
// -  "1" = IMMUNITY_TYPE_MIND_SPELLS
// -  "2" = IMMUNITY_TYPE_POISON
// -  "3" = IMMUNITY_TYPE_DISEASE
// -  "4" = IMMUNITY_TYPE_FEAR
// -  "5" = IMMUNITY_TYPE_TRAP
// -  "6" = IMMUNITY_TYPE_PARALYSIS
// -  "7" = IMMUNITY_TYPE_BLINDNESS
// -  "8" = IMMUNITY_TYPE_DEAFNESS
// -  "9" = IMMUNITY_TYPE_SLOW
// - "10" = IMMUNITY_TYPE_ENTANGLE
// - "11" = IMMUNITY_TYPE_SILENCE
// - "12" = IMMUNITY_TYPE_STUN
// - "13" = IMMUNITY_TYPE_SLEEP
// - "14" = IMMUNITY_TYPE_CHARM
// - "15" = IMMUNITY_TYPE_DOMINATE
// - "16" = IMMUNITY_TYPE_CONFUSED
// - "17" = IMMUNITY_TYPE_CURSED
// - "18" = IMMUNITY_TYPE_DAZED
// - "19" = IMMUNITY_TYPE_ABILITY_DECREASE
// - "20" = IMMUNITY_TYPE_ATTACK_DECREASE
// - "21" = IMMUNITY_TYPE_DAMAGE_DECREASE
// - "22" = IMMUNITY_TYPE_DAMAGE_IMMUNITY_DECREASE
// - "23" = IMMUNITY_TYPE_AC_DECREASE
// - "24" = IMMUNITY_TYPE_MOVEMENT_SPEED_DECREASE
// - "25" = IMMUNITY_TYPE_SAVING_THROW_DECREASE
// - "26" = IMMUNITY_TYPE_SPELL_RESISTANCE_DECREASE
// - "27" = IMMUNITY_TYPE_SKILL_DECREASE
// - "28" = IMMUNITY_TYPE_KNOCKDOWN
// - "29" = IMMUNITY_TYPE_NEGATIVE_LEVEL
// - "30" = IMMUNITY_TYPE_SNEAK_ATTACK
// - "31" = IMMUNITY_TYPE_CRITICAL_HIT
// - "32" = IMMUNITY_TYPE_DEATH
//
// race:
// -  "0" = RACIAL_TYPE_DWARF
// -  "1" = RACIAL_TYPE_ELF
// -  "2" = RACIAL_TYPE_GNOME
// -  "3" = RACIAL_TYPE_HALFLING
// -  "4" = RACIAL_TYPE_HALFELF
// -  "5" = RACIAL_TYPE_HALFORC
// -  "6" = RACIAL_TYPE_HUMAN
// -  "7" = RACIAL_TYPE_ABERRATION
// -  "8" = RACIAL_TYPE_ANIMAL
// -  "9" = RACIAL_TYPE_BEAST
// - "10" = RACIAL_TYPE_CONSTRUCT
// - "11" = RACIAL_TYPE_DRAGON
// - "12" = RACIAL_TYPE_HUMANOID_GOBLINOID
// - "13" = RACIAL_TYPE_HUMANOID_MONSTROUS
// - "14" = RACIAL_TYPE_HUMANOID_ORC
// - "15" = RACIAL_TYPE_HUMANOID_REPTILIAN
// - "16" = RACIAL_TYPE_ELEMENTAL
// - "17" = RACIAL_TYPE_FEY
// - "18" = RACIAL_TYPE_GIANT
// - "19" = RACIAL_TYPE_MAGICAL_BEAST
// - "20" = RACIAL_TYPE_OUTSIDER
// - "23" = RACIAL_TYPE_SHAPECHANGER
// - "24" = RACIAL_TYPE_UNDEAD
// - "25" = RACIAL_TYPE_VERMIN
// - "28" = RACIAL_TYPE_ALL
// - "29" = RACIAL_TYPE_INVALID
//
// save:
// - "0" = SAVING_THROW_ALL
// - "1" = SAVING_THROW_FORT
// - "2" = SAVING_THROW_REFLEX
// - "3" = SAVING_THROW_WILL
//
// save-type:
// -  "0" = SAVING_THROW_TYPE_ALL
// -  "1" = SAVING_THROW_TYPE_MIND_SPELLS
// -  "2" = SAVING_THROW_TYPE_POISON
// -  "3" = SAVING_THROW_TYPE_DISEASE
// -  "4" = SAVING_THROW_TYPE_FEAR
// -  "5" = SAVING_THROW_TYPE_SONIC
// -  "6" = SAVING_THROW_TYPE_ACID
// -  "7" = SAVING_THROW_TYPE_FIRE
// -  "8" = SAVING_THROW_TYPE_ELECTRICITY
// -  "9" = SAVING_THROW_TYPE_POSITIVE
// - "10" = SAVING_THROW_TYPE_NEGATIVE
// - "11" = SAVING_THROW_TYPE_DEATH
// - "12" = SAVING_THROW_TYPE_COLD
// - "13" = SAVING_THROW_TYPE_DIVINE
// - "14" = SAVING_THROW_TYPE_TRAP
// - "15" = SAVING_THROW_TYPE_SPELL
// - "16" = SAVING_THROW_TYPE_GOOD
// - "17" = SAVING_THROW_TYPE_EVIL
// - "18" = SAVING_THROW_TYPE_LAW
// - "19" = SAVING_THROW_TYPE_CHAOS
//
// skill:
// -   "0" = SKILL_ANIMAL_EMPATHY
// -   "1" = SKILL_CONCENTRATION
// -   "2" = SKILL_DISABLE_TRAP
// -   "3" = SKILL_DISCIPLINE
// -   "4" = SKILL_HEAL
// -   "5" = SKILL_HIDE
// -   "6" = SKILL_LISTEN
// -   "7" = SKILL_LORE
// -   "8" = SKILL_MOVE_SILENTLY
// -   "9" = SKILL_OPEN_LOCK
// -  "10" = SKILL_PARRY
// -  "11" = SKILL_PERFORM
// -  "12" = SKILL_PERSUADE
// -  "13" = SKILL_PICK_POCKET
// -  "14" = SKILL_SEARCH
// -  "15" = SKILL_SET_TRAP
// -  "16" = SKILL_SPELLCRAFT
// -  "17" = SKILL_SPOT
// -  "18" = SKILL_TAUNT
// -  "19" = SKILL_USE_MAGIC_DEVICE
// - "255" = SKILL_ALL_SKILLS
//
//
// stSubrace.m_nLightSensitivity = <sensitivity level>;
//
//  This field sets the subrace's light sensitivity. Characters sensitive to
//  bright light get a penalty based on the light sensitivity. Note that while
//  light blindness isn't included in the light sensitivity, a subrace must have
//  a light sensitivity of at least 1 to have light blindness.
//
// sensitivity level:
//  0 = Not sensitive to bright light.
//  1 = Exposure to bright light give a -1 penalty.
//  2 = Exposure to bright light give a -2 penalty.
//  3 = Blindness if on daylight - by kucik
//
//
// stSubrace.m_nStonecunning = <TRUE/FALSE>;
//
//  This field describes if the subrace gives stonecunning. Characters with
//  stonecunning will have a higher search and hide skill while underground.
//
//
// stSubrace.m_nSpellLikeAbility = <spell-like ability>;
//
//  This field describes which spell-like ability the subrace gives. Currently
//  there are three spell-like abilities supported (based on spells available
//  in NWN): Blindness/deafness, darkness and invisibility. A subrace can only
//  have one spell-like ability.
//
// spell-like ability:
//  0 = No spell-like ability.
//  1 = Blindness/deafness
//  2 = Darkness
//  3 = Invisibility
//  4 = Cure light wounds once a day
//  5 = Inflict light wounds once a day
//
//
// stSubrace.m_bSpellResistance = <TRUE/FALSE>;
//
//  This field describes if the subrace grants spell resistance. If granted the
//  spell resistance will be 11 + character level.
//
//
// stSubrace.m_nFavoredClassF = <favored class>;
// stSubrace.m_nFavoredClassM = <favored class>;
//
//  These fields set the favored class for the subrace (for females and males
//  respectively). If no favored class is specified then the base race's favored
//  class will be used. Use "CLASS_TYPE_INVALID" to have a character's highest
//  class be their favored class.
//
// favored class:
//  CLASS_TYPE_BARBARIAN
//  CLASS_TYPE_BARD
//  CLASS_TYPE_CLERIC
//  CLASS_TYPE_DRUID
//  CLASS_TYPE_FIGHTER
//  CLASS_TYPE_MONK
//  CLASS_TYPE_PALADIN
//  CLASS_TYPE_RANGER
//  CLASS_TYPE_ROGUE
//  CLASS_TYPE_SORCERER
//  CLASS_TYPE_WIZARD
//  CLASS_TYPE_INVALID
//
//
// stSubrace.m_nECLAdd = <amount to add for ECL>;
//
//  These fields set how much must be added to the subrace's level to get to
//  the effective character level. This is used to define the powerful races.
//
//
// stSubrace.m_bIsDefault = <TRUE/FALSE>;
//
//  This field sets if the subrace is the default race for the base race. Only
//  use it if you know what you're doing.
//
//
//  ADDED BY KUCIK
//
// m_nECLClass
//
//  ECL Class - urcuje postih na expy pridelovane za cas
//
//
// m_nSpellResistanceConst
//
//  Konstantni (s levelem se nemenici) cast spell resistance
//
//
// m_nSpellResistancePerLevel
//
//  Pocet levelu, za ktery stoupne spell resistance o 1 bod
//
//
// m_bIsUnderdark
//
//  Nastavuje se, pokud subrasa patri do podtemna
//
//
// m_nAlignmentMask
//
//  Maska presvedceni
//                LAWFUL
//      ||=======================||
//  E   ||   400 |   40  |   4   ||  G
//  V   ||-----------------------||  O
//  I   ||   200 |   20  |   2   ||  O
//  L   ||-----------------------||  D
//      ||   100 |   10  |   1   ||
//      ||=======================||
//                CHAOTIC
//
//  END KUCIK
//
// SEI_SaveSubrace( subrace struct )
//
//  Once the subrace is completely defined this function saves the data so
//  that characters can become this subrace when they enter.


// **************************************************************
// ** Forward declarations
// **********************

// Private function for the subraces script. Do not use.
struct Subrace SEI_CreateSubrace( int a_nSubrace, int a_nBaseRace, string a_sDescription );

// Private function for the subraces script. Do not use.
struct Subrace SEI_AddFieldText( struct Subrace a_stSubrace, string a_sText );

// Private function for the subraces script. Do not use.
struct Subrace SEI_AddTrait( struct Subrace a_stSubrace, string a_sTrait );

// Private function for the subraces script. Do not use.
void SEI_SaveSubrace( struct Subrace a_stSubrace );


// Define all available subraces.
//
void SEI_DefineSubraces()
{

    struct Subrace stSubrace;


    ////////////////////////////////////////////////////////////////////////////
    // Default subraces
    ////////////////////////////////////////////////////////////////////////////

    // SEI_NOTE: The favored classes for the default subraces need to be the
    //           same as the favored classes for the base races in NWN.
    //           Only change the default subraces if you know what you're doing.

    // Define the "Shield dwarf" subrace (dwarf default).
    stSubrace = SEI_CreateSubrace( SUBRACE_DWARF_SHIELD, RACIAL_TYPE_DWARF, "Stitovy Trpaslik" );
    stSubrace = SEI_AddFieldText( stSubrace, "shield" );    // "shield dwarf"
    stSubrace = SEI_AddFieldText( stSubrace, "stitovy" );    // "shield dwarf"
    // The favored class for dwarves is fighter.
    stSubrace.m_nFavoredClassF = CLASS_TYPE_FIGHTER;
    stSubrace.m_nFavoredClassM = CLASS_TYPE_FIGHTER;
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 3 3" );             // +3 to Disciple
    stSubrace.m_bIsDefault = TRUE;
    SEI_SaveSubrace( stSubrace );

    // Define the "Wood elf" subrace (elf default).
    stSubrace = SEI_CreateSubrace( SUBRACE_ELF_WOOD, RACIAL_TYPE_ELF, "Lesni Elf" );
    stSubrace = SEI_AddFieldText( stSubrace, "wood" );                  // "wood elf"
    stSubrace = SEI_AddFieldText( stSubrace, "lesni" );                 // "lesni"
    stSubrace = SEI_AddFieldText( stSubrace, "lesny" );                 // "lesny"
    // The favored class for elves is ranger from now.
    stSubrace.m_nFavoredClassF = CLASS_TYPE_RANGER;
    stSubrace.m_nFavoredClassM = CLASS_TYPE_RANGER;
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 10 3" );             // +3 to Parry
    stSubrace.m_bIsDefault = TRUE;
    SEI_SaveSubrace( stSubrace );

    // Define the "Gnome" subrace (gnome default).
    stSubrace = SEI_CreateSubrace( SUBRACE_GNOME, RACIAL_TYPE_GNOME, "Gnome" );
//    stSubrace = SEI_AddFieldText( stSubrace, "rock" );
    // The favored class for gnomes is illusionist (wizard in NWN).
    stSubrace.m_nFavoredClassF = CLASS_TYPE_WIZARD;
    stSubrace.m_nFavoredClassM = CLASS_TYPE_WIZARD;
    stSubrace.m_bIsDefault = TRUE;
    SEI_SaveSubrace( stSubrace );

    // Define the "Half-elf" subrace (half-elf default).
    stSubrace = SEI_CreateSubrace( SUBRACE_HALFELF, RACIAL_TYPE_HALFELF, "Pul-Elf" );
    // The favored class for half-elves is any.
    stSubrace.m_nFavoredClassF = CLASS_TYPE_INVALID;
    stSubrace.m_nFavoredClassM = CLASS_TYPE_INVALID;
    stSubrace.m_bIsDefault = TRUE;
    SEI_SaveSubrace( stSubrace );

    // Define the "Lowland Half-orc" subrace (half-orc).
    stSubrace = SEI_CreateSubrace( SUBRACE_HALFORC_LOWLAND, RACIAL_TYPE_HALFORC, "Nizinny Pul-Ork" );
    stSubrace = SEI_AddFieldText( stSubrace, "lowland" );               //"lowland"
    stSubrace = SEI_AddFieldText( stSubrace, "nizinny" );               //"nizinny"
    // The favored class for half-orcs is barbarian.
    stSubrace.m_nFavoredClassF = CLASS_TYPE_BARBARIAN;
    stSubrace.m_nFavoredClassM = CLASS_TYPE_BARBARIAN;
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 3 2" );             // +2 to Disciple
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc " + IntToString(SKILL_INTIMIDATE) + " 6" ); // +6 to Intimidate
    stSubrace.m_bIsDefault = TRUE;
    SEI_SaveSubrace( stSubrace );

    // Define the "City Halfling" subrace (halfling default).
    stSubrace = SEI_CreateSubrace( SUBRACE_HALFLING_CITY, RACIAL_TYPE_HALFLING, "Mestsky Pulcik" );
    stSubrace = SEI_AddFieldText( stSubrace, "city" );                  //"city"
    stSubrace = SEI_AddFieldText( stSubrace, "mestsky" );                  //"mestsky"
    // The favored class for halflings is rogue.
    stSubrace.m_nFavoredClassF = CLASS_TYPE_ROGUE;
    stSubrace.m_nFavoredClassM = CLASS_TYPE_ROGUE;
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 5 2" );             // +2 to Hide
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 13 2" );            // +2 to Pick-Pocket
    stSubrace.m_bIsDefault = TRUE;
    SEI_SaveSubrace( stSubrace );

    // Define the "Human" subrace (human default).
    stSubrace = SEI_CreateSubrace( SUBRACE_HUMAN, RACIAL_TYPE_HUMAN, "Clovek" );
    // The favored class for elves is any.
    stSubrace.m_nFavoredClassF = CLASS_TYPE_INVALID;
    stSubrace.m_nFavoredClassM = CLASS_TYPE_INVALID;
    stSubrace.m_bIsDefault = TRUE;
    SEI_SaveSubrace( stSubrace );


    ////////////////////////////////////////////////////////////////////////////
    // Additional subraces
    ////////////////////////////////////////////////////////////////////////////


// ELF-LIKE RACES

    // Define the "Grey Elf" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_ELF_GREY, RACIAL_TYPE_ELF, "Sedy Elf" );
    stSubrace = SEI_AddFieldText( stSubrace, "grey" );                  // "grey"
    stSubrace = SEI_AddFieldText( stSubrace, "sedy" );                  // "sedy elf"
    // Grey ma +2INT a -2STR navic k Elfovi
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 3 2" );           // +2 Int
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 0 2" );           // -2 Str
//    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 1 2" );           // -2 Str
    stSubrace = SEI_AddTrait( stSubrace, "save_inc 3 1 15" );           // +1 Will save against spells
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 16 3" );            // +3 to SpellCraft
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 7 3" );             // +3 to Lore
    stSubrace.m_nFavoredClassF = CLASS_TYPE_WIZARD;                     // favored class wizard
    stSubrace.m_nFavoredClassM = CLASS_TYPE_WIZARD;                     // favored class wizard
    stSubrace.m_nECLClass = 0;                                          // Postih na expy = 1
    SEI_SaveSubrace( stSubrace );

    // Define the "Sun Elf" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_ELF_SUN, RACIAL_TYPE_ELF, "Slunecni Elf" );
    stSubrace = SEI_AddFieldText( stSubrace, "sun" );                   // "sun elf"
    stSubrace = SEI_AddFieldText( stSubrace, "slunecni" );              // "slunecni elf"
    stSubrace = SEI_AddFieldText( stSubrace, "slnecny" );               // "slnecny elf"
    stSubrace = SEI_AddFieldText( stSubrace, "slunecny" );              // "slunecny elf"
    // Sun ma +2CHAR, -2STR a -2DEX navic k Elfovi
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 5 2" );           // +2 Char
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 0 2" );           // -2 Str
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 1 2" );           // -2 Dex
//    stSubrace = SEI_AddTrait( stSubrace, "damage_im_inc " + IntToString(DAMAGE_TYPE_FIRE) + " 5" ); // +5% damage immunity against fire
    stSubrace = SEI_AddTrait( stSubrace, "damage_im_dec " + IntToString(DAMAGE_TYPE_COLD) + " 5" ); // -5% damage immunity against fire
    stSubrace = SEI_AddTrait( stSubrace, "save_inc 0 2 7" );            // +2 All save against fire
    stSubrace = SEI_AddTrait( stSubrace, "save_dec 0 2 12" );           // -2 All save against cold
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 16 3" );            // +3 to SpellCraft
    stSubrace.m_nFavoredClassF = CLASS_TYPE_SORCERER;                   // favored class sorcerer
    stSubrace.m_nFavoredClassM = CLASS_TYPE_SORCERER;                   // favored class sorcerer
    SEI_SaveSubrace( stSubrace );

    // Define the "Wild Elf" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_ELF_WILD, RACIAL_TYPE_ELF, "Divoky Elf" );
    stSubrace = SEI_AddFieldText( stSubrace, "wild" );                  // "wild elf"
    stSubrace = SEI_AddFieldText( stSubrace, "divoky" );                // "divoky elf"
    // Wild ma -2INT, +2STR a -2WIS navic k Elfovi
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 0 2" );           // +2 Str
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 3 2" );           // -2 Int
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 4 2" );           // -2 wis
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc " + IntToString(SKILL_INTIMIDATE) + " 2" ); // +2 to Intimidate
    stSubrace = SEI_AddTrait( stSubrace, "vs 8 attack_inc 1" );         // +1 Attack vs. animal
    stSubrace.m_nFavoredClassF = CLASS_TYPE_BARBARIAN;                  // favored class barbarian
    stSubrace.m_nFavoredClassM = CLASS_TYPE_BARBARIAN;                  // favored class barbarian
    SEI_SaveSubrace( stSubrace );

    // Define the "Winged Elf" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_ELF_WINGED, RACIAL_TYPE_ELF, "Okridleny Elf" );
    stSubrace = SEI_AddFieldText( stSubrace, "winged" );                // "winged elf"
    stSubrace = SEI_AddFieldText( stSubrace, "okridleny" );             // "okridleny elf"
    // Winged ma +2DEX a -2CONST navic k Elfovi
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 1 2" );           // +2 Dex
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 2 2" );           // -2 Con
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 17 2" );            // +2 to Spot
    stSubrace = SEI_AddTrait( stSubrace, "speed_inc 20" );              // +20% to Movement speed
    stSubrace.m_nAlignmentMask = 33;                                    // non lawfull and non evil
    stSubrace.m_nFavoredClassF = CLASS_TYPE_CLERIC;                     // favored class cleric
    stSubrace.m_nFavoredClassM = CLASS_TYPE_CLERIC;                     // favored class cleric
    stSubrace.m_bInterionPenalty = 2;                                   // Interior penalty 2
    stSubrace.m_nECLClass = 1;                                          // Postih na expy = 1
    stSubrace.m_nWingType = CREATURE_WING_TYPE_BIRD;                    // Ptaci kridla
    stSubrace.m_nWingLevel = 15;                                        // ^^ na 15. levelu
    SEI_SaveSubrace( stSubrace );

// ELF-LIKE RACES - UNDERDARK

    // Define the "Drow Aristocrat" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_ELF_DROW_ARISTOCRAT, RACIAL_TYPE_ELF, "Drow slechtic" );
    stSubrace = SEI_AddFieldText( stSubrace, "drow aristocrat" );       // "drow aristocrat"
    stSubrace = SEI_AddFieldText( stSubrace, "drow aristokrat" );       // "drow aristokrat"
    stSubrace = SEI_AddFieldText( stSubrace, "drow slechtic" );         // "drow slechtic"
    stSubrace = SEI_AddFieldText( stSubrace, "drow-aristocrat" );       // "drow-aristocrat"
    stSubrace = SEI_AddFieldText( stSubrace, "drow-aristokrat" );       // "drow-aristokrat"
    stSubrace = SEI_AddFieldText( stSubrace, "drow-slechtic" );         // "drow-slechtic"
    // Drow aristokrat ma +2 INT, +2CHA navic k Elfovi
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 5 2" );           // +2 Cha
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 3 2" );           // +2 Int
    stSubrace = SEI_AddTrait( stSubrace, "save_inc 3 2 15" );           // +2 Will save against spells
//    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 7 4" );             // +4 to Lore
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc " + IntToString(SKILL_BLUFF) + " 4" );         // +4 to Bluff
//    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 16 3" );            // +3 to Spellcraft
//    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 3 3" );             // +3 to Disciple
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
    stSubrace.m_nLightSensitivity = 3;                                  // Slepy na svetle
    stSubrace.m_nSpellLikeAbility = 2;                                  // Darkness
    stSubrace.m_nECLClass = 2;                                          // Postih na expy = 2
    stSubrace.m_nSpellResistanceConst = 15;                             // Konstantni slozka spell resistance 10
    stSubrace.m_nSpellResistancePerLevel = 2;                           // Spell resistance se zveda kazde 2 levely
    stSubrace.m_bIsUnderdark = 1;                                       // Subrasa podtemna
    stSubrace.m_nFavoredClassF = CLASS_TYPE_WIZARD;                     // favored class wizard
    stSubrace.m_nFavoredClassM = CLASS_TYPE_WIZARD;                     // favored class wizard
    SEI_SaveSubrace( stSubrace );


    // Define the "Drow" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_ELF_DROW, RACIAL_TYPE_ELF, "Drow" );
    stSubrace = SEI_AddFieldText( stSubrace, "drow" );                  // "drow"
    stSubrace = SEI_AddFieldText( stSubrace, "dark" );                  // "dark elf"
    // Drow ma +2INT navic k Elfovi
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 3 2" );           // +2 Int
    stSubrace = SEI_AddTrait( stSubrace, "save_inc 3 1 15" );           // +1 Will save against spells
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc " + IntToString(SKILL_BLUFF) + " 2" );         // +2 to Bluff
//    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 3 3" );             // +3 to Disciple
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
    stSubrace.m_nLightSensitivity = 3;                                  // Slepy na svetle
    stSubrace.m_nECLClass = 1;                                          // Postih na expy = 1
    stSubrace.m_nSpellResistanceConst = 10;                              // Konstantni slozka spell resistance 5
    stSubrace.m_nSpellResistancePerLevel = 2;                           // Spell resistance se zveda kazde 3 levely
    stSubrace.m_bIsUnderdark = 1;                                       // Subrasa podtemna
    stSubrace.m_nFavoredClassF = CLASS_TYPE_ROGUE;                      // favored class rogue
    stSubrace.m_nFavoredClassM = CLASS_TYPE_ROGUE;                      // favored class rogue
    SEI_SaveSubrace( stSubrace );



// GNOME-LIKE SUBRACES - UNDERDARK

    // Define the "svirfneblin" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_GNOME_SVIRFNEBLIN, RACIAL_TYPE_GNOME, "Svirfneblin" );
    stSubrace = SEI_AddFieldText( stSubrace, "svirfneblin" );           // "svirfneblin"
    // Svirfneblin ma -2CHA, +2INT navic ke Gnomovi
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 5 2" );           // -2 Cha
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 3 2" );           // +2 Int
    stSubrace = SEI_AddTrait( stSubrace, "save_inc 0 2 15" );           // +2 All saves against spells
    stSubrace = SEI_AddTrait( stSubrace, "vs 10 ac_inc 1" );            // +1 AC vs constructs
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 16 3" );            // +3 to Spellcraft
//    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 7 4" );             // +4 to Lore
//    stSubrace = SEI_AddTrait( stSubrace, "skill_inc " + IntToString(SKILL_BLUFF) + " 4" );         // +4 to Bluff
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
    stSubrace.m_nLightSensitivity = 3;                                  // Slepy na svetle
    stSubrace.m_nECLClass = 1;                                          // Postih na expy = 1
    stSubrace.m_nSpellResistanceConst = 10;                             // Konstantni slozka spell resistance 8
    stSubrace.m_nSpellResistancePerLevel = 2;                           // Spell resistance se zveda kazde 3 levely
    stSubrace.m_bIsUnderdark = 1;                                       // Subrasa podtemna
    stSubrace.m_nFavoredClassF = CLASS_TYPE_WIZARD;                     // favored class wizard
    stSubrace.m_nFavoredClassM = CLASS_TYPE_WIZARD;                     // favored class wizard
    SEI_SaveSubrace( stSubrace );


// HALFLING-LIKE SUBRACES

    // Define the "Wood halfling" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_HALFLING_WOOD, RACIAL_TYPE_HALFLING, "Lesni Pulcik" );
    stSubrace = SEI_AddFieldText( stSubrace, "wood" );                  // "wood"
    stSubrace = SEI_AddFieldText( stSubrace, "lesni" );                 // "lesni"
    stSubrace = SEI_AddFieldText( stSubrace, "lesny" );                 // "lesny"
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 12 2" );            // +2 to Persuade
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc " + IntToString(SKILL_APPRAISE) + " 2" ); // +2 to Appraise
    stSubrace.m_nFavoredClassF = CLASS_TYPE_BARD;                       // favored class bard
    stSubrace.m_nFavoredClassM = CLASS_TYPE_BARD;                       // favored class bard
    SEI_SaveSubrace( stSubrace );

    // Define the "Wild halfling" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_HALFLING_WILD, RACIAL_TYPE_HALFLING, "Divoky Pulcik" );
    stSubrace = SEI_AddFieldText( stSubrace, "wild" );                  // "wild"
    stSubrace = SEI_AddFieldText( stSubrace, "divoky" );                // "divoky"
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 5 2" );           // -2 Char
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 5 4" );             // +4 to Hide
    stSubrace = SEI_AddTrait( stSubrace, "vs 8 attack_inc 1" );         // +1 attack vs. animal
    stSubrace.m_nFavoredClassF = CLASS_TYPE_RANGER;                     // favored class ranger
    stSubrace.m_nFavoredClassM = CLASS_TYPE_RANGER;                     // favored class ranger
    SEI_SaveSubrace( stSubrace );

// HALFLING-LIKE SUBRACES - UNDERDARK

    // Define the "Deep halfling" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_HALFLING_DEEP, RACIAL_TYPE_HALFLING, "Hlubinny pulcik" );
    stSubrace = SEI_AddFieldText( stSubrace, "deep" );                  // "deep"
    stSubrace = SEI_AddFieldText( stSubrace, "hlubinny" );              // "hlubinny"
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 5 2" );             // +2 to Hide
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 8 2" );             // +2 to Move Silently
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc " + IntToString(SKILL_APPRAISE) + " 2" ); // +2 to Appraise
    stSubrace = SEI_AddTrait( stSubrace, "ultravision" );               // Ultravision
    stSubrace.m_nECLClass = 0;                                          // Postih na expy = 0
    stSubrace.m_bIsUnderdark = 1;                                       // Subrasa podtemna
    stSubrace.m_nLightSensitivity = 3;
    stSubrace.m_nFavoredClassF = CLASS_TYPE_ROGUE;                      // favored class rogue
    stSubrace.m_nFavoredClassM = CLASS_TYPE_ROGUE;                      // favored class rogue
    SEI_SaveSubrace( stSubrace );

    // Define the "Kobold" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_HALFLING_KOBOLD, RACIAL_TYPE_HALFLING, "Kobold" );
    stSubrace = SEI_AddFieldText( stSubrace, "kobold" );                // "kobold"
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 5 2" );           // -2 Char
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 0 0" );           // -2 Str
    stSubrace = SEI_AddTrait( stSubrace, "feat_add 209" );              // Purity of body
    stSubrace = SEI_AddTrait( stSubrace, "feat_add 214" );              // Diamond body
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 5 2" );             // +2 to Hide
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 8 2" );             // +2 to Move Silently
    stSubrace = SEI_AddTrait( stSubrace, "gender "+IntToString(GENDER_MALE));  // Only male gender
    stSubrace = SEI_AddTrait( stSubrace, "ultravision" );               // Ultravision
    stSubrace.m_nECLClass = 1;                                          // Postih na expy = 0
    stSubrace.m_bIsUnderdark = 1;                                       // Subrasa podtemna
    stSubrace.m_nFavoredClassF = CLASS_TYPE_ROGUE;                      // favored class rogue
    stSubrace.m_nFavoredClassM = CLASS_TYPE_ROGUE;                      // favored class rogue
    stSubrace.m_nLightSensitivity = 3;
    stSubrace.m_nChangeAppearance = 984;                                // Kobold
    SEI_SaveSubrace( stSubrace );



// DWARF-LIKE SUBRACES

    // Define the "Gold Dwarf" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_DWARF_GOLD, RACIAL_TYPE_DWARF, "Zlaty Trpaslik" );
    stSubrace = SEI_AddFieldText( stSubrace, "gold" );                  // "gold"
    stSubrace = SEI_AddFieldText( stSubrace, "zlaty" );                 // "zlaty"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 5 2" );           // +2 Cha
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 1 2" );           // -2 Dex
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc " + IntToString(SKILL_APPRAISE) + " 3" ); // +3 to Appraise
    stSubrace.m_nFavoredClassF = CLASS_TYPE_CLERIC;                     // favored class cleric
    stSubrace.m_nFavoredClassM = CLASS_TYPE_CLERIC;                     // favored class cleric
    SEI_SaveSubrace( stSubrace );

// DWARF-LIKE SUBRACES - UNDERDARK

    // Define the "Duergar" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_DWARF_DUERGAR, RACIAL_TYPE_DWARF, "Duergar" );
    stSubrace = SEI_AddFieldText( stSubrace, "duergar" );               // "duergar"
    // Duergar ma -2CHA navic k Trpaslikovi
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 5 2" );           // -2 Cha
    stSubrace = SEI_AddTrait( stSubrace, "immune 6" );                  // Immunity to paralysis
    stSubrace = SEI_AddTrait( stSubrace, "save_inc 0 2 15" );           // +2 all saves against spells
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 8 2" );             // +2 to Move Silently
//    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 6 1" );             // +1 to Listen
//    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 3 3" );             // +3 to Disciple
    stSubrace = SEI_AddTrait( stSubrace, "immune 2" );                  // immunity to all poisons
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
    stSubrace.m_nLightSensitivity = 3;                                  // Slepy na svetle
    stSubrace.m_nECLClass = 1;                                          // Postih na expy = 1
    stSubrace.m_bIsUnderdark = 1;                                       // Subrasa podtemna
    stSubrace.m_nFavoredClassF = CLASS_TYPE_FIGHTER;                    // favored class fighter
    stSubrace.m_nFavoredClassM = CLASS_TYPE_FIGHTER;                    // favored class fighter
    SEI_SaveSubrace( stSubrace );


// HALF-ORC-LIKE SUBRACES

    // Define the "Half-orc northerner" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_HALFORC_NORDIC, RACIAL_TYPE_HALFORC, "Severni Pul-Ork" );
    stSubrace = SEI_AddFieldText( stSubrace, "nordic" );                // "nordic"
    stSubrace = SEI_AddFieldText( stSubrace, "seversky" );              // "seversky"
    stSubrace = SEI_AddFieldText( stSubrace, "severni" );               // "severni"
    stSubrace = SEI_AddFieldText( stSubrace, "severny" );               // "severny"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 2 2" );           // +2 Con
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 0 2" );           // -2 Str
    stSubrace = SEI_AddTrait( stSubrace, "damage_im_dec " + IntToString(DAMAGE_TYPE_FIRE) + " 5" ); // -5% damage immunity against fire
    stSubrace = SEI_AddTrait( stSubrace, "damage_im_inc " + IntToString(DAMAGE_TYPE_COLD) + " 5" ); // +5% damage immunity against fire
    stSubrace = SEI_AddTrait( stSubrace, "save_dec 0 2 7" );            // -2 All save against fire
    stSubrace = SEI_AddTrait( stSubrace, "save_inc 0 2 12" );           // +2 All save against cold
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 3 2" );             // +2 to Disciple
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc " + IntToString(SKILL_INTIMIDATE) + " 6" ); // +6 to Intimidate
    stSubrace.m_nFavoredClassF = CLASS_TYPE_BARBARIAN;                  // favored class barbarian
    stSubrace.m_nFavoredClassM = CLASS_TYPE_BARBARIAN;                  // favored class barbarian
    SEI_SaveSubrace( stSubrace );

    // Define the "Hakvarn - Halfogre" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_HALFORC_HALFOGRE, RACIAL_TYPE_HALFORC, "Hakavarn" );
    stSubrace = SEI_AddFieldText( stSubrace, "hakavarn" );                 // "hiran"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 0 4" );           // +4 Str
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 2 2" );           // +2 Con
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 1 2" );           // -2 Dex
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 4 2" );           // -2 Wis
    stSubrace = SEI_AddTrait( stSubrace, "save_inc 0 4 4" );            // +4 save fear
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc " + IntToString(SKILL_INTIMIDATE) + " 4" ); // +4 to Intimidate
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 3 4" );             // +4 to Disciple
//    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
//    stSubrace.m_nLightSensitivity = 3;                                  // Slepy na svetle
    stSubrace.m_nECLClass = 1;                                          // Postih na expy = 1
//    stSubrace.m_bIsUnderdark = 1;                                       // Subrasa podtemna
    stSubrace.m_nFavoredClassF = CLASS_TYPE_BARBARIAN;                  // favored class barbarian
    stSubrace.m_nFavoredClassM = CLASS_TYPE_BARBARIAN;                  // favored class barbarian
    stSubrace.m_nChangeAppearance = 985;                                // half-ogre
    SEI_SaveSubrace( stSubrace );

// HALF-ORC-LIKE SUBRACES - UNDERDARK

    // Define the "Black goblin" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_HALFORC_BLACK_GOBLIN, RACIAL_TYPE_HALFORC, "Cerny Skret" );
    stSubrace = SEI_AddFieldText( stSubrace, "black goblin" );          // "black goblin"
    stSubrace = SEI_AddFieldText( stSubrace, "cerny skret" );           // "cerny skret"
    // Black goblin ma -2CHA +2 CON navic k Orkovi
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 2 2" );           // +2 Con
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 5 2" );           // -2 Cha
    stSubrace = SEI_AddTrait( stSubrace, "save_inc 0 4 2" );            // +4 save poisons
    stSubrace = SEI_AddTrait( stSubrace, "save_inc 0 4 4" );            // +4 save fear
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc " + IntToString(SKILL_INTIMIDATE) + " 4" ); // +4 to Intimidate
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 3 4" );             // +4 to Disciple
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
    stSubrace.m_nLightSensitivity = 3;                                  // Slepy na svetle
    stSubrace.m_nECLClass = 1;                                          // Postih na expy = 1
    stSubrace.m_bIsUnderdark = 1;                                       // Subrasa podtemna
    stSubrace.m_nFavoredClassF = CLASS_TYPE_BARBARIAN;                  // favored class barbarian
    stSubrace.m_nFavoredClassM = CLASS_TYPE_BARBARIAN;                  // favored class barbarian
    SEI_SaveSubrace( stSubrace );


    // Define the "Hiran - black Halfogre" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_HALFORC_BLACK_HALFOGRE, RACIAL_TYPE_HALFORC, "Hiran" );
    stSubrace = SEI_AddFieldText( stSubrace, "hiran" );                 // "hiran"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 0 4" );           // +4 Str
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 2 2" );           // +2 Con
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 1 2" );           // -2 Dex
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 4 2" );           // -2 Wis
    stSubrace = SEI_AddTrait( stSubrace, "save_inc 0 4 4" );            // +4 save fear
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc " + IntToString(SKILL_INTIMIDATE) + " 4" ); // +4 to Intimidate
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 3 4" );             // +4 to Disciple
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
    stSubrace.m_nLightSensitivity = 3;                                  // Slepy na svetle
    stSubrace.m_nECLClass = 1;                                          // Postih na expy = 1
    stSubrace.m_bIsUnderdark = 1;                                       // Subrasa podtemna
    stSubrace.m_nFavoredClassF = CLASS_TYPE_BARBARIAN;                  // favored class barbarian
    stSubrace.m_nFavoredClassM = CLASS_TYPE_BARBARIAN;                  // favored class barbarian
    stSubrace.m_nChangeAppearance = 985;                                // favored class barbarian
    SEI_SaveSubrace( stSubrace );


// HUMAN-LIKE RACES

    // Define the "Desert Human" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_HUMAN_DESERT, RACIAL_TYPE_HUMAN, "Poustni Clovek" );
    stSubrace = SEI_AddFieldText( stSubrace, "desert" );                // "desert"
    stSubrace = SEI_AddFieldText( stSubrace, "poustni" );               // "poustni"
    stSubrace = SEI_AddFieldText( stSubrace, "pustny" );                // "pustny"
    stSubrace = SEI_AddTrait( stSubrace, "damage_im_inc " + IntToString(DAMAGE_TYPE_FIRE) + " 5" ); // +5% damage immunity against fire
    stSubrace = SEI_AddTrait( stSubrace, "damage_im_dec " + IntToString(DAMAGE_TYPE_COLD) + " 5" ); // -5% damage immunity against fire
    stSubrace = SEI_AddTrait( stSubrace, "save_inc 0 2 7" );            // +2 All save against fire
    stSubrace = SEI_AddTrait( stSubrace, "save_dec 0 2 12" );           // -2 All save against cold
    SEI_SaveSubrace( stSubrace );

    // Define the "Nordic Human" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_HUMAN_NORDIC, RACIAL_TYPE_HUMAN, "Severan" );
    stSubrace = SEI_AddFieldText( stSubrace, "nordic" );                // "nordic"
    stSubrace = SEI_AddFieldText( stSubrace, "severan" );               // "severan"
    stSubrace = SEI_AddTrait( stSubrace, "damage_im_dec " + IntToString(DAMAGE_TYPE_FIRE) + " 5" ); // -5% damage immunity against fire
    stSubrace = SEI_AddTrait( stSubrace, "damage_im_inc " + IntToString(DAMAGE_TYPE_COLD) + " 5" ); // +5% damage immunity against fire
    stSubrace = SEI_AddTrait( stSubrace, "save_dec 0 2 7" );            // -2 All save against fire
    stSubrace = SEI_AddTrait( stSubrace, "save_inc 0 2 12" );           // +2 All save against cold
    stSubrace.m_nFavoredClassF = CLASS_TYPE_BARBARIAN;                  // favored class barbarian
    stSubrace.m_nFavoredClassM = CLASS_TYPE_BARBARIAN;                  // favored class barbarian
    SEI_SaveSubrace( stSubrace );

    // Define the "Aasimar" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_HUMAN_AASIMAR, RACIAL_TYPE_HUMAN, "Aasimar" );
    stSubrace = SEI_AddFieldText( stSubrace, "aasimar" );               // "aasimar"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 5 2" );           // +2 Cha
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 4 2" );           // +2 Wis
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 12 2" );            // +2 to Persuade
//    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 4 2" );             // +2 to Heal
//    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 16 2" );            // +2 to Spellcraft
//    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 1 2" );             // +2 to Concentration
    stSubrace = SEI_AddTrait( stSubrace, "vsa " + IntToString(ALIGNMENT_ALL) + " " + IntToString(ALIGNMENT_EVIL) + " attack_inc 1" ); // +1 attack vs. All Evil
    stSubrace = SEI_AddTrait( stSubrace, "dmg_res " + IntToString(DAMAGE_TYPE_ELECTRICAL) + " 5 0" ); // 5 damage resistance to electrical
    stSubrace.m_nSpellLikeAbility = 4;                                  // Cure Light wounds once a day
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
    stSubrace.m_nECLClass = 2;                                          // Postih na expy = 2
    stSubrace.m_nFavoredClassF = CLASS_TYPE_CLERIC;                     // favored class cleric
    stSubrace.m_nFavoredClassM = CLASS_TYPE_CLERIC;                     // favored class cleric
    stSubrace.m_nAlignmentMask = 7;                                     // good
    stSubrace.m_nWingType = CREATURE_WING_TYPE_ANGEL;                   // Andelska kridla
    stSubrace.m_nWingLevel = 15;                                        // ^^ na 15. levelu
    SEI_SaveSubrace( stSubrace );

    // Define the "Tiefling" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_HUMAN_TIEFLING, RACIAL_TYPE_HUMAN, "Tiefling" );
    stSubrace = SEI_AddFieldText( stSubrace, "tiefling" );              // "tiefling"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 1 2" );           // +2 Dex
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 3 2" );           // +2 Int
//    stSubrace = SEI_AddTrait( stSubrace, "skill_inc " + IntToString(SKILL_BLUFF) + " 3" ); // +3 to Bluff
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 5 2" );             // +2 to Hide
//    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 16 2" );            // +2 to Spellcraft
//    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 1 2" );             // +2 to Concentration
    stSubrace = SEI_AddTrait( stSubrace, "vsa " + IntToString(ALIGNMENT_ALL) + " " + IntToString(ALIGNMENT_GOOD) + " attack_inc 1" ); // +1 attack vs. All Evil
    stSubrace = SEI_AddTrait( stSubrace, "dmg_res " + IntToString(DAMAGE_TYPE_FIRE) + " 5 0" ); // 5 damage resistance to fire
    stSubrace.m_nSpellLikeAbility = 5;                                  // inflict Light wounds once a day
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
    stSubrace.m_nECLClass = 2;                                          // Postih na expy = 2
    stSubrace.m_nFavoredClassF = CLASS_TYPE_ROGUE;                      // favored class rogue
    stSubrace.m_nFavoredClassM = CLASS_TYPE_ROGUE;                      // favored class rogou
    stSubrace.m_nAlignmentMask = 700;                                   // Evil
    stSubrace.m_nWingType = CREATURE_WING_TYPE_DEMON;                   // Kridla demona
    stSubrace.m_nWingLevel = 15;                                        // ^^ na 15. levelu
    stSubrace.m_nTailType = CREATURE_TAIL_TYPE_DEVIL;                   // Ocas
    stSubrace.m_nTailLevel = 1;                                         // ^^ na 1. levelu
    SEI_SaveSubrace( stSubrace );

} // End SEI_DefineSubraces

