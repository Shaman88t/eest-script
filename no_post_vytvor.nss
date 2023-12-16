
// predam balik od NPC cka hraci a balik u NPC znicim, cimz umoznim generovani dalsich Q
#include "ku_libtime"

object no_oPC;
object no_Item;
int no_donaska;
void main()
{
no_Item = GetFirstItemInInventory(OBJECT_SELF);
while(GetIsObjectValid(no_Item))  {
  if(GetTag(no_Item) == "no_balik")
    break;
  no_Item = GetNextItemInInventory(OBJECT_SELF);
  }

no_donaska = GetLocalInt(OBJECT_SELF,"no_donaska");//zjistim za jak dlouho ma balik dojit

SetLocalInt(no_Item,"no_cas",ku_GetTimeStamp(0,10*no_donaska));  // na baliku nastavi pocet hodinIG na predani
                                                      // coz je 10x min REAL
no_oPC = GetPCSpeaker();



//////////////////////////////////////////////////////////   21.cervenec
if  (GetGold(no_oPC) < (FloatToInt(  IntToFloat(GetLocalInt(no_Item,"no_cena")) / 10 ))) {
SpeakString(" Nesnaz se me podvadet ! ");
SendMessageToAllDMs("postava " + ObjectToString(no_oPC) + "podvadi pri postovnim Q. Dava pravdepodobne zalohu na zem");
                                }


else { CopyItem(no_Item,no_oPC,TRUE);
        TakeGoldFromCreature(FloatToInt(  IntToFloat(GetLocalInt(no_Item,"no_cena")) / 10 ),no_oPC,TRUE);
        }
//////////////////////////////////////////////////////////

DestroyObject(no_Item);


SetLocalInt(OBJECT_SELF,"obch_q_lastquest",ku_GetTimeStamp(0,160)); // kdyz vezmes balik, novej muze generovat az za 60minut.








}
