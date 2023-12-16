// condicional jestli je rasa drow/aristocrat / pritel podtemna
/*
 * release Kucik 06.01.2008
 */
#include "ja_inc_frakce"
#include "subraces"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  if( (Subraces_IsCharacterOfSubrace(oPC, SUBRACE_ELF_DROW_ARISTOCRAT) ) ||
      (Subraces_IsCharacterOfSubrace(oPC, SUBRACE_ELF_DROW           ) ) ||
      (getFaction(oPC) == PRITEL                                       ) )
    return TRUE;
  else
    return FALSE;
}
