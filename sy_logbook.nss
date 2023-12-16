/*
    Original verzia z NWN Vault
    Pre Thaliu prelozil a poupravil Sylmael

    buguje v multiplayeri ked skusam prenasat knihu medzi hracmi alebo ked
    kopirujem predmet spusta sa vzdy tento event
    -skusil som zmazat OnActivated - x2_mod_def_act
*/

#include "x2_inc_switches"

location GetInFront(location lLocation)
{
  float fFacing = GetFacingFromLocation(lLocation);
  vector vPos = GetPositionFromLocation(lLocation);

  vPos.x = vPos.x + 2.0*cos(fFacing);
  vPos.y = vPos.y + 2.0*sin(fFacing);

  return Location(GetAreaFromLocation(lLocation), vPos, GetFacingFromLocation(lLocation) + 180);

}

void main()
{
  int iEvent = GetUserDefinedItemEventNumber();
  if (iEvent == X2_ITEM_EVENT_ACTIVATE)
  {
    object oActivatedItem = GetItemActivated();
    object oActivator     = GetItemActivator();

    SendMessageToPC(oActivator,"<cx  >Otvoril si knihu</c>");

    // Setup the LogBookAvatar location.
    location lLogBookAvatar = GetInFront(GetLocation(oActivator));

    // Create LogBookAvatar object
    object oLogBookAvatar = CreateObject(OBJECT_TYPE_CREATURE, "sy_logbook_npc", lLogBookAvatar, FALSE);

    // Store the LogBook object on the avatar for future reference.
    SetLocalObject(oLogBookAvatar, "oLogBook", oActivatedItem);

    // Store the LogBook activator on the avatar for future reference.
    SetLocalObject(oLogBookAvatar, "oActivator", oActivator);

    // Start the LogBookAvatar conversation.
    AssignCommand(oActivator, ActionStartConversation(oLogBookAvatar, "sy_con_logbook", TRUE));

    //In the conversation script when the conversation ends, the LogBookAvatar is destroyed.
  }
}
