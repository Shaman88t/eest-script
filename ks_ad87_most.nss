object oPC, oWP, oItem, oArmor;
int nHP, nOdl, nSil, nObr;
void Pad();

void main()
{
oPC = GetEnteringObject(); //postava vlitnuvsi na trigger
oWP = GetObjectByTag("wp_" + GetTag(OBJECT_SELF)); //waypoint oznacujici misto dopadu
oItem = GetFirstItemInInventory(oPC); //prvni object v invu postavy
oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC); //armor postavy
nHP = GetCurrentHitPoints(oPC); //ulozi aktualni HP postavy
nOdl = GetAbilityModifier(ABILITY_CONSTITUTION, oPC); //zjisti bonus za odolnost postavy

object oSound = GetObjectByTag("PraskaniDreva");
SoundObjectPlay(oSound);
DelayCommand(2.0f, Pad()); //o vterinu pozdeji se stane samotny pad
}
void Pad()
{
if(d100() >= 30) //d100() je funkce stostenne kostky - pokud padne 1, provest vse ve slozenych zavorkach
{
AssignCommand(oPC, ClearAllActions(TRUE)); //zrusi PC vsechny akce (beh, boj, cokoliv)
AssignCommand(oPC, ActionJumpToObject(oWP)); //teleportne okamzite PC na Waypoint

//vypocet zraneni
if(GetItemACValue(oArmor) >= 6) //pokud postava nese AC6 a vyssi...
{
nHP = nHP / ((d4() + 1) * 2); //zredukuje hp bud na 1/4, 1/6, 1/8, nebo 1/10
}
else
{
nHP = nHP / (d4() + 1); //zredukuje hp bud na 1/2, 1/3, 1/4, nebo 1/5
}

//sance na zlomeninu na zaklade odolnosti postavy
nSil = (d10() - nOdl); //vypocet postihu na silu (min 0, max 10 bodu postih - zalezi na desetistenne kostce a odolnosti)
nObr = (d10() - nOdl); //vypocet postihu na obratnost - ten samy, jako u sily - to ovsem neznamena, ze bude stejny, protoze pro kazdy postih se hazi znova kostkou

//aplikovat efekty zlomenin na postavu - aplikovat jako Extraordinary effect, coz znamena, ze nemuze byt dispellnuto, ale zrusi se spankem
ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_STRENGTH, nSil)), oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_DEXTERITY, nObr)), oPC);

//aplikovat vypoctene zraneni
ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nHP), oPC);

while(GetIsObjectValid(oItem)) //cyklus, ohraniceny slozenymi zavorkami, ktery se opakuje, dokud neprojede vsechny itemy v invu PC
{ //zacatek cyklu
if(GetBaseItemType(oItem) == BASE_ITEM_POTIONS && d3() == 1) //pookud je item typu POTION (lektvar) a zaroven na trojstenne kostce padne 1
{DestroyObject(oItem);} //znici se dany lektvar - z pravdepodobnosti vyplyva, ze pri pouziti trojclenne kostky by se melo znicit cca tretina lektvaru v invu
oItem = GetNextItemInInventory(oPC); //preskocit na dalsi item v invu
} //konec cyklu - tady se to dycky zastavi a vrati na zacatek cyklu a takhle to cykluje, dokud to neprojede v invu vsechny veci

//postava s sebou flakne na zem
AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 0.3f, 5.0f));

//nakonec to napise zlutou zpravu postave
SendMessageToPC(oPC, "*spadl si z velké výšky..v batohu jsi našel spoušt v podobì støepu a rozmoèeneho jídla, ale vzhledem k výšce která je nad tebou mužeš byt rad že jsi naživu.*");
}
}
