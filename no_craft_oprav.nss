void main()
{


//SendMessageToPC(GetLastOpenedBy(),"on_used");
//SetLocalInt(OBJECT_SELF,"no_MULTIKLIK",GetLocalInt(OBJECT_SELF,"no_MULTIKLIK")+1);
int CRAFT_PLACEABLE = FALSE;
object no_oPC = GetItemActivator();

if (GetTag(GetItemActivatedTarget())=="AlchemistsApparatus") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="no_keram") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="no_sleva") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="Loom") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="no_susak") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="no_spalek") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="no_platner") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="no_tr_koza") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="tc_alchemy_kotel") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="no_brusnykamen") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="no_kovadlina") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="X2_PLC_STUBE") CRAFT_PLACEABLE = TRUE;

if  ( GetIsObjectValid(GetItemActivatedTarget()) == FALSE )  {
FloatingTextStringOnCreature(" Neplatny cil !" ,no_oPC,FALSE);
            }
if  ( (CRAFT_PLACEABLE == FALSE))  {
FloatingTextStringOnCreature(" Tento objekt nemuze spravce dilny opravit" ,no_oPC,FALSE);
            }
if  ( GetIsObjectValid(GetItemActivatedTarget()) & (CRAFT_PLACEABLE == TRUE))  {

///////////// kdyby to udelal umyslne, toz ho aspon musi script objevit/////////

effect no_effect=GetFirstEffect(no_oPC);
while (GetIsEffectValid(no_effect))
   {
   if (GetEffectType(no_effect)==EFFECT_TYPE_INVISIBILITY) RemoveEffect(no_oPC,no_effect);
   if (GetEffectType(no_effect)==EFFECT_TYPE_IMPROVEDINVISIBILITY) RemoveEffect(no_oPC,no_effect);
   if (GetEffectType(no_effect)==EFFECT_TYPE_SANCTUARY) RemoveEffect(no_oPC,no_effect);
   no_effect=GetNextEffect(no_oPC);
   }

         FloatingTextStringOnCreature(" Safra je to znicene ! ",no_oPC,TRUE );
         ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_FIREBALL),GetItemActivatedTarget());
         DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SMOKE_PUFF),GetItemActivatedTarget()));
         DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION),GetItemActivatedTarget()));


         AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 4.0));
         AssignCommand(no_oPC, SetCommandable(FALSE));
         DelayCommand(1.0,AssignCommand(no_oPC, SetCommandable(TRUE)));
         ActionLockObject(GetItemActivatedTarget());
         location locForge = GetLocation(GetItemActivatedTarget());
         float    fForgeFacing =GetFacingFromLocation(locForge);
         object no_novapec = CreateObject(OBJECT_TYPE_PLACEABLE,GetResRef(GetItemActivatedTarget()),locForge,TRUE,"");
         ActionLockObject(no_novapec);
///////////prekopirujeme veci co nejsou tlacitky///////////////////////////////
         object  no_Item = GetFirstItemInInventory(GetItemActivatedTarget());

                 while (GetIsObjectValid(no_Item)) {

                        if (GetStringLeft(GetTag(no_Item),8) != "prepinac" ) {
                        CopyItem(no_Item,no_novapec,TRUE);
                         }
               // SendMessageToPC(GetLastOpenedBy(),"next item");
                no_Item = GetNextItemInInventory(GetItemActivatedTarget());
                 }
///////////prekopirujeme veci co nejsou tlacitky///////////////////////////////

         DestroyObject(GetItemActivatedTarget(),4.0);
         DelayCommand(2.0,ActionUnlockObject(no_novapec));

         DelayCommand(4.0,FloatingTextStringOnCreature(" Spravce dilny opravil " + GetName(GetItemActivatedTarget(),FALSE),no_oPC,TRUE ));
            }



}
