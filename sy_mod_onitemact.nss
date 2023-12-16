//Sylmaelov onItemActivateEvent pre custom veci
//volat z hlavneho eventu onItemActivate cez ExecuteScript

/*
    1-prazdna cutora
    2-plna cutora
    3-sviecka,stan
    4-pecene maso, jedlo..
    5-deka na sedenie
    6-
    7-farba
    8-zvukove emoty
    9-zviera domace
    X-lopata na vykopavanie/zakopavanie veci
*/

//#include "x2_inc_switches"
#include "me_pcneeds_inc"
void main()
{
    //zistim ktora vec sa pouzila
    object oItem = GetItemActivated();

    //zistim o aky typ custom veci ide
    int iItemType = GetLocalInt(oItem,"ItemType");
    if(!iItemType)
      if(GetTag(oItem)=="sy_cutora_empty") {
        iItemType=1;
        SetLocalString(oItem, "Vyzor","sy_cutora_full");
      }

    if (iItemType==1) //prazdna cutora
    {
        //zistim ci som blizko pitnej vody a ak ano naplnim cutoru
        string sVyzor   = GetLocalString(oItem, "Vyzor");
        object oPlayer  = GetItemActivator();
        int    iTypVody = GetLocalInt(oPlayer,"TypVody");

        //ak niesom pri vode tak mozem skoncit
        if (iTypVody==0)
        {
            FloatingTextStringOnCreature("Musis stat u vodneho zdroja.", oPlayer,TRUE);
            return;
        }

        //vytvorim cutoru a naplnim ju vodou (pocet pouziti,typ vody)
        object oPlnaCutora = CreateItemOnObject(sVyzor, oPlayer, 1, "");
        SetLocalInt(oPlnaCutora,"VodaType",iTypVody);
        int iMaxNaplni = GetLocalInt(oPlnaCutora,"MaxNaplni");
        SetLocalInt(oPlnaCutora,"AktNaplni",iMaxNaplni);

        //znicim prazdnu cutotu z invu
        DestroyObject(oItem, 0.0f);
        FloatingTextStringOnCreature("*Naplni cutoru*", oPlayer,TRUE);
        AssignCommand(oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_GET_LOW, 1.0, 3.0));
        return;
    }

    if (iItemType==2) //plna cutora
    {
        //ak stojim vo vode doplnim cutoru
        object oPlayer   = GetItemActivator();
        int    iVodaType = GetLocalInt(oPlayer,"TypVody");
        if (iVodaType>0)
        {
            SetLocalInt(oItem,"VodaType",iVodaType);
            int iMaxNaplni = GetLocalInt(oItem,"MaxNaplni");
            SetLocalInt(oItem,"AktNaplni",iMaxNaplni);
            SetName(oItem,"Plna cutora ("+IntToString(iMaxNaplni)+")");
            FloatingTextStringOnCreature("*Naplni cutoru*", oPlayer,TRUE);
            AssignCommand(oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_GET_LOW, 1.0, 3.0));
            return;
        }

        //lognem si z cutory
        int iAktNaplni = GetLocalInt(oItem,"AktNaplni");
            iVodaType  = GetLocalInt(oItem,"VodaType");

        AssignCommand(oPlayer, ActionPlayAnimation (ANIMATION_FIREFORGET_DRINK, 1.0, 3.0));

        if (iVodaType==1) {
            FloatingTextStringOnCreature("*Napijes se* Aaah, prijemne osviezujici.", oPlayer,TRUE);
            PC_ConsumeItValues(oPlayer,0.0,10.0,0.0);
        }
        if (iVodaType==2) {
            FloatingTextStringOnCreature("*Napijes se* Fuj, slana je!", oPlayer,TRUE);
            effect eEfx = EffectAbilityDecrease(ABILITY_CONSTITUTION,4);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,eEfx,oPlayer,0.0f);
        }
        if (iVodaType==3) {
            FloatingTextStringOnCreature("*Napijes se* Uff, nejak nechuti dobre.", oPlayer,TRUE);
            effect eEfx = EffectDisease(DISEASE_SHAKES);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,eEfx,oPlayer,0.0f);
        }

        iAktNaplni = iAktNaplni - 1;
        SetLocalInt(oItem,"AktNaplni",iAktNaplni);
        SetName(oItem,"Plna cutora ("+IntToString(iAktNaplni)+")");

        if (iAktNaplni==0)
        {
            //vytvorim prazdnu cutoru pre hraca
            string sVyzor = GetLocalString(oItem, "Vyzor");
            CreateItemOnObject(sVyzor, oPlayer, 1, "");
            FloatingTextStringOnCreature("Dosla ti voda.", oPlayer,TRUE);
            DestroyObject(oItem, 0.0f);
        }
        return;
    }

    //16.8.2006
    if (iItemType==3) //sviecka,stan,deka...
    {
        object   oPlayer = GetItemActivator();
        string   sVyzor  = GetLocalString(oItem,"Vyzor");
        vector   vPos    = GetPosition(oPlayer);
        float    fOsZ    = GetLocalFloat(oItem,"sy_osZ");
        vPos.z = vPos.z - fOsZ;
        location lPoz = Location(GetArea(oPlayer),vPos,GetFacing(oPlayer));

        object   oSvica  = CreateObject(OBJECT_TYPE_PLACEABLE,sVyzor,lPoz,FALSE,"");

        DestroyObject(oItem, 0.0f);
        return;
    }

    if (iItemType==4) //pecene maso, jedlo... vsetko co sa da jest
    {
        object oPlayer  = GetItemActivator();
        int    iNahodne = Random(3);

        if (iNahodne==0) FloatingTextStringOnCreature("Chrum chrum... chuti to dobre.", oPlayer,TRUE);
        if (iNahodne==1) FloatingTextStringOnCreature("Ehm, mirne nedopecene.", oPlayer,TRUE);
        if (iNahodne==2) FloatingTextStringOnCreature("No snad to preziju.", oPlayer,TRUE);

        //doplni hlad
        PC_ConsumeItValues(oPlayer,13.0,0.0,0.0);

        //vylieci n zivotov podla premennej vo veci
        int    iHeal = GetLocalInt(oItem, "KolkoLieci");
        effect eHeal = EffectHeal(iHeal);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPlayer);

        //vizualne znazorni kuzlo cure minor wounds
        effect eVisual = EffectVisualEffect(VFX_IMP_HEAD_HEAL);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVisual, oPlayer, 1.0);

        //zmaze pecene maso z inventara
        DestroyObject(oItem, 0.0f);
        return;
    }

    if (iItemType==5) //deky na sedenie
    {
        object   oPlayer = GetItemActivator();
        location lPoz    = GetLocation(oPlayer);
        string   sVyzor  = GetLocalString(oItem,"Vyzor");
        object   oDeka   = CreateObject(OBJECT_TYPE_PLACEABLE,sVyzor,lPoz,FALSE,"");

        FloatingTextStringOnCreature("*Polozi deku*", oPlayer,TRUE);

        //sadne na deku polozenu na zemi
        AssignCommand (oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_SIT_CROSS, 1.0, 10000.0));

        //zmazem deku z inventara hraca
        DestroyObject(oItem, 0.0f);
        return;
    }

    if (iItemType==7) //farba na kreslenie
    {
         object oPlayer = GetItemActivator();
         AssignCommand(oPlayer,ActionStartConversation(oPlayer,"sy_farba_dlg",TRUE,FALSE));
         return;
    }

    if (iItemType==8) //nove zvukove emoty
    {
        object oPlayer = GetItemActivator();
        AssignCommand(oPlayer,ActionStartConversation(oPlayer,"sy_emote_dlg",TRUE,FALSE));
        return;
    }

    if (iItemType==9) //zviera domace
    {
        object oPlayer  = GetItemActivator();

        //hladam ci uz hracove zviera existuje vo svete
        //ak ano oznamim mu to ale nebudem ho brat! nech si ho najde
        string sPetTag = GetLocalString(oItem,"sy_pettag");
        object oPet    = GetObjectByTag(sPetTag,0);
        if (oPet!=OBJECT_INVALID) {
            SendMessageToPC(oPlayer,"tvoje zvire je nekde tu v okoli");
            return;
        }

        //sumonne zviera-henchmana
        string sTag    = GetLocalString(oItem,"sy_zviera");
        string sMeno   = GetLocalString(oItem,"sy_zviera_meno");
        object oZviera = CreateObject(OBJECT_TYPE_CREATURE,sTag,GetLocation(oPlayer),TRUE,sPetTag);
        if (sMeno!="ziadne") SetName(oZviera,sMeno);
        SetLocalString(oZviera,"sy_majitel",GetName(oPlayer,TRUE));
        if (GetHenchman(oPlayer)==OBJECT_INVALID) AddHenchman(oPlayer,oZviera);
        return;
    }

    //upravena cnrShovel lopata aby slo s nou kopat
    if (GetTag(oItem)=="cnrShovel")
    {
        object   oPC  = GetItemActivator();
        object   oObj = GetItemActivatedTarget();
        location lPoz = GetItemActivatedTargetLocation();

        if (oObj!=OBJECT_INVALID)
        { //aktivoval vec v inventari - ide zakopat
            if ((GetObjectType(oObj)==OBJECT_TYPE_ITEM) && (oObj!=oItem))
            {
                //najdi najblizsi 4m vzdialeny bod zakopania ak je
                object oWP;
                oWP = GetNearestObjectByTag("sy_truhla_inv",oPC,1);
                //ak tento bod neni alebo vzdialenost od hraca je viac nez 4m
                if ((oWP==OBJECT_INVALID) || (GetDistanceBetween(oWP,oPC)>4.0f))
                {
                    //tak vytvorim novy bod
                    oWP = CreateObject(OBJECT_TYPE_PLACEABLE,"sy_truhla_inv",GetLocation(oPC),1,"");
                }
                //ulozim oznacenu vec pod zem
                int iVeci = GetLocalInt(oWP,"sy_veci");
                iVeci++;
                if (iVeci==10) {
                    SendMessageToPC(oPC,"Privela veci zakopavas chlapce!");
                    return;
                }
                SendMessageToPC(oPC,"Zakopal si "+GetName(oObj));
                CopyItem(oObj,oWP,TRUE);
                DestroyObject(oObj);
                SetLocalInt(oWP,"sy_veci",iVeci);
                AssignCommand(oPC, ActionPlayAnimation (ANIMATION_LOOPING_GET_LOW, 1.0, 3.0));
            } else
            {
                SendMessageToPC(oPC,"Toto nemozes zakopat");
            }
        } else
        { //aktivoval miesto kopania - ide vykopat
            object oWP = GetNearestObjectByTag("sy_truhla_inv",oPC,1);
            if ((oWP!=OBJECT_INVALID) && (GetDistanceBetween(oWP,oPC)<4.0f) && (GetArea(oWP) == GetArea(oPC)))
            {
                //nasiel som bod kopania ta vykopem truhlu!
                AssignCommand(oPC, ActionPlayAnimation (ANIMATION_LOOPING_GET_LOW, 1.0, 2.0));
                SendMessageToPC(oPC,"Nieco si nasiel. A je to truhla!");
                object oChest = CreateObject(OBJECT_TYPE_PLACEABLE,"sy_truhla",GetLocation(oWP),1,"");
                //a nahadzem do nej veci
                int iVeci = GetLocalInt(oWP,"sy_veci");
                object oVec = GetFirstItemInInventory(oWP);
                while (oVec!=OBJECT_INVALID) {
                    CopyItem(oVec,oChest,TRUE);
                    oVec = GetNextItemInInventory(oWP);
                }
                //nakoniec zmazem tajny objekt s vecami

                // add by melvik, oprava bugu: po zniceni zustavaly itemy z tajneho na zemi (dablovani), takze pridavam vymaz invu
                object oItemToDelete = GetFirstItemInInventory(oWP);
                while (oItemToDelete != OBJECT_INVALID)
                {
                    SetPlotFlag(oItemToDelete, FALSE);
                    WriteTimestampedLogEntry("Vykopana vec -" + GetName(oItemToDelete) + "- znicena. Vykopavac byl " + GetName(GetItemActivator()));
                    DestroyObject(oItemToDelete);
                    oItemToDelete = GetNextItemInInventory(oWP);
                }
                // add by melvik, oprava bugu: po zniceni zustavaly itemy z tajneho na zemi (dablovani), takze pridavam vymaz invu

                DestroyObject(oWP);
                AssignCommand(oPC, ActionPlayAnimation (ANIMATION_FIREFORGET_VICTORY1, 1.0, 3.0));
            } else
            {
                SendMessageToPC(oPC,"Kopes a kopes no nic si nenasiel");
                AssignCommand(oPC, ActionPlayAnimation (ANIMATION_LOOPING_GET_LOW, 1.0, 3.0));
            }
        }
        return;
    }
}
