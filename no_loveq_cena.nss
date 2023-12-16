//skript pro odkooupeni veci


#include "ku_libtime"

object no_Item;
object no_oPC;
string no_nazev;
string no_pomocna;
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
           if(price == 0)
             price = 5;
                no_stacksize = GetItemStackSize(no_Item);      //zjisti kolik je toho ve stacku

                if (no_pocet>no_stacksize)   no_pocet=no_stacksize;
                if (no_pocet<no_stacksize)   no_pocet= no_pocet;

    price=price*4; //cena 4x vetsi    // pokyn Rejtyho 7.srpen
    no_nazev = IntToString(price);
    no_pomocna = IntToString(no_pocet);

/// no_ 25 zari///
//SpeakString( " Za tuhle kuzi bych ti dal "  + no_nazev );
if (no_pocet >=0 )  SpeakString( " Za tuhle kuzi bych ti dal "  + no_nazev );
else SpeakString("Neni vypsana zadna odmena ");
    }


}

