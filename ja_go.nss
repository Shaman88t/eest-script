#include "ja_variables"

void main()
{
    object oPC = GetPCSpeaker();
    int iReq = GetLocalInt(oPC, v_Price);
    int iGold = GetGold(oPC);

    if( iGold >= iReq ){
        TakeGoldFromCreature(iReq, oPC);
        string sWPTag = GetLocalString(OBJECT_SELF, v_TransportTo);
        object oWP = GetWaypointByTag(sWPTag);
        AssignCommand( oPC, JumpToObject(oWP) );
    }
    else SpeakString("Hmm, snazis se me podvest nebo co?");
}
