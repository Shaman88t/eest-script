//
//  NWSubraces
//
//  Basic subrace functionality - private stuff
//
//  (c) Shir'le E. Illios, 2002 (shirle@drowwanderer.com)
//
////////////////////////////////////////////////////////

//
//  BY KUCIK
//
//  Asi do poloviny scriptu jsou me zasahy huste komentovane
//  Potom uz to moc srozumitelne neslo :/
//  Tak ted uz to neni komentovane vubec :(
//
////////////////////////////////////////////////////////
/*
 * rev. Kucik 06.01.2008 pridana funkce pro zjisteni, zda je postava z podtemna
 * rev. Kucik 05.01.2008 Pridan klic podtemna
 */

//#include "nwnx_funcs"
#include "nwnx_creature"
// melvik upava na novy zpusob nacitani soulstone 16.5.2009
#include "me_lib"

// **************************************************************
// ** Constants
// **********************

// Constant to note if we are currently debugging. Should be FALSE in release version.
int SUBRACE_DEBUG           = FALSE;

// Constant to note if we're using the subrace hide or the subrace effects.
int USE_SUBRACE_HIDE        = FALSE;

// Name of the subrace field on the characters.
string SUBRACE_FIELD        = "SUBRACE_CHARACTER";

// Base field name used to save subrace information.
string SUBRACE_STRUCT_TAG   = "SUBRACE";

// Field name for the number of stored subraces.
string SUBRACE_COUNT        = "SUBRACE_COUNT";

// Base field name for the mapping of subrace ID to index.
string SUBRACE_IDMAP        = "SUBRACE_IDMAP";

// Base field name for the mapping of subrace ID to description.
string SUBRACE_DESCMAP      = "SUBRACE_DESCMAP";

// The field name for the area settings.
string AREA_SETTING         = "AREA_SETTING";

// The Field name for the light setting on the character.
string LIGHT_SETTING        = "LIGHT_SETTING";

// The Field name for the ground setting on the character.
string GROUND_SETTING       = "GROUND_SETTING";

// The Field name for the underdark setting on the character.
string UNDERDARK_SETTING    = "UNDERDARK_SETTING";

// The Field name for setting if was a day or night
string KU_SUBR_DAYNIGHT     = "KU_SUBR_DAYNIGHT";

// The Field name for the interior setting on the character.
string INTERIOR_SETTING     = "KU_SUBR_ISINTERIOR";


// Tag placeablu, ktery se stara o permanentni nastaveni vlastnosti subras
string KU_SUBRACES_PERM_TAG     = "ku_subr_perm";

// Tag placeablu, ktery se stara o nastaveni vlastnosti subras zavisle na prostredi
string KU_SUBRACES_AREA_TAG     = "ku_subraces_area";

// Placeable, ktery se stara o permanentni nastaveni vlastnosti subras
string KU_SUBRACES_PERM_FIELD     = "KU_SUBR_PERM";

// Placeable, ktery se stara o nastaveni vlastnosti subras zavisle na prostredi
string KU_SUBRACES_AREA_FIELD     = "KU_SUBR_AREA";

// Get Soul stone if exists a create one, of doesn't
object SEI_GetSoul(object oPC);

// Set TRUE to compute level from XP.
const int SUBRACES_USE_TOTAL_XP_TO_COMPUTE_PCLEVEL = TRUE;

// **************************************************************
// ** Forward declarations
// **********************

// Private function for the subraces script. Do not use.
effect SEI_ParseTrait( object a_oCharacter, string a_sTrait );

// Private function for the subraces script. Do not use.
void SEI_DefineSubraces(); //defined in sei_subraceslst


// Private function for the subraces script. Do not use.
int SEI_NWNXParseTrait( object oPC, string a_sTrait );

// Public function to calculate and repair skillpoints
int KU_CalcAndGiveSkillPoints(object oPC);



// **************************************************************
// ** Feedback functions
// **********************

// Write an entry for subraces in the log.
//
void SEI_WriteSubraceLogEntry( string a_sLogEntry, int a_bIsDebug = FALSE )
{
    // If this is a normal log entry or if we are debugging.
    if( !a_bIsDebug || SUBRACE_DEBUG )
    {
        // Write entry to log file.
        WriteTimestampedLogEntry( "SEI Subraces: " + a_sLogEntry );
    }
}


// Send a subraces message to a PC.
//
void SEI_SendSubraceMessageToPC( object a_oPC, string a_sMessage )
{
    // First make sure we actually have a valid PC
    if( GetIsPC( a_oPC ) )
    {
        SEI_WriteSubraceLogEntry( a_sMessage, TRUE );
        SendMessageToPC( a_oPC, "[Subraces] " + a_sMessage );
    }
}

// Test if character has underdark penalty
//
int ku_GetHasUnderdarkPenalty(object oPC,int underd)
{
  if(underd)
    return 0;

  object oSoul = GetSoulStone(oPC);

  int iFaction = GetLocalInt(oSoul,"KU_SPEC_FACTIONS");

  if(iFaction > 1)
    return 0;

  return 1;

}

// Translates the subrace enum to a readable string.
//
string SEI_SubraceEnumToString( int a_nSubrace )
{

    if( a_nSubrace == SUBRACE_NONE )
    {
        return "subrace not initialized";
    }
    else if( a_nSubrace == SUBRACE_MONSTER )
    {
        return "Monster";
    }
    else
    {
        return GetLocalString( GetModule(), SUBRACE_DESCMAP + IntToString( a_nSubrace ) );
    }

} // End SEI_SubraceEnumToString


// Send a message to the character that the subrace has been initialized.
//
void SEI_SendSubraceInitMsg( object a_oCharacter, int a_nSubrace )
{

    // Send a message to the PC that the subrace was successfully initialized.
    if( GetIsPC( a_oCharacter ) )
    {

        // Get the textual description of the subrace.
        string sSubraceDesc = SEI_SubraceEnumToString( a_nSubrace );

        // Write a debug message to the log.
        SEI_WriteSubraceLogEntry(
            "Subrace field of character '" + GetName( a_oCharacter ) +
            "' (played by '" + GetPCPlayerName( a_oCharacter ) +
            "') is '" + GetSubRace( a_oCharacter ) +
            "', which has been interpreted as [" + IntToString( a_nSubrace ) +
            "] '" + sSubraceDesc + "' and set accordingly." );

        // Tell the player that the subrace was initialized.
        SEI_SendSubraceMessageToPC( a_oCharacter,
            "Tvoje rasa byla rozpoznana jako '" + sSubraceDesc +
            "' a byly ti nastaveny odpovidajici vlastnosti." );

    } // End if

} // End SEI_SendSubraceInitMsg




// **************************************************************
// ** Subrace data functions
// **********************

object SEI_GetSoul(object oPC) {
   object oSoul = GetSoulStone(oPC);
   if(!GetIsObjectValid(oSoul)) {
      oSoul = CreateItemOnObject("sy_soulstone", oPC);
   }
   return oSoul;
}

// Returns a new subrace structure and saves it to the global object.
//
struct Subrace SEI_CreateSubrace( int a_nSubrace, int a_nBaseRace, string a_sDescription )
{

    // The struct we're creating.
    struct Subrace stSubrace;

    // Global object to store the values on.
    object oModule = GetModule();

    // Number of subraces already added (highest index is nSubraceCount-1)
    int nSubraceCount = GetLocalInt( oModule, SUBRACE_COUNT );

    // Store the values in the new struct.
    stSubrace.m_nID                 = a_nSubrace;
    stSubrace.m_nBaseRace           = a_nBaseRace;
    stSubrace.m_nNumFieldValues     = 0;
    stSubrace.m_nNumTraits          = 0;
    stSubrace.m_bSpellResistance    = 0;
    stSubrace.m_nLightSensitivity   = 0;
    stSubrace.m_fLightBlindness     = 0.0;
    stSubrace.m_nStonecunning       = 0;
    stSubrace.m_nSpellLikeAbility   = 0;
    stSubrace.m_nECLAdd             = 0;
    stSubrace.m_nFavoredClassF      = -1;
    stSubrace.m_nFavoredClassM      = -1;
    stSubrace.m_bIsDefault          = FALSE;
//  ADDED BY KUCIK
    stSubrace.m_nECLClass                   = 0;
    stSubrace.m_nSpellResistanceConst       = 0;
    stSubrace.m_nSpellResistancePerLevel    = 100;
    stSubrace.m_bIsUnderdark                = 0;
    stSubrace.m_nAlignmentMask              = 777;
    stSubrace.m_bInterionPenalty            = 0;
    stSubrace.m_nWingType                   = 0;
    stSubrace.m_nTailType                   = 0;
    stSubrace.m_nWingLevel                  = 0;
    stSubrace.m_nTailLevel                  = 0;
    stSubrace.m_nChangeAppearance           = 0;
//  END KUCIK

    // Save the mapping of subrace ID to index.
    SetLocalInt( oModule, SUBRACE_IDMAP + IntToString(a_nSubrace), nSubraceCount );

    // Save the textual description of this subrace
    // SEI_NOTE: Storing strings in structs doesn't seem to work. Hence done this way.
    SetLocalString( GetModule(), SUBRACE_DESCMAP + IntToString( a_nSubrace ), a_sDescription );

    // Increase the number of added subraces.
    SetLocalInt( oModule, SUBRACE_COUNT, ++nSubraceCount );

    return stSubrace;

} // End SEI_CreateSubrace


// Adds a new field text for the subrace.
// These field texts translate to matches in the subrace field on the character
// sheet; if the field contains one of these texts the subrace will match.
//
struct Subrace SEI_AddFieldText( struct Subrace a_stSubrace, string a_sText )
{

    // Global object to store the values on.
    object oModule = GetModule();

    // The field name to store the new text under.
    string sTag = SUBRACE_STRUCT_TAG + IntToString(a_stSubrace.m_nID) +
                  "_FIELD" + IntToString(a_stSubrace.m_nNumFieldValues);

    // Store the text.
    SetLocalString( oModule, sTag, a_sText );

    // Increase the number of stored texts.
    ++(a_stSubrace.m_nNumFieldValues);

    return a_stSubrace;

} // End SEI_AddFieldText


// Adds a trait for the subrace.
// These trait strings are parsed into the effects applied to the character.
//
struct Subrace SEI_AddTrait( struct Subrace a_stSubrace, string a_sTrait )
{

    // Global object to store the values on.
    object oModule = GetModule();

    // The field name to store the new trait under.
    string sTag = SUBRACE_STRUCT_TAG + IntToString(a_stSubrace.m_nID) +
                  "_TRAIT" + IntToString(a_stSubrace.m_nNumTraits);

    // Store the text.
    SetLocalString( oModule, sTag, a_sTrait );

    // Increase the number of stored traits.
    ++(a_stSubrace.m_nNumTraits);

    return a_stSubrace;

} // End SEI_AddTrait


// Returns the mapping of the subrace to the index where the subrace is stored.
//
int SEI_SubraceIDToIdx( int a_nSubrace )
{
    return GetLocalInt( GetModule(), SUBRACE_IDMAP + IntToString(a_nSubrace) );
}


// Saves the subrace struct to the module for later retrieval to a specific index.
//
void SEI_SaveSubraceIdx( struct Subrace a_stSubrace, int a_nSubraceIdx )
{

    // Global object to store the values on.
    object oModule = GetModule();

    // The base field name to store the values under.
    string sTag = SUBRACE_STRUCT_TAG + IntToString(a_nSubraceIdx) + "_";

    // Save the values from the struct.
    SetLocalInt( oModule, sTag + "ID",   a_stSubrace.m_nID );
    SetLocalInt( oModule, sTag + "RACE", a_stSubrace.m_nBaseRace );
    SetLocalInt( oModule, sTag + "NFLD", a_stSubrace.m_nNumFieldValues );
    SetLocalInt( oModule, sTag + "NTRT", a_stSubrace.m_nNumTraits );
    SetLocalInt( oModule, sTag + "SRES", a_stSubrace.m_bSpellResistance );
    SetLocalInt( oModule, sTag + "LSEN", a_stSubrace.m_nLightSensitivity );
    SetLocalFloat( oModule, sTag + "LBLI", a_stSubrace.m_fLightBlindness );
    SetLocalInt( oModule, sTag + "STON", a_stSubrace.m_nStonecunning );
    SetLocalInt( oModule, sTag + "SLA",  a_stSubrace.m_nSpellLikeAbility );
//    SetLocalInt( oModule, sTag + "ECL",  a_stSubrace.m_nECLAdd );
    SetLocalInt( oModule, sTag + "ECL",  a_stSubrace.m_nECLClass );
    SetLocalInt( oModule, sTag + "FAVF", a_stSubrace.m_nFavoredClassF );
    SetLocalInt( oModule, sTag + "FAVM", a_stSubrace.m_nFavoredClassM );
    SetLocalInt( oModule, sTag + "DEF",  a_stSubrace.m_bIsDefault );


//  ADDED BY KUCIK
    SetLocalInt( oModule, sTag + "ECLC", a_stSubrace.m_nECLClass );
    SetLocalInt( oModule, sTag + "SRC",  a_stSubrace.m_nSpellResistanceConst );
    SetLocalInt( oModule, sTag + "SRPL", a_stSubrace.m_nSpellResistancePerLevel );
    SetLocalInt( oModule, sTag + "UND",  a_stSubrace.m_bIsUnderdark );
    SetLocalInt( oModule, sTag + "MASK",  a_stSubrace.m_nAlignmentMask );
    SetLocalInt( oModule, sTag + "INP",  a_stSubrace.m_bInterionPenalty );
    SetLocalInt( oModule, sTag + "WING",  a_stSubrace.m_nWingType );
    SetLocalInt( oModule, sTag + "TAIL",  a_stSubrace.m_nTailType );
    SetLocalInt( oModule, sTag + "WINL",  a_stSubrace.m_nWingLevel );
    SetLocalInt( oModule, sTag + "TAL",  a_stSubrace.m_nTailLevel );
    SetLocalInt( oModule, sTag + "APP",  a_stSubrace.m_nChangeAppearance );
//  END KUCIK

} // End SEI_SaveSubraceIdx


// Loads the subrace struct from the module at a specific index.
//
struct Subrace SEI_LoadSubraceIdx( int a_nSubraceIdx )
{

    // The structure that the data will be loaded into.
    struct Subrace stSubrace;

    // Global object where the values are stored.
    object oModule = GetModule();

    // The base field name the values are stored under.
    string sTag = SUBRACE_STRUCT_TAG + IntToString(a_nSubraceIdx) + "_";

    // Load the values into the struct.
    stSubrace.m_nID                 = GetLocalInt( oModule, sTag + "ID" );
    stSubrace.m_nBaseRace           = GetLocalInt( oModule, sTag + "RACE" );
    stSubrace.m_nNumFieldValues     = GetLocalInt( oModule, sTag + "NFLD" );
    stSubrace.m_nNumTraits          = GetLocalInt( oModule, sTag + "NTRT" );
    stSubrace.m_bSpellResistance    = GetLocalInt( oModule, sTag + "SRES" );
    stSubrace.m_nLightSensitivity   = GetLocalInt( oModule, sTag + "LSEN" );
    stSubrace.m_fLightBlindness     = GetLocalFloat( oModule, sTag + "LBLI" );
    stSubrace.m_nStonecunning       = GetLocalInt( oModule, sTag + "STON" );
    stSubrace.m_nSpellLikeAbility   = GetLocalInt( oModule, sTag + "SLA" );
    stSubrace.m_nECLAdd             = GetLocalInt( oModule, sTag + "ECL" );
    stSubrace.m_nFavoredClassF      = GetLocalInt( oModule, sTag + "FAVF" );
    stSubrace.m_nFavoredClassM      = GetLocalInt( oModule, sTag + "FAVM" );
    stSubrace.m_bIsDefault          = GetLocalInt( oModule, sTag + "DEF" );
//  ADDED BY KUCIK
    stSubrace.m_nECLClass           = GetLocalInt( oModule, sTag + "ECLC" );
    stSubrace.m_nSpellResistanceConst     = GetLocalInt( oModule, sTag + "SRC" );
    stSubrace.m_nSpellResistancePerLevel  = GetLocalInt( oModule, sTag + "SRPL" );
    stSubrace.m_bIsUnderdark        = GetLocalInt( oModule, sTag + "UND" );
    stSubrace.m_nAlignmentMask      = GetLocalInt( oModule, sTag + "MASK" );
    stSubrace.m_bInterionPenalty    = GetLocalInt( oModule, sTag + "INP" );
    stSubrace.m_nWingType           = GetLocalInt( oModule, sTag + "WING" );
    stSubrace.m_nTailType           = GetLocalInt( oModule, sTag + "TAIL" );
    stSubrace.m_nWingLevel          = GetLocalInt( oModule, sTag + "WINL" );
    stSubrace.m_nTailLevel          = GetLocalInt( oModule, sTag + "TAL" );
    stSubrace.m_nChangeAppearance   = GetLocalInt( oModule, sTag + "APP" );
//  END KUCIK

    return stSubrace;

} // End SEI_LoadSubraceIdx


// Saves the subrace struct to the module for later retrieval.
//
void SEI_SaveSubrace( struct Subrace a_stSubrace )
{
    // Settings for all races
//    a_stSubrace = SEI_AddTrait( a_stSubrace, "skill_dec 13 40" );             // -40 to Pickpocket

    //Save it
    SEI_SaveSubraceIdx( a_stSubrace, SEI_SubraceIDToIdx( a_stSubrace.m_nID ) );
}


// Loads the subrace struct from the module.
//
struct Subrace SEI_LoadSubrace( int a_nSubrace )
{
    return SEI_LoadSubraceIdx( SEI_SubraceIDToIdx( a_nSubrace ) );
}


// Returns the ECL modification for the character.
//
int SEI_GetECLAdd( object a_oCharacter )
{

    int nECLAdd = 0;

    // Read the local variable off the character.
    int nSubrace = GetLocalInt( a_oCharacter, SUBRACE_FIELD );

    // Make sure we actually have a subrace.
    if( nSubrace != SUBRACE_NONE )
    {

        // Load the information on the character's subrace.
        struct Subrace stSubrace = SEI_LoadSubrace( nSubrace );

        // Get the ECL modification from the subrace information.
        nECLAdd = stSubrace.m_nECLAdd;

    } // End if

    return nECLAdd;

} // End SEI_GetECLAdd


// Returns if is character from underdark.
//
int KU_GetIsFromUnderdark( object a_oCharacter )
{

    int bIsUndrd = 0;

    // Read the local variable off the character.
    int nSubrace = GetLocalInt( a_oCharacter, SUBRACE_FIELD );

    // Make sure we actually have a subrace.
    if( nSubrace != SUBRACE_NONE )
    {

        // Load the information on the character's subrace.
        struct Subrace stSubrace = SEI_LoadSubrace( nSubrace );

        // Get the ECL modification from the subrace information.
        bIsUndrd = stSubrace.m_bIsUnderdark;

    } // End if

    return bIsUndrd;

} // End

// Returns if is character from underdark.
//
int KU_GetSubraceAppearanceChange( object a_oCharacter )
{

    int bIsUndrd = 0;

    // Read the local variable off the character.
    int nSubrace = GetLocalInt( a_oCharacter, SUBRACE_FIELD );

    // Make sure we actually have a subrace.
    if( nSubrace != SUBRACE_NONE )
    {

        // Load the information on the character's subrace.
        struct Subrace stSubrace = SEI_LoadSubrace( nSubrace );

        // Get the ECL modification from the subrace information.
        bIsUndrd = stSubrace.m_nChangeAppearance;

    } // End if

    return bIsUndrd;

} // End


// **************************************************************
// ** Subrace trait parser functions
// **********************

// Parse the trait string to get the effect it describes.
// This function recognises traits with three arguments.
//
effect SEI_ParseTrait3( object a_oCharacter, string a_sTrait, string a_sArg1, string a_sArg2, string a_sArg3 )
{

    effect eResult;

    if( a_sTrait == "save_inc" )
    {
        eResult = EffectSavingThrowIncrease( StringToInt(a_sArg1), StringToInt(a_sArg2), StringToInt(a_sArg3) );
    }
    else if( a_sTrait == "save_dec" )
    {
        eResult = EffectSavingThrowDecrease( StringToInt(a_sArg1), StringToInt(a_sArg2), StringToInt(a_sArg3) );
    }
    else if( a_sTrait == "vsa" )
    {
        effect eEffect = SEI_ParseTrait( a_oCharacter, a_sArg3 );
        eResult = VersusAlignmentEffect( eEffect, StringToInt( a_sArg1 ) , StringToInt( a_sArg2 ) );
    }
    else if( a_sTrait == "dmg_res" )
    {
        eResult = EffectDamageResistance( StringToInt(a_sArg1), StringToInt(a_sArg2), StringToInt(a_sArg3) );
    }
    else
    {
        SEI_WriteSubraceLogEntry( "Unable to parse trait: '" +
            a_sTrait + " " + a_sArg1 + " " + a_sArg2 + " " + a_sArg3 + "'" );
    }

    return eResult;

} // End SEI_ParseTrait3


// Parse the trait string to get the effect it describes.
// This function recognises traits with two arguments.
//
effect SEI_ParseTrait2( object a_oCharacter, string a_sTrait, string a_sArg1, string a_sArg2 )
{

    effect eResult;

    if( a_sTrait == "ability_inc" )
    {
        eResult = EffectAbilityIncrease( StringToInt(a_sArg1), StringToInt(a_sArg2) );
        SetLocalInt(a_oCharacter,"KU_SUBRACES_ABILITY" + a_sArg1,StringToInt(a_sArg2));
    }
    else if( a_sTrait == "ability_dec" )
    {
        eResult = EffectAbilityDecrease( StringToInt(a_sArg1), StringToInt(a_sArg2) );
        SetLocalInt(a_oCharacter,"KU_SUBRACES_ABILITY_" + a_sArg1,( 0 - StringToInt(a_sArg2)));
    }
    else if( a_sTrait == "skill_inc" )
    {
        eResult = EffectSkillIncrease( StringToInt(a_sArg1), StringToInt(a_sArg2) );
    }
    else if( a_sTrait == "skill_dec" )
    {
        eResult = EffectSkillDecrease( StringToInt(a_sArg1), StringToInt(a_sArg2) );
    }
    else if( a_sTrait == "damage_im_inc" )
    {
        eResult = EffectDamageImmunityIncrease( StringToInt(a_sArg1), StringToInt(a_sArg2) );
    }
    else if( a_sTrait == "damage_im_dec" )
    {
        eResult = EffectDamageImmunityDecrease( StringToInt(a_sArg1), StringToInt(a_sArg2) );
    }
    else if( a_sTrait == "vs" )
    {
        effect eEffect = SEI_ParseTrait(a_oCharacter, a_sArg2 );
        eResult = VersusRacialTypeEffect( eEffect, StringToInt( a_sArg1 ) );
    }
    else
    {

        int nSplit = FindSubString( a_sArg2, " " );

        if( nSplit >= 0 )
        {

            string sHead = GetStringLeft( a_sArg2, nSplit );
            string sTail = GetStringRight( a_sArg2, GetStringLength(a_sArg2) - ( nSplit + 1 ) );

            eResult = SEI_ParseTrait3( a_oCharacter, a_sTrait, a_sArg1, sHead, sTail );

        }
        else
        {
            SEI_WriteSubraceLogEntry( "Unable to parse trait: '" +
                a_sTrait + " " + a_sArg1 + " " + a_sArg2 + "'" );
        }

    } // End if-elseif-else

    return eResult;

} // End SEI_ParseTrait2


// Parse the trait string to get the effect it describes.
// This function recognises traits with one argument.
//
effect SEI_ParseTrait1( object a_oCharacter, string a_sTrait, string a_sArg1 )
{

    effect eResult;

    if( a_sTrait == "ac_inc" )
    {
        eResult = EffectACIncrease( StringToInt(a_sArg1) );
    }
    else if( a_sTrait == "ac_dec" )
    {
        eResult = EffectACDecrease( StringToInt(a_sArg1) );
    }
    else if( a_sTrait == "attack_inc" )
    {
        eResult = EffectAttackIncrease( StringToInt(a_sArg1) );
    }
    else if( a_sTrait == "attack_dec" )
    {
        eResult = EffectAttackDecrease( StringToInt(a_sArg1) );
    }
    else if( a_sTrait == "immune" )
    {
        eResult = EffectImmunity( StringToInt(a_sArg1) );
    }
    else if( a_sTrait == "speed_inc" )
    {
        eResult = EffectMovementSpeedIncrease( StringToInt(a_sArg1) );
    }
    else if( a_sTrait == "speed_dec" )
    {
        eResult = EffectMovementSpeedDecrease( StringToInt(a_sArg1) );
    }
    else if( a_sTrait == "ex" )
    {
        effect eEffect = SEI_ParseTrait( a_oCharacter, a_sArg1 );
        eResult = ExtraordinaryEffect( eEffect );
    }
    else if( a_sTrait == "su" )
    {
        effect eEffect = SEI_ParseTrait( a_oCharacter, a_sArg1 );
        eResult = SupernaturalEffect( eEffect );
    }
    else if( a_sTrait == "m" )
    {
        if( GetGender( a_oCharacter ) == GENDER_MALE )
        {
            eResult = SEI_ParseTrait( a_oCharacter, a_sArg1 );
        }
    }
    else if( a_sTrait == "f" )
    {
        if( GetGender( a_oCharacter ) == GENDER_FEMALE )
        {
            eResult = SEI_ParseTrait( a_oCharacter, a_sArg1 );
        }
    }
    else
    {

        int nSplit = FindSubString( a_sArg1, " " );

        if( nSplit >= 0 )
        {

            string sHead = GetStringLeft( a_sArg1, nSplit );
            string sTail = GetStringRight( a_sArg1, GetStringLength(a_sArg1) - ( nSplit + 1 ) );

            eResult = SEI_ParseTrait2( a_oCharacter, a_sTrait, sHead, sTail );

        }
        else
        {
            SEI_WriteSubraceLogEntry( "Unable to parse trait: '" +
                a_sTrait + " " + a_sArg1 + "'" );
        }

    } // End if-elseif-else

    return eResult;

} // End SEI_ParseTrait1


// Parse the trait string to get the effect it describes.
// This function recognises traits without arguments.
//
effect SEI_ParseTrait( object a_oCharacter, string a_sTrait )
{

    effect eResult;

    if( a_sTrait == "darkvision" )
    {
        eResult = EffectVisualEffect( VFX_DUR_DARKVISION );
    }
// ADDED BY KUCIK
    else if( a_sTrait == "ultravision" )
    {
        eResult = EffectUltravision();
    }
// END KUCIK
    else
    {

        int nSplit = FindSubString( a_sTrait, " " );

        if( nSplit >= 0 )
        {

            string sHead = GetStringLeft( a_sTrait, nSplit );
            string sTail = GetStringRight( a_sTrait, GetStringLength(a_sTrait) - ( nSplit + 1 ) );

            eResult = SEI_ParseTrait1( a_oCharacter, sHead, sTail );

        }
        else
        {
            SEI_WriteSubraceLogEntry( "Unable to parse trait: '" + a_sTrait + "'" );
        }

    } // End if-else

    return eResult;

} // End SEI_ParseTrait

int KU_SUB_GiveFeat( object oPC, int iFeat ) {
  object oSoul=SEI_GetSoul(oPC);

  if(iFeat < 0) {
    iFeat = 0 - iFeat;
    if(GetLocalInt(oSoul,SUBRACE_FIELD+"_FEAT_"+IntToString(iFeat))) {
      NWNX_Creature_RemoveFeat (oPC,iFeat);
      DeleteLocalInt(oSoul,SUBRACE_FIELD+"_FEAT_"+IntToString(iFeat));
    }
  }
  else {
    if(!GetLocalInt(oSoul,SUBRACE_FIELD+"_FEAT_"+IntToString(iFeat))) {
      NWNX_Creature_AddFeatByLevel(oPC,iFeat,1);
      SetLocalInt(oSoul,SUBRACE_FIELD+"_FEAT_"+IntToString(iFeat),1);
    }
  }
  return 1;
}

// Parse the trait string to get the effect it describes.
// This function recognises traits with three arguments.
//
int SEI_NWNXParseTrait3( object oPC, string a_sTrait, string a_sArg1, string a_sArg2, string a_sArg3 )
{
  /*
    object oSoul=SEI_GetSoul(oPC);
    int iArg1 = StringToInt(a_sArg1);
    int iArg2 = StringToInt(a_sArg2);
    int iArg3 = StringToInt(a_sArg3);

    // Saves
    if( a_sTrait == "save_dec" ) {
      a_sTrait = "save_inc";
      iArg2 = 0 - iArg2;
    }
    if( a_sTrait == "save_inc" )
    {
        if(iArg3!=SAVING_THROW_TYPE_ALL)
          return 0;
        else {
          int iOld = GetLocalInt(oSoul,SUBRACE_FIELD+"_SAVE_"+a_sArg1);
          if(iOld != iArg2) {
            ModifySavingThrowBonus(oPC,iArg1,iArg2);
            SetLocalInt(oSoul,SUBRACE_FIELD+"_SAVE_"+a_sArg1,iArg2 - iOld);
          }
          return 1;
        }

    }
               */
    return 0;

} // End SEI_NWNXParseTrait3

// Parse the trait string to get the effect it describes.
// This function recognises traits with two arguments.
//
int SEI_NWNXParseTrait2( object oPC, string a_sTrait, string a_sArg1, string a_sArg2 )
{
    object oSoul=SEI_GetSoul(oPC);
    int iArg1 = StringToInt(a_sArg1);
    int iArg2 = StringToInt(a_sArg2);

    // Abillities
    if( a_sTrait == "ability_dec" ) {
      a_sTrait = "ability_inc";
      iArg2 = 0 - iArg2;
    }
    if( a_sTrait == "ability_inc" )
    {
        DeleteLocalInt(oPC,"KU_SUBRACES_ABILITY" + a_sArg1);
        int iOld = GetLocalInt(oSoul,SUBRACE_FIELD+"_ABILITY_"+a_sArg1);
        if(iOld != iArg2) {
          NWNX_Creature_ModifyRawAbilityScore(oPC,iArg1,iArg2);
          SetLocalInt(oSoul,SUBRACE_FIELD+"_ABILITY_"+a_sArg1,iArg2 - iOld);
        }
        return 1;
    }

    if( a_sTrait == "skill_dec" ) {
      a_sTrait = "skill_inc";
      iArg2 = 0 - iArg2;
    }
    // Skills
    if( a_sTrait == "skill_inc" )
    {
        int iOld = GetLocalInt(oSoul,SUBRACE_FIELD+"_SKILL_"+a_sArg1);
/*        if(iOld != iArg2) {
          if(SUBRACE_DEBUG)
            SendMessageToPC(oPC,"Skill: "+IntToString(GetSkillRank(iArg1,oPC,0))+"("+IntToString(GetSkillRank(iArg1,oPC,1))+"); modify: "+IntToString(iArg2));
          ModifySkillRank(oPC,iArg1,iArg2);
          SetLocalInt(oSoul,SUBRACE_FIELD+"_SKILL_"+a_sArg1,iArg2 - iOld);
          if(SUBRACE_DEBUG)
            SendMessageToPC(oPC,"Skill: "+IntToString(GetSkillRank(iArg1,oPC,0))+"("+IntToString(GetSkillRank(iArg1,oPC,1))+"); modify: "+IntToString(iArg2));
        }
        return 1;
*/
     // Moved back to effects
        if(iOld != 0) {
          NWNX_Creature_SetSkillRank(oPC,iArg1,-iOld);
          SetLocalInt(oSoul,SUBRACE_FIELD+"_SKILL_"+a_sArg1,0);
        }
        return 0;
    }

    else if( a_sTrait == "damage_im_inc" )
      return 0;
    else if( a_sTrait == "damage_im_dec" )
      return 0;
    else if( a_sTrait == "vs" )
      return 0;
    else
    {

        int nSplit = FindSubString( a_sArg2, " " );

        if( nSplit >= 0 )
        {

            string sHead = GetStringLeft( a_sArg2, nSplit );
            string sTail = GetStringRight( a_sArg2, GetStringLength(a_sArg2) - ( nSplit + 1 ) );

            return SEI_NWNXParseTrait3( oPC, a_sTrait, a_sArg1, sHead, sTail );

        }

    } // End if-elseif-else

    return 0;

} // End SEI_ParseTrait2


int SEI_NWNXParseTrait1( object oPC, string a_sTrait, string a_sArg1 )
{
    object oSoul=SEI_GetSoul(oPC);
    int a_iArg1 = StringToInt(a_sArg1);

    if( a_sTrait == "ac_dec" ) {
      a_sTrait = "ac_inc";
      a_sArg1 = "-"+a_sArg1;
    }
    if( a_sTrait == "ac_inc" )
    {
        int AC = StringToInt(a_sArg1);
        int MyAC = GetLocalInt(oSoul,SUBRACE_FIELD+"_AC");
        if(AC != MyAC) {
          //SetACNaturalBase(oPC,GetACNaturalBase(oPC)+ AC - MyAC);
          SetLocalInt(oSoul,SUBRACE_FIELD+"_AC",AC);
        }
        return 1;
    }
    if( a_sTrait == "feat_add" ) {
       KU_SUB_GiveFeat( oPC, StringToInt(a_sArg1));
       return 1;
    }
    if( a_sTrait == "feat_rem" ) {
       KU_SUB_GiveFeat( oPC, 0 - StringToInt(a_sArg1));
       return 1;
    }
    if( a_sTrait == "gender" ) {
       if(a_iArg1 != GetGender(oPC))
         SetGender(oPC,a_iArg1);
       return 1;
    }
    else if( a_sTrait == "m" )
    {
        if( GetGender( oPC ) == GENDER_MALE )
        {
            return SEI_NWNXParseTrait( oPC, a_sArg1 );
        }
    }
    else if( a_sTrait == "f" )
    {
        if( GetGender( oPC ) == GENDER_FEMALE )
        {
           return SEI_NWNXParseTrait( oPC, a_sArg1 );
        }
    }
    else
    {

        int nSplit = FindSubString( a_sArg1, " " );

        if( nSplit >= 0 )
        {

            string sHead = GetStringLeft( a_sArg1, nSplit );
            string sTail = GetStringRight( a_sArg1, GetStringLength(a_sArg1) - ( nSplit + 1 ) );

            return SEI_NWNXParseTrait2( oPC, a_sTrait, sHead, sTail );

        }

    } // End if-elseif-else

    return 0;

} // End SEI_ParseTrait1


// Parse the trait string and apply it using NWNeXalt.
// This function recognises traits without arguments.
//
int SEI_NWNXParseTrait( object oPC, string a_sTrait )
{

    if( a_sTrait == "darkvision" )
    {
        KU_SUB_GiveFeat( oPC, FEAT_DARKVISION );
        return 1;
    }
    else if( a_sTrait == "ultravision" )
    {
        return 0;
    }
    else
    {

        int nSplit = FindSubString( a_sTrait, " " );

        if( nSplit >= 0 )
        {

            string sHead = GetStringLeft( a_sTrait, nSplit );
            string sTail = GetStringRight( a_sTrait, GetStringLength(a_sTrait) - ( nSplit + 1 ) );

            return SEI_NWNXParseTrait1( oPC, sHead, sTail );

        }

    } // End if-else

    return 0;

} // End SEI_ParseTrait



// **************************************************************
// ** Subrace initialization functions
// **********************

// Initializes the available subraces and everything that is needed to properly
// run this script.
//
void SEI_InitSubraces()
{

    struct Subrace stSubrace;

    // First define an invalid subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_NONE, RACIAL_TYPE_INVALID, "Invalid subrace" );
    stSubrace.m_bIsDefault = TRUE;
    SEI_SaveSubrace( stSubrace );

    // Then define all the other subraces.
    SEI_DefineSubraces();

//    GetObjectByTag(KU_SUBRACES_PERM_TAG + IntToString(Random(10)));
    object oPermEffect = GetObjectByTag(KU_SUBRACES_PERM_TAG+"1");
    object oAreaEffect = GetObjectByTag(KU_SUBRACES_AREA_TAG);
    SetLocalObject(GetModule(),KU_SUBRACES_PERM_FIELD,oPermEffect);
    SetLocalObject(GetModule(),KU_SUBRACES_AREA_FIELD,oAreaEffect);

} // End SEI_InitSubraces


// Sets the subrace field on a_oCharacter to a_nSubrace.
//
void SEI_SetSubraceVar( object a_oCharacter, int a_nSubrace, int a_bPrintToLog = TRUE )
{

    if( a_oCharacter != OBJECT_INVALID )
    {

        SEI_WriteSubraceLogEntry(
            "Setting subrace variable of character '" + GetName(a_oCharacter) +
            "' (played by '" + GetPCPlayerName(a_oCharacter) +
            "') to [" + IntToString(a_nSubrace) +
            "] '" + SEI_SubraceEnumToString(a_nSubrace) + "'.", !a_bPrintToLog );

        // Store the subrace on the character for easy reference later.
        SetLocalInt( a_oCharacter, SUBRACE_FIELD, a_nSubrace );
        object oSoul = SEI_GetSoul(a_oCharacter);
        SetLocalInt( oSoul, SUBRACE_FIELD , a_nSubrace);

    } // End if

} // End SEI_SetSubraceVar


// Test to see if the subrace field (and base race) match to this subrace.
//
int SEI_TestSubraceField( struct Subrace a_stSubrace, int a_nRace, string a_sSubraceField )
{

    int nSubrace = SUBRACE_NONE;

    // If subrace's base race matches the to be tested race.
    if( a_stSubrace.m_nBaseRace == a_nRace )
    {

        // Global object whre the values are stored.
        object oModule = GetModule();

        // Basic field name of the stored field texts.
        string sTag = SUBRACE_STRUCT_TAG + IntToString(a_stSubrace.m_nID) + "_FIELD";

        // If this subrace is a default and no subrace was specified then use this subrace.
        if( a_stSubrace.m_bIsDefault && ( GetStringLength( a_sSubraceField ) == 0 ) )
        {
            nSubrace = a_stSubrace.m_nID;
        }
        else
        {

            // For each text stored (and so long as we haven't found a match).
            int nField;
            for( nField = 0 ;
                 ( nField < a_stSubrace.m_nNumFieldValues ) && ( nSubrace == SUBRACE_NONE ) ;
                 ++nField )
            {
                // Get the field text and test for a match.
                string sFieldText = GetLocalString( oModule, sTag + IntToString(nField) );
                if( FindSubString( a_sSubraceField, sFieldText ) != -1 )
                {
                    nSubrace = a_stSubrace.m_nID;
                }
            }

        } // End if-else

    } // End if

    return nSubrace;

} // End SEI_TestSubraceField


// Interpret the subrace string and return the subrace enum.
//
int SEI_ReadSubraceField( int a_nRace, string a_sSubraceField )
{

    int nSubrace = SUBRACE_NONE;

    // Get the total number of added subraces.
    int nNrSubraces = GetLocalInt( GetModule(), SUBRACE_COUNT );

    // For each subrace stored (and so long as we haven't found a match).
    int nIdx;
    for( nIdx = 0 ; ( nIdx < nNrSubraces ) && ( nSubrace == SUBRACE_NONE ) ; ++nIdx )
    {
        // Load the subrace information and check to see if there's a match.
        struct Subrace stSubrace = SEI_LoadSubraceIdx( nIdx );
        nSubrace = SEI_TestSubraceField( stSubrace, a_nRace, a_sSubraceField );
    }

    return nSubrace;

} // End SEI_ReadSubraceField


// Start the subrace dialog for character a_oCharacter.
//
void SEI_StartSubraceDialog( object a_oCharacter )
{
    if( a_oCharacter != OBJECT_INVALID )
    {
        AssignCommand( a_oCharacter, SetCommandable( TRUE, a_oCharacter ) );
        AssignCommand( a_oCharacter, ClearAllActions() );
        AssignCommand( a_oCharacter, ActionStartConversation( a_oCharacter, "sei_subraces", TRUE ) );
        AssignCommand( a_oCharacter, ActionDoCommand( SetCommandable( FALSE, a_oCharacter ) ) );
    }
}


// Check if it is possible to have this subrase and alignment
//
int KU_MakeAlignmentTest( object a_oCharacter , int nSubrace)
{
    // The structure that the data will be loaded into.
    struct Subrace stSubrace = SEI_LoadSubrace( nSubrace );

    int bGEAlignment = GetAlignmentGoodEvil( a_oCharacter );
    int bLCAlignment = GetAlignmentLawChaos( a_oCharacter );

    int nmod = 10;
    if( bGEAlignment == ALIGNMENT_EVIL )
      nmod = 100;
    if( bGEAlignment == ALIGNMENT_GOOD )
      nmod = 1;

    int nAlignment = (stSubrace.m_nAlignmentMask % ( 10 * nmod )) / nmod;

    if( bLCAlignment == ALIGNMENT_LAWFUL )
      return (nAlignment / 4);
    if( bLCAlignment == ALIGNMENT_NEUTRAL )
      return ((nAlignment % 4) / 2);
    else
      return (nAlignment % 2);


}

// Reads the character's subrace field and sets the corresponding variable
// on the character. To do this it tries to interpret the subrace field on
// the character sheet.
//
int SEI_InitSubraceVar( object a_oCharacter )
{

    // Read the local variable off the character.
    int nSubrace = GetLocalInt( a_oCharacter, SUBRACE_FIELD );

    // Only initialize the subrace variable if we haven't done so already.
    if( nSubrace == SUBRACE_NONE )
    {

        string sSubraceField = GetStringLowerCase( GetSubRace( a_oCharacter ) );


        SEI_WriteSubraceLogEntry( "Subrace field of " + GetName( a_oCharacter ) +
                                  " is '" + sSubraceField + "'", TRUE );

        nSubrace = SEI_ReadSubraceField( GetRacialType( a_oCharacter ), sSubraceField );

        SEI_WriteSubraceLogEntry( "Subrace of player " + GetName( a_oCharacter ) +
                                  " interpreted as " + IntToString( nSubrace ) +
                                  " (" + SEI_SubraceEnumToString( nSubrace ) + ")", TRUE );

        // Alignment test
        int bAlignmentTest = KU_MakeAlignmentTest( a_oCharacter , nSubrace);

        if (bAlignmentTest == 0) {
            SendMessageToPC(a_oCharacter, "Tato kombinace rasy a presvedceni neni mozna. Nastavuje se defaultni subrasa");
            nSubrace = SEI_ReadSubraceField( GetRacialType( a_oCharacter ), "" );
        }

        // See if we have recognized the subrace or not.
        if( nSubrace == SUBRACE_NONE )
        {
            if( GetIsPC( a_oCharacter ) )
            {
                // Ask the player for a subrace we understand.
                SEI_StartSubraceDialog( a_oCharacter );
            }
            else
            {
                // Assume the character is a monster.
                nSubrace = SUBRACE_MONSTER;
            }
        }

        // Store the subrace on the character for easy reference later.
        SEI_SetSubraceVar( a_oCharacter, nSubrace, FALSE );

    } // End if

    return nSubrace;

} // End SEI_InitSubraceVar


// Remove the subrace hide item of the character.
//
void SEI_RemoveSubraceHide( object a_oCharacter )
{

    // Get the item stored in the creature hide slot.
    object oHide = GetItemInSlot( INVENTORY_SLOT_CARMOUR, a_oCharacter );

    if( GetIsObjectValid( oHide ) &&
        ( GetStringLeft( GetTag( oHide ), 11 ) == "sei_subrace" ) )
    {
        DestroyObject( oHide );
    }

} // End SEI_RemoveSubraceHide


// Create the subrace hide item on the character.
//
void SEI_CreateSubraceHide( object a_oCharacter, string a_sHide )
{

    object oHide = CreateItemOnObject( a_sHide, a_oCharacter );

    if(SUBRACE_DEBUG)
      SendMessageToPC(a_oCharacter,"Making hide item");
    if( oHide != OBJECT_INVALID )
    {
        //AssignCommand( a_oCharacter, ActionEquipItem( oHide, INVENTORY_SLOT_CARMOUR ) );
        ActionEquipItem( oHide, INVENTORY_SLOT_CARMOUR );
        if(SUBRACE_DEBUG)
            SendMessageToPC(a_oCharacter,"Mas Hide Item");
    }

} // End SEI_CreateSubraceHide


// Set the subrace hide item of the character to a_sHide.
//
void SEI_GiveSubraceHide( object a_oCharacter, string a_sHide )
{

    object oHide = GetItemInSlot( INVENTORY_SLOT_CARMOUR, a_oCharacter );

    string sHideTag = GetTag( oHide );

    // If this item isn't already equiped.
    if( sHideTag != a_sHide )
    {

        // Let the character stop doing whatever it is doing.
        AssignCommand( a_oCharacter, ClearAllActions() );

        // First remove whatever hide item is already set on the character.
        AssignCommand( a_oCharacter, ActionDoCommand( SEI_RemoveSubraceHide( a_oCharacter ) ) );

        // Create the subrace hide and equip it.
        // SEI_NOTE: Assigned as an action to correctly follow the removal of the item.
        AssignCommand( a_oCharacter, ActionDoCommand( SEI_CreateSubraceHide( a_oCharacter, a_sHide ) ) );

    } // End if

} // End SEI_GiveSubraceHide




// **************************************************************
// ** Subrace area functions
// **********************

// Function to get area setting from JA_LOC_TYPE variable
int ku_CountAreaEnvSettings(object oArea)
{
// object oArea = GetArea(oPC);
 int iJaVar = GetLocalInt(oArea,"JA_LOC_TYPE");
 int iSetting = 0;

 if(iJaVar == 2) {
  iSetting = KU_AREA_UNDERDARK + AREA_DEFAULT_GROUND + AREA_DEFAULT_LIGHT;
  return iSetting;
 }
 else if(iJaVar == 1) {
  iSetting = KU_AREA_SURFACE + AREA_DEFAULT_GROUND + AREA_SUN;
  return iSetting;
 }
 else {
  iSetting = KU_AREA_SURFACE + AREA_DEFAULT_GROUND + AREA_DEFAULT_LIGHT;
  return iSetting;
 }

}

// Read a specific setting of the settings.
//
int SEI_ReadAreaSetting( int a_nSettings, int a_nUnit )
{
    int iRet;
    if( a_nUnit == 0 )
    {
        return AREA_NONE;
    }
    else
    {
//        if(SUBRACE_DEBUG)
//          SendMessageToPC(GetFirstPC(),"Reading Area Setting :" + IntToString(a_nSettings) + "; unit :" + IntToString(a_nUnit));
        // SEI_NOTE: Making use of the integer-division rounding here.
        iRet = ( ( ( a_nSettings % ( 10 * a_nUnit ) ) / a_nUnit ) * a_nUnit );
        return iRet;
    }
}


// Get an area setting.
//
int SEI_GetAreaSetting( object a_oArea, int a_nSettings, int a_nUnit )
{

    // Read the passed settings to get the specific setting.
    int nResult = SEI_ReadAreaSetting( a_nSettings, a_nUnit );

    // If we want to use the default for the area...
    if( nResult <= a_nUnit )
    {

        // Read the area settings from the area.
        int nAreaSetting = GetLocalInt( a_oArea, AREA_SETTING );

        // Get the area setting.
        nResult = SEI_ReadAreaSetting( nAreaSetting, a_nUnit );

        // If the area uses the module default...
        if( nResult <= a_nUnit )
        {

            // Get the module.
            object oModule = GetModule();

            // Read the default settings from the module.
            nAreaSetting = GetLocalInt( oModule, AREA_SETTING );

            // Get the default setting.
            nResult = SEI_ReadAreaSetting( nAreaSetting, a_nUnit );

            // We're already at the default, so if it's default again then nothing is set.
            if( nResult <= a_nUnit )
            {
                nResult = AREA_NONE;
            }

        } // End if

    } // End if

    return nResult;

} // End SEI_GetAreaSetting


// Sets the area settings for the area.
// SEI_NOTE: I'd much rather use the toolset area settings, but I can't
//           access them from script.
//
void SEI_SetAreaSettings( object a_oArea, int a_nSettings )
{

    // If we have a valid object.
    if( GetIsObjectValid( a_oArea ) )
    {

        // Get the current default settings.
        int nDefaultSettings = GetLocalInt( a_oArea, AREA_SETTING );

        // Make sure we're not going to set the same settings again.
        if( nDefaultSettings != a_nSettings )
        {

            // Get the current default light setting.
            int nDefaultLight =( nDefaultSettings % 10 );

            // Get the current default underground setting.
            int nDefaultGround = ( ( nDefaultSettings % 100 ) / 10 ) * 10;

            // Get the rest of the current default settings.
            int nDefaultRest =( nDefaultSettings / 100 ) * 100;

            // Get the light setting.
            int nSettingLight = ( a_nSettings % 10 );

            // Get the underground setting.
            int nSettingGround = ( ( a_nSettings % 100 ) / 10 ) * 10;

            // If we're trying to set the light setting, then change it.
            if( nSettingLight > 0 )
            {
                nDefaultLight = nSettingLight;
            }

            // If we're trying to set the underground setting, then change it.
            if( nSettingGround > 0 )
            {
                nDefaultGround = nSettingGround;
            }

            // Combine the new settings to get the new default setting.
            int nNewDefaultSettings = nDefaultRest + nDefaultGround + nDefaultLight;

            // Set the new settings if they have changed.
            if( nNewDefaultSettings != nDefaultSettings )
            {
                SetLocalInt( a_oArea, AREA_SETTING, nNewDefaultSettings );
            }

        } // End if

    } // End if

} // End SEI_SetAreaSettings


// Sets the default area settings for the module.
//
void SEI_SetDefaultAreaSettings( int a_nSettings )
{

    // Get the module to store the defaults on.
    object oModule = GetModule();

    // Set the default settings on the module object.
    // SEI_NOTE: This is a bit of a sneaky way of doing this, but since the
    //           SEI_SetAreaSettings functions doesn't use the fact that it is
    //           an area being passed to it, it works.
    SEI_SetAreaSettings( oModule, a_nSettings );

} // End SEI_SetDefaultAreaSettings


// Remove the effects from the character if it isn't a subrace effect.
//
void SEI_RemoveEffect( object a_oCharacter, effect a_eEffect )
{

    object oMod = GetModule();
    object oPermEffect = GetLocalObject(oMod,KU_SUBRACES_PERM_FIELD);
    object oAreaEffect = GetLocalObject(oMod,KU_SUBRACES_AREA_FIELD);
    object oCreator = GetEffectCreator( a_eEffect );
    // Only remove effects not applied by spec placeables.
//    string sEffectCreatorTag = GetStringLeft(GetTag(GetEffectCreator( a_eEffect )),12);

//    if( ( sEffectCreatorTag != KU_SUBRACES_AREA_TAG ) &&
//        ( sEffectCreatorTag != KU_SUBRACES_PERM_TAG ) )
    if( ( oCreator != oAreaEffect ) &&
        ( oCreator != oPermEffect ) )
    {
        RemoveEffect( a_oCharacter, a_eEffect );
    }

} // End SEI_RemoveEffect


// Remove the effects from the character if it isn't a subrace effect.
//
void SEI_RemoveEffects( object a_oCharacter )
{
    object oMod = GetModule();
    object oPermEffect = GetLocalObject(oMod,KU_SUBRACES_PERM_FIELD);
    object oAreaEffect = GetLocalObject(oMod,KU_SUBRACES_AREA_FIELD);

    // Go through all effects on the character.
    effect eEffect = GetFirstEffect( a_oCharacter );
    while( GetIsEffectValid( eEffect ) )
    {

        SEI_RemoveEffect(a_oCharacter, eEffect );   //Changed by KUCIK
//        RemoveEffect( a_oCharacter, eEffect );

        eEffect = GetNextEffect( a_oCharacter );

    } // End while

} // End SEI_RemoveEffects


// Remove the subrace effects from the character.
//
void SEI_RemoveSubraceEffects( object a_oCharacter, int a_bIncludePermanent = TRUE,
                               int a_iEffectType = EFFECT_TYPE_INVALIDEFFECT )
{

    object oMod = GetModule();
    object oPermEffect = GetLocalObject(oMod,KU_SUBRACES_PERM_FIELD);
    object oAreaEffect = GetLocalObject(oMod,KU_SUBRACES_AREA_FIELD);

    // Go through all effects on the character.
    effect eEffect = GetFirstEffect( a_oCharacter );
    object oCreator;
    while( GetIsEffectValid( eEffect ) )
    {

        // Only remove subrace effects.
//        if( ( GetEffectSubType( eEffect ) == SUBTYPE_SUPERNATURAL ) &&
//            ( ( a_iEffectType == EFFECT_TYPE_INVALIDEFFECT ) ||
//              ( GetEffectType( eEffect ) == a_iEffectType ) ) &&
//            ( ( a_bIncludePermanent ) ||
//              ( GetEffectCreator( eEffect ) != GetModule() ) ) )
        oCreator = GetEffectCreator( eEffect );
//        string sEffectCreatorTag = GetStringLeft(GetTag(GetEffectCreator( eEffect )),12);

        if(SUBRACE_DEBUG) {
//           SendMessageToPC(a_oCharacter,"Test Effect");
           SendMessageToPC(a_oCharacter,"Creator is " + GetTag(oCreator));
           SendMessageToPC(a_oCharacter,"Creator is " + GetName(oCreator));
           SendMessageToPC(a_oCharacter,"Creator type is " + IntToString(GetObjectType(GetEffectCreator( eEffect ))));
        }

/*        if( ( GetEffectSubType( eEffect ) == SUBTYPE_SUPERNATURAL ) &&
            ( ( a_iEffectType == EFFECT_TYPE_INVALIDEFFECT      ) ||
              ( GetEffectType( eEffect ) == a_iEffectType       ) ) &&
//            ( ( sEffectCreatorTag == KU_SUBRACES_AREA_TAG       ) ||
            ( ( GetObjectType(GetEffectCreator( eEffect )) == OBJECT_TYPE_CREATURE ) ||
              ( ( sEffectCreatorTag == KU_SUBRACES_PERM_TAG   ) &&
                ( a_bIncludePermanent                         ) ) ) )
*/      if( ( oCreator == oAreaEffect ) ||
            ( (oCreator == oPermEffect ) && (a_bIncludePermanent) ) )
        {
            if( (a_iEffectType == EFFECT_TYPE_INVALIDEFFECT) ||
                (a_iEffectType == GetEffectType(eEffect)   ) )
              RemoveEffect( a_oCharacter, eEffect );
        }

        eEffect = GetNextEffect( a_oCharacter );

    } // End while

//    if(SUBRACE_DEBUG) {
//           SendMessageToPC(a_oCharacter,"ALL is " + IntToString(OBJECT_TYPE_ALL));
//           SendMessageToPC(a_oCharacter,"AREA is " + IntToString(OBJECT_TYPE_AREA_OF_EFFECT));
//           SendMessageToPC(a_oCharacter,"INVALID is " + IntToString(OBJECT_TYPE_INVALID));
//           SendMessageToPC(a_oCharacter,"Module is " + IntToString(GetObjectType(GetModule())));
//    }

} // End SEI_RemoveSubraceEffects


void SEI_ApplyEffectToObject( int a_nDurationType, effect a_eEffect, object a_oTarget, float a_fDuration = 0.0, int a_bPermanent = FALSE )
{
    object oMod = GetModule();
//    object oPermEffect = GetObjectByTag(KU_SUBRACES_PERM_TAG + IntToString(Random(10)));
//    object oAreaEffect = GetObjectByTag(KU_SUBRACES_AREA_TAG);
    object oPermEffect = GetLocalObject(oMod,KU_SUBRACES_PERM_FIELD);
    object oAreaEffect = GetLocalObject(oMod,KU_SUBRACES_AREA_FIELD);
    // Make the effect supernatural so that it persists through resting.
//    AssignCommand( ( a_bPermanent ? GetModule() : GetArea( a_oTarget ) ),
    if (a_bPermanent) {
    SetEffectSpellId(a_eEffect,11000);
    AssignCommand( oPermEffect,
        ApplyEffectToObject( a_nDurationType, SupernaturalEffect( a_eEffect ), a_oTarget, a_fDuration ) );
    }
    else {
    SetEffectSpellId(a_eEffect,11100);
    DelayCommand(3.0,AssignCommand( oAreaEffect ,
        ApplyEffectToObject( a_nDurationType, SupernaturalEffect( a_eEffect ), a_oTarget, a_fDuration ) ));
    }

} // End SEI_ApplyEffectToObject


// Create the effect simulating stonecunning.
//
effect SEI_EffectStonecunning()
{

    // Stonecunning gives +2 on search checks while underground.
    effect eResult = EffectSkillIncrease( SKILL_SEARCH, 2 );

    // +2 to Hide checks while underground.
    // SEI_NOTE: Included in Stonecunning to safe from adding yet another attribute.
    eResult = EffectLinkEffects( eResult,
        EffectSkillIncrease( SKILL_HIDE, 2 ) );

    return eResult;

} // End SEI_EffectStonecunning


// Create the effect simulating light sensitivity.
//
effect SEI_EffectLightSensitivity( int a_nSeverity )
{
//ADDED BY KUCIK
  effect eResult;
  if( a_nSeverity < 3 ) {
//END BY KUCIK
    // Decrease attack rolls.
    eResult = EffectAttackDecrease( a_nSeverity );

    // Decrease all saving throws.
    eResult = EffectLinkEffects( eResult,
        EffectSavingThrowDecrease( SAVING_THROW_ALL, a_nSeverity, SAVING_THROW_TYPE_ALL ) );

    // Decrease all skill checks.
    eResult = EffectLinkEffects( eResult,
        EffectSkillDecrease( SKILL_ALL_SKILLS, a_nSeverity ) );
//ADDED BY KUCIK
  }
  else {
    eResult = EffectBlindness();
  }
//END BY KUCIK
    return eResult;

} // End SEI_EffectLightSensitivity


// Remove blindness if character comes from light to dark
void ku_RemoveLightBlindness( object oPC )
{
 if(SUBRACE_DEBUG)
  SendMessageToPC(oPC,"Removing blindness");

 object oAreaEffect = GetLocalObject(GetModule(),KU_SUBRACES_AREA_FIELD);
 effect a_eEffect = GetFirstEffect(oPC);

 while(GetIsEffectValid(a_eEffect)) {

    string sEffectCreatorTag = GetTag(GetEffectCreator( a_eEffect ));

    // Only remove effects applied by the area.
    //if( ( GetObjectType(GetEffectCreator( a_eEffect )) == OBJECT_TYPE_CREATURE ) &&
    if( ( GetEffectCreator( a_eEffect ) ==  oAreaEffect) &&
        ( GetEffectType( a_eEffect ) == EFFECT_TYPE_BLINDNESS ) )
    {
        if(SUBRACE_DEBUG)
           SendMessageToPC(oPC,"Match!");
        RemoveEffect( oPC, a_eEffect );

//        return; // Remove only one effect

    }
    a_eEffect = GetNextEffect(oPC);
 }
} // End ku_RemoveLightBlindness


// Apply the area settings to the character.
//
void SEI_ApplyAreaSettings( object a_oCharacter, object oArea, int a_nSettings )
{

    // If we have something to work with.
    if( GetIsObjectValid( a_oCharacter ) )
    {

        // Read the local variable off the character.
        int nSubrace = GetLocalInt( a_oCharacter, SUBRACE_FIELD );

        // Make sure we actually have a subrace.
        if( nSubrace != SUBRACE_NONE )
        {
            if(SUBRACE_DEBUG)
              SendMessageToPC(a_oCharacter,"Subrasa je OK");
            // Load the information on the character's subrace.
            struct Subrace stSubrace = SEI_LoadSubrace( nSubrace );

            // Get the area the character is in.
//            object oArea = GetArea( a_oCharacter );

            // If this subrace has stonecunning...
            if( stSubrace.m_nStonecunning )
            {

                // Get the ground setting (underground/above ground).
                int nGroundSetting = SEI_GetAreaSetting( oArea, a_nSettings, 10 );

                // Get if the character thinks it's above or underground.
                int nCharGround = GetLocalInt( a_oCharacter, GROUND_SETTING );

                // If this area is underground...
                if( nGroundSetting == SEI_AREA_UNDERGROUND )
                {

                    // If the character just went underground.
                    if( nCharGround != SEI_AREA_UNDERGROUND )
                    {

                        // Apply the stonecunning effect to the character.
                        SEI_ApplyEffectToObject(
                            DURATION_TYPE_PERMANENT,
                            SEI_EffectStonecunning(),
                            a_oCharacter );

                        // Remember that the character is underground.
                        SetLocalInt( a_oCharacter, GROUND_SETTING, SEI_AREA_UNDERGROUND );

                    } // End if

                }
                else
                {

                    // If the character just came above ground.
                    if( nCharGround != SEI_AREA_ABOVEGROUND )
                    {

                        // Remove the stonecunning effect.
                        SEI_RemoveSubraceEffects( a_oCharacter, FALSE, EFFECT_TYPE_SKILL_INCREASE );

                        // Remember that the character is above ground.
                        SetLocalInt( a_oCharacter, GROUND_SETTING, SEI_AREA_ABOVEGROUND );

                    } // End if

                } // End if-else

            } // End if (Stonecunning)

            if(SUBRACE_DEBUG)
               SendMessageToPC(a_oCharacter,"Svetloplachost?");
            // If this subrace is sensitive to light...
            if( stSubrace.m_nLightSensitivity > 0 )
            {

                if(SUBRACE_DEBUG)
                  SendMessageToPC(a_oCharacter,"Svetloplachost OK");
                // Get the light setting.
                int nLightSetting = SEI_GetAreaSetting( oArea, a_nSettings, 1 );

                // Get the amount of light the character is in.
                int nCharLight = GetLocalInt( a_oCharacter, LIGHT_SETTING );

                // If the character is in a light area...
                if( ( nLightSetting == AREA_LIGHT ) ||
                    ( ( nLightSetting == AREA_SUN ) && ( GetIsDay() || GetIsDawn() ) ) )
                {

                    if(SUBRACE_DEBUG)
                      SendMessageToPC(a_oCharacter,"Svetlo tu je");
                    // If the character just entered a light area.
                    if( nCharLight != AREA_LIGHT )
                    {
                        if(SUBRACE_DEBUG)
                           SendMessageToPC(GetFirstPC(),"Entering Light");
                        // Apply the light sensitivity effect to the character.
                        SEI_ApplyEffectToObject(
                            DURATION_TYPE_PERMANENT,
                            SEI_EffectLightSensitivity( stSubrace.m_nLightSensitivity ),
                            a_oCharacter );
                        SEI_ApplyEffectToObject(
                            DURATION_TYPE_PERMANENT,
                            EffectSlow(),
                            a_oCharacter );

                        // If the character is blinded by bright light...
                        if( stSubrace.m_fLightBlindness > 0.0 )
                        {

                            // Blind the character for the time specified.
                            SEI_ApplyEffectToObject(
                                DURATION_TYPE_TEMPORARY,
                                EffectBlindness(),
                                a_oCharacter,
                                stSubrace.m_fLightBlindness );

                        } // End if

                        // Remember that the character is in a light area.
                        SetLocalInt( a_oCharacter, LIGHT_SETTING, AREA_LIGHT );

                    } // End if

                }
                else
                {
                    if(SUBRACE_DEBUG)
                       SendMessageToPC(a_oCharacter,"Je tu tma");
                    // If the character just entered a dark area.
                    if( nCharLight != AREA_DARK )
                    {
                        if(SUBRACE_DEBUG)
                           SendMessageToPC(GetFirstPC(),"Entering Dark");
                        // Remove the light sensitivity effect.
                        SEI_RemoveSubraceEffects( a_oCharacter, FALSE, EFFECT_TYPE_SKILL_DECREASE );
                        if(SUBRACE_DEBUG)
                          SendMessageToPC(a_oCharacter,"Skills fixed, removing slow");
                        SEI_RemoveSubraceEffects( a_oCharacter, FALSE, EFFECT_TYPE_SLOW );

                        if(SUBRACE_DEBUG)
                          SendMessageToPC(a_oCharacter,"slow removed, removing blindness");

                        // ADDED BY KUCIK - remove light blindness
                        //DelayCommand(3.0,ku_RemoveLightBlindness( a_oCharacter ));
                        DelayCommand(3.0,SEI_RemoveSubraceEffects( a_oCharacter, FALSE, EFFECT_TYPE_BLINDNESS ));

                        // Remember that the character is in a dark area.
                        SetLocalInt( a_oCharacter, LIGHT_SETTING, AREA_DARK );

                    } // End if

                } // End if-else

            } // End if (Light sensitivity)
            else  if(SUBRACE_DEBUG)
               SendMessageToPC(a_oCharacter,"Neni svetloplacha");

            if(SUBRACE_DEBUG)
                   SendMessageToPC(a_oCharacter,"subrasa je z podtemna? : " + IntToString(stSubrace.m_bIsUnderdark));
            // If this subrace isn't from underdark
            if( stSubrace.m_bIsUnderdark == 0 )
//            if(ku_GetHasUnderdarkPenalty(a_oCharacter,stSubrace.m_bIsUnderdark))
            {

                if(SUBRACE_DEBUG)
                   SendMessageToPC(a_oCharacter,"Subrasa NENI z podtemna");
                // Get the underdark setting.
                int nRestOfSetting = SEI_GetAreaSetting( oArea, a_nSettings, 100 );

                if(SUBRACE_DEBUG)
                   SendMessageToPC(a_oCharacter,"setting je: " + IntToString(nRestOfSetting) + ":" + IntToString(a_nSettings));

                // Get the where was character
                int nCharLast = GetLocalInt( a_oCharacter, UNDERDARK_SETTING );

                // If the character is in underdark...
                if( nRestOfSetting == KU_AREA_UNDERDARK )
                {
                    if(SUBRACE_DEBUG)
                      SendMessageToPC(a_oCharacter,"v podtemnu");
                    // If the character just entered a underdark area.
                    if( nCharLast != KU_AREA_UNDERDARK )
                    {
                        if(SUBRACE_DEBUG)
                           SendMessageToPC(GetFirstPC(),"Entering Underdark");
                        // Apply the "bad air" effect to the character.
                        SEI_ApplyEffectToObject(
                            DURATION_TYPE_PERMANENT,
                            EffectACDecrease(4),
                            a_oCharacter );
                        SEI_ApplyEffectToObject(
                            DURATION_TYPE_PERMANENT,
                            EffectAttackDecrease(4),
                            a_oCharacter );
                        SEI_ApplyEffectToObject(
                            DURATION_TYPE_PERMANENT,
                            EffectSkillDecrease(SKILL_ALL_SKILLS,4),
                            a_oCharacter );
                        SEI_ApplyEffectToObject(
                            DURATION_TYPE_PERMANENT,
                            EffectSpellFailure(10),
                            a_oCharacter );

                        // Remember that the character is in underdark area.
                        SetLocalInt( a_oCharacter, UNDERDARK_SETTING, KU_AREA_UNDERDARK );

                    } // End if

                }
                else
                {
                    if(SUBRACE_DEBUG)
                      SendMessageToPC(a_oCharacter,"na povrchu");
                    // If the character just entered a surface area.
                    if( nCharLast != KU_AREA_SURFACE )
                    {
                        if(SUBRACE_DEBUG)
                           SendMessageToPC(GetFirstPC(),"Entering Surface");
                        // Remove the "bad air" effect.
                        SEI_RemoveSubraceEffects( a_oCharacter, FALSE, EFFECT_TYPE_AC_DECREASE );
                        SEI_RemoveSubraceEffects( a_oCharacter, FALSE, EFFECT_TYPE_ATTACK_DECREASE );
                        SEI_RemoveSubraceEffects( a_oCharacter, FALSE, EFFECT_TYPE_SKILL_DECREASE );
                        SEI_RemoveSubraceEffects( a_oCharacter, FALSE, EFFECT_TYPE_SPELL_FAILURE );

                        // Remember that the character is in surface area.
                        SetLocalInt( a_oCharacter, UNDERDARK_SETTING, KU_AREA_SURFACE );

                    } // End if

                } // End if-else

            } // End if (Underdark)


            // If this subrace has penalty in interior and underground
            if( stSubrace.m_bInterionPenalty != 0 )
            {

                if(SUBRACE_DEBUG)
                   SendMessageToPC(a_oCharacter,"Subrasa Ma trosku problem v interierech");
                // Get the area setting.
                int bIsInterion = GetIsAreaInterior( oArea );

                if(SUBRACE_DEBUG)
                   SendMessageToPC(a_oCharacter,"Interier ?: " + IntToString(bIsInterion));

                // Get the where was character
                int nCharLast = GetLocalInt( a_oCharacter, INTERIOR_SETTING );

                // If the character is in interior...
                if( bIsInterion == TRUE )
                {
                    if(SUBRACE_DEBUG)
                      SendMessageToPC(a_oCharacter,"v interieru nebo podzemi");
                    // If the character just entered a underdark area.
                    if( nCharLast != TRUE )
                    {
                        if(SUBRACE_DEBUG)
                           SendMessageToPC(GetFirstPC(),"Entering Underdark");
                        // Apply the "bad air" effect to the character.
                        SEI_ApplyEffectToObject(
                            DURATION_TYPE_PERMANENT,
                            EffectACDecrease(stSubrace.m_bInterionPenalty),
                            a_oCharacter );
                        SEI_ApplyEffectToObject(
                            DURATION_TYPE_PERMANENT,
                            EffectAttackDecrease(stSubrace.m_bInterionPenalty),
                            a_oCharacter );

                        // Remember that the character is in underdark area.
                        SetLocalInt( a_oCharacter, INTERIOR_SETTING, TRUE );

                    } // End if

                }
                else
                {
                    if(SUBRACE_DEBUG)
                      SendMessageToPC(a_oCharacter,"mimo interier");
                    // If the character just cames out of interior
                    if( nCharLast == TRUE )
                    {
                        if(SUBRACE_DEBUG)
                           SendMessageToPC(GetFirstPC(),"Entering Surface");
                        // Remove the "bad air" effect.
                        SEI_RemoveSubraceEffects( a_oCharacter, FALSE, EFFECT_TYPE_AC_DECREASE );
                        SEI_RemoveSubraceEffects( a_oCharacter, FALSE, EFFECT_TYPE_ATTACK_DECREASE );

                        // Remember that the character is in surface area.
                        SetLocalInt( a_oCharacter, INTERIOR_SETTING, FALSE );

                    } // End if

                } // End if-else

            } // End if (Interior)

        } // End if (is defined subrace)

    } // End if

} // End SEI_ApplyAreaSettings


// Set spacial traits to a character when the characters enters an area.
//
void SEI_EnterArea( object a_oCharacter, object oArea, int a_nSettings )
{

    // If we have something to work with.
    if( GetIsObjectValid( a_oCharacter ) )
    {

        // Get the area the character is in.
//        object oArea = GetArea( a_oCharacter );

        // Save the settings as the area settings.
        SEI_SetAreaSettings( oArea, a_nSettings );

        // Apply the settings to the character.
        SEI_ApplyAreaSettings( a_oCharacter, oArea, a_nSettings );

    } // End if

} // End SEI_EnterArea


void SEI_AreaHeartbeat( object a_oArea )
{

    // Get the area's light setting setting.
    int nAreaLightSetting = SEI_ReadAreaSetting( GetLocalInt( a_oArea, AREA_SETTING ), 1 );

    if( nAreaLightSetting == AREA_SUN )
    {

        // Is it currently light or dark?
        int bIsLight = ( GetIsDay() || GetIsDawn() );

        // What does the area think it is?
        int nAreaLight = GetLocalInt( a_oArea, LIGHT_SETTING );

        // Variable of whether the characters in the area need updating.
        int bMustUpdate = FALSE;

        // If it is light, but the area still thinks it's dark...
        if( bIsLight && ( nAreaLight != AREA_LIGHT ) )
        {

            // We must update the characters in the area.
            bMustUpdate = TRUE;

            // Update the light setting of the area.
            SetLocalInt( a_oArea, LIGHT_SETTING, AREA_LIGHT );

        }
        // If it is dark, but the area still thinks it's light...
        else if( !bIsLight && ( nAreaLight != AREA_DARK ) )
        {

            // We must update the characters in the area.
            bMustUpdate = TRUE;

            // Update the light setting of the area.
            SetLocalInt( a_oArea, LIGHT_SETTING, AREA_DARK );

        } // End if-elseif

        // If the characters in the area must be updated.
        if( bMustUpdate )
        {

            object oAreaEffect = GetLocalObject(GetModule(),KU_SUBRACES_AREA_FIELD);

            // Go through all the PCs.
            object oPC = GetFirstPC();
            while( GetIsObjectValid( oPC ) )
            {

                // If the PC is in this area then update the character.
                if( GetArea( oPC ) == a_oArea )
                {

                    AssignCommand( oAreaEffect, SEI_ApplyAreaSettings( oPC, a_oArea, 0 ) );
//                    SEI_ApplyAreaSettings( oPC, a_oArea, 0 );
                }

                oPC = GetNextPC();

            } // End while

        } // End if

    } // End if

} // End SEI_AreaHeartbeat


/*
 * Check if changed day to night or night to day
 */
void ku_SubraceModuleHeartbeat( )
{
    object oMod = GetModule();
    object oAreaEffect = GetLocalObject(oMod,KU_SUBRACES_AREA_FIELD);

    int iPrevDayNight = GetLocalInt(oMod, KU_SUBR_DAYNIGHT);
    int bIsLight = ( GetIsDay() || GetIsDawn() );

    // changed day/night
    if ( bIsLight != iPrevDayNight ) {

    object a_oArea;

    // Go through all the PCs.
      object oPC = GetFirstPC();
      while( GetIsObjectValid( oPC ) ) {

        a_oArea = GetArea( oPC );
        int nAreaLightSetting = SEI_ReadAreaSetting( GetLocalInt( a_oArea, AREA_SETTING ), 1 );

        // If the PC is in area with open sky
        if( nAreaLightSetting == AREA_SUN ) {
          AssignCommand( oAreaEffect, SEI_ApplyAreaSettings( oPC, a_oArea, 0 ) );
//          SEI_ApplyAreaSettings( oPC, a_oArea, 0 );
        }

        oPC = GetNextPC();

      } // End while


    }

} // End ku_SubraceModuleHeartbeat

/*
 * Check if changed day to night or night to day
 */
void me_SubraceModuleHeartbeat(object oPC)
{
    object oMod = GetModule();
    object oAreaEffect = GetLocalObject(oMod,KU_SUBRACES_AREA_FIELD);

    int iPrevDayNight = GetLocalInt(oMod, KU_SUBR_DAYNIGHT);
    int bIsLight = ( GetIsDay() || GetIsDawn() );

    // changed day/night
    if ( bIsLight != iPrevDayNight ) {
        object a_oArea;
        a_oArea = GetArea( oPC );
        int nAreaLightSetting = SEI_ReadAreaSetting( GetLocalInt( a_oArea, AREA_SETTING ), 1 );

        // If the PC is in area with open sky
        if( nAreaLightSetting == AREA_SUN ) {
          AssignCommand( oAreaEffect, SEI_ApplyAreaSettings( oPC, a_oArea, 0 ) );
        }
    }
}

// **************************************************************
// ** Subrace initialization functions (cont.)
// **********************

// Set the character's correct hide item based on the subrace.
//
void SEI_SetSubraceHide( struct Subrace a_stSubrace, object a_oCharacter )
{

    // If we're using the subrace hide instead of the subrace effects....
    if( USE_SUBRACE_HIDE )
    {

        // Default subraces don't have any traits (past the default).
        if( a_stSubrace.m_bIsDefault )
        {
            // Give the subrace hide item without any attributes.
            SEI_GiveSubraceHide( a_oCharacter, "sei_subrace0" );
        }
        else
        {
            // Give the subrace hide item with the traits.
            SEI_GiveSubraceHide( a_oCharacter, "sei_subrace_" + IntToString( a_stSubrace.m_nID ) );
        }

    }
    else
    {

        SEI_RemoveSubraceHide( a_oCharacter );

    } // End if-else

} // End SEI_SetSubraceHide


// Give the spell-like abilities to the character depending on the subrace.
//
void SEI_GiveSpellLikeAbilities( struct Subrace a_stSubrace, object a_oCharacter )
{

    // If this subrace has a spell-like ability then give it to them.
    if( a_stSubrace.m_nSpellLikeAbility > 0 )
    {

        // Create the tag for the item.
        string sItemTag = "ku_subr_sla_" + IntToString( a_stSubrace.m_nSpellLikeAbility );

        // Get an item with the tag (if the character has one).
        object oSpellItem = GetItemPossessedBy( a_oCharacter, sItemTag );

        // If the character doesn't have the item yet...
        if( ! GetIsObjectValid( oSpellItem ) )
        {
            // Create a new spell-like abilities item on the character.
            CreateItemOnObject( sItemTag, a_oCharacter );
        }

    } // End if

} // End SEI_GiveSpellLikeAbilities


// Apply the subrace traits for this subrace to the character.
//
void SEI_ApplySubraceTraits( struct Subrace a_stSubrace, object a_oCharacter )
{

    effect eSubraceEffect;

    int bFirstValidInited = FALSE;

    // Only do this if we're not using the subrace hide item for this.
    if( !USE_SUBRACE_HIDE )
    {

        // Global object where the values are stored.
        object oModule = GetModule();

        // Basic field name of the stored traits.
        string sTag = SUBRACE_STRUCT_TAG + IntToString(a_stSubrace.m_nID) + "_TRAIT";

        // For each trait stored...
        int nTrait;
        for( nTrait = 0 ; nTrait < a_stSubrace.m_nNumTraits ; ++nTrait )
        {

            // Get the string describing this trait.
            string sTraitString = GetLocalString( oModule, sTag + IntToString( nTrait ) );
            if(SUBRACE_DEBUG)
               SendMessageToPC(a_oCharacter,GetName(OBJECT_SELF)+"Parsing: "+sTraitString);
            if(!SEI_NWNXParseTrait( a_oCharacter, sTraitString)) {
//            if(1) {

              if( bFirstValidInited )
              {

                // Add the effect to the chain of effects we already have.
                eSubraceEffect =  EffectLinkEffects( eSubraceEffect,
                    SEI_ParseTrait( a_oCharacter, sTraitString ) );

              }
              else
              {

                // This may be the first trait, so just parse the trait string.
                eSubraceEffect = SEI_ParseTrait( a_oCharacter, sTraitString );

                // If this is the first valid effect then note that so.
                if( GetEffectType( eSubraceEffect ) != EFFECT_TYPE_INVALIDEFFECT )
                {
                    bFirstValidInited = TRUE;
                }

              } // End if-else first valid effect

              if(SUBRACE_DEBUG)
                SendMessageToPC(a_oCharacter,"-> Effect");
            } //End if no nwnx trait
            else {
              if(SUBRACE_DEBUG)
                SendMessageToPC(a_oCharacter,"-> NWNX");
            }

        } // End for

    } // End if


    // If this subrace has spell resistance, apply it based on character level.
    if( ( a_stSubrace.m_nSpellResistanceConst > 0 ) || ( a_stSubrace.m_nSpellResistancePerLevel < 100 ) ) {

        // Create the spell resistance effect.
        int nSpellResist = a_stSubrace.m_nSpellResistanceConst + ( GetHitDice( a_oCharacter ) / a_stSubrace.m_nSpellResistancePerLevel );

//---Qel-1  modification to prevent Monk SR stacking with Subrace SR
        int nMonkLvl = GetLevelByClass(CLASS_TYPE_MONK, a_oCharacter);
        if (nMonkLvl >= 12)
            {
            nSpellResist = nSpellResist - (nMonkLvl + 10);
            }
//---Qel-1  end
        if(nSpellResist > 0) {
          effect eSREffect = EffectSpellResistanceIncrease( nSpellResist );

          // Link it if we haven't linked anything yet.
          if( bFirstValidInited )
          {
              eSubraceEffect = EffectLinkEffects( eSubraceEffect, eSREffect );
          }
          else
          {
              // This is the first valid effect.
              eSubraceEffect = eSREffect;
              bFirstValidInited = TRUE;
          }
        }
    } // End if (spell resistance)

    object oSoul = SEI_GetSoul(a_oCharacter);

    // If we have something to apply, then apply it to the character.
    if( bFirstValidInited )
    {
        SEI_ApplyEffectToObject( DURATION_TYPE_PERMANENT,
            eSubraceEffect, a_oCharacter, 0.0, TRUE );
    }

    // Pokud ma postava kridylka
    if((a_stSubrace.m_nWingLevel != 0) && (a_stSubrace.m_nWingLevel <= GetHitDice(a_oCharacter) )) {
      int iWing = GetLocalInt(oSoul,"SPECIFIC_WING_TYPE");
      if(iWing == 0) {
        iWing = a_stSubrace.m_nWingType;
        SetLocalInt(oSoul,"SUBRACE_WING_TYPE",a_stSubrace.m_nWingType);
      }
      else if(iWing == -1) {
        iWing = 0;
      }
      SetCreatureWingType(iWing, a_oCharacter);
    }

    // Pokud je postava vocas
    if((a_stSubrace.m_nTailLevel != 0) && (a_stSubrace.m_nTailLevel <= GetHitDice(a_oCharacter) )) {
      int iTail = GetLocalInt(oSoul,"SUBRACE_TAIL_TYPE");
      if(iTail == 0) {
        iTail = a_stSubrace.m_nTailType;
        SetLocalInt(oSoul,"SUBRACE_TAIL_TYPE",a_stSubrace.m_nTailType);
      }
      else if (iTail == -1) {
        iTail = 0;
      }
      SetCreatureTailType(iTail, a_oCharacter);
    }

} // End SEI_ApplySubraceTraits


// Reads the character's subrace field and sets the corresponding traits
// on the character.
//
void SEI_InitSubraceTraits( object a_oCharacter, int a_bIncludeItems = TRUE )
{

    object oMod = GetModule();
    object oAreaEffect = GetLocalObject(oMod,KU_SUBRACES_AREA_FIELD);
    object oPermEffect = GetLocalObject(oMod,KU_SUBRACES_PERM_FIELD);

    // Read the local variable off the character.
    int nSubrace = GetLocalInt( a_oCharacter, SUBRACE_FIELD );

    // Make sure we actually have a subrace.
    if( nSubrace != SUBRACE_NONE )
    {

        // Load the information on the character's subrace.
        struct Subrace stSubrace = SEI_LoadSubrace( nSubrace );

        // If we also want to include the items
        if( a_bIncludeItems )
        {

            // Set the subrace hide item to te character.
            SEI_SetSubraceHide( stSubrace, a_oCharacter );

            // Give the spell-like abilities item.
            SEI_GiveSpellLikeAbilities( stSubrace, a_oCharacter );

        } // End if

        // Apply the subrace's racial traits to the character.
        AssignCommand(oPermEffect,SEI_ApplySubraceTraits( stSubrace, a_oCharacter ));

        // Apply effects based on the area settings if needed.
//        object oExecutor = GetObjectByTag(KU_SUBRACES_AREA_TAG);
/*        object oExecutor = a_oCharacter;
        SetLocalObject(oExecutor,"KU_CHARAKTER",a_oCharacter);
        SetLocalObject(oExecutor,"KU_AREA",GetArea(a_oCharacter));
        SetLocalInt(oExecutor,"KU_AREA_SETTINGS",0);
        ExecuteScript("ku_apply_area_s",GetObjectByTag(KU_SUBRACES_AREA_TAG));
*/
        AssignCommand(oAreaEffect,SEI_ApplyAreaSettings( a_oCharacter, GetArea(a_oCharacter) ,0 ));

        object oSoul = SEI_GetSoul(a_oCharacter);
        int appearance = KU_GetSubraceAppearanceChange( a_oCharacter );

        if(GetLocalInt(oSoul,"KU_STANDART_APPEARANCE")==0) {

          if(appearance) {
            SetCreatureAppearanceType(a_oCharacter,appearance);

//          if(GetLocalInt(oSoul,"KU_STANDART_APPEARANCE")==0) {
            object oPC = a_oCharacter;
            string KU_DLG = "KU_UNI_DIALOG";
            if(SUBRACE_DEBUG)
              SendMessageToPC(oPC,"EXEcuting ku_uni_dlg");
            SetLocalInt(oPC,KU_DLG+"dialog",1);
            SetCustomToken(6300,"Nastaveni vzhledu hlavy. Po ukonceni toho dialogu jiz nebude mozne vzhled menit.");
            SetLocalInt(oPC,"KU_STANDART_APPEARANCE",appearance);
            SetLocalInt(oSoul,"KU_STANDART_APPEARANCE",appearance);
            SetLocalInt(oPC,KU_DLG+"_allow_0",1);

            AssignCommand( a_oCharacter, SetCommandable( TRUE, a_oCharacter ) );
            AssignCommand( a_oCharacter, ClearAllActions() );
            AssignCommand( a_oCharacter, ActionStartConversation( a_oCharacter, "ku_uni_dlg", TRUE ) );
          }
          else if(!GetLocalInt(oSoul,"KU_HEAD_CHANGED")) {
            object oPC = a_oCharacter;
            string KU_DLG = "KU_UNI_DIALOG";
            SetLocalInt(oSoul,"KU_STANDART_APPEARANCE",GetAppearanceType(a_oCharacter));
            SetLocalInt(oSoul,"KU_HEAD_CHANGED",TRUE);
            SetLocalInt(oPC,KU_DLG+"dialog",1);
            SetCustomToken(6300,"Nastaveni vzhledu hlavy. Po ukonceni toho dialogu jiz nebude mozne vzhled menit.");
            SetLocalInt(oPC,KU_DLG+"_allow_0",1);

            AssignCommand( a_oCharacter, SetCommandable( TRUE, a_oCharacter ) );
            AssignCommand( a_oCharacter, ClearAllActions() );
            AssignCommand( a_oCharacter, ActionStartConversation( a_oCharacter, "ku_uni_dlg", TRUE ) );

          }

        }
        if(SUBRACE_DEBUG)
              SendMessageToPC(a_oCharacter,"Appearance ="+IntToString(GetLocalInt(oSoul,"KU_STANDART_APPEARANCE")));

    } // End if

} // End SEI_InitSubraceTraits


// Remove all possible subrace stuff from the character.
//
void SEI_RemoveSubrace( object a_oCharacter, int a_bRemoveItems = TRUE )
{

    if( GetIsObjectValid( a_oCharacter ) )
    {

        if( a_bRemoveItems )
        {

            // Remove the subrace hide.
            SEI_RemoveSubraceHide( a_oCharacter );

            int nSpellItem;
            for( nSpellItem = 1 ; nSpellItem <= 3 ; ++nSpellItem )
            {

                // Get the spell-like ability item.
                object oSpellItem = GetItemPossessedBy( a_oCharacter, "sei_sla_" + IntToString( nSpellItem ) );

                // If the character has the object, then destroy it.
                if( GetIsObjectValid( oSpellItem ) )
                {
                    DestroyObject( oSpellItem );
                }

            } // End for

        } // End if

        SEI_RemoveSubraceEffects( a_oCharacter );

    } // End if

} // End SEI_RemoveSubrace


// Initializes the subrace for character a_oCharacter.
//
void SEI_InitSubrace( object a_oCharacter )
{

    // Sanity check, make sure we have something to work with.
    if( GetIsObjectValid( a_oCharacter ) )
    {
        object oSoul = SEI_GetSoul(a_oCharacter);

        // Get the character's subrace.
        int nSubrace = GetLocalInt( oSoul, SUBRACE_FIELD );
        SetLocalInt( a_oCharacter, SUBRACE_FIELD ,nSubrace);
        if(SUBRACE_DEBUG)
          SendMessageToPC(a_oCharacter,"Soul="+GetName(oSoul)+"; subrace="+IntToString(nSubrace));

        SEI_RemoveSubrace( a_oCharacter, FALSE );

        // See if this character's subrace has been initialized before.
        if( nSubrace == SUBRACE_NONE )
        {

            // Initialize the subrace variable on the character.
            nSubrace = SEI_InitSubraceVar( a_oCharacter );

            // See if we successfully initialized the character's subrace.
            if( nSubrace != SUBRACE_NONE )
            {

                // Initialize the subrace traits on the character.
//                object oExecutor = GetObjectByTag(KU_SUBRACES_PERM_TAG + IntToString(Random(10)));
//                SetLocalObject(oExecutor,"KU_CHARAKTER",a_oCharacter);
//               SetLocalInt(oExecutor,"KU_INCLUDE_ITEMS",TRUE);
//                ExecuteScript("ku_subr_init_tr",oExecutor);  //remove this script

                SetLocalInt( oSoul, SUBRACE_FIELD , nSubrace);
                SetLocalInt( a_oCharacter, SUBRACE_FIELD ,nSubrace);
                SEI_InitSubraceTraits( a_oCharacter );

//                SetCreatureAppearanceType( KU_GetSubraceAppearanceChange( a_oCharacter ),a_oCharacter);

                // Send a message that the subrace has been inited.
                SEI_SendSubraceInitMsg( a_oCharacter, nSubrace );

            } // End if

        }
        else
        {

            // Initialize the subrace traits on the character.
//            object oExecutor = GetObjectByTag(KU_SUBRACES_PERM_TAG + IntToString(Random(10)));
//            SetLocalObject(oExecutor,"KU_CHARAKTER",a_oCharacter);
//            SetLocalInt(oExecutor,"KU_INCLUDE_ITEMS",TRUE);
//            ExecuteScript("ku_subr_init_tr",oExecutor);
            SEI_InitSubraceTraits( a_oCharacter );

        } // End if no subrace

//       SendMessageToPC(a_oCharacter,"Klic");

        // Dej klic vsem z podtemna
/*       if(KU_GetIsFromUnderdark(a_oCharacter)) {
         if(!GetIsObjectValid(GetItemPossessedBy(a_oCharacter,"ry_klic_podtemno"))) {
           CreateItemOnObject("ry_klic_podtemno",a_oCharacter,1);
         }
       }*/


    } // End if valid character


} // End SEI_InitSubrace


// Finishes the subrace dialog for the character, initializing the subrace.
//
void SEI_FinishSubraceDialog( object a_oCharacter )
{

    SetCommandable( TRUE, a_oCharacter );

    // Sanity check, make sure we have something to work with.
    if( GetIsObjectValid( a_oCharacter ) )
    {
        // Initialize the subrace for the effects, etc.
/*
        object oExecutor = GetObjectByTag(KU_SUBRACES_PERM_TAG + IntToString(Random(10)));
        SetLocalObject(oExecutor,"KU_CHARAKTER",a_oCharacter);
        SetLocalInt(oExecutor,"KU_INCLUDE_ITEMS",TRUE);
        ExecuteScript("ku_subr_init_tr",oExecutor);
*/
        SEI_InitSubraceTraits( a_oCharacter );
        SEI_SendSubraceInitMsg( a_oCharacter, GetLocalInt( a_oCharacter, SUBRACE_FIELD ) );
    }

} // End SEI_FinishSubraceDialog




// **************************************************************
// ** Subrace active functions
// **********************

// Modifies the character's subrace attributes on a character's level up.
//
void SEI_LevelUpSubrace( object a_oCharacter )
{

    object oSoul = SEI_GetSoul(a_oCharacter);
    // Read the local variable off the character.
    int nSubrace = GetLocalInt( a_oCharacter, SUBRACE_FIELD );

    // Make sure that we actually have a subrace.
    if( nSubrace != SUBRACE_NONE )
    {

        // Load the information on the character's subrace.
        struct Subrace stSubrace = SEI_LoadSubrace( nSubrace );

        // If this subrace has spell resistance then increase it.
//        if( stSubrace.m_bSpellResistance )
        if( ( stSubrace.m_nSpellResistanceConst > 0 ) || ( stSubrace.m_nSpellResistancePerLevel < 100 ) )
        {
            // Create the spell resistance effect, higher value overrides previous value.
            int nSpellResist = stSubrace.m_nSpellResistanceConst + ( GetHitDice( a_oCharacter ) / stSubrace.m_nSpellResistancePerLevel );
//            int nSpellResist = 11 + GetHitDice( a_oCharacter );

//---Qel-1  modification to prevent Monk SR stacking with Subrace SR
           int nMonkLvl = GetLevelByClass(CLASS_TYPE_MONK, a_oCharacter);
           if (nMonkLvl >= 12)
                {
                nSpellResist = nSpellResist - (nMonkLvl + 10);
                }
//---Qel-1  end
            effect eSREffect = EffectSpellResistanceIncrease( nSpellResist );


            // Apply the effect to the character.
            if(nSpellResist > 0)
              SEI_ApplyEffectToObject( DURATION_TYPE_INSTANT, eSREffect, a_oCharacter, 0.0, TRUE );

        } // End if

        // Pokud ma postava kridylka
        if((stSubrace.m_nWingLevel != 0) && (stSubrace.m_nWingLevel <= GetHitDice(a_oCharacter) )) {
          int iWing = GetLocalInt(oSoul,"SPECIFIC_WING_TYPE");
          if(iWing == 0) {
            iWing = stSubrace.m_nWingType;
            SetLocalInt(oSoul,"SUBRACE_WING_TYPE",stSubrace.m_nWingType);
          }
          else if(iWing == -1) {
            iWing = 0;
          }
          SetCreatureWingType(iWing, a_oCharacter);
          //SetCreatureWingType(stSubrace.m_nWingType, a_oCharacter);
        }

        // Pokud je postava vocas
        if((stSubrace.m_nTailLevel != 0) && (stSubrace.m_nTailLevel <= GetHitDice(a_oCharacter) )) {
          int iTail = GetLocalInt(oSoul,"SUBRACE_TAIL_TYPE");
          if(iTail == 0) {
            iTail = stSubrace.m_nTailType;
            SetLocalInt(oSoul,"SUBRACE_TAIL_TYPE",stSubrace.m_nTailType);
          }
          else if (iTail == -1) {
            iTail = 0;
          }
          SetCreatureTailType(iTail, a_oCharacter);
        }

    } // End if

} // End SEI_LevelUpSubrace


// Returns the subrace (enum) for the target.
//
int SEI_GetCharacterSubrace( object a_oCharacter )
{

    int nSubrace = SUBRACE_NONE;

    // Sanity check, make sure we have something to work with.
    if( a_oCharacter != OBJECT_INVALID )
    {

        // Read the local variable off the character.
        nSubrace = GetLocalInt( a_oCharacter, SUBRACE_FIELD );

        // Write the findings into the log.
        SEI_WriteSubraceLogEntry( "Subrace of player " + GetName( a_oCharacter ) +
                                  " is " + IntToString( nSubrace ) +
                                  " (" + SEI_SubraceEnumToString( nSubrace ) + ")", TRUE );

        // If subrace not initialized yet.
        if( nSubrace == SUBRACE_NONE )
        {
            SEI_InitSubrace( a_oCharacter );
            nSubrace = GetLocalInt( a_oCharacter, SUBRACE_FIELD );
        } // End if

    } // End if

    // Return the character's subrace.
    return nSubrace;

} // End SEI_GetCharacterSubrace


// Returns whether the character is of subrace a_nSubrace.
//
int SEI_IsCharacterOfSubrace( object a_oCharacter, int a_nSubrace )
{
    return SEI_GetCharacterSubrace( a_oCharacter ) == a_nSubrace;
}


// Returns the effective character level of the character.
//
int SEI_GetEffectiveCharacterLevel( object a_oCharacter )
{
    int iHD = FloatToInt(0.5 + sqrt(0.25 + ( IntToFloat(GetXP(a_oCharacter)) / 500 )));
    if(!SUBRACES_USE_TOTAL_XP_TO_COMPUTE_PCLEVEL) {
      iHD = GetHitDice( a_oCharacter );
    }

    return iHD + SEI_GetECLAdd( a_oCharacter );
}


// Make sure that the character has the subrace items they're supposed to have.
//
void SEI_KeepSubraceItem( object a_oCharacter )
{

    // Have we been given a valid character?
    if( GetIsObjectValid( a_oCharacter ) )
    {

        // Read the local variable off the character.
        int nSubrace = GetLocalInt( a_oCharacter, SUBRACE_FIELD );

        // Make sure we actually have a subrace.
        if( nSubrace != SUBRACE_NONE )
        {

            // Load the information on the character's subrace.
            struct Subrace stSubrace = SEI_LoadSubrace( nSubrace );

            // Give the spell-like abilities item.
            SEI_GiveSpellLikeAbilities( stSubrace, a_oCharacter );

        } // End if

    } // End if

} // End SEI_KeepSubraceItem


// Make sure that the subrace item is removed when someone loses it.
//
int SEI_DropSubraceItem( object a_oItem )
{

    // If this is a spell-like ability item...
    if( GetStringLeft( GetTag( a_oItem ), 8 ) == "sei_sla_" )
    {
        // Destroy the item.
        DestroyObject( a_oItem );

        // Return the we've recognized the item.
        return TRUE;
    }
    else
    {
        // This is not a spell-like ability item,
        // so return we haven't recognized it.
        return FALSE;
    } // End if-else

} // End SEI_DropSubraceItem




// **************************************************************
// ** Subrace experience functions
// **********************

// Finds the default subrace for the race.
//
int SEI_FindDefaultSubrace( int a_nRace )
{

    // Global object where the values are stored.
    object oModule = GetModule();

    // Get the total number of added subraces.
    int nNrSubraces = GetLocalInt( oModule, SUBRACE_COUNT );

    // For all stored subraces...
    int nIdx;
    for( nIdx = 0 ; nIdx < nNrSubraces ; ++nIdx )
    {

        // The base field name the values are stored under.
        string sTag = SUBRACE_STRUCT_TAG + IntToString( nIdx ) + "_";

        // If this is the default subrace for the race...
        if( ( GetLocalInt( oModule, sTag + "RACE" ) == a_nRace ) &&
            GetLocalInt( oModule, sTag + "DEF" ) )
        {
            // Return the ID of the subrace.
            return GetLocalInt( oModule, sTag + "ID" );
        }

    } // End for

    // There is no default race for this subrace.
    return SUBRACE_NONE;

} // End SEI_FindDefaultSubrace


// Returns the favored class for the subrace.
//
int SEI_GetFavoredClass( object a_oCharacter, struct Subrace a_stSubrace, int n_aHighestClass )
{

    int nResult = CLASS_TYPE_INVALID;

    int nClass = -1;

    // Get te favored class depending on the gender of the character.
    if( GetGender( a_oCharacter ) == GENDER_FEMALE )
    {
        nClass = a_stSubrace.m_nFavoredClassF;
    }
    else if( GetGender( a_oCharacter ) == GENDER_MALE )
    {
        nClass = a_stSubrace.m_nFavoredClassM;
    }

    // If we have a favored class...
    if( nClass >= 0 )
    {

        // If no specific class is specified then take the highest class.
        if( nClass == CLASS_TYPE_INVALID )
        {
            nResult = n_aHighestClass;
        }
        else
        {
            nResult = nClass;
        }

    } // End if

    return nResult;

}  // End SEI_GetFavoredClass


// Find the favored class for the subrace.
//
int SEI_FindFavoredClass( object a_oCharacter, struct Subrace a_stSubrace, int n_aHighestClass )
{

    // Get the favored class for the subrace.
    int nResult = SEI_GetFavoredClass( a_oCharacter, a_stSubrace, n_aHighestClass );

    // If no favored class was specified...
    if( nResult == CLASS_TYPE_INVALID )
    {

        // Get the favored class for the subrace's base race.
        nResult = SEI_GetFavoredClass(
            a_oCharacter,
            SEI_LoadSubrace( SEI_FindDefaultSubrace( a_stSubrace.m_nBaseRace ) ),
            n_aHighestClass );

    } // End if

    return nResult;

}  // End SEI_FindFavoredClass


// Calculate the amount of experience the character of would get with these two classes.
// It is assumed that a_nHigh is the highest level in a class.
// It is assumed that the favored class is already dropped.
//
float SEI_CalcXPPenaltyForClasses( int a_nHigh, int a_nLow )
{

    // Start without a penalty.
    float fPenalty = 0.0;

    // If the difference between the highest class and the other class is too
    // high then increase the penalty.
    if( ( a_nLow != 0 ) && ( ( a_nHigh - a_nLow ) > 1 ) )
    {
        fPenalty += 0.2;
    }

    return fPenalty;

} // End SEI_CalcXPPenaltyForClasses


// Calculate the amount of experience penalty the character will get.
// Sorts level according to highest level and drops the favored class.
//
float SEI_DropForFavoredClass( object a_oCharacter, struct Subrace a_stSubrace, int a_nClass1, int a_nLevel1, int a_nClass2, int a_nLevel2, int a_nClass3, int a_nLevel3 )
{

    // Get the class with the most levels.
    int nHighestClass = CLASS_TYPE_INVALID;
    if( a_nLevel2 > a_nLevel1 )
    {
        nHighestClass = ( ( a_nLevel3 > a_nLevel2 ) ? a_nClass3 : a_nClass2 );
    }
    else
    {
        nHighestClass = ( ( a_nLevel3 > a_nLevel1 ) ? a_nClass3 : a_nClass1 );
    }

    // Find the favored class for this subrace.
    int nFavoredClass = SEI_FindFavoredClass( a_oCharacter, a_stSubrace, nHighestClass );

    // Ignore the level in the favored class.
    int nLevel1 = ( ( a_nClass1 == nFavoredClass ) ? 0 : a_nLevel1 );
    int nLevel2 = ( ( a_nClass2 == nFavoredClass ) ? 0 : a_nLevel2 );
    int nLevel3 = ( ( a_nClass3 == nFavoredClass ) ? 0 : a_nLevel3 );

    // Sort the first and the second level to highest.
    int nTempHigh = ( ( nLevel1 > nLevel2 ) ? nLevel1 : nLevel2 );
    int nLow1 =     ( ( nLevel1 > nLevel2 ) ? nLevel2 : nLevel1 );

    // Sort the third level and the current highest.
    int nHigh = ( ( nLevel3 > nTempHigh ) ? nLevel3 : nTempHigh );
    int nLow2 = ( ( nLevel3 > nTempHigh ) ? nTempHigh : nLevel3 );

    // Start without a penalty.
    float fPenalty = 0.0;

    // Calculate the penalty for the two lower classes in relation to the higher one.
    fPenalty += SEI_CalcXPPenaltyForClasses( nHigh, nLow1 );
    fPenalty += SEI_CalcXPPenaltyForClasses( nHigh, nLow2 );

    // Return the calculated penalty.
    return fPenalty;

} // End SEI_DropForFavoredClass


// Modify the amount of experience for the character's favored class.
//
int SEI_ModifyXPForFavoredClass( object a_oCharacter, int a_nXP )
{

    int nXP = a_nXP;

    // Get the three classes the character has.
    int nClass1 = GetClassByPosition( 1, a_oCharacter );
    int nClass2 = GetClassByPosition( 2, a_oCharacter );
    int nClass3 = GetClassByPosition( 3, a_oCharacter );

    // If character only has one class then this isn't an issue.
    if( nClass2 != CLASS_TYPE_INVALID )
    {

        // Get the number of levels in the character's classes.
        int nLevel1 = GetLevelByClass( nClass1, a_oCharacter );
        int nLevel2 = GetLevelByClass( nClass2, a_oCharacter );
        int nLevel3 = 0;

        // If this character has three classes get the level in the third class.
        if(  nClass3 != CLASS_TYPE_INVALID  )
        {
            nLevel3 = GetLevelByClass( nClass3, a_oCharacter );
        }

        // Load the character's subrace.
        struct Subrace stSubrace = SEI_LoadSubrace( SEI_GetCharacterSubrace( a_oCharacter ) );

        // Get the normal XP modification.
        float fNormalMod = 1.0 - SEI_DropForFavoredClass(
            a_oCharacter, SEI_LoadSubrace( SEI_FindDefaultSubrace( stSubrace.m_nBaseRace ) ),
            nClass1, nLevel1, nClass2, nLevel2, nClass3, nLevel3 );

        // Get the XP modification for subrace.
        float fSubraceMod = 1.0 - SEI_DropForFavoredClass(
            a_oCharacter, stSubrace, nClass1, nLevel1, nClass2, nLevel2, nClass3, nLevel3 );

        // Undo the normal penalty and set the new one.
        // SEI_NOTE: No danger of div-0 as the max penalty is 40%.
        nXP = FloatToInt( IntToFloat( nXP ) * ( fSubraceMod / fNormalMod ) );

    } // End if

    return nXP;

} // End SEI_ModifyXPForFavoredClass


// Modify the experience to take into acount any ECL modification.
//
int SEI_ModifyXPForECL( object a_oCharacter, int a_nXP )
{

    // Get the level without ECL modification.
    float fBaseLevel = IntToFloat( GetHitDice( a_oCharacter ) );

    // Get the amount of ECL modification.
    int nECLAdd = SEI_GetECLAdd( a_oCharacter );

    // Calculate how much to modify the experience.
    float fModify = ( fBaseLevel / ( fBaseLevel + nECLAdd ) );

    // Modify the experience and return.
    return FloatToInt( fModify * a_nXP );

} // End SEI_ModifyXPForECL


// Modify the experience the character would get to correct for subrace.
//
int SEI_ModifyXPForSubrace( object a_oCharacter, int a_nXP )
{

    int nXP = a_nXP;

    nXP = SEI_ModifyXPForFavoredClass( a_oCharacter, nXP );

    nXP = SEI_ModifyXPForECL( a_oCharacter, nXP );

    return nXP;

} // End SEI_ModifyXPForSubrace

int ku_GetClassBaseSkillPoints(int iCls) {
   return StringToInt(Get2DAString("classes","SkillPointBase",iCls));

}

int ku_GetModifierFromAbility(int ability) {
  ability = (ability / 2) - 5 ;
  return ability;
}

int KU_CalcAndGiveSkillPoints(object oPC)
{
  /*int i,j,sum=0,skill,cost;
  object oPC = GetPlaceableLastClickedBy();
  int HD = GetHitDice(oPC);
  int Class = 0;
  int perClass = 0;
  int Int = GetAbilityScore(oPC,ABILITY_INTELLIGENCE,TRUE);
  int iIntSkillPoints = 0;

  /// Levels
  for(j=HD; j>0; j--) {

    Class = NWNX_Creature_GetClassByLevel(oPC,j);
    perClass = 0;
    // Skills
    for(i=0;i<=27;i++) {
      skill = NWNX_Creature_GetSkillRankByLevel(oPC,j,i);
      if(skill != 0) {
        if(GetIsClassSkill(Class,i))
          cost = skill;
        else
          cost = skill * 2;
        sum = sum + cost;
        perClass = perClass + cost;
//        SendMessageToPC(oPC,"Level: "+IntToString(j)+
//                           ";Class: "+IntToString(Class)+
//                           ";Skill: "+IntToString(i)+" = "+IntToString(skill)+
//                           ";Cost: "+IntToString(cost));
      }
    }
//    SendMessageToPC(oPC,"Skills per class "+IntToString(j)+" : "+IntToString(perClass)+
//                       "; Int = "+IntToString(Int));

    iIntSkillPoints = iIntSkillPoints + ku_GetModifierFromAbility(Int);
    //  3x on level 1
    if(j == 1) {
      iIntSkillPoints = iIntSkillPoints + (3 * ku_GetModifierFromAbility(Int));
    }
    if(GetAbilityIncreaseByLevel(oPC,j) == ABILITY_INTELLIGENCE)
      Int--;
  }

  int class = GetClassByPosition(1,oPC);
  skill = ku_GetClassBaseSkillPoints(class) * (GetLevelByPosition(1,oPC) + 3);
  class = GetClassByPosition(2,oPC);
  if(class != CLASS_TYPE_INVALID)
    skill = skill + (ku_GetClassBaseSkillPoints(class) * (GetLevelByPosition(2,oPC)));

//  int Intelect = GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
  skill = skill + iIntSkillPoints;
//  int free = GetPCSkillPoints(oPC);
  int iDiff = skill - sum;

//  SendMessageToPC(oPC,"Skills total: "+IntToString(sum)+
//                    "; Skill should have: "+ IntToString(skill)+
//                    "; Free: "+IntToString(free)+
//                    "; Diff"+IntToString(iDiff));

  SetPCSkillPoints(oPC,iDiff);
                    */
  return 0;

}
