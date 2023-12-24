// condicional jestli je rasa drow/aristocrat
/*
 * release Kucik 06.01.2008
 */

#include "subraces"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  if(GetRacialType(oPC)==RACIAL_TYPE_DROW)
    return TRUE;
  else
    return FALSE;
}

