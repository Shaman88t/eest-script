//skript pro odkooupeni veci

#include "ku_libtime"

object no_Item;
object no_oPC;
string no_nazev;
int no_pocet;
int no_stacksize;

const int ItemMaxAge = 129600; // 36hours in seconds

int CheckItem(object oItem, string sResref) {

  if(GetResRef(oItem) != sResref) { // Check item resref
    return FALSE;
  }

  int iStamp = GetLocalInt(oItem,"TROFEJ_TIMESTAMP");

  if(iStamp + ItemMaxAge <  ku_GetTimeStamp() ) { // Check if trophy isn't too old
    return FALSE;
  }

  return TRUE;

}

void main()
{
no_oPC = GetPCSpeaker();


no_nazev = GetLocalString(OBJECT_SELF,"no_nazevveci");//nahrani promene do skriptu
no_pocet = GetLocalInt(OBJECT_SELF,"no_pocetveci");
int zbozi = GetLocalInt(OBJECT_SELF,"no_poptavka");


no_Item = GetFirstItemInInventory(no_oPC);  //pro kazde zavolani skriptu zacne od zacatku
                                            // DULEZITE!!! jinak se provede skript jednou a pamatuje si hodnotu itemu
                                            // nafurt i kdyz item nenajde..

while(GetIsObjectValid(no_Item))  {
  if(GetResRef(no_Item) == no_nazev)
    break;
  no_Item = GetNextItemInInventory(no_oPC);
}
//takze projede vsechno a skonci bud pokud najde vec co je nastavena na postave, nebo pokud prohleda vsechno

if (!GetIsObjectValid(no_Item)) {
  SpeakString( " Zadne takove veci co bych potreboval u sebe nemas " );
  return;
}

if (!CheckItem(no_Item, no_nazev)) {
  SpeakString( "Trofej "+GetName(no_Item)+" je prilis stara. Jak dlouho jsi to s sebou vlacel? To uz ti nevezmu.");
  return;
}


int cnt=0;

if (GetIsObjectValid(no_Item)) {

           int price = GetLocalInt(no_Item,"TROFEJ");
           if(price == 0)  price = 5;    //nastavi vykupni cenu

no_Item = GetFirstItemInInventory(no_oPC);
while (GetIsObjectValid(no_Item)) {
 if (no_pocet <= 0)
 break;

 if(!CheckItem(no_Item, no_nazev)) {
   no_Item = GetNextItemInInventory(no_oPC);
   continue;
 }

 no_pocet = no_pocet-1; //snizi se promena na obchodnikovy
 cnt++;
 DestroyObject(no_Item);

 no_Item = GetNextItemInInventory(no_oPC);
}

SetLocalInt(OBJECT_SELF,"no_pocetveci",no_pocet);





    GiveGoldToCreature(no_oPC, cnt*price*4); //vykoupi dvakrate draze, nez normalne
      SpeakString( " Dekuji. Kdyztak se zase nekdy zastav, mozna pro tebe budu mit i jinou praci. " );
    }  // cela procedura na vykup
    }

