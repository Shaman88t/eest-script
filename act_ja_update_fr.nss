#include "ja_inc_frakce"

void main()
{
    object oActivator = GetItemActivator();

    updateAllPCs();

    SendMessageToPC(oActivator, "Frakce pro vsechny postavy aktualizovany");
}
