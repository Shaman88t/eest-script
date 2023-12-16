void main()
{
object torch     = GetObjectByTag("Hansova_pochoden");
object leva_ruka = GetItemInSlot(INVENTORY_SLOT_LEFTHAND);

if(GetIsNight()){
if(leva_ruka == OBJECT_INVALID){
ClearAllActions();
ActionEquipItem(torch, INVENTORY_SLOT_LEFTHAND);
ActionRandomWalk();
}
}

if(GetIsDay()){
if(leva_ruka != OBJECT_INVALID){
ClearAllActions();
ActionUnequipItem(leva_ruka);
ActionRandomWalk();
}
}
}
