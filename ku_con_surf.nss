// condicional jestli je rasa z povrchu
/*
 * release Kucik 06.01.2008
 */

#include "subraces"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int iSubrace = Subraces_GetCharacterSubrace( oPC );

  if( Subraces_GetIsCharacterFromUnderdark(oPC ) != 1 ) {
    return TRUE;
  }
  else {
    return FALSE;
  }
}
