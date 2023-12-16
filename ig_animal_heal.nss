// * Nastaveni pravdepodobnosti ve scriptu x3_name_gen
// * Nutne vlozit podminku do OnSpawn a OnDamage scriptu
// *
// * Urcita sance, ze zvire bude nemocne nebo nejak poraneno,
// * tj. napriklad Cerny medved *vypada nemocne*. Zvire muze
// * vylecit pouze druid a to jakymkoliv lecivym kouzlem. Za
// * odmenu jsou mu prideleny XP a podle hodu se vypise hlaska
// * ze bylo zvire vyleceno. Pokud na vylecene zvire druid
// * nebo jeho pritelicek zautoci, ziskane XP se zase odectou.


void main()
{
  object oCaster = GetLastSpellCaster();
  int nIsHeal;

  int nSpell = GetLastSpell();

  if (GetLocalObject(OBJECT_SELF,"IG_ANIMAL_HEALER")!=OBJECT_INVALID) {

    object oHealer = GetLocalObject(OBJECT_SELF,"IG_ANIMAL_HEALER");
    object oLastDamager = GetLastDamager(OBJECT_SELF);
    object oMaster = GetMaster(GetLastDamager(OBJECT_SELF));

    if((oLastDamager == oHealer) || (oHealer == oMaster)) {

        int nXP = GetLocalInt(OBJECT_SELF,"IG_ANIMAL_XP");

        SendMessageToPC(oCaster,"===========================");
        SendMessageToPC(oHealer,"Jednas v rozporu s presvedcenim.");
        SendMessageToPC(oCaster,"===========================");

        SetXP(oHealer,GetXP(oHealer)-nXP);
        SetLocalInt(OBJECT_SELF,"IG_ANIMAL_XP", 0);
        SetLocalObject(OBJECT_SELF,"IG_ANIMAL_HEALER",OBJECT_INVALID);
    }
   }

   switch(nSpell) {
    case SPELL_CURE_LIGHT_WOUNDS:
    case SPELL_CURE_MINOR_WOUNDS:
    case SPELL_CURE_MODERATE_WOUNDS:
    case SPELL_CURE_SERIOUS_WOUNDS:
    case SPELL_CURE_CRITICAL_WOUNDS:
    case SPELL_HEAL:
    case SPELL_HEALING_CIRCLE:
    case SPELL_MASS_HEAL:
    nIsHeal = 1;
    break;
   }

   int nIsIll = GetLocalInt(OBJECT_SELF,"IG_ANIMAL_ILL");
   if (nIsHeal == TRUE && nIsIll) {

     if (GetLevelByClass(CLASS_TYPE_DRUID, oCaster) > 0) {
        int nRoll = Random(20)+1;
        int nXP = (nRoll*3)+10;
        string sMsg;
        switch (nRoll) {

            case 1:
            case 2: sMsg = "Nejprve si te zvire neduverive prohlizelo, ale nakonec se nechalo osetrit.";
            break;

            case 3:
            case 4: sMsg = "Zvire melo jen odrenou packu, po chvili uklidnovani se ti povedlo skrabanec zacelit.";
            break;

            case 5:
            case 6: sMsg = "Na boku jsi nasel krvavy sram, zrejme od souboje s jinym zviretem. Po vyleceni je zvire ocividne klidnejsi.";
            break;

            case 7:
            case 8: sMsg = "Po chvilce se ti povedlo najit mensi zraneni. Nyni zvire vypada spokojene.";
            break;

            case 9:
            case 10: sMsg = "Jak snadno se nekde zachyti drap a kolik bolesti to zpusobi. Tva pomoc prisla vhod.";
            break;

            case 11:
            case 12: sMsg = "Osklive zraneni bylo videt uz z dalky, chvilka pece a zvireti je hned lepe.";
            break;

            case 13:
            case 14: sMsg = "Jen kratkou chvili ti trvalo, nez jsi nasel ostry kaminek v pacce. Pacient zase vesele odbehl.";
            break;

            case 15:
            case 16: sMsg = "Zvire se pravdepodobne nakazilo ze zkazeneho jidla, diky tve pomoci bude brzy v poradku.";
            break;

            case 17:
            case 18: sMsg = "Vyhladovele zvire se dalo poznat snadno, osetreni cumaku ti netrvalo dlouho a zvire se muze zase v klidu nazrat.";
            break;

            case 19:
            case 20: sMsg = "Zkusene se ti povedlo osetrit skrabanec blizko oka, zvire se na tebe vdecne diva.";
            break;
        }


        SendMessageToPC(oCaster,"===========================");
        SendMessageToPC(oCaster,sMsg);
        SendMessageToPC(oCaster,"===========================");

        GiveXPToCreature(oCaster,nXP);
        SetName(OBJECT_SELF,GetLocalString(OBJECT_SELF,"IG_ANIMAL_NAME"));

        SetLocalInt(OBJECT_SELF,"IG_ANIMAL_ILL", 0);
        SetLocalInt(OBJECT_SELF,"IG_ANIMAL_XP", nXP);
        SetLocalObject(OBJECT_SELF,"IG_ANIMAL_HEALER",oCaster);
     }
     else {
        SendMessageToPC(oCaster,"===========================");
        SendMessageToPC(oCaster,"Netusis jak zvireti pomoci.");
        SendMessageToPC(oCaster,"===========================");
     }
   }

}
