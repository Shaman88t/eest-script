// * Script pro artefakty
// * Tokeny: 50 - jmeno, 51 - pocet zbyvajicich casti, 52 - cena artefaktu


void main()
{
    object oPC = GetPCSpeaker();
    object oMod = GetModule();
    object oKovadlina = GetNearestObjectByTag("ig_art_kovadlina");
    object oItem = GetFirstItemInInventory(oKovadlina);

    float fFacing = GetFacing(OBJECT_SELF);
    int i = 1;
    int x = 1;
    int y = 1;
    int nArt;
    string sResRef = GetResRef(oItem);
    string sFoundedResRef;

    DeleteLocalInt(OBJECT_SELF, "art_status");
    DeleteLocalInt(OBJECT_SELF, "art_num");
    DeleteLocalInt(OBJECT_SELF, "art_price");

// * pokud je v kovadline artefakt, zjistime jeho cislo - nArt
    while (oItem != OBJECT_INVALID) {
        while (GetLocalString(oMod, "artefact_part_" + IntToString(x) + "_" + IntToString(y)) != "") {
            while ((sFoundedResRef = GetLocalString(oMod, "artefact_part_" + IntToString(x) + "_" + IntToString(y))) != "") {
                if ((sResRef == sFoundedResRef) && GetIdentified(oItem)) {
                    nArt = x;
                }
                y++;
            }
            y = 1;
            x++;
        }
        oItem = GetNextItemInInventory(oKovadlina);
    }

// * zjistime pocet casti v kovadline - nOwn
    if (nArt) {

        int nOwn = 0;
        y = 1;

        while ((sFoundedResRef = GetLocalString(oMod, "artefact_part_" + IntToString(nArt) + "_" + IntToString(y))) != "") {
            oItem = GetFirstItemInInventory(oKovadlina);
            while (oItem!=OBJECT_INVALID) {
                 if ((sFoundedResRef == GetResRef(oItem)) && GetIdentified(oItem)) {
                    nOwn++;
                 }
                 oItem = GetNextItemInInventory(oKovadlina);
            }
            y++;
        }

// * nNumOfParts = celkovy pocet casti artefaktu
// * nPrice = cena artefaktu
// * sResRef = ResRef vysledneho artefaktu

        int nNumOfParts = y-1;
        int nPrice = GetLocalInt(oMod, "artefact_" + IntToString(nArt) + "_price");
        string sResRef = GetLocalString(oMod,"artefact_" + IntToString(nArt));

// * Vytvorime artefakt oArtefact na kovari, pro zjisteni jmena a nastavime UNDROPPABLE
        object oArtefact = CreateItemOnObject(sResRef, OBJECT_SELF);
        SetDroppableFlag(oArtefact, FALSE);

        SetCustomToken(50,(GetName(oArtefact) + "</c>"));
        SetCustomToken(51,IntToString(nNumOfParts-nOwn));
        SetCustomToken(52,IntToString(nPrice));

        DestroyObject(oArtefact);

// * Pokud je artefakt kompletni
        if (nNumOfParts == nOwn) {
            SetLocalFloat(OBJECT_SELF, "art_facing", fFacing);
            SetLocalInt(OBJECT_SELF, "art_status", 2);
            SetLocalInt(OBJECT_SELF, "art_num", nArt);
            SetLocalInt(OBJECT_SELF, "art_price", nPrice);
        }
// * Pokud neni artefakt kompletni
        else {
            SetLocalInt(OBJECT_SELF, "art_status", 1);
        }

    }


}
