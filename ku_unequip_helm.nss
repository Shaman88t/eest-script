void main()
{
  object oPC = GetPCSpeaker();
  object oHelm= GetItemInSlot(INVENTORY_SLOT_HEAD,oPC);

  AssignCommand(oPC,ActionUnequipItem(oHelm));

}
