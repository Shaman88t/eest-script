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

#include "racial_t_const"
#include "nwnx_creature"
// melvik upava na novy zpusob nacitani soulstone 16.5.2009
#include "me_lib"

// **************************************************************
// ** Constants
// **********************
// Placeable, ktery se stara o nastaveni vlastnosti subras zavisle na prostredi
string KU_SUBRACES_AREA_FIELD     = "KU_SUBR_AREA";

// Tag placeablu, ktery se stara o nastaveni vlastnosti subras zavisle na prostredi
string KU_SUBRACES_AREA_TAG     = "ku_subraces_area";

// The Field name for setting if was a day or night
string KU_SUBR_DAYNIGHT     = "KU_SUBR_DAYNIGHT";

void SEI_InitSubraces()
{
    object oAreaEffect = GetObjectByTag(KU_SUBRACES_AREA_TAG);
    SetLocalObject(GetModule(),KU_SUBRACES_AREA_FIELD,oAreaEffect);

} // End SEI_InitSubraces


// **************************************************************
// ** Subrace data functions
// **********************

// Returns if is character from underdark.
//
int KU_GetIsFromUnderdark( object a_oCharacter )
{
    int iRacialType = GetRacialType(a_oCharacter);
    if (
        (iRacialType == RACIAL_TYPE_DROW) ||
        (iRacialType == RACIAL_TYPE_DUERGAR) ||
        (iRacialType == RACIAL_TYPE_SVIRFNEBLIN)

    )
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
} // End

// Remove the effects from the character if it isn't a subrace effect.
//
void SEI_RemoveEffect( object a_oCharacter, effect a_eEffect )
{

    object oMod = GetModule();
    object oAreaEffect = GetLocalObject(oMod,KU_SUBRACES_AREA_FIELD);
    object oCreator = GetEffectCreator( a_eEffect );
    if( oCreator != oAreaEffect )
    {
        RemoveEffect( a_oCharacter, a_eEffect );
    }

} // End SEI_RemoveEffect


// Remove the effects from the character if it isn't a subrace effect.
//
void SEI_RemoveEffects( object a_oCharacter )
{
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
void SEI_RemoveSubraceEffects( object a_oCharacter)
{

    object oMod = GetModule();
    object oAreaEffect = GetLocalObject(oMod,KU_SUBRACES_AREA_FIELD);

    // Go through all effects on the character.
    effect eEffect = GetFirstEffect( a_oCharacter );
    object oCreator;
    while( GetIsEffectValid( eEffect ) )
    {
        oCreator = GetEffectCreator( eEffect );
        if(oCreator == oAreaEffect )
        {
            RemoveEffect( a_oCharacter, eEffect );
        }
        eEffect = GetNextEffect( a_oCharacter );

    } // End while

} // End SEI_RemoveSubraceEffects


void SEI_ApplyEffectToObject(effect a_eEffect, object a_oTarget)
{
    object oMod = GetModule();
    object oAreaEffect = GetLocalObject(oMod,KU_SUBRACES_AREA_FIELD);
    AssignCommand( oAreaEffect,
        ApplyEffectToObject( DURATION_TYPE_PERMANENT, SupernaturalEffect( a_eEffect ), a_oTarget) );


} // End SEI_ApplyEffectToObject


// Remove blindness if character comes from light to dark

// Apply the area settings to the character.
//
void SEI_ApplyAreaSettings( object a_oCharacter, object oArea)
{
    int iIsUnderdarkRace =  KU_GetIsFromUnderdark(a_oCharacter) ;
    if (!iIsUnderdarkRace)
    {
        return;
    }
    int iUseSunBlindness = TRUE;
    string sAreaTag = GetTag(oArea);
    string sAreaName = GetName(oArea);

    /*
    //Underdark
    if (iUseSunBlindness)
    {
        if (GetSubString(sAreaName,0,1)=="*")
        {
            iUseSunBlindness = FALSE;
        }
    }
    //Interior
    if (iUseSunBlindness)
    {
        if (GetIsAreaInterior(oArea))
        {
            iUseSunBlindness = FALSE;
        }
    }     */
    int iLocType = GetLocalInt(oArea,"JA_LOC_TYPE");                              //Povrch 1, podtemno 2, interiery systemove lokace 0
    if (iLocType != 1)
    {
        iUseSunBlindness = FALSE;
    }

    //System areas
    if (iUseSunBlindness)
    {
        if (sAreaTag == "VitejtevThalii")
        {
            iUseSunBlindness = FALSE;
        }
    }

    //Dusk/Night
    if (iUseSunBlindness)
    {
        if ((GetIsDusk()) || (GetIsNight()))
        {
            iUseSunBlindness = FALSE;
        }
    }

    //Apply
    if (iUseSunBlindness)
    {
        SEI_ApplyEffectToObject(EffectBlindness(),a_oCharacter );
    }
    else
    {
        SEI_RemoveSubraceEffects(a_oCharacter);
    }
} // End SEI_ApplyAreaSettings


// Set spacial traits to a character when the characters enters an area.
//
void SEI_EnterArea( object a_oCharacter, object oArea, )
{

    // If we have something to work with.
    if( GetIsObjectValid( a_oCharacter ) )
    {
        // Apply the settings to the character.
        SEI_ApplyAreaSettings( a_oCharacter, oArea );
    } // End if

} // End SEI_EnterArea

/*
 * Check if changed day to night or night to day
 */
void me_SubraceModuleHeartbeat(object oPC)
{
    object oMod = GetModule();
    object oAreaEffect = GetLocalObject(oPC,KU_SUBRACES_AREA_FIELD);

    int iPrevDayNight = GetLocalInt(oMod, KU_SUBR_DAYNIGHT);
    int bIsLight = ( GetIsDay() || GetIsDawn() );

    // changed day/night
    if ( bIsLight != iPrevDayNight ) {
        object a_oArea;
        a_oArea = GetArea( oPC );
        AssignCommand( oAreaEffect, SEI_ApplyAreaSettings( oPC, a_oArea));
    }
    SetLocalInt(oPC, KU_SUBR_DAYNIGHT,bIsLight);
}

// Reads the character's subrace field and sets the corresponding traits
// on the character.
//
void SEI_InitSubraceTraits(object a_oCharacter)
{

    object oMod = GetModule();
    object oAreaEffect = GetLocalObject(oMod,KU_SUBRACES_AREA_FIELD);
    AssignCommand(oAreaEffect,SEI_ApplyAreaSettings( a_oCharacter, GetArea(a_oCharacter)));
}








