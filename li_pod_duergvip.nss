// condicional jestli je rasa duergar / pritel podtemna
/*
 * release Kucik 06.01.2008
 */
#include "ja_inc_frakce"
#include "subraces"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  if(GetRacialType(oPC)==RACIAL_TYPE_DUERGAR)
    return TRUE;
  else
    return FALSE;
}
