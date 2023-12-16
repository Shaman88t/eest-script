// * Looks for the nearest store and opens it
#include "nw_i0_plot"
#include "subraces"

void main()
{
    object oPC = GetPCSpeaker();
    string sShop = "li_povrch";

    if(Subraces_GetIsCharacterFromUnderdark(oPC ) == 1 )
      sShop = "li_podtemno";

    if( (Subraces_IsCharacterOfSubrace(oPC, SUBRACE_ELF_DROW_ARISTOCRAT) ) ||
      (Subraces_IsCharacterOfSubrace(oPC, SUBRACE_ELF_DROW           ) ) )
      sShop = "li_drow";

    object oStore = GetNearestObjectByTag(sShop);
    if (GetIsObjectValid(oStore) == TRUE)
    {
        OpenStore(oStore, GetPCSpeaker());
    }
    else
        PlayVoiceChat(VOICE_CHAT_CUSS);

    SetLocalInt(GetPCSpeaker(), "THAL_STATE",1);
}


