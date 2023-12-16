//::///////////////////////////////////////////////
//:: FileName no_post_nema
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created On: 26.6.2008 16:42:08
//:://////////////////////////////////////////////

object no_Item;
object no_oPC;
int no_cena;
int StartingConditional()
{

no_Item = GetFirstItemInInventory(OBJECT_SELF);
while(GetIsObjectValid(no_Item))  {
  if(GetTag(no_Item) == "no_balik")
    break;
  no_Item = GetNextItemInInventory(OBJECT_SELF);
  }
    // Ujistit se, že postava má v inventáøi tyto pøedmìty


    if(!GetIsObjectValid(no_Item))
        return FALSE;




//////////////////////////////////////////////////////////
no_oPC = GetPCSpeaker();            /// 21.cervence zaloha

no_cena = FloatToInt(  IntToFloat(GetLocalInt(no_Item,"no_cena")) / 10 );

if  (GetGold(no_oPC) < no_cena) { return  FALSE;
//SendMessageToPC(no_oPC," Nemas dostatek penez na zalohu baliku. ");
//neposle se  message, bo to neprojde ten skript.. jen se overuje true, false

                                }

    return TRUE;
//////////////////////////////////////////////////////////
}
