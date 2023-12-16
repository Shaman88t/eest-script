/*
    System meditace/modlitby
*/

#include "ja_inc_meditace"
#include "me_lib"


string getRestString(int type){
    switch(type){
        case 0: return "Opetovne budes moci spat za ";
        case 1: return "Opetovne budes moci meditovat za ";
        case 2: return "Tve modlitby budou vyslyseny az za ";
    }

    return "---CHYBA - REPORTUJ DM TENTO UDAJ: (ja_meditace:"+IntToString(type)+")---";
}

void finish(object oPC){

    if(GetCurrentAction(oPC) == ACTION_WAIT){   //uspech
        setMinutesAwake(oPC, "JA_MED_");
        SendMessageToPC(oPC, "Opet jsi nabyl svych schopnosti");

        int lastHP = GetCurrentHitPoints(oPC);
        ForceRest(oPC);
        int damage = GetCurrentHitPoints(oPC) - lastHP;
        if(lastHP > 0 && damage > 0){
            effect e = EffectDamage( damage, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_TWENTY);
            ApplyEffectToObject( DURATION_TYPE_INSTANT, e, oPC );
        }
    }
    else{
        SendMessageToPC(oPC, "Prerusil jsi sve soustredeni!");
    }
}

void RemoveAllSpells(object oPC){
    int i;
    int remain;
    for(i = 0; i<805; i++) {
        remain = 15;
        // Fuj! Hnusna pojistka proti zacykleni.
        while(GetHasSpell(i, oPC) && remain > 0) {
            DecrementRemainingSpellUses( oPC, i );
            remain--;
        }
    }
}

void main()
{

    object oPC = OBJECT_SELF;

    int restStyle = getRestStyle(oPC);
    if(restStyle == SPANEK){
        SendMessageToPC(oPC, "Pokud chces spat, zmackni R nebo klikni na ikonku spani.");
        return;
    }

    int length = 10 + 2 * GetHitDice(oPC); // v minutach (tazich)
    int awake = getMinutesAwake(oPC, "JA_MED_");

    if(length <= awake){
        string act;
        int animation;

        if(restStyle == MEDITACE){
            act = "*medituje*";
            animation = ANIMATION_LOOPING_MEDITATE;
            RemoveAllSpells(oPC);

        }
        else if(restStyle == MODLITBA){
            act = "*modli se*";
            animation = ANIMATION_LOOPING_WORSHIP;
        }
        object oSoul = GetSoulStone(oPC);
        int iAltAnim = GetLocalInt(oSoul,"KU_MEDITATE_ANIM");
        if(iAltAnim > 0) {
          animation = iAltAnim;
        }

        FloatingTextStringOnCreature( act, oPC, FALSE );
        AssignCommand(oPC, PlayAnimation( animation, 1.0, 39.5 ));
        AssignCommand(oPC, ActionWait(1.0));

        DelayCommand( 40.0f, finish(oPC) );
    }
    else{
        SendMessageToPC(oPC, getRestString(restStyle)+IntToString(length-awake)+" minut.");
        return;
    }
}
