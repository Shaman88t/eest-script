//::///////////////////////////////////////////////
//:: FileName lis_vzit_klepetn
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 14.2.2005 0:55:05
//:://////////////////////////////////////////////
void main()
{

    // Odebere hr��i p�edm�t z invent��e
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "liv_ch_svitek_klepe");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
}
