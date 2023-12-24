// condicional jestli je rasa duergar
/*
 * release Kucik 06.01.2008
 */

#include "subraces"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  if(GetRacialType(oPC)==RACIAL_TYPE_DUERGAR)
    return TRUE;
  else
    return FALSE;
}
