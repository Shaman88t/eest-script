#include "subraces"

void main()
{
    object oPC = GetPCSpeaker();

     int subrace = GetRacialType(oPC);
     int gender = GetGender(oPC);
     int class = GetClassByPosition(1, oPC);
     string deity = GetDeity(oPC);

     if( (subrace == RACIAL_TYPE_DROW) && (gender == GENDER_FEMALE) && (class == CLASS_TYPE_CLERIC) && (deity == "Xi'An")){
         CreateItemOnObject("li_drowk_knez", oPC);
     }
}
