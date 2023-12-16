// condicional jestli je rasa z podtemna ale zaroven neni drow/aristocrat/duergar
/*
 * release Kucik 06.01.2008
 */

#include "subraces"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int iSubrace = Subraces_GetCharacterSubrace( oPC );

  if( ( iSubrace != SUBRACE_ELF_DROW_ARISTOCRAT         ) &&
      ( iSubrace != SUBRACE_ELF_DROW                    ) &&
      ( iSubrace != SUBRACE_DWARF_DUERGAR               ) &&
      ( Subraces_GetIsCharacterFromUnderdark(oPC ) == 1 ) )
    return TRUE;
  else
    return FALSE;
}
