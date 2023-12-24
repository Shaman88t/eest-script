// condicional jestli neni rasa duergar
/*
 * release Kucik 11.01.2008
 */

#include "subraces"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  if(GetRacialType(oPC)== RACIAL_TYPE_DUERGAR)
    return FALSE;
  else
    return TRUE;
}
