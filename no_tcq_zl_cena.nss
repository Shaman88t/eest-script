//skript pro odkooupeni veci

object no_Item;
object no_oPC;
string no_nazev;
string no_pomocna;
int no_pocet;
int no_stacksize;
int price;

void main()
{
no_oPC = GetPCSpeaker();


no_nazev = GetLocalString(OBJECT_SELF,"no_poptavka");//nahrani promene do skriptu
no_pocet = GetLocalInt(OBJECT_SELF,"no_pocetveci");
// int zbozi = GetLocalInt(OBJECT_SELF,"no_poptavka");


no_Item = GetFirstItemInInventory(no_oPC);  //pro kazde zavolani skriptu zacne od zacatku
                                            // DULEZITE!!! jinak se provede skript jednou a pamatuje si hodnotu itemu
                                            // nafurt i kdyz item nenajde..

while(GetIsObjectValid(no_Item))  {
  if ( (GetTag(no_Item) == no_nazev) & (GetResRef(no_Item)!= "no_polot_zl")   )
    {
    break;    }

  no_Item = GetNextItemInInventory(no_oPC);
  }
//takze projede vsechno a skonci bud pokud najde vec co je nastavena na postave, nebo pokud prohleda vsechno
if ((!GetIsObjectValid(no_Item))||(no_pocet == 0)) {
  SpeakString( " Zadne takove veci co bych potreboval u sebe nemas " );
  return;
}

int no_penize = 0;
 int cnt=0;
if (GetIsObjectValid(no_Item)) {

no_Item = GetFirstItemInInventory(no_oPC);



while (GetIsObjectValid(no_Item)) {
                   if (no_pocet==0)
                   break;

                    if((GetTag(no_Item) != no_nazev) || (GetResRef(no_Item)== "no_polot_zl")) {
                    no_Item = GetNextItemInInventory(no_oPC);
                    continue;
                    }
                price = GetLocalInt(no_Item,"tc_cena");
                if(price == 0)  price = 5;    //nastavi vykupni cenu

                no_pocet = no_pocet - 1;
                cnt++;
                no_Item = GetNextItemInInventory(no_oPC);

                }  //while is valid

    no_pomocna = IntToString(cnt);
    //cena trikrat vetsi
    no_nazev = IntToString(cnt * price * 2);


  SpeakString( " Hm, no dal bych ti za tech " + no_pomocna + " veci  " + no_nazev );
  } //kdyz je valid 1.


}

