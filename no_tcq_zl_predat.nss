//skript pro odkooupeni veci

object no_Item;
object no_oPC;
string no_nazev;
int no_pocet;
int no_stacksize;
void main()
{
no_oPC = GetPCSpeaker();


no_pocet = GetLocalInt(OBJECT_SELF,"no_pocetveci"); //rekne kolik
no_nazev = GetLocalString(OBJECT_SELF,"no_poptavka"); // nahraje se tag veci


no_Item = GetFirstItemInInventory(no_oPC);  //pro kazde zavolani skriptu zacne od zacatku
                                            // DULEZITE!!! jinak se provede skript jednou a pamatuje si hodnotu itemu
                                            // nafurt i kdyz item nenajde..

while(GetIsObjectValid(no_Item))  {
  if ( (GetTag(no_Item) == no_nazev)& (GetResRef(no_Item)!= "no_polot_zl")   )
    break;
  no_Item = GetNextItemInInventory(no_oPC);
  }


//takze projede vsechno a skonci bud pokud najde vec co je nastavena na postave, nebo pokud prohleda vsechno
if (!GetIsObjectValid(no_Item)) {
  SpeakString( " Zadne takove veci co bych potreboval u sebe nemas " );
  return;
}

int cnt=0;
int price = 0;


if (GetIsObjectValid(no_Item)) {

                int price = GetLocalInt(no_Item,"tc_cena");
                if(price == 0)  price = 5;    //nastavi vykupni cenu

no_Item = GetFirstItemInInventory(no_oPC);
//zacneme uplne od zacatku a budeme pocitat, koik jich tam je.
while (GetIsObjectValid(no_Item)) {
 if (no_pocet==0)
 break;    //kdyz nebude mit uz zadne pro vykoupeni, spusti se break;

 if((GetTag(no_Item) != no_nazev) || (GetResRef(no_Item)== "no_polot_zl")) {
 no_Item = GetNextItemInInventory(no_oPC);
 continue;
 }


 no_pocet = no_pocet-1; //snizi se promena na obchodnikovy
 cnt++;
 DestroyObject(no_Item);

no_Item = GetNextItemInInventory(no_oPC);
  }
    SetLocalInt(OBJECT_SELF,"no_pocetveci",no_pocet);
    SpeakString( " Diky. Dobre se s tebou obchodovalo. tady mas svych "+IntToString(cnt*price*2) +  "zlatych" );
    GiveGoldToCreature(no_oPC, (cnt*price*2)); //vykoupi 2x draze, nez normalne
      // cela procedura na vykup
    }}


