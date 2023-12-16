// condicional jestli neni drow
/*
 * release Kucik 11.01.2008
 */

#include "subraces"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int subr = Subraces_GetCharacterSubrace(oPC);
  if( (subr != SUBRACE_ELF_DROW_ARISTOCRAT)  &&
      (subr != SUBRACE_ELF_DROW           ) )
    return TRUE;
  else
    return FALSE;
}

