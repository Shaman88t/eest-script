#include "ku_libbase"
#include "subraces"


void main()
{
 object oPC = GetEnteringObject();
 if(GetIsDM(oPC))
   return;
 ku_OnClientEnter( oPC ); // Inicializace eXPiciho systemu pri loginu hrace.
 Subraces_InitSubrace( oPC ); //Inicializace subrasy
}
