//::///////////////////////////////////////////////
//:: FileName lis_vzit_beholde
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 14.2.2005 0:55:59
//:://////////////////////////////////////////////
void main()
{

	// Odebere hr��i p�edm�t z invent��e
	object oItemToTake;
	oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "liv_ch_svitek_beho");
	if(GetIsObjectValid(oItemToTake) != 0)
		DestroyObject(oItemToTake);
}
