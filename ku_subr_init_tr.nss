#include "subraces"

void main()
{
  object a_oCharacter = GetLocalObject(OBJECT_SELF,"KU_CHARAKTER");
  int b_IncludeItems = GetLocalInt(OBJECT_SELF,"KU_INCLUDE_ITEMS");
  SEI_InitSubraceTraits( a_oCharacter, b_IncludeItems );
}
