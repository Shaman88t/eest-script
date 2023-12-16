#include "x2_inc_switches"

void main()
{
    int iEventNum = GetUserDefinedItemEventNumber();
    if (iEventNum == X2_ITEM_EVENT_ACTIVATE)
    {
        object oPaper = GetItemActivated();
        object oPlayer = GetItemActivator();

        SetLocalObject(oPlayer, "notes_currentobject", oPaper);

        AssignCommand(oPlayer, ClearAllActions());
        AssignCommand(oPlayer, ActionStartConversation(OBJECT_SELF, "sy_not_con_paper", TRUE, FALSE));
    }
}
