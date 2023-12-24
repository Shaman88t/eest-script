//
//  NWSubraces
//
//  Basic subrace functionality
//
//  (c) Shir'le E. Illios, 2002 (shirle@drowwanderer.com)
//
////////////////////////////////////////////////////////
/*
 * rev. Kucik 06.01.2008 pridana funkce pro zjisteni, zda je postava z podtemna
 * Kucik 27.05.2008 Oprava - mazani nastaveni lokace pri relogu
 *
 */

// Include the subrace definitions and the subraces code.
#include "sei_subraces"
#include "aps_include"
//#include "sei_xp"   //removed by Kucik



//  END KUCIK

// **************************************************************
// ** Event functions
// **********************

// Initializes the available subraces and everything that is needed to properly
// run this script.
// Call this function in the OnModuleLoad event of the module.
//
void Subraces_InitSubraces();


// Sets the default area settings. This is so you don't have to do it for every area.
// Call this function in the OnModuleLoad event of the module.
//  ARGUMENTS:
//      a_nSettings = What the default settings for the area are.
//                    There is light-level:
//                      AREA_DARK   - The area is considered dark.
//                      AREA_LIGHT  - The area is considered daylight.
//                      AREA_SUN    - The light level depends on the sun (day/night).
//                    And there is the 'ground' setting:
//                      SEI_AREA_UNDERGROUND    - The area is underground.
//                      SEI_AREA_ABOVEGROUND    - The area is above ground.
//                    Add the setting for lightness to that of ground for the
//                    final setting, i.e.:
//                      Subraces_SetDefaultAreaSettings( AREA_DARK + SEI_AREA_UNDERGROUND );
//                    for if most of the areas in the module are dark and underground.
//
void Subraces_SetDefaultAreaSettings( int a_nSettings );


// Initializes the subrace for character a_oCharacter.
// Call this function in the OnClientEnter event of the module.
//  ARGUMENTS:
//      a_oCharacter    = The character to initialize the subrace for
//
void Subraces_InitSubrace( object a_oCharacter );


// Modifies the character's subrace attributes on a character's level up.
// Call this function in the OnPlayerLevelUp event of the module.
//  ARGUMENTS:
//      a_oCharacter    = The character to level up.
//
void Subraces_LevelUpSubrace( object a_oCharacter );


// Makes sure that the subrace is set correctly again when the character respawns.
//  ARGUMENTS:
//      a_oCharacter    = The character respawning.
//
void Subraces_RespawnSubrace( object a_oCharacter );


// Does some subrace specific things when a character enters a new area.
// Call this function in the OnEnter event of every area.
//  ARGUMENTS:
//      a_oCharacter    = The character to enter the new area.
//      a_nSettings     = The light and (under)ground settings of the area.
//                        Don't specify this argument to use module defaults.
//
void Subraces_OnEnterArea( object a_oCharacter, int a_nSettings = 0 );




// **************************************************************
// ** Useage functions
// **********************


// Returns if is character from underdark
// return 1 if yes
//        0 if not
//  ARGUMENTS:
//      a_oCharacter    = The character which we want (assumed valid)
//
int Subraces_GetIsCharacterFromUnderdark( object a_oCharacter );



// Change the area settings dependent traits for the character.
// This function can for instance be called in the OnEnter and OnExit scripts
// of a trigger to create an area where the settings differ from the rest of the
// area. (Like a room of sunlight in an otherwise lightless dungeon).
//  ARGUMENTS:
//      a_oCharacter    = The character the settings affect.
//      a_nSettings     = What these differing settings are. Leave away to reset
//                        to the area defaults.
//
void Subraces_ChangeAreaSettings( object a_oCharacter, int a_nSettings = 0 );


// A subrace safe version of BioWare's RemoveEffect function. Removes effect
// in such a way as not to touch te subraces (i.e. te subraces are safe).
//  ARGUMENTS:
//      a_oCreature     = The creature to remove the effect from.
//      a_eEffect       = The effect to remove from the creature.
//
void Subraces_SafeRemoveEffect( object a_oCreature, effect a_eEffect );

// heartbeat jen pro jedno pc
// pridano melvik > optimalizace
void Subraces_ModuleHeartBeatPC(object oPC);




// **************************************************************
// ** Function definitions
// **********************

// Initializes the available subraces and everything that is needed to properly
// run this script.
//
void Subraces_InitSubraces()
{
    SEI_InitSubraces();
}


// Initializes the subrace for character a_oCharacter.
//
void Subraces_InitSubrace( object a_oCharacter )
{

}


// Modifies the character's subrace attributes on a character's level up.
//
void Subraces_LevelUpSubrace( object a_oCharacter )
{

}


// Makes sure that the subrace is set correctly again when the character respawns.
//
void Subraces_RespawnSubrace( object a_oCharacter )
{

}


// Does some subrace specific things when a character enters a new area.
//
void Subraces_OnEnterArea( object a_oCharacter, int a_nSettings = 0 )
{

    object oArea = GetArea(a_oCharacter);
    SEI_EnterArea( a_oCharacter, oArea );
}

// Does some subrace specific things when a character enters a new area.
//
void KU_Subraces_OnEnterArea( object a_oCharacter, int a_nSettings = 0 )
{
    object oArea = GetArea(a_oCharacter);
    object oMod = GetModule();
    object oExecutor = GetLocalObject(oMod,KU_SUBRACES_AREA_FIELD);
    AssignCommand( oExecutor, SEI_EnterArea( a_oCharacter, oArea ) );
}

// Returns if the character is from underdark.
//
int Subraces_GetIsCharacterFromUnderdark( object a_oCharacter )
{
    return KU_GetIsFromUnderdark( a_oCharacter );
}


// Change the area settings dependent traits for the character.
//
void Subraces_ChangeAreaSettings( object a_oCharacter, int a_nSettings = 0 )
{
    SEI_ApplyAreaSettings( a_oCharacter, GetArea(a_oCharacter) );
}


// A subrace safe version of BioWare's RemoveEffect function.
//
void Subraces_SafeRemoveEffect( object a_oCreature, effect a_eEffect )
{
    SEI_RemoveEffect( a_oCreature, a_eEffect );
}


void Subraces_ModuleHeartBeatPC(object oPC)
{
    me_SubraceModuleHeartbeat(oPC);
}

int Subraces_GetIsSubraceEffect(effect eBad) {

    int iSpellId = GetEffectSpellId(eBad);
    if(iSpellId >= 10999 && iSpellId <= 12000) {
      return TRUE;
    }

    return FALSE;
}

int Subrace_DMOnlyAllowed(object oPC, int iLoud=TRUE)
{


  switch(GetRacialType(oPC))
  {
    case RACIAL_TYPE_AASIMAR:
    case RACIAL_TYPE_TIEFLING:
     if(iLoud) {
        SpeakString("Tato rasa je povolena jen se souhlasem DM. Pozadej DM, aby te vpustil do sveta.");
      }
      return TRUE;
    default: break;
  }

  return FALSE;
}

// SEI_TODO: Added for development. Remove!
/*
void main ()
{
}
//*/

