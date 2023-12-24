// condicional jestli je rasa drow/aristocrat / pritel podtemna
/*
 * release Kucik 06.01.2008
 */
#include "ja_inc_frakce"
#include "subraces"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  return Subraces_GetIsCharacterFromUnderdark(oPC);
}
