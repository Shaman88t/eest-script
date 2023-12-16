// condicional jestli neni rasa duergar
/*
 * release Kucik 11.01.2008
 */

#include "subraces"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  if(Subraces_IsCharacterOfSubrace(oPC, SUBRACE_DWARF_DUERGAR) )
    return FALSE;
  else
    return TRUE;
}
