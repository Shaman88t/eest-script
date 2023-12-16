#include "subraces"
// melvik upava na novy zpusob nacitani soulstone 16.5.2009
#include "me_lib"

/*
    -povoli lvlup jedine ak hrac prehovoril s majstrom a ten mu to povolil
     prestup na dalsi lvl
    -pricom script potom testuje ci hrac nepodvadza (nedava si nasetrene body
     do statistik a ci nekombinuje zakazane povolania)

*/
void sy_relevel_retxp(object oPC, int nXpNow) {

 SetXP(oPC,nXpNow);
 DeleteLocalInt(oPC,"RELEVELING");

}

void sy_relevel(object oPC, int nLevel)
{
    //znizim mu XP na hranicu predosleho lvl a nasledne vratim povodne XP spet
    //tym sa zaruci relevel
    nLevel--;
    int nXP    = ((nLevel * (nLevel - 1)) / 2) * 1000;
    int nXpNow = GetXP(oPC);
    // mark to disable raising now
    SetLocalInt(oPC,"RELEVELING",TRUE);
    SetXP(oPC,nXP);

    // Zkontrolovat a dopocitat skillpointy
    KU_CalcAndGiveSkillPoints(oPC);

    DelayCommand(2.0f, sy_relevel_retxp(oPC,nXpNow));
}


//==============================================================================

//ak ma druhe povolanie hrac prestizne, tak vrati 1 ako vysledok
int sy_isPrestige(object oPC)
{
    int nClass = GetClassByPosition(2, oPC);
    if (nClass == CLASS_TYPE_ARCANE_ARCHER ||
        nClass == CLASS_TYPE_ASSASSIN ||
        nClass == CLASS_TYPE_BLACKGUARD ||
        nClass == CLASS_TYPE_DRAGON_DISCIPLE ||
        nClass == CLASS_TYPE_DWARVEN_DEFENDER ||
        nClass == CLASS_TYPE_DIVINE_CHAMPION ||
        //nClass == CLASS_TYPE_HARPER ||            //harper je vtip nie prestiz
        nClass == CLASS_TYPE_PALE_MASTER ||
        nClass == CLASS_TYPE_SHADOWDANCER ||
        nClass == CLASS_TYPE_SHIFTER ||
        nClass == CLASS_TYPE_WEAPON_MASTER
       ) return 1;
    return 0;
}

//==============================================================================

void main()
{
    //ziskam hraca a jeho level
    object oPC  = GetPCLevellingUp();
    int nLevel  = GetHitDice(oPC);
    object oTrainer = GetLocalObject(oPC, "JA_LVL_TRAINER");


    object oSoulStone = GetSoulStone(oPC);    //by jaara
    int oldClass = GetLocalInt(oSoulStone, "JA_LAST_CLASS");       //mohl umrit..
    int oldLevel = GetLocalInt(oSoulStone, "JA_LAST_LVL");

    //ziskam nejake potrebne premenne
    int nClass1 = GetClassByPosition(1, oPC);
    int nClass2 = GetClassByPosition(2, oPC);
    int nClass3 = GetClassByPosition(3, oPC);

    int classPos = 0;
    if(nClass1 == oldClass)
      classPos = 1;
    else if(nClass2 == oldClass)
      classPos = 2;

    //1. nesmie kombinovat 3 povolania
    if (nClass3 != CLASS_TYPE_INVALID)
    {
        AssignCommand(oTrainer,SpeakString("Nemuzes se ucit vice jak dvema povolanim!"));
        sy_relevel(oPC, nLevel);
        return;
    }

//    if(classPos != 0 && GetLevelByPosition(classPos, oPC) == oldLevel){
    if( (GetLevelByPosition(1, oPC) <= GetLocalInt(oSoulStone, "KU_LAST_LVL1") ) &&
        (GetLevelByPosition(2, oPC) <= GetLocalInt(oSoulStone, "KU_LAST_LVL2") ) &&
        (nClass1 == GetLocalInt(oSoulStone, "KU_LAST_CLASS1") )                  &&
        (nClass2 == GetLocalInt(oSoulStone, "KU_LAST_CLASS2") )                  ) {
        SendMessageToPC(oPC, "Protoze jsi umrel, je ti povoleno znovu nahazet level zadarmo a bez ucitele");
        return; //udelal znovu lvl
    }


    //ak trener nepovolil trenink alebo nastal pad serveru a hrac ma tu premennu
    //nastavenu na 0, tak vypisem chybovu hlasku
    if (GetLocalInt(oPC, "sy_allowlvl")==0)
    {
        SendMessageToPC(oPC, "</c>Pokud se chces neco noveho naucit, mel/a bys vyhledat vhodneho trenera.</c>");
        sy_relevel(oPC, nLevel);
        return;
    }

    //2. nesmie davat dualclass povolanie mnicha alebo paladina
    if ((nClass2 == CLASS_TYPE_MONK || nClass2 == CLASS_TYPE_PALADIN) ||
        ((nClass1 == CLASS_TYPE_MONK || nClass1 == CLASS_TYPE_PALADIN) && nClass2!=CLASS_TYPE_INVALID)
       )
    {
        AssignCommand(oTrainer,SpeakString("Pokud sis zvolil/a cestu mnicha a nebo paladina, nemuzes se ucit jinemu povolani."));
        sy_relevel(oPC, nLevel);
        return;
    }

    //3.
    //-povolanie c.2 nesmie mat vacsi pocet lvl ako povolanie c.1
    //-pricom tato podmienka neplati ak hrac dava prestizne levely do povolania az kym
    // prestizny level nieje >= 10
    //-a ak raz zacne prestizne nesmie sa vracat k povolaniu c.1 kym nezrobi 10lvl prestizneho
    int nIsPrestige = sy_isPrestige(oPC);
    int nLvl1       = GetLevelByPosition(1, oPC);
    int nLvl2       = GetLevelByPosition(2, oPC);
    /*if ((nLvl1 < nLvl2) && nIsPrestige==0)
    {
        //plati iba ak druhe povolanie nieje prestizne a ma viac lvl ako prve povolanie
        AssignCommand(oTrainer,SpeakString("Nemohu te naucit druhe povolani lepe, jak tvoje hlavni."));
        sy_relevel(oPC, nLevel);
        return;
    } */

    //4. nedovolit hracovi dat ine povolanie nez ma majster
    int oldClass1Lvl = GetLocalInt(oPC, "sy_class1_lvl");            //lvl pociatocne povolanie
    int misterClass = GetLocalInt(oPC, "sy_class_mistra");            //typ - povolanie majstra
    int class;
    if (oldClass1Lvl == nLvl1)                               //zistim ktore povolanie ziskalo lvl
        class = 2;            //1. zustalo stejne, muselo tedy povysit 2.
        else
        class = 1;
    if (GetClassByPosition(class, oPC) != misterClass)    //porovna majstrovo a hracove pridane povolanie
    {
        AssignCommand(oTrainer,SpeakString("Tomuhle povolani te nemohu naucit. Na to si najdi jineho ucitele a me nezdrzuj..."));
        sy_relevel(oPC, nLevel);
        return;
    }

    //5. ak ma hrac prestizne povolanie, a dal si teraz lvl do hlavneho povolania
    if ((nIsPrestige==1 && class==1) && nLvl2<10)
    {
        //a prestizne povolanie nema este minimalne 10lvl tak vypis pokus o podvod
        AssignCommand(oTrainer,SpeakString("Musis dosahnout ve svem prestiznim povolani alespon 10. urovne, aby ses mohl/a vratit ke tvemu puvodnimu povolani."));
        sy_relevel(oPC, nLevel);
        return;
    }

    //6. test vysky skilov
    int nSkill, nSkillPC, nLoop;
    for (nLoop=0;nLoop<27;nLoop++)
    {
        //zadefinujem retazec hladanej premennej na hracovy o vyske skilu
        //zistim aktualnu vysku skilu a porovnam s tou pred levelom
        nSkill = GetSkillRank(nLoop, oPC, TRUE);
        nSkillPC = GetLocalInt(oPC, "sy_skill"+IntToString(nLoop));

        //ak je rozdiel vacsi ako 1 bod, tak hrac podvadza a da sa relevel
        //if ((nSkill-nSkillPC)>1)   //by jaara
        if ((nSkill-nSkillPC)>3)
        {
           AssignCommand(oTrainer,SpeakString("Pri kazdem treninku mohu zlepsit tve dovednosti maximalne o tri stupne."));
           sy_relevel(oPC, nLevel);
           return;
        }
    }

    //zistim ci ma hrac potrebne peniaze na lvlup
    //musim to testovat tu az ked uspesne potvrdi level, az tak sa odcitaju
    //zlataky, tak som rozhodol
    int nLvlCost = GetLocalInt(oPC, "sy_gp_cost");
    if (GetGold(oPC)<nLvlCost)
    {
        AssignCommand(oTrainer,SpeakString("Ty nemas "+IntToString(nLvlCost)+" zlatych?! To je moje cena. Dokud nebudes mit na zaplaceni, tak te nic noveho nenaucim!"));
        sy_relevel(oPC, nLevel);
        return;
    }
    AssignCommand(oTrainer, TakeGoldFromCreature(nLvlCost, oPC, TRUE));

    //zmazem docasne premenne na hracovi
    DeleteLocalInt(oPC, "sy_class_mistra");
    DeleteLocalInt(oPC, "sy_class1_lvl");
    DeleteLocalInt(oPC, "sy_gp_cost");
    DeleteLocalInt(oPC, "sy_allowlvl");
    for (nLoop = 0;nLoop<27;nLoop++) DeleteLocalInt(oPC, "sy_skill"+IntToString(nLoop));

    //uspesna sprava ked hrac naklika level
    AssignCommand(oTrainer,SpeakString("Blahopreji ti! Byl/a jsi skvelym zakem. Naucil/a ses vse, co bylo potreba, ani jsem to nemusel opakovat. Muzes jit, az naberes dostatek zkusenosti na dalsi trenink, tak vis, kde me najdes. Mej se!"));

    SetLocalInt(oSoulStone, "JA_LAST_CLASS", misterClass);       //by jaara
    SetLocalInt(oSoulStone, "JA_LAST_LVL", GetLevelByPosition(class, oPC));
    SetLocalInt(oSoulStone, "KU_LAST_LVL1", GetLevelByPosition(1, oPC));
    SetLocalInt(oSoulStone, "KU_LAST_LVL2", GetLevelByPosition(2, oPC));
    SetLocalInt(oSoulStone, "KU_LAST_CLASS1", GetClassByPosition(1, oPC));
    SetLocalInt(oSoulStone, "KU_LAST_CLASS2", GetClassByPosition(2, oPC));

    Subraces_LevelUpSubrace( oPC ); // uprava vlastnosti subrasy zavislych na levelu

}
