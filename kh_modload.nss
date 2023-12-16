////////////////////////////////////////////////////////////////////////////////
//
// Thalie Drogy
//
// meno: kh_modload
// autor: Michael G. Janicki
// datum: 05 February 2003
//
//  This file indicates the method for establishing addictive
//  item records in your module.  Each addictive item you want
//  to have should have a block as below which defines the
//  various parameters for the addiction.  Included as part
//  of the example are 2 addictive items with varying properties
//  for you to test and experiment with.
//
////////////////////////////////////////////////////////////////////////////////

#include "kh_include"

void main()
{
    struct AddictiveItem aItem;

    // Haunspeir
    aItem.sItemTag = "Haunspeir";
    aItem.sCureTag = "AddictionCure";
    aItem.sNewAddictMsg = "Stal si sa zavyslim na droge Haunspeir";
    aItem.sOldAddictMsg = "Tvoja zavyslost na droge Haunspeir sa posilnila";
    aItem.sWithdrawalMsg = "Tvoje telo a mysel chce dalsiu davku drogy Haunspeir";
    aItem.sCureMsg = "Uspesne si sa vyliecil zo zavyslosti na droge Haunspeir";
    aItem.nNeedHours = 23;
    aItem.nWorsenHours = 0;
    aItem.nTimesToOverdose = 0;
    aItem.nAddictionDC = 8;
    aItem.nWithdrawalDC = 15;
    aItem.nOverdoseDC = 1;
    CreateMonkey(aItem);

    // Kammarth
    aItem.sItemTag = "Kammarth";
    aItem.sCureTag = "AddictionCure";
    aItem.sNewAddictMsg = "Stal si sa zavyslim na droge Kammarth";
    aItem.sOldAddictMsg = "Tvoja zavyslost na droge Kammarth sa posilnila";
    aItem.sWithdrawalMsg = "Tvoje telo a mysel chce dalsiu davku drogy Kammarth";
    aItem.sCureMsg = "Uspesne si sa vyliecil zo zavyslosti na droge Kammarth";
    aItem.nNeedHours = 13;
    aItem.nWorsenHours = 1;
    aItem.nTimesToOverdose = 0;
    aItem.nAddictionDC = 15;
    aItem.nWithdrawalDC = 19;
    aItem.nOverdoseDC = 1;
    CreateMonkey(aItem);

    // Mordayn Vapor
    aItem.sItemTag = "MordaynVapor";
    aItem.sCureTag = "AddictionCure";
    aItem.sNewAddictMsg = "Stal si sa zavyslim na droge Mordayn Vapor";
    aItem.sOldAddictMsg = "Tvoja zavyslost na droge Mordayn Vapor sa posilnila";
    aItem.sWithdrawalMsg = "Tvoje telo a mysel chce dalsiu davku drogy Mordayn Vapor";
    aItem.sCureMsg = "Uspesne si sa vyliecil zo zavyslosti na droge Mordayn Vapor";
    aItem.nNeedHours = 5;
    aItem.nWorsenHours = 3;
    aItem.nTimesToOverdose = 0;
    aItem.nAddictionDC = 18;
    aItem.nWithdrawalDC = 20;
    aItem.nOverdoseDC = 1;
    CreateMonkey(aItem);

    // Rhul
    aItem.sItemTag = "Rhul";
    aItem.sCureTag = "AddictionCure";
    aItem.sNewAddictMsg = "Stal si sa zavyslim na droge Rhul";
    aItem.sOldAddictMsg = "Tvoja zavyslost na droge Rhul sa posilnila";
    aItem.sWithdrawalMsg = "Tvoje telo a mysel chce dalsiu davku drogy Rhul";
    aItem.sCureMsg = "Uspesne si sa vyliecil zo zavyslosti na droge Rhul";
    aItem.nNeedHours = 6;
    aItem.nWorsenHours = 1;
    aItem.nTimesToOverdose = 0;
    aItem.nAddictionDC = 15;
    aItem.nWithdrawalDC = 17;
    aItem.nOverdoseDC = 1;
    CreateMonkey(aItem);

    // Sezarad Root
    aItem.sItemTag = "SezaradRoot";
    aItem.sCureTag = "AddictionCure";
    aItem.sNewAddictMsg = "Stal si sa zavyslim na droge Sezarad Root";
    aItem.sOldAddictMsg = "Tvoja zavyslost na droge Sezarad Root sa posilnila";
    aItem.sWithdrawalMsg = "Tvoje telo a mysel chce dalsiu davku drogy Sezarad Root";
    aItem.sCureMsg = "Uspesne si sa vyliecil zo zavyslosti na droge Sezarad Root";
    aItem.nNeedHours = 23;
    aItem.nWorsenHours = 0;
    aItem.nTimesToOverdose = 0;
    aItem.nAddictionDC = 10;
    aItem.nWithdrawalDC = 13;
    aItem.nOverdoseDC = 1;
    CreateMonkey(aItem);

    // Ziran
    aItem.sItemTag = "Ziran";
    aItem.sCureTag = "AddictionCure";
    aItem.sNewAddictMsg = "Stal si sa zavyslim na droge Ziran";
    aItem.sOldAddictMsg = "Tvoja zavyslost na droge Ziran sa posilnila";
    aItem.sWithdrawalMsg = "Tvoje telo a mysel chce dalsiu davku drogy Ziran";
    aItem.sCureMsg = "Uspesne si sa vyliecil zo zavyslosti na droge Ziran";
    aItem.nNeedHours = 3;
    aItem.nWorsenHours = 2;
    aItem.nTimesToOverdose = 0;
    aItem.nAddictionDC = 18;
    aItem.nWithdrawalDC = 20;
    aItem.nOverdoseDC = 1;
    CreateMonkey(aItem);

    return;
}

