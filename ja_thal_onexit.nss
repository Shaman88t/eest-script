#include "subraces"


void GiveIfNotPossesed(string sItem, object oPC){
    if(!GetIsObjectValid(GetItemPossessedBy(oPC, sItem))){
        CreateItemOnObject(sItem, oPC);
    }
}

void main()
{
     object oPC = GetExitingObject();

     int subrace = Subraces_GetCharacterSubrace(oPC);
     int gender = GetGender(oPC);
     int class = GetClassByPosition(1, oPC);
     string deity = GetDeity(oPC);
     string specialItem = "";

     if(subrace == SUBRACE_GNOME_SVIRFNEBLIN){
        specialItem = "li_svirf_mag";
     }
     else if( (subrace == SUBRACE_ELF_DROW || subrace == SUBRACE_ELF_DROW_ARISTOCRAT ) && (class == CLASS_TYPE_WIZARD || class == CLASS_TYPE_SORCERER )){
        specialItem = "li_drowk_mag";
     }
     else if( subrace == SUBRACE_ELF_DROW_ARISTOCRAT && gender == GENDER_FEMALE && class == CLASS_TYPE_CLERIC){
        specialItem = "li_drowk_mag";
     }
     else if( subrace == SUBRACE_DWARF_DUERGAR ){
        specialItem = "li_duerk";
     }

     GiveIfNotPossesed(specialItem, oPC);

     if( subrace == SUBRACE_ELF_DROW_ARISTOCRAT && gender == GENDER_FEMALE && class == CLASS_TYPE_CLERIC && deity == "Xi'An"){
         GiveIfNotPossesed("li_drowk_knez", oPC);
     }
}
