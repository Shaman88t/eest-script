// condicional jestli je to otrok
/*
 * release Kucik 06.01.2008
 */
#include "ja_inc_frakce"


int StartingConditional()
{
  object oPC = GetPCSpeaker();
  if( getFaction(oPC) == OTROK )
    return TRUE;
  else
    return FALSE;
}
