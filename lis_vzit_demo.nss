//::///////////////////////////////////////////////
//:: FileName lis_vzit_demo
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 14.2.2005 0:56:50
//:://////////////////////////////////////////////
void main()
{

	// Odebere hr��i p�edm�t z invent��e
	object oItemToTake;
	oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "liv_ch_svitek_demo");
	if(GetIsObjectValid(oItemToTake) != 0)
		DestroyObject(oItemToTake);
}
