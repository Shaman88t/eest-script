// condicional jestli je rasa duergar
/*
 * release Kucik 06.01.2008
 */

#include "subraces"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  if(Subraces_IsCharacterOfSubrace(oPC, SUBRACE_DWARF_DUERGAR) )
    return TRUE;
  else
    return FALSE;
}
