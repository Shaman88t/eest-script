// condicional jestli je rasa z podtemna ale zaroven neni drow/aristocrat/duergar
/*
 * release Kucik 06.01.2008
 */

#include "subraces"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  if(GetRacialType(oPC)==RACIAL_TYPE_SVIRFNEBLIN)
    return TRUE;
  else
    return FALSE;
}
