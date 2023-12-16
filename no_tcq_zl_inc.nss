//prejmenovana fuinction, bo iniciaci nemusim tady vubec mit (.

void no_zjistisutry(string no_tagveci);
//podle tagu veci zjisti kolik je sutru, jejich cislo a ulozi je na :
// zarizeni do int no_pouzitykov no_prvnisutr no_druhysutr no_tretisutr no_pocetsutru

void  no_udelejjmeno(string no_tagveci);
// podle no:zjistisutry udela celkocej nazec predmetu.

void no_nazevsutru(int no_sutr);
//udela na OBJECT_SELF no_nazevsutru  string s nazvem


void no_zjistisutry(string no_tagveci)
//podle tagu veci zjisti kolik je sutru, jejich cislo a ulozi je na :
// zarizeni do int no_pouzitykov  no_prvnisutr no_druhysutr no_tretisutr no_pocetsutru
{
string no_pouzitavec="";
int no_pocetsutru=0;
SetLocalInt(OBJECT_SELF,"no_pouzitykov",0);
SetLocalString(OBJECT_SELF,"no_pouzitykov","");
SetLocalInt(OBJECT_SELF,"no_prvnisutr",0);
SetLocalString(OBJECT_SELF,"no_prvnisutr","");
SetLocalInt(OBJECT_SELF,"no_druhysutr",0);
SetLocalString(OBJECT_SELF,"no_druhysutr","");
SetLocalInt(OBJECT_SELF,"no_tretisutr",0);
SetLocalString(OBJECT_SELF,"no_tretisutr","");
SetLocalInt(OBJECT_SELF,"no_pocetsutru",0);

//// zjistime, zda prsten, ci amulet

if (GetStringLeft(no_tagveci,5) == "no_zl") SetLocalInt(OBJECT_SELF,"no_JEprsten",1);
if (GetStringLeft(no_tagveci,5) == "no_ZL") SetLocalInt(OBJECT_SELF,"no_JEprsten",2);


/////zjistime nejdrive pouzitykov  musi to byt, bo se to zjistuje zpetne u polotovaru !!/////////////
no_pouzitavec = GetStringLeft(no_tagveci,8);
no_pouzitavec = GetStringRight(no_pouzitavec,2);
SetLocalString(OBJECT_SELF,"no_pouzitykov",no_pouzitavec);
SetLocalInt(OBJECT_SELF,"no_pouzitykov",(StringToInt(no_pouzitavec)));

/////zjistime 1 sutr/////////////
no_pouzitavec = GetStringLeft(no_tagveci,11);
no_pouzitavec = GetStringRight(no_pouzitavec,2);
SetLocalString(OBJECT_SELF,"no_prvnisutr",no_pouzitavec);
SetLocalInt(OBJECT_SELF,"no_prvnisutr",(StringToInt(no_pouzitavec)));


/////zjistime 2 sutr/////////////
no_pouzitavec = GetStringLeft(no_tagveci,14);
no_pouzitavec = GetStringRight(no_pouzitavec,2);
SetLocalString(OBJECT_SELF,"no_druhysutr",no_pouzitavec);
SetLocalInt(OBJECT_SELF,"no_druhysutr",(StringToInt(no_pouzitavec)));


/////zjistime 2 sutr/////////////
no_pouzitavec = GetStringRight(no_tagveci,2);
SetLocalString(OBJECT_SELF,"no_tretisutr",no_pouzitavec);
SetLocalInt(OBJECT_SELF,"no_tretisutr",(StringToInt(no_pouzitavec)));


///spocitame pocet pritomnych sutru ve veci
if (GetLocalInt(OBJECT_SELF,"no_prvnisutr")>0) no_pocetsutru=no_pocetsutru+1;
if (GetLocalInt(OBJECT_SELF,"no_druhysutr")>0) no_pocetsutru=no_pocetsutru+1;
if (GetLocalInt(OBJECT_SELF,"no_tretisutr")>0) no_pocetsutru=no_pocetsutru+1;
SetLocalInt(OBJECT_SELF,"no_pocetsutru",no_pocetsutru);

}////////konec no_zjisti sutry

void no_nazevsutru(int no_sutr)
//ulozi do string no_sutr no OBVJECT_SELF stringovej nazev kamene
{
switch(no_sutr) {
case 1:  SetLocalString(OBJECT_SELF,"no_sutr","nefritem"); break;
case 2:  SetLocalString(OBJECT_SELF,"no_sutr","malachitem"); break;
case 3:  SetLocalString(OBJECT_SELF,"no_sutr","ohnivym achatem"); break;
case 4:  SetLocalString(OBJECT_SELF,"no_sutr","aventurinem"); break;
case 5:  SetLocalString(OBJECT_SELF,"no_sutr","fenelopem"); break;
case 6:  SetLocalString(OBJECT_SELF,"no_sutr","ametystem"); break;
case 7:  SetLocalString(OBJECT_SELF,"no_sutr","zivcem"); break;
case 8:  SetLocalString(OBJECT_SELF,"no_sutr","granatem"); break;
case 9:  SetLocalString(OBJECT_SELF,"no_sutr","alexandritem"); break;
case 10:  SetLocalString(OBJECT_SELF,"no_sutr","topazem"); break;
case 11:  SetLocalString(OBJECT_SELF,"no_sutr","safirem"); break;
case 12:  SetLocalString(OBJECT_SELF,"no_sutr","opalem"); break;
case 13:  SetLocalString(OBJECT_SELF,"no_sutr","diamantem"); break;
case 14:  SetLocalString(OBJECT_SELF,"no_sutr","rubinem"); break;
case 15:  SetLocalString(OBJECT_SELF,"no_sutr","smaragdem"); break;
}//konec switche
} //konec no_nazevsutru



void  no_udelejjmeno(string no_tagveci)
{
no_zjistisutry(no_tagveci);
string no_jmeno = "";

if (GetLocalInt(OBJECT_SELF,"no_JEprsten") == 1) no_jmeno = " prsten ";
if (GetLocalInt(OBJECT_SELF,"no_JEprsten") == 2) no_jmeno = " amulet ";

switch (GetLocalInt(OBJECT_SELF,"no_pouzitykov")){

case 1: {no_jmeno ="Cinovy" + no_jmeno ;
         break; }
case 2: {no_jmeno ="Medeny" + no_jmeno ;
         break; }
case 3: {no_jmeno ="Bronzovy" + no_jmeno ;
         break; }
case 4: {no_jmeno ="Zelezny" + no_jmeno ;
         break; }
case 5: {no_jmeno ="Zlaty" + no_jmeno ;
         break; }
case 6: {no_jmeno ="Platinovy" + no_jmeno ;
         break; }
case 7: {no_jmeno ="Mithrilovy" + no_jmeno ;
         break; }
case 8: {no_jmeno ="Adamantinovy" + no_jmeno ;
         break; }
case 9: {no_jmeno ="Titanovy" + no_jmeno ;
         break; }
case 10: {no_jmeno ="Stribrny" + no_jmeno ;
         break; }
case 11: {no_jmeno = no_jmeno + "ze stinove oceli" ;
         break; }
case 12: {no_jmeno = no_jmeno + "z meteoriticke oceli" ;
         break; }
}//konec switche kovu

if (GetLocalInt(OBJECT_SELF,"no_prvnisutr") != 0){no_nazevsutru(GetLocalInt(OBJECT_SELF,"no_prvnisutr"));
//ulozi do string no_sutr no OBVJECT_SELF stringovej nazev kamene
no_jmeno = no_jmeno + " s " +  GetLocalString(OBJECT_SELF,"no_sutr");
                      }
if (GetLocalInt(OBJECT_SELF,"no_druhysutr") != 0){no_nazevsutru(GetLocalInt(OBJECT_SELF,"no_druhysutr"));
//ulozi do string no_sutr no OBVJECT_SELF stringovej nazev kamene
no_jmeno = no_jmeno + " a " +  GetLocalString(OBJECT_SELF,"no_sutr");
                      }
if (GetLocalInt(OBJECT_SELF,"no_tretisutr") != 0){no_nazevsutru(GetLocalInt(OBJECT_SELF,"no_tretisutr"));
//ulozi do string no_sutr no OBVJECT_SELF stringovej nazev kamene
no_jmeno = no_jmeno + " a " +  GetLocalString(OBJECT_SELF,"no_sutr");
                      }


SetLocalString(OBJECT_SELF,"no_jmeno",no_jmeno);


} //konec udelej jmeno
