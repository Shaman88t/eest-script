// condicional jestli je rasa drow/aristocrat
/*
 * release Kucik 06.01.2008
 */

#include "subraces"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  if( (Subraces_IsCharacterOfSubrace(oPC, SUBRACE_ELF_DROW_ARISTOCRAT) ) ||
      (Subraces_IsCharacterOfSubrace(oPC, SUBRACE_ELF_DROW           ) ) )
    return TRUE;
  else
    return FALSE;
}

