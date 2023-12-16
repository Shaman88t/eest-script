int StartingConditional()
{
int iHas = 0;
object oPC = GetPCSpeaker();
object oSitem = GetFirstItemInInventory(oPC);
do
{
if (
(GetTag(oSitem) == "liv_ch_svitek_trol")||
(GetTag(oSitem) == "liv_ch_svitek_klep")||
(GetTag(oSitem) == "liv_ch_svitek_obr")||
(GetTag(oSitem) == "liv_ch_svitek_jest")||
(GetTag(oSitem) == "liv_ch_svitek_demo")||
(GetTag(oSitem) == "liv_ch_svitek_beho")
)
{
iHas = 1;
break;
}
oSitem = GetNextItemInInventory(oPC);
}
while (oSitem != OBJECT_INVALID);
if (!iHas) return TRUE;
return FALSE;
}
