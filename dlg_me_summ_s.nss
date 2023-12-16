
#include "zzdlg_main_inc"
#include "ja_lib"

// obtiznosti
const int BASE_PER_LVL = 5;   // jednotka obtiznosti za lvl (lvl * BASE_PER_LVL potom)
const int BASE_PLUS1LVL = 30; // lvl +1 monstrum povolani
const int BASE_PLUS2LVL = 60; // lvl +2 monstrum povolani
const int BASE_ALIGDIFF = 10; // jine presvedceni monstra

// menu
const string RESPONSE_PAGE = "spell_responses";

const string PAGE_MAIN = "main_page";

const string PAGE_SUMMON0 = "summon0_page";
const string PAGE_SUMMON1 = "summon1_page";
const string PAGE_SUMMON2 = "summon2_page";
const string PAGE_SUMMON3 = "summon3_page";
const string PAGE_SUMMON4 = "summon4_page";
const string PAGE_SUMMON5 = "summon5_page";
const string PAGE_SUMMON6 = "summon6_page";
const string PAGE_SUMMON7 = "summon7_page";
const string PAGE_SUMMON8 = "summon8_page";
const string PAGE_SUMMON9 = "summon9_page";

const string INSTRUCTIONS_SUBPAGE = "instructionsSubpage";

// Prototypes
void MainPageInit( );
void MainPageSelect( );

void Summon0Init();
void Summon0Select();
void Summon1Init();
void Summon1Select();
void Summon2Init();
void Summon2Select();
void Summon3Init();
void Summon3Select();
void Summon4Init();
void Summon4Select();
void Summon5Init();
void Summon5Select();
void Summon6Init();
void Summon6Select();
void Summon7Init();
void Summon7Select();
void Summon8Init();
void Summon8Select();
void Summon9Init();
void Summon9Select();


string setVarsToSummonOnPC(int iSpell , string sRefMon, string sRefIng, int iPen, int iMonAlig, object oPC, int iPCAlig,int iDel);

void OnInit( )
{
    dlgChangeLabelNext( "Dalsi strana");
    dlgChangeLabelPrevious( "Predchozi strana");
    dlgChangePage( PAGE_MAIN );
    dlgActivatePreservePageNumberOnSelection( );
}

// Create the page
void OnPageInit( string sPage )
{
    DeleteList( RESPONSE_PAGE, dlgGetSpeakingPC() );

    // PAGE INITIALIZATIONS START
    if( sPage == PAGE_MAIN ) MainPageInit( );
   // else if( sPage == PAGE_SUMMON0 ) Summon0Init( );
    else if( sPage == PAGE_SUMMON1 ) Summon1Init( );
    else if( sPage == PAGE_SUMMON2 ) Summon2Init( );
    else if( sPage == PAGE_SUMMON3 ) Summon3Init( );
    else if( sPage == PAGE_SUMMON4 ) Summon4Init( );
    else if( sPage == PAGE_SUMMON5 ) Summon5Init( );
    else if( sPage == PAGE_SUMMON6 ) Summon6Init( );
    else if( sPage == PAGE_SUMMON7 ) Summon7Init( );
    else if( sPage == PAGE_SUMMON8 ) Summon8Init( );
    else if( sPage == PAGE_SUMMON9 ) Summon9Init( );
    // PAGE INITIALIZATIONS END

    dlgSetActiveResponseList( RESPONSE_PAGE );
}

// Handles any selection.
void OnSelection( string sPage )
{
    if ( sPage == PAGE_MAIN ) MainPageSelect( );
    else if ( sPage == PAGE_SUMMON0 ) Summon0Select( );
    else if ( sPage == PAGE_SUMMON1 ) Summon1Select( );
    else if ( sPage == PAGE_SUMMON2 ) Summon2Select( );
    else if ( sPage == PAGE_SUMMON3 ) Summon3Select( );
    else if ( sPage == PAGE_SUMMON4 ) Summon4Select( );
    else if ( sPage == PAGE_SUMMON5 ) Summon5Select( );
    else if ( sPage == PAGE_SUMMON6 ) Summon6Select( );
    else if ( sPage == PAGE_SUMMON7 ) Summon7Select( );
    else if ( sPage == PAGE_SUMMON8 ) Summon8Select( );
    else if ( sPage == PAGE_SUMMON9 ) Summon9Select( );
}

// Reset
void OnReset( string sPage )
{

    dlgChangePage( PAGE_MAIN );
    dlgResetPageNumber( );
}

void OnAbort( string sPage )
{
    DeleteList( RESPONSE_PAGE, dlgGetSpeakingPC() );
}
void OnEnd( string sPage )
{
    DeleteList( RESPONSE_PAGE, dlgGetSpeakingPC() );
}

void OnContinue( string sPage, int iContinuePage )
{
}

// Message handler
void main()
{
    dlgOnMessage();
}

// Specific scripting starts here

// MAIN PAGE START
void MainPageInit( )
{
    dlgSetPrompt( "Otevrel jsi knihu..." + GetName(dlgGetSpeakingPC()));
  //  dlgAddResponseAction( RESPONSE_PAGE, "Povolej tvory 0" );
    dlgAddResponseAction( RESPONSE_PAGE, "Povolej tvory 1" );
    dlgAddResponseAction( RESPONSE_PAGE, "Povolej tvory 2" );
    dlgAddResponseAction( RESPONSE_PAGE, "Povolej tvory 3" );
    dlgAddResponseAction( RESPONSE_PAGE, "Povolej tvory 4" );
 /*   dlgAddResponseAction( RESPONSE_PAGE, "Povolej tvory 5" );
    dlgAddResponseAction( RESPONSE_PAGE, "Povolej tvory 6" );
    dlgAddResponseAction( RESPONSE_PAGE, "Povolej tvory 7" );
    dlgAddResponseAction( RESPONSE_PAGE, "Povolej tvory 8" );
    dlgAddResponseAction( RESPONSE_PAGE, "Povolej tvory 9" );   */

    dlgDeactivateResetResponse( );
    dlgActivateEndResponse( "Zavrit knihu" );
}

void MainPageSelect( )
{
    if ( dlgIsSelectionEqualToName( "Povolej tvory 0" ) ) dlgChangePage( PAGE_SUMMON0  );
    else if ( dlgIsSelectionEqualToName( "Povolej tvory 1" ) ) dlgChangePage( PAGE_SUMMON1  );
    else if ( dlgIsSelectionEqualToName( "Povolej tvory 2" ) ) dlgChangePage( PAGE_SUMMON2  );
    else if ( dlgIsSelectionEqualToName( "Povolej tvory 3" ) ) dlgChangePage( PAGE_SUMMON3  );
    else if ( dlgIsSelectionEqualToName( "Povolej tvory 4" ) ) dlgChangePage( PAGE_SUMMON4  );
    else if ( dlgIsSelectionEqualToName( "Povolej tvory 5" ) ) dlgChangePage( PAGE_SUMMON5  );
    else if ( dlgIsSelectionEqualToName( "Povolej tvory 6" ) ) dlgChangePage( PAGE_SUMMON6  );
    else if ( dlgIsSelectionEqualToName( "Povolej tvory 7" ) ) dlgChangePage( PAGE_SUMMON7  );
    else if ( dlgIsSelectionEqualToName( "Povolej tvory 8" ) ) dlgChangePage( PAGE_SUMMON8  );
    else if ( dlgIsSelectionEqualToName( "Povolej tvory 9" ) ) dlgChangePage( PAGE_SUMMON9  );
}
// MAIN PAGE PAGE END

// SUMMON 0  TYPE PAGE START
void Summon0Init(){
    object oPC = dlgGetSpeakingPC();
    dlgAddResponseAction( RESPONSE_PAGE, "Zadnou, at rozhodne osud.." );
    // zle monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "zloun" );
    }
    // neutralni monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "neutrous" );
    }
    // hodne monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "hodnous" );
    }

    dlgActivateResetResponse( "Zpet" );
    dlgActivateEndResponse( "Zavrit knihu" );
;}
void Summon0Select(){
    if ( dlgIsSelectionEqualToName( "zloun" ) ) setVarsToSummonOnPC(0 , "", "", 10, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "neutrous" ) )setVarsToSummonOnPC(0 , "", "", 10, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "hodnous" ) ) setVarsToSummonOnPC(0 , "", "", 10, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Zadnou, at rozhodne osud.." ) ) setVarsToSummonOnPC(0 , "", "", 0, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 1);
    SetName(dlgGetSpeakingPC(), IntToString(GetLocalInt(dlgGetSpeakingPC(),"MESUMMON0iPen")));
    dlgEndDialog( );
    SpeakString(IntToString(GetLocalInt(dlgGetSpeakingPC(),"MESUMMON0iPen")));

;}
// SUMMON 0  TYPE PAGE END


void Summon1Init(){
    object oPC = dlgGetSpeakingPC();
    dlgAddResponseAction( RESPONSE_PAGE, "Zadnou, at rozhodne osud.." );
    // zle monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "Styrga *1*" );        // ry_sum_1_d
        dlgAddResponseAction( RESPONSE_PAGE, "Stonozka *1*" );           // ry_sum_1_a
        dlgAddResponseAction( RESPONSE_PAGE, "Krenshar *2*" );        // ry_sum_2_a
        dlgAddResponseAction( RESPONSE_PAGE, "Bazinna zmije *2*" );           // ry_sum_2_b
        dlgAddResponseAction( RESPONSE_PAGE, "Plivnik *3*" );             // ry_sum_3_a
        dlgAddResponseAction( RESPONSE_PAGE, "Mlady medvedvyr *3*" );  // ry_sum_3_b
    }
    // neutralni monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "Ohnivy brouk *1*" ); // ry_sum_1_f
        dlgAddResponseAction( RESPONSE_PAGE, "Zemni elemental *1*" );  // ry_sum_1_e
        dlgAddResponseAction( RESPONSE_PAGE, "Vrrk *2*" );             // ry_sum_2_d
        dlgAddResponseAction( RESPONSE_PAGE, "Vzdusny element *2*" );  // ry_sum_2_f
        dlgAddResponseAction( RESPONSE_PAGE, "Obri pavouk *3*" );      // ry_sum_3_c
        dlgAddResponseAction( RESPONSE_PAGE, "Zemni mephit *3*" );     // ry_sum_3_d
    }
    // hodne monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "Nebeska sova *1*" );      // ry_sum_1_b
        dlgAddResponseAction( RESPONSE_PAGE, "Nebesky vlk *1*" );      // ry_sum_1_c
        dlgAddResponseAction( RESPONSE_PAGE, "Nebeska puma *2*" );     // ry_sum_2_e
        dlgAddResponseAction( RESPONSE_PAGE, "Grig *2*" );  // ry_sum_2_c
        dlgAddResponseAction( RESPONSE_PAGE, "Mizici pes *3*" );             // ry_sum_3_f
        dlgAddResponseAction( RESPONSE_PAGE, "Nebesky divocak *3*" );  // ry_sum_3_e
    }
    dlgActivateResetResponse( "Zpet" );
    dlgActivateEndResponse( "Zavrit knihu" );
;}

void Summon1Select(){

    int iLVL = 1;
    int iP0 = BASE_PER_LVL * iLVL;
    int iP1 = iP0 + BASE_PLUS1LVL;
    int iP2 = iP0 + BASE_PLUS2LVL;

         if ( dlgIsSelectionEqualToName( "Styrga *1*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_1_d", "", iP0, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Stonozka *1*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_1_a", "", iP0, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Krenshar *2*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_2_a", "", iP1, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Bazinna zmije *2*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_2_b", "", iP1, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Plivnik *3*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_3_a", "", iP2, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Mlady medvedvyr *3*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_3_b", "", iP2, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);

    else if ( dlgIsSelectionEqualToName( "Ohnivy brouk *1*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_1_f", "", iP0, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Zemni elemental *1*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_1_e", "", iP0, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Vrrk *2*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_2_d", "", iP1, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Vzdusny element *2*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_2_f", "", iP1, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Obri pavouk *3*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_3_c", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Zemni mephit *3*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_3_d", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);

    else if ( dlgIsSelectionEqualToName( "Nebeska sova *1*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_1_b", "", iP0, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Nebesky vlk *1*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_1_c", "", iP0, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Nebeska puma *2*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_2_e", "", iP1, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Grig *2*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_2_c", "", iP1, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Mizici pes *3*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_3_f", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Nebesky divocak *3*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_3_e", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);


    else if ( dlgIsSelectionEqualToName( "Zadnou, at rozhodne osud.." ) )
    {
        setVarsToSummonOnPC(iLVL , "", "", 0, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 1);
    }
    dlgEndDialog( );
;}
void Summon2Init(){
    object oPC = dlgGetSpeakingPC();
    dlgAddResponseAction( RESPONSE_PAGE, "Zadnou, at rozhodne osud.." );
    // zle monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "Krenshar *2*" );        // ry_sum_2_a
        dlgAddResponseAction( RESPONSE_PAGE, "Bazinna zmije *2*" );           // ry_sum_2_b
        dlgAddResponseAction( RESPONSE_PAGE, "Plivnik *3*" );             // ry_sum_3_a
        dlgAddResponseAction( RESPONSE_PAGE, "Mlady medvedvyr *3*" );  // ry_sum_3_b
        dlgAddResponseAction( RESPONSE_PAGE, "Krvatka skvrnita *4*" );      // ry_sum_4_e
        dlgAddResponseAction( RESPONSE_PAGE, "Pavoukovec *4*" );      // ry_sum_4_f
    }
    // neutralni monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "Vrrk *2*" );             // ry_sum_2_d
        dlgAddResponseAction( RESPONSE_PAGE, "Vzdusny element *2*" );  // ry_sum_2_f
        dlgAddResponseAction( RESPONSE_PAGE, "Obri pavouk *3*" );      // ry_sum_3_c
        dlgAddResponseAction( RESPONSE_PAGE, "Zemni mephit *3*" );     // ry_sum_3_d
        dlgAddResponseAction( RESPONSE_PAGE, "Hakovy das *4*" ); // ry_sum_4_d
        dlgAddResponseAction( RESPONSE_PAGE, "Harpie *4*" );  // ry_sum_4_c
    }
    // hodne monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "Nebeska puma *2*" );     // ry_sum_2_e
        dlgAddResponseAction( RESPONSE_PAGE, "Grig *2*" );  // ry_sum_2_c
        dlgAddResponseAction( RESPONSE_PAGE, "Mizici pes *3*" );             // ry_sum_3_f
        dlgAddResponseAction( RESPONSE_PAGE, "Nebesky divocak *3*" );  // ry_sum_3_e
        dlgAddResponseAction( RESPONSE_PAGE, "Nebesky hnedy medved *4*" );        // ry_sum_4_b
        dlgAddResponseAction( RESPONSE_PAGE, "Medeny dracek *4*" );           // ry_sum_4_a

    }
    dlgActivateResetResponse( "Zpet" );
    dlgActivateEndResponse( "Zavrit knihu" );
;}
void Summon2Select(){
    int iLVL = 2;
    int iP0 = BASE_PER_LVL * iLVL;
    int iP1 = iP0 + BASE_PLUS1LVL;
    int iP2 = iP0 + BASE_PLUS2LVL;

    int iT =  iP0;
    iP0 = iP2;
    iP2 = iP1;
    iP1 = iT;

         if ( dlgIsSelectionEqualToName( "Krvatka skvrnita *4*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_4_e", "", iP0, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Pavoukovec *4*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_4_f", "", iP0, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Krenshar *2*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_2_a", "", iP1, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Bazinna zmije *2*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_2_b", "", iP1, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Plivnik *3*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_3_a", "", iP2, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Mlady medvedvyr *3*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_3_b", "", iP2, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);

    else if ( dlgIsSelectionEqualToName( "Hakovy das *4*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_4_d", "", iP0, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Harpie *4*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_4_c", "", iP0, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Vrrk *2*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_2_d", "", iP1, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Vzdusny element *2*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_2_f", "", iP1, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Obri pavouk *3*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_3_c", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Zemni mephit *3*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_3_d", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);

    else if ( dlgIsSelectionEqualToName( "Nebesky hnedy medved *4*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_4_b", "", iP0, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Medeny dracek *4*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_4_a", "", iP0, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Nebeska puma *2*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_2_e", "", iP1, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Grig *2*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_2_c", "", iP1, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Mizici pes *3*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_3_f", "", iP2, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Nebesky divocak *3*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_3_e", "", iP2, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);


    else if ( dlgIsSelectionEqualToName( "Zadnou, at rozhodne osud.." ) )
    {
        setVarsToSummonOnPC(iLVL , "", "", 0, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 1);
    }
    dlgEndDialog( );
;}

void Summon3Init(){
    object oPC = dlgGetSpeakingPC();
    dlgAddResponseAction( RESPONSE_PAGE, "Zadnou, at rozhodne osud.." );

    // zle monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL)
    {

        dlgAddResponseAction( RESPONSE_PAGE, "Plivnik *3*" );             // ry_sum_3_a
        dlgAddResponseAction( RESPONSE_PAGE, "Mlady medvedvyr *3*" );  // ry_sum_3_b
        dlgAddResponseAction( RESPONSE_PAGE, "Krvatka skvrnita *4*" );      // ry_sum_4_e
        dlgAddResponseAction( RESPONSE_PAGE, "Pavoukovec *4*" );      // ry_sum_4_f
        dlgAddResponseAction( RESPONSE_PAGE, "Bazilišek nepravý *5*" );        // ry_sum_5_c
        dlgAddResponseAction( RESPONSE_PAGE, "Pekelny pes *5*" );           // ry_sum_5_b
    }
    // neutralni monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "Obri pavouk *3*" );      // ry_sum_3_c
        dlgAddResponseAction( RESPONSE_PAGE, "Zemni mephit *3*" );     // ry_sum_3_d
        dlgAddResponseAction( RESPONSE_PAGE, "Hakovy das *4*" ); // ry_sum_4_d
        dlgAddResponseAction( RESPONSE_PAGE, "Harpie *4*" );  // ry_sum_4_c
        dlgAddResponseAction( RESPONSE_PAGE, "Element ohne *5*" );             // ry_sum_5_d
        dlgAddResponseAction( RESPONSE_PAGE, "Element vody *5*" );  // ry_sum_5_e
    }
    // hodne monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "Mizici pes *3*" );             // ry_sum_3_f
        dlgAddResponseAction( RESPONSE_PAGE, "Nebesky divocak *3*" );  // ry_sum_3_e
        dlgAddResponseAction( RESPONSE_PAGE, "Nebesky hnedy medved *4*" );        // ry_sum_4_b
        dlgAddResponseAction( RESPONSE_PAGE, "Medeny dracek *4*" );           // ry_sum_4_a
        dlgAddResponseAction( RESPONSE_PAGE, "Nebesky medved grizzly *5*" );     // ry_sum_5_f
        dlgAddResponseAction( RESPONSE_PAGE, "Nebesky lity orel  *5*" );  // ry_sum_5_a
    }
    dlgActivateResetResponse( "Zpet" );
    dlgActivateEndResponse( "Zavrit knihu" );
;}
void Summon3Select(){
    int iLVL = 3;
    int iP0 = BASE_PER_LVL * iLVL;
    int iP1 = iP0 + BASE_PLUS1LVL;
    int iP2 = iP0 + BASE_PLUS2LVL;

    int iT =  iP0;
    iP0 = iP1;
    iP1 = iP2;
    iP2 = iT;

         if ( dlgIsSelectionEqualToName( "Krvatka skrvnita *4*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_4_e", "", iP0, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Pavoukovec *4*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_4_f", "", iP0, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Bazilišek nepravý *5*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_5_c", "", iP1, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Pekelny pes *5*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_5_b", "", iP1, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Plivnik *3*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_3_a", "", iP2, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Mlady medvedvyr *3*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_3_b", "", iP2, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);

    else if ( dlgIsSelectionEqualToName( "Hakovy das *4*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_4_d", "", iP0, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Harpie *4*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_4_c", "", iP0, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Element ohne *5*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_5_d", "", iP1, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Element vody *5*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_5_e", "", iP1, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Obri pavouk *3*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_3_c", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Zemni mephit *3*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_3_d", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);

    else if ( dlgIsSelectionEqualToName( "Nebesky hnedy medved *4*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_4_b", "", iP0, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Medeny dracek *4*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_4_a", "", iP0, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Nebesky medved grizzly *5*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_5_f", "", iP1, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Nebesky lity orel *5*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_5_a", "", iP1, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Mizici pes *3*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_3_f", "", iP2, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Nebesky divocak *3*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_3_e", "", iP2, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);


    else if ( dlgIsSelectionEqualToName( "Zadnou, at rozhodne osud.." ) )
    {
        setVarsToSummonOnPC(iLVL , "", "", 0, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 1);
    }
    dlgEndDialog( );
;}
void Summon4Init(){
    object oPC = dlgGetSpeakingPC();
    dlgAddResponseAction( RESPONSE_PAGE, "Zadnou, at rozhodne osud.." );

    // zle monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "krvatka skvrnita *4*" );      // ry_sum_4_e
        dlgAddResponseAction( RESPONSE_PAGE, "Pavoukovec *4*" );      // ry_sum_4_f
        dlgAddResponseAction( RESPONSE_PAGE, "Bazilišek nepravý *5*" );        // ry_sum_5_c
        dlgAddResponseAction( RESPONSE_PAGE, "Pekelny pes *5*" );           // ry_sum_5_b
        dlgAddResponseAction( RESPONSE_PAGE, "Salamandr *6*" );             // ry_sum_6_b
        dlgAddResponseAction( RESPONSE_PAGE, "Temny panter *6*" );  // ry_sum_6_a
    }
    // neutralni monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "Hakovy das *4*" ); // ry_sum_4_d
        dlgAddResponseAction( RESPONSE_PAGE, "Harpie *4*" );  // ry_sum_4_c
        dlgAddResponseAction( RESPONSE_PAGE, "Element ohne *5*" );             // ry_sum_5_d
        dlgAddResponseAction( RESPONSE_PAGE, "Element vody *5*" );  // ry_sum_5_e
        dlgAddResponseAction( RESPONSE_PAGE, "Brouk rohac *6*" );      // ry_sum_6_d
        dlgAddResponseAction( RESPONSE_PAGE, "Gorgon *6*" );     // ry_sum_6_c
    }
    // hodne monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "Nebesky hnedy medved *4*" );        // ry_sum_4_b
        dlgAddResponseAction( RESPONSE_PAGE, "Medeny dracek *4*" );           // ry_sum_4_a
        dlgAddResponseAction( RESPONSE_PAGE, "Nebesky medved grizzly *5*" );     // ry_sum_5_f
        dlgAddResponseAction( RESPONSE_PAGE, "Nebesky lity orel *5*" );  // ry_sum_5_a
        dlgAddResponseAction( RESPONSE_PAGE, "Dzin *6*" );             // ry_sum_6_f
        dlgAddResponseAction( RESPONSE_PAGE, "Nebesky tygr *6*" );  // ry_sum_6_e
    }
    dlgActivateResetResponse( "Zpet" );
    dlgActivateEndResponse( "Zavrit knihu" );
;}

void Summon4Select(){
    int iLVL = 4;
    int iP0 = BASE_PER_LVL * iLVL;
    int iP1 = iP0 + BASE_PLUS1LVL;
    int iP2 = iP0 + BASE_PLUS2LVL;

  //  int iT =  iP0;
  //  iP0 = iP1;
  //  iP1 = iP2;
  // iP2 = iT;

         if ( dlgIsSelectionEqualToName( "Krvatka skvrnita *4*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_4_e", "", iP0, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Pavoukovec *4*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_4_f", "", iP0, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Bazilišek nepravý *5*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_5_c", "", iP1, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Pekelny pes *5*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_5_b", "", iP1, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Salamandr *6*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_6_b", "", iP2, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Temny panter *6*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_6_a", "", iP2, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);

    else if ( dlgIsSelectionEqualToName( "Hakovy das *4*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_4_d", "", iP0, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Harpie *4*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_4_c", "", iP0, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Element ohne *5*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_5_d", "", iP1, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Element vody *5*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_5_e", "", iP1, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Brouk rohac *6*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_6_d", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Gorgon *6*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_6_c", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);

    else if ( dlgIsSelectionEqualToName( "Nebesky hnedy medved *4*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_4_b", "", iP0, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Medeny dracek *4*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_4_a", "", iP0, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Nebesky medved grizzly *5*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_5_f", "", iP1, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Nebesky lity orel *5*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_5_a", "", iP1, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Dzin *6*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_6_f", "", iP2, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Nebesky tygr *6*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_6_e", "", iP2, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);


    else if ( dlgIsSelectionEqualToName( "Zadnou, at rozhodne osud.." ) )
    {
        setVarsToSummonOnPC(iLVL , "", "", 0, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 1);
    }
    dlgEndDialog( );
;}
void Summon5Init(){
    object oPC = dlgGetSpeakingPC();
    dlgAddResponseAction( RESPONSE_PAGE, "Zadnou, at rozhodne osud.." );


    // zle monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "Bazilišek nepravý *5*" );        // ry_sum_5_c
        dlgAddResponseAction( RESPONSE_PAGE, "Pekelny pes *5*" );           // ry_sum_5_b
        dlgAddResponseAction( RESPONSE_PAGE, "Salamandr *6*" );             // ry_sum_6_b
        dlgAddResponseAction( RESPONSE_PAGE, "Temny panter *6*" );  // ry_sum_6_a
        dlgAddResponseAction( RESPONSE_PAGE, "Bludicka *7*" );      // ry_sum_7_b
        dlgAddResponseAction( RESPONSE_PAGE, "Stary medvedvyr *7*" );      // ry_sum_7_c
    }
    // neutralni monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "Element ohne *5*" );             // ry_sum_5_d
        dlgAddResponseAction( RESPONSE_PAGE, "Element vody *5*" );  // ry_sum_5_e
        dlgAddResponseAction( RESPONSE_PAGE, "Brouk rohac *6*" );      // ry_sum_6_d
        dlgAddResponseAction( RESPONSE_PAGE, "Gorgon *6*" );     // ry_sum_6_c
        dlgAddResponseAction( RESPONSE_PAGE, "Thorny *7*" ); // ry_sum_7_d
        dlgAddResponseAction( RESPONSE_PAGE, "Golem z masa *7*" );  // ry_sum_7_f
    }
    // hodne monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "Nebesky medved grizzly *5*" );     // ry_sum_5_f
        dlgAddResponseAction( RESPONSE_PAGE, "Nebesky lity orel *5*" );  // ry_sum_5_a
        dlgAddResponseAction( RESPONSE_PAGE, "Dzin *6*" );             // ry_sum_6_f
        dlgAddResponseAction( RESPONSE_PAGE, "Nebesky tygr *6*" );  // ry_sum_6_e
        dlgAddResponseAction( RESPONSE_PAGE, "Nebesky lity medved *7*" );        // ry_sum_7_a
        dlgAddResponseAction( RESPONSE_PAGE, "Zlaty dracek *7*" );           // ry_sum_7_e
    }
    dlgActivateResetResponse( "Zpet" );
    dlgActivateEndResponse( "Zavrit knihu" );
;}
void Summon5Select(){
    int iLVL = 5;
    int iP0 = BASE_PER_LVL * iLVL;
    int iP1 = iP0 + BASE_PLUS1LVL;
    int iP2 = iP0 + BASE_PLUS2LVL;

    int iT =  iP0;
    iP0 = iP2;
    iP2 = iP1;
    iP1 = iT;

         if ( dlgIsSelectionEqualToName( "Bludicka *7*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_7_b", "", iP0, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Stary medvedvyr *7*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_7_c", "", iP0, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Bazilišek nepravý *5*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_5_c", "", iP1, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Pekelny pes *5*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_5_b", "", iP1, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Salamandr *6*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_6_b", "", iP2, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Temny panter *6*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_6_a", "", iP2, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);

    else if ( dlgIsSelectionEqualToName( "Thorny *7*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_7_d", "", iP0, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Golem z masa *7*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_7_f", "", iP0, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Element ohne *5*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_5_d", "", iP1, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Element vody *5*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_5_e", "", iP1, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Brouk rohac *6*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_6_d", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Gorgon *6*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_6_c", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);

    else if ( dlgIsSelectionEqualToName( "Nebesky lity medved *7*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_7_a", "", iP0, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Zlaty dracek *7*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_7_e", "", iP0, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Nebesky medved grizzly *5*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_5_f", "", iP1, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Nebeský lítý orel  *5*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_5_a", "", iP1, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Dzin *6*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_6_f", "", iP2, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Nebesky tygr *6*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_6_e", "", iP2, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);


    else if ( dlgIsSelectionEqualToName( "Zadnou, at rozhodne osud.." ) )
    {
        setVarsToSummonOnPC(iLVL , "", "", 0, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 1);
    }
    dlgEndDialog( );
;}

void Summon6Init(){
    object oPC = dlgGetSpeakingPC();
    dlgAddResponseAction( RESPONSE_PAGE, "Zadnou, at rozhodne osud.." );

    // zle monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "Salamandr *6*" );             // ry_sum_6_b
        dlgAddResponseAction( RESPONSE_PAGE, "Temný panter *6*" );  // ry_sum_6_a
        dlgAddResponseAction( RESPONSE_PAGE, "Bludicka *7*" );      // ry_sum_7_b
        dlgAddResponseAction( RESPONSE_PAGE, "Stary medvedvyr *7*" );      // ry_sum_7_c
        dlgAddResponseAction( RESPONSE_PAGE, "Mantikora *8*" );        // ry_sum_8_e
        dlgAddResponseAction( RESPONSE_PAGE, "Sekac jeskynni *8*" );           // ry_sum_8_b
    }
    // neutralni monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "Brouk rohac *6*" );      // ry_sum_6_d
        dlgAddResponseAction( RESPONSE_PAGE, "Gorgon *6*" );     // ry_sum_6_c
        dlgAddResponseAction( RESPONSE_PAGE, "Thorny *7*" ); // ry_sum_7_d
        dlgAddResponseAction( RESPONSE_PAGE, "Golem z masa *7*" );  // ry_sum_7_f
        dlgAddResponseAction( RESPONSE_PAGE, "Sedy trhac *8*" );             // ry_sum_8_c
        dlgAddResponseAction( RESPONSE_PAGE, "Obr. el. ohne *8*" );  // ry_sum_8_f
        dlgAddResponseAction( RESPONSE_PAGE, "Obr. el. vody *8*" );             // ry_sum_8_g
        dlgAddResponseAction( RESPONSE_PAGE, "Obr. el vzduchu *8*" );  // ry_sum_8_h
        dlgAddResponseAction( RESPONSE_PAGE, "Obr. el zeme *8*" );             // ry_sum_8_ch
    }
    // hodne monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "Dzin *6*" );             // ry_sum_6_f
        dlgAddResponseAction( RESPONSE_PAGE, "Nebesky tygr *6*" );  // ry_sum_6_e
        dlgAddResponseAction( RESPONSE_PAGE, "Nebesky lity medved *7*" );        // ry_sum_7_a
        dlgAddResponseAction( RESPONSE_PAGE, "Zlaty dracek *7*" );           // ry_sum_7_e
        dlgAddResponseAction( RESPONSE_PAGE, "Nebesky legendarni orel *8*" );     // ry_sum_8_d
        dlgAddResponseAction( RESPONSE_PAGE, "Nebesky lity tygr  *8*" );  // ry_sum_8_a
    }
    dlgActivateResetResponse( "Zpet" );
    dlgActivateEndResponse( "Zavrit knihu" );
;}
void Summon6Select(){
    int iLVL = 6;
    int iP0 = BASE_PER_LVL * iLVL;
    int iP1 = iP0 + BASE_PLUS1LVL;
    int iP2 = iP0 + BASE_PLUS2LVL;

    int iT =  iP0;
    iP0 = iP1;
    iP1 = iP2;
    iP2 = iT;

         if ( dlgIsSelectionEqualToName( "Bludicka *7*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_7_b", "", iP0, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Stary medvedvyr *7*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_7_c", "", iP0, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Mantikora *8*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_8_e", "", iP1, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Sekac jeskynni *8*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_8_b", "", iP1, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Salamandr *6*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_6_b", "", iP2, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Temný panter *6*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_6_a", "", iP2, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);

    else if ( dlgIsSelectionEqualToName( "Thorny *7*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_7_d", "", iP0, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Golem z masa *7*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_7_f", "", iP0, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Sedy trhac *8*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_8_c", "", iP1, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Obr. el. ohne *8*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_8_f", "", iP1, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Obr. el. vody *8*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_8_g", "", iP1, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Obr. el vzduchu *8*"  ) ) setVarsToSummonOnPC(iLVL , "ry_sum_8_h", "", iP1, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Obr. el zeme *8*"  ) ) setVarsToSummonOnPC(iLVL , "ry_sum_8_ch", "", iP1, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Brouk rohac *6*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_6_d", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Gorgon *6*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_6_c", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);

    else if ( dlgIsSelectionEqualToName( "Nebesky lity medved *7*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_7_a", "", iP0, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Zlaty dracek *7*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_7_e", "", iP0, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Nebesky legendarni orel *8*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_8_d", "", iP1, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Nebesky lity tygr  *8*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_8_a", "", iP1, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Dzin *6*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_6_f", "", iP2, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Nebesky tygr *6*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_6_e", "", iP2, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);


    else if ( dlgIsSelectionEqualToName( "Zadnou, at rozhodne osud.." ) )
    {
        setVarsToSummonOnPC(iLVL , "", "", 0, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 1);
    }
    dlgEndDialog( );
;}
void Summon7Init(){
    object oPC = dlgGetSpeakingPC();
    dlgAddResponseAction( RESPONSE_PAGE, "Zadnou, at rozhodne osud.." );

    // zle monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "Bludicka *7*" );      // ry_sum_7_b
        dlgAddResponseAction( RESPONSE_PAGE, "Stary medvedvyr *7*" );      // ry_sum_7_c
        dlgAddResponseAction( RESPONSE_PAGE, "Mantikora *8*" );        // ry_sum_8_e
        dlgAddResponseAction( RESPONSE_PAGE, "Sekac jeskynni *8*" );           // ry_sum_8_b
        dlgAddResponseAction( RESPONSE_PAGE, "Beholder *9*" );             // ry_sum_9_f
        dlgAddResponseAction( RESPONSE_PAGE, "Klepetnatec okrovy *9*" );  // ry_sum_9_h
    }
    // neutralni monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "Thorny *7*" ); // ry_sum_9_e
        dlgAddResponseAction( RESPONSE_PAGE, "Golem z masa *7*" );  // ry_sum_7_f
        dlgAddResponseAction( RESPONSE_PAGE, "Sedy trhac *8*" );             // ry_sum_8_c
        dlgAddResponseAction( RESPONSE_PAGE, "Obr. el. ohne *8*" );  // ry_sum_8_f
        dlgAddResponseAction( RESPONSE_PAGE, "Obr. el. vody *8*" );             // ry_sum_8_g
        dlgAddResponseAction( RESPONSE_PAGE, "Obr. el vzduchu *8*" );  // ry_sum_8_h
        dlgAddResponseAction( RESPONSE_PAGE, "Obr. el zeme *8*" );             // ry_sum_8_ch
        dlgAddResponseAction( RESPONSE_PAGE, "Silnejsi el. vody *9*" );      // ry_sum_9_a
        dlgAddResponseAction( RESPONSE_PAGE, "Siln. el. vzduchu *9*" );     // ry_sum_9_b
        dlgAddResponseAction( RESPONSE_PAGE, "Vetsi el. ohne *9*" );      // ry_sum_9_c
        dlgAddResponseAction( RESPONSE_PAGE, "Vetsi el. zeme *9*" );     // ry_sum_9_d
        dlgAddResponseAction( RESPONSE_PAGE, "Stitovy strazce *9*" );      // ry_sum_9_ch
        dlgAddResponseAction( RESPONSE_PAGE, "Stary krokodyl *9*" );     // ry_sum_9_d
    }
    // hodne monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "Nebesky lity medved *7*" );        // ry_sum_7_a
        dlgAddResponseAction( RESPONSE_PAGE, "Zlaty dracek *7*" );           // ry_sum_7_e
        dlgAddResponseAction( RESPONSE_PAGE, "Nebesky legendarni orel *8*" );     // ry_sum_8_d
        dlgAddResponseAction( RESPONSE_PAGE, "Nebesky lity tygr  *8*" );  // ry_sum_8_a
        dlgAddResponseAction( RESPONSE_PAGE, "Androsfinga *9*" );      // ry_sum_9_g
        dlgAddResponseAction( RESPONSE_PAGE, "Neb.pradav.medv. *9*" );     // ry_sum_9_i
    }
    dlgActivateResetResponse( "Zpet" );
    dlgActivateEndResponse( "Zavrit knihu" );
;}
void Summon7Select(){
    int iLVL = 7;
    int iP0 = BASE_PER_LVL * iLVL;
    int iP1 = iP0 + BASE_PLUS1LVL;
    int iP2 = iP0 + BASE_PLUS2LVL;


         if ( dlgIsSelectionEqualToName( "Bludicka *7*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_7_b", "", iP0, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Stary medvedvyr *7*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_7_c", "", iP0, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Mantikora *8*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_8_e", "", iP1, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Sekac jeskynni *8*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_8_b", "", iP1, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Beholder *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_f", "", iP2, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Klepetnatec okrovy *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_h", "", iP2, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);

    else if ( dlgIsSelectionEqualToName( "Thorny *7*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_7_d", "", iP0, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Golem z masa *7*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_7_f", "", iP0, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Sedy trhac *8*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_8_c", "", iP1, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Obr. el. ohne *8*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_8_f", "", iP1, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Obr. el. vody *8*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_8_g", "", iP1, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Obr. el vzduchu *8*"  ) ) setVarsToSummonOnPC(iLVL , "ry_sum_8_h", "", iP1, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Obr. el zeme *8*"  ) ) setVarsToSummonOnPC(iLVL , "ry_sum_8_ch", "", iP1, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Silnejsi el. vody *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_a", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Siln. el. vzduchu *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_b", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Vetsi el. ohne *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_c", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Vetsi el. zeme *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_d", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Stitovy strazce *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_ch", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Stary krokodyl *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_e", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);

    else if ( dlgIsSelectionEqualToName( "Nebesky lity medved *7*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_7_a", "", iP0, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Zlaty dracek *7*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_7_e", "", iP0, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Nebesky legendarni orel *8*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_8_d", "", iP1, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Nebesky lity tygr  *8*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_8_a", "", iP1, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Androsfinga *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_g", "", iP2, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Neb.pradav.medv. *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_i", "", iP2, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);


    else if ( dlgIsSelectionEqualToName( "Zadnou, at rozhodne osud.." ) )
    {
        setVarsToSummonOnPC(iLVL , "", "", 0, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 1);
    }
    dlgEndDialog( );
;}
void Summon8Init(){
    object oPC = dlgGetSpeakingPC();
    dlgAddResponseAction( RESPONSE_PAGE, "Zadnou, at rozhodne osud.." );

    // zle monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "Mantikora *8*" );        // ry_sum_8_e
        dlgAddResponseAction( RESPONSE_PAGE, "Sekac jeskynni *8*" );           // ry_sum_8_b
        dlgAddResponseAction( RESPONSE_PAGE, "Beholder *9*" );             // ry_sum_9_f
        dlgAddResponseAction( RESPONSE_PAGE, "Klepetnatec okrovy *9*" );  // ry_sum_9_h
    }
    // neutralni monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "Sedy trhac *8*" );             // ry_sum_8_c
        dlgAddResponseAction( RESPONSE_PAGE, "Obr. el. ohne *8*" );  // ry_sum_8_f
        dlgAddResponseAction( RESPONSE_PAGE, "Obr. el. vody *8*" );             // ry_sum_8_g
        dlgAddResponseAction( RESPONSE_PAGE, "Obr. el vzduchu *8*" );  // ry_sum_8_h
        dlgAddResponseAction( RESPONSE_PAGE, "Obr. el zeme *8*" );             // ry_sum_8_ch
        dlgAddResponseAction( RESPONSE_PAGE, "Silnejsi el. vody *9*" );      // ry_sum_9_a
        dlgAddResponseAction( RESPONSE_PAGE, "Siln. el. vzduchu *9*" );     // ry_sum_9_b
        dlgAddResponseAction( RESPONSE_PAGE, "Vetsi el. ohne *9*" );      // ry_sum_9_c
        dlgAddResponseAction( RESPONSE_PAGE, "Vetsi el. zeme *9*" );     // ry_sum_9_d
        dlgAddResponseAction( RESPONSE_PAGE, "Stitovy strazce *9*" );      // ry_sum_9_ch
        dlgAddResponseAction( RESPONSE_PAGE, "Stary krokodyl *9*" );     // ry_sum_9_e
    }
    // hodne monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "Nebesky legendarni orel *8*" );     // ry_sum_8_d
        dlgAddResponseAction( RESPONSE_PAGE, "Nebesky lity tygr  *8*" );  // ry_sum_8_a
        dlgAddResponseAction( RESPONSE_PAGE, "Androsfinga *9*" );      // ry_sum_9_g
        dlgAddResponseAction( RESPONSE_PAGE, "Neb.pradav.medv. *9*" );     // ry_sum_9_i
    }
    dlgActivateResetResponse( "Zpet" );
    dlgActivateEndResponse( "Zavrit knihu" );
;}
void Summon8Select(){
    int iLVL = 8;
    int iP0 = BASE_PER_LVL * iLVL;
    int iP1 = iP0 + BASE_PLUS1LVL;
    int iP2 = iP0 + BASE_PLUS2LVL;

    int iT =  iP0;
    iP0 = iP2;
    iP2 = iP1;
    iP1 = iT;


         if ( dlgIsSelectionEqualToName( "Mantikora *8*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_8_e", "", iP1, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Sekac jeskynni *8*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_8_b", "", iP1, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Beholder *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_f", "", iP2, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Klepetnatec okrovy *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_h", "", iP2, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);

    else if ( dlgIsSelectionEqualToName( "Sedy trhac *8*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_8_c", "", iP1, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Obr. el. ohne *8*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_8_f", "", iP1, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Obr. el. vody *8*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_8_g", "", iP1, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Obr. el vzduchu *8*"  ) ) setVarsToSummonOnPC(iLVL , "ry_sum_8_h", "", iP1, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Obr. el zeme *8*"  ) ) setVarsToSummonOnPC(iLVL , "ry_sum_8_ch", "", iP1, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Silnejsi el. vody *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_a", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Siln. el. vzduchu *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_b", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Vetsi el. ohne *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_c", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Vetsi el. zeme *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_d", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Stitovy strazce *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_ch", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Stary krokodyl *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_e", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);

    else if ( dlgIsSelectionEqualToName( "Nebesky legendarni orel *8*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_8_d", "", iP1, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Nebesky lity tygr  *8*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_8_a", "", iP1, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Androsfinga *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_g", "", iP2, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Neb.pradav.medv. *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_i", "", iP2, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);


    else if ( dlgIsSelectionEqualToName( "Zadnou, at rozhodne osud.." ) )
    {
        setVarsToSummonOnPC(iLVL , "", "", 0, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 1);
    }
    dlgEndDialog( );

;}
void Summon9Init(){
    object oPC = dlgGetSpeakingPC();
    dlgAddResponseAction( RESPONSE_PAGE, "Zadnou, at rozhodne osud.." );

    // zle monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "Beholder *9*" );             // ry_sum_9_f
        dlgAddResponseAction( RESPONSE_PAGE, "Klepetnatec okrovy *9*" );  // ry_sum_9_h
    }
    // neutralni monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "Silnejsi el. vody *9*" );      // ry_sum_9_a
        dlgAddResponseAction( RESPONSE_PAGE, "Siln. el. vzduchu *9*" );     // ry_sum_9_b
        dlgAddResponseAction( RESPONSE_PAGE, "Vetsi el. ohne *9*" );      // ry_sum_9_c
        dlgAddResponseAction( RESPONSE_PAGE, "Vetsi el. zeme *9*" );     // ry_sum_9_d
        dlgAddResponseAction( RESPONSE_PAGE, "Stitovy strazce *9*" );      // ry_sum_9_ch
        dlgAddResponseAction( RESPONSE_PAGE, "Stary krokodyl *9*" );     // ry_sum_9_e
    }
    // hodne monstra
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL)
    {
        dlgAddResponseAction( RESPONSE_PAGE, "Androsfinga *9*" );      // ry_sum_9_g
        dlgAddResponseAction( RESPONSE_PAGE, "Neb.pradav.medv. *9*" );     // ry_sum_9_i
    }
    dlgActivateResetResponse( "Zpet" );
    dlgActivateEndResponse( "Zavrit knihu" );
;}


void Summon9Select(){
    int iLVL = 9;
    int iP0 = BASE_PER_LVL * iLVL;
    int iP1 = iP0 + BASE_PLUS1LVL;
    int iP2 = iP0 + BASE_PLUS2LVL;
    int iP3 =  iP2 + iP1;

    int iT =  iP0;
    iP0 = iP2;
    iP1 = iP2;
    iP2 = iT;



         if ( dlgIsSelectionEqualToName( "Cerveny drak *12*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_12_d", "", iP3, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Beholder *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_f", "", iP2, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Klepetnatec okrovy *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_h", "", iP2, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);

    else if ( dlgIsSelectionEqualToName( "Silnejsi el. vody *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_a", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Siln. el. vzduchu *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_b", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Vetsi el. ohne *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_c", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Vetsi el. zeme *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_d", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Stitovy strazce *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_ch", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Stary krokodyl *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_e", "", iP2, ALIGNMENT_NEUTRAL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);

    else if ( dlgIsSelectionEqualToName( "Androsfinga *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_g", "", iP2, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);
    else if ( dlgIsSelectionEqualToName( "Neb.pradav.medv. *9*" ) ) setVarsToSummonOnPC(iLVL , "ry_sum_9_i", "", iP2, ALIGNMENT_GOOD, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 0);


    else if ( dlgIsSelectionEqualToName( "Zadnou, at rozhodne osud.." ) )
    {
        setVarsToSummonOnPC(iLVL , "", "", 0, ALIGNMENT_EVIL, dlgGetSpeakingPC(), GetAlignmentGoodEvil(dlgGetSpeakingPC()), 1);
    }
    dlgEndDialog( );

;}

// end
string setVarsToSummonOnPC(int iSpell , string sRefMon, string sRefIng, int iPen, int iMonAlig, object oPC, int iPCAlig, int iDel)
{

    object oSoulStone = GetSoulStone(oPC);
    string sPrefix = "MESUMMON" + IntToString(iSpell);

    if (iDel == 1)
    {
        DeleteLocalString(oSoulStone, sPrefix + "sRefMon");
        DeleteLocalString(oSoulStone, sPrefix + "sRefIng");
        DeleteLocalInt(oSoulStone, sPrefix + "iPen");
        return "";
    }

    int iAlPC = GetAlignmentGoodEvil(oPC);
    int iAlPen = 0;
    if (iAlPC != iMonAlig)
    {
        iAlPen = BASE_ALIGDIFF;
    }

    SetLocalString(oSoulStone,sPrefix + "sRefMon", sRefMon);
    SetLocalString(oSoulStone,sPrefix + "sRefIng", sRefIng);
    SetLocalInt(oSoulStone,sPrefix + "iPen", iPen + iAlPen);

    return "";
}
