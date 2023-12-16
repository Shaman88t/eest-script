/////////////////nomis_b create 6.rijen 2008 ///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

void no_vylec (object no_oPC, object no_Item)
{
if  ( GetLocalInt(no_oPC,"no_mast_boj") == FALSE ) {
// kdyz je to false, tak cele overovani uz delat nemusim.

int no_akce = GetCurrentAction(no_oPC);
if (no_akce != 65535 )  {    //  or = ||
 // nevim proc zrovna tohle cislo, ale kdyz je ulne v klidu, tak je to proste tohle cislo ): k cemu patri, to fakt nevim
                            // SetLocalInt(no_Item,"no_leceni",FALSE);
                            SetLocalInt(no_oPC,"no_mast_boj",TRUE);
                            SendMessageToPC(no_oPC," Prerusil jsi leceni.");
                            }

if (GetLocalInt(no_oPC,"no_mast_boj") == FALSE)
                      { effect no_lecim = EffectVisualEffect(IP_CONST_CASTSPELL_CURE_MINOR_WOUNDS_1,FALSE);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,no_lecim,no_oPC);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(8),no_oPC);
                        SetLocalInt(no_oPC,"no_mast_leceni",TRUE);
                       }

}// jestli to vubec probehne

}// konec no_vylec



void main()
{
if (GetResRef(GetItemActivated())=="no_mast_stre") {
//jinak se to spousti i pri blbem zvednuti ze zeme
object no_Item = GetItemActivated();
object no_oPC = GetItemActivator();
// ulozime pc

if  ( GetLocalInt(no_oPC,"no_mast_leceni") == TRUE ) {
     FloatingTextStringOnCreature("Nemuzes mast pouzit tak rychle po sobe ! ",no_oPC);
     effect no_dazed = EffectVisualEffect(IP_CONST_CASTSPELL_DAZE_1,FALSE);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,no_dazed,no_oPC,15.0);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDazed(),no_oPC,15.0);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSlow(),no_oPC,6.0);
     }

if  ( GetLocalInt(no_oPC,"no_mast_leceni") == FALSE ) {
// kdyz uz to nebezi, tka to spustime

//nastavime to tak, ze se momentalne lecime
SetLocalInt(no_oPC,"no_mast_leceni",TRUE);

int no_boj = FALSE; // na zacatek = false
SetLocalInt(no_oPC,"no_mast_boj",FALSE);
float no_delay = 0.0;

AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0,30.0));
// nastavime PC  aby si sedlo a pauzovalo na tech 1 kol = 60 sekund


ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSlow(),no_oPC,6.0);

DelayCommand(6.0,no_vylec(no_oPC, no_Item));
DelayCommand(12.0,no_vylec(no_oPC, no_Item));
DelayCommand(18.0,no_vylec(no_oPC, no_Item));
DelayCommand(24.0,no_vylec(no_oPC, no_Item));
DelayCommand(30.0,no_vylec(no_oPC, no_Item));
DelayCommand(36.0,no_vylec(no_oPC, no_Item));
DelayCommand(42.0,no_vylec(no_oPC, no_Item));
DelayCommand(48.0,no_vylec(no_oPC, no_Item));
DelayCommand(54.0,no_vylec(no_oPC, no_Item));
DelayCommand(60.0,no_vylec(no_oPC, no_Item));

/// tzn dohromady 10 x aktviace presne jak chtel Rejty.

DelayCommand(30.1,SetLocalInt(no_oPC,"no_mast_leceni",FALSE));
DelayCommand(30.1,SetLocalInt(no_oPC,"no_mast_boj",FALSE));
// na konci to musim nastavit, aby se to mohlo spustit znova


}// kdyz je aktivovanej pouze 1 predmet.

}// kdyz je predmet aktivovanej
}

