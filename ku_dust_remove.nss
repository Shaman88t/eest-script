/* Function remove dust from curently equiped armor
 *
 */

#include "ku_libbase"

void main()
{
  object oPC = GetPCSpeaker();
  KU_ChangeArmorDust(oPC,GetItemInSlot(INVENTORY_SLOT_CHEST,oPC));
}
