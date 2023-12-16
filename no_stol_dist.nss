void main()
{
int NO_DEBUG = FALSE;
object no_oPC = GetLastDisturbed();
object no_Item = GetInventoryDisturbItem();

if (GetInventoryDisturbType()== INVENTORY_DISTURB_TYPE_REMOVED) {

string no_added = GetLocalString(no_Item,"no_added");

if (NO_DEBUG == TRUE) SendMessageToPC(no_oPC,"no_oPC = " + GetName(no_oPC) );
if (NO_DEBUG == TRUE) SendMessageToPC(no_oPC,"no_added = " + no_added);


//pro testovani offline: if  ( (no_added != GetName(no_oPC)) & (no_added != "") ) {
//if  ( (no_added != GetName(no_oPC)) & (no_added != "") ) {
/////   pridana 26.2: sy_mulica - zabijelo to tazne zvirata :D
if  ( (no_added != GetName(no_oPC)) & (no_added != "") & (GetStringLeft(GetTag(no_oPC),9)== "sy_mulica")) {
    ActionCastSpellAtObject(SPELL_GREATER_DISPELLING,no_oPC,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE);
    ActionCastSpellAtObject(SPELL_INVISIBILITY_PURGE,no_oPC,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDispelMagicAll(40),no_oPC);
    DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCurse(5, 5, 5, 5, 5, 5),no_oPC,RoundsToSeconds(5)));
    DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE),no_oPC));
    DelayCommand(1.0,ActionCastSpellAtObject(SPELL_DOOM,no_oPC,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
    //vypneme stealth mode
    SetActionMode(no_oPC,ACTION_MODE_STEALTH,0);

    RemoveEffect(no_oPC,EffectInvisibility(INVISIBILITY_TYPE_IMPROVED));
    RemoveEffect(no_oPC,EffectInvisibility(INVISIBILITY_TYPE_NORMAL));
    RemoveEffect(no_oPC, EffectSanctuary(1));

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_MOVE_SILENTLY,50),no_oPC,RoundsToSeconds(5));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_HIDE,50),no_oPC,RoundsToSeconds(5));
                }



if  ( (no_added != GetName(no_oPC)) & (no_added != "") & (GetStringLeft(GetTag(no_oPC),9)!= "sy_mulica")) {
// kdyz to nejni stejne PC + to nejni prvni otevriajici PC
    if (NO_DEBUG == TRUE) SendMessageToPC(no_oPC,"(no_added != no_oPC) & (GetName(no_last_dist) != nic)  " );
//    SetPCDislike(no_oPC,GetLocalObject(OBJECT_SELF,"no_last_dist"));
    //nastavime dislike
    FloatingTextStringOnCreature("Strazim se nelibi, jak obchodujes ! ",no_oPC,TRUE );
    SendMessageToAllDMs("//Nomis kontrolni script// postava:" + GetName(no_oPC)+ " se pokusila odebrat vec ze stolku, ktery tam dala postava :"+no_added+ " v lokaci:" + GetName(GetArea(no_oPC)) );
    //spadne na zem
    AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0,RoundsToSeconds(5)));
    //na 10 sekund ho znehybnime
    DelayCommand(1.0,AssignCommand(no_oPC, SetCommandable(FALSE)));
    DelayCommand(10.0,AssignCommand(no_oPC, SetCommandable(TRUE)));
    //trochu ho vydispellujem
    //ActionCastSpellAtObject(SPELL_GREATER_DISPELLING,no_oPC,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE);
    //ActionCastSpellAtObject(SPELL_INVISIBILITY_PURGE,no_oPC,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE);
    ActionCastSpellAtObject(SPELL_GREATER_DISPELLING,no_oPC,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE);
    ActionCastSpellAtObject(SPELL_INVISIBILITY_PURGE,no_oPC,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDispelMagicAll(40),no_oPC);
    DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCurse(5, 5, 5, 5, 5, 5),no_oPC,RoundsToSeconds(5)));
    DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE),no_oPC));

    DelayCommand(1.0,ActionCastSpellAtObject(SPELL_DOOM,no_oPC,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));

    //vypneme stealth mode
    SetActionMode(no_oPC,ACTION_MODE_STEALTH,0);

    RemoveEffect(no_oPC,EffectInvisibility(INVISIBILITY_TYPE_IMPROVED));
    RemoveEffect(no_oPC,EffectInvisibility(INVISIBILITY_TYPE_NORMAL));
    RemoveEffect(no_oPC, EffectSanctuary(1));

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_MOVE_SILENTLY,50),no_oPC,RoundsToSeconds(5));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_HIDE,50),no_oPC,RoundsToSeconds(5));

    int pokusy = GetLocalInt(no_oPC,"no_pokusy_o_kradeni_ze_stolku");
    SetLocalInt(no_oPC,"no_pokusy_o_kradeni_ze_stolku",pokusy+1);

    SendMessageToPC(no_oPC,IntToString(pokusy+1) +". vystraha, jestli dosahnes 3, bude tva postava usmrcena strazemi !");
    if (pokusy >1) {
    FloatingTextStringOnCreature("Strazim zabili " + GetName(no_oPC) +"za opakovane kradeze  ",no_oPC,TRUE );
    SendMessageToAllDMs("//Nomis kontrolni script// postava:" + GetName(no_oPC)+ " se uz 3x pokousela nekomu neco ukrast ze stolku. Proto byla usmrcena strazi,najdes ji u rohateho :D " );
    DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(500,DAMAGE_TYPE_MAGICAL),no_oPC));
                        }
        // vec zkopirujeme zpatky do stolku a pak smazem tu co si vzalo no_oPC do inventare.
    CopyItem(no_Item,OBJECT_SELF,TRUE);
    DestroyObject(no_Item);

    }
/// pro testovani /// if ( (no_added == GetName(no_oPC)) || (no_added == "")  ) {
if ( (no_added == GetName(no_oPC)) || (no_added == "")  ) {
    if (NO_DEBUG == TRUE) SendMessageToPC(no_oPC,"else" );
    SetLocalString(no_Item,"no_added", GetName(no_oPC));
    DelayCommand(30.0,SetLocalString(no_Item,"no_added",""));
    if (NO_DEBUG == TRUE)DelayCommand(30.0,SendMessageToAllDMs("Nulujem veci z predmetu:"+ GetName(no_Item)));
  if (NO_DEBUG == TRUE)DelayCommand(30.0,SendMessageToPC(no_oPC,"Nulujem veci z predmetu:"+ GetName(no_Item)));
        }


}// removed
if (GetInventoryDisturbType()== INVENTORY_DISTURB_TYPE_ADDED) {
    if (NO_DEBUG == TRUE) SendMessageToPC(no_oPC,"ADDED" );
SetLocalString(no_Item,"no_added", GetName(no_oPC));
DelayCommand(30.0,SetLocalString(no_Item,"no_added",""));
 if (NO_DEBUG == TRUE)DelayCommand(30.0,SendMessageToAllDMs("Nulujem veci z predmetu:"+ GetName(no_Item)));
  if (NO_DEBUG == TRUE)DelayCommand(30.0,SendMessageToPC(no_oPC,"Nulujem veci z predmetu:"+ GetName(no_Item)));
}

}
