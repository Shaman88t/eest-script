// condicional jestli je PC zena, knezka Xi'An, aristocrat
/*
 * release Kucik 06.01.2008
 */

#include "subraces"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int iSubrace = GetRacialType( oPC );

  if( ( iSubrace == RACIAL_TYPE_DROW             ) &&
      ( GetDeity(oPC) == "Xi'An"                            ) &&
      ( GetGender(oPC) == GENDER_FEMALE                     ) &&
      ( ( GetClassByPosition(1,oPC) == CLASS_TYPE_CLERIC  ) ||
        ( GetClassByPosition(2,oPC) == CLASS_TYPE_CLERIC  ) ||
        ( GetClassByPosition(3,oPC) == CLASS_TYPE_CLERIC  ) ) )
    return TRUE;
  else
    return FALSE;
}
