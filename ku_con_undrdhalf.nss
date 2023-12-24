// condicional jestli je rasa z podtemna a neni o pulcik
/*
 * release Kucik 06.01.2008
 */

#include "subraces"

int StartingConditional()
{
  object oPC = GetPCSpeaker();

  if (Subraces_GetIsCharacterFromUnderdark(oPC ) == 1            )
    return TRUE;
  else
    return FALSE;
}
