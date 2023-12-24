// condicional jestli neni drow
/*
 * release Kucik 11.01.2008
 */

#include "subraces"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int subr = GetRacialType(oPC);
  if (subr != RACIAL_TYPE_DROW)
    return TRUE;
  else
    return FALSE;
}

