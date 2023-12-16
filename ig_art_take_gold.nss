void IntroAnimation(location locEffect) {
        object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
        DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_GOOD_HELP), OBJECT_SELF));
        DelayCommand(2.0, AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), oWeapon, 18.0));
        //DelayCommand(2.5,
        //ActionSpeakString("Dame se do toho!");
        //);
}
void AnvilAnimation(location locEffect) {
        float fDelay = 3.0;
        DelayCommand(3.0, PlayAnimation(ANIMATION_LOOPING_CUSTOM9, 1.0 , 9.0 + fDelay));
        DelayCommand(2.0 + fDelay, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_SPARKS_PARRY), locEffect));
        DelayCommand(2.8 + fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_LIGHTNING_S, FALSE), locEffect));
        DelayCommand(3.2 + fDelay, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_SPARKS_PARRY), locEffect));
        DelayCommand(4.5 + fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DISPEL, FALSE), locEffect));
        DelayCommand(5.0 + fDelay, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_SPARKS_PARRY), locEffect));
        DelayCommand(7.5 + fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WORD, FALSE), locEffect));
        DelayCommand(9.0 + fDelay, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_SPARKS_PARRY), locEffect));
        DelayCommand(11.0 + fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_LIGHTNING_S, FALSE), locEffect));
        DelayCommand(13.0 + fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH, FALSE), locEffect));

}

void GiveArtefact(int nArt, string sResRef, object oPC, object oMod) {

        if (GetIsObjectValid(CreateItemOnObject(sResRef,oPC))) {

            //* Vyjimka pro Dvojcata - jsou to 2 artefakty
            if (sResRef == "ry_art_dvvychsl1") {
               CreateItemOnObject("ry_art_dvvychsl2",oPC);
            }

            int y = 1;
            string sFoundedResRef;
            object oItem;
            object oKovadlina = GetNearestObjectByTag("ig_art_kovadlina");

            while ((sFoundedResRef = GetLocalString(oMod, "artefact_part_" + IntToString(nArt) + "_" + IntToString(y))) != "") {
                oItem = GetFirstItemInInventory(oKovadlina);
                while (oItem!=OBJECT_INVALID) {
                    if ((sFoundedResRef == GetResRef(oItem)) && GetIdentified(oItem)) {
                       DestroyObject(oItem);
                    }
                    oItem = GetNextItemInInventory(oKovadlina);
                }
                y++;
           }

        }

}

void main()
{
    object oPC = GetPCSpeaker();
    object oMod = GetModule();
    object oKovadlina = GetNearestObjectByTag("ig_art_kovadlina");
    object oItem = GetFirstItemInInventory(oKovadlina);

    int nPrice = GetLocalInt(OBJECT_SELF, "art_price");
    int nArt = GetLocalInt(OBJECT_SELF, "art_num");
    string sResRef = GetLocalString(oMod, "artefact_" + IntToString(nArt));

    if (GetGold(oPC) >= nPrice) {

        TakeGoldFromCreature(nPrice, oPC, TRUE);

        location locDefault = GetLocation(OBJECT_SELF);
        location locKovadlina = GetLocation(oKovadlina);
        float fKovFacing = GetFacingFromLocation(locKovadlina);
        vector vEffectPos = GetPositionFromLocation(locKovadlina);
        vEffectPos.z += 1.1;
        location locEffect = Location(GetAreaFromLocation(locKovadlina), vEffectPos, GetFacingFromLocation(locKovadlina) );

        AssignCommand(OBJECT_SELF, ActionMoveToObject(oKovadlina, FALSE, 0.1));
        AssignCommand(OBJECT_SELF, ActionDoCommand(IntroAnimation(locEffect)));
        AssignCommand(OBJECT_SELF, ActionSpeakString("Dame se do toho!"));
       //ActionDoCommand(SetFacing(fKovFacing - 180.0));
        AssignCommand(OBJECT_SELF, ActionDoCommand(AnvilAnimation(locEffect)));
        AssignCommand(OBJECT_SELF, DelayCommand(23.0, ActionMoveToLocation(locDefault)));
        AssignCommand(OBJECT_SELF, DelayCommand(24.0, ActionDoCommand(SetFacing(GetLocalFloat(OBJECT_SELF, "art_facing")))));
        AssignCommand(OBJECT_SELF, DelayCommand(25.0, ActionSpeakString("Tak a je to. *podava ti artefakt*")));
        AssignCommand(OBJECT_SELF, DelayCommand(26.0, ActionDoCommand(GiveArtefact(nArt, sResRef, oPC, oMod))));


    }
    else {
        SpeakString("Nemas dostatek zlata.");
    }
}
