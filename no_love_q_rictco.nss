//skript by mel rict co shani, ci rict,ze  obchodnik nic neshani

#include "no_love_q_inc"
string no_nazev;
string no_pomocna;
int no_pocet;

void main()
{

no_nazev = GetLocalString(OBJECT_SELF,"no_nazevveci");   //nahrani promene do skriptu
no_pocet = GetLocalInt(OBJECT_SELF,"no_pocetveci");
no_pomocna = IntToString(no_pocet);
int zbozi = GetLocalInt(OBJECT_SELF,"no_poptavka");


switch(zbozi) {

case id_Bleskoveohnisko: no_nazev = "Strazce pokladu"; break;
case id_Drahokamcirehozla: no_nazev = "Padla bojovnice"; break;
case id_Drevoprastarehodubu: no_nazev = "Prastary dubovec"; break;
case id_Hlasivkysireny: no_nazev = " Sirena"; break;
case id_Hlavaprastarehourozenehotroloka: no_nazev = "Prastary urozeny trolok"; break;
case id_Hlavastarehoorka: no_nazev = "Orci nacelnik"; break;
case id_Hlavaurozenerakshasy: no_nazev = "Urozena rakshasa"; break;
case id_Hlavavudceyettiu: no_nazev = "Vudce yettiu"; break;
case id_Kladelkokralovnyformianu: no_nazev = "Kralovna formianu"; break;
case id_Krevprvnihoupira: no_nazev = "Prvni z upiru"; break;
case id_Krovkykralovnybroukuohnivaku: no_nazev = "Kralovna brouku ohnivaku"; break;
case id_Krunyrsamicecernehostira: no_nazev = "Samice digesteru"; break;
case id_Krunyrsamicerudehostira: no_nazev = "Samice prizracnych pavouku"; break;
case id_Krunyrstarehohakovce: no_nazev = "Stary hakovec"; break;
case id_Krunyrstingera: no_nazev = "Nacelnik stingeru"; break;
case id_Kuzesamicealansijskehotygra: no_nazev = "Samice alansijskeho tygra"; break;
case id_Kuzecernehodraka: no_nazev = "Cerny drak"; break;
case id_Kuzeledovehodraka: no_nazev = "Bily drak"; break;
case id_Kuzemodrehodraka: no_nazev = "Modry drak"; break;
case id_Kuzeohnivehodraka: no_nazev = "Ohnivy drak"; break;
case id_Kuzeohnivehowyrma: no_nazev = "Ohnivy wyrm"; break;
case id_Kuzestarezurivegorily: no_nazev = "Stara zuriva gorila"; break;
case id_Kuzezelenehodraka: no_nazev = "Zeleny drak"; break;
case id_Kuzezlatehodraka: no_nazev = "Zlaty drak"; break;
case id_Kyseleohnisko: no_nazev = "kysele ohnisko"; break;
case id_Lebkademilicha: no_nazev = "Demilich"; break;
case id_Lebkapanavlkodlaku: no_nazev = "Pan vlkodlaku"; break;
case id_Lebkaprastareholicha: no_nazev = "Prastary lich"; break;
case id_Lebkastareholicha: no_nazev = "Stary lich"; break;
case id_Magickeohnisko: no_nazev = "Nemrtvy lord"; break;
case id_Mozekklepetnatcepsyonika: no_nazev = "Klepetnatec psyonik"; break;
case id_Mozekstarsihomozkomora: no_nazev = "Starsi mozkomor"; break;
case id_Mozkomysnimokstarehoklepetnatceokroveho: no_nazev = "Stary klepetnatec okrovy"; break;
case id_Okovelkehoorbu: no_nazev = "Velky orb"; break;
case id_OkoVsevidouciho: no_nazev = "Vsevidouci"; break;
case id_Ostnystarehodrapatce: no_nazev = "Stary drapatec"; break;
case id_Paratvlkodlacihovelekneze: no_nazev = "Vlkodlaci veleknez"; break;
case id_Pirkoerynie: no_nazev = "Erynie"; break;
case id_PirkomladeErinye: no_nazev = "Mlada erynie"; break;
case id_Posvatnykamen: no_nazev = "Saman kyklopu"; break;
case id_Slinyohnivehoslaada: no_nazev = "Pan ohnivych slaadu"; break;
case id_Slizhnilovnika: no_nazev = "Hnilobnik"; break;

///////////////////pridano 7.srpna ///////////////////////
case id_Mitrilovygolem: no_nazev = "Mitrilovy golem"; break;
case id_Prvnizprastarych: no_nazev = "Prvni ze starych"; break;
case id_Bilyslaad: no_nazev = "Bily slaad"; break;
case id_Demoniprinc: no_nazev = "Demoni princ"; break;
case id_Harpyjematriarcha: no_nazev = "Harpyje matriarcha"; break;
case id_Staryelementalkyseliny: no_nazev = "Stary elemental kyseliny"; break;
case id_Nacelnikkyklopu: no_nazev = "Nacelnik kyklopu"; break;
case id_Nacelnikohnivcu: no_nazev = "Nacelnik kostlivcu"; break;
case id_Kralsalamandru: no_nazev = "Kral salamandru"; break;
case id_Puldrak: no_nazev = "Puldrak"; break;
case id_Staryelementalohne: no_nazev = "Stary elemental ohne"; break;
case id_Staryelementalvody: no_nazev = "Stary elemental vody"; break;
case id_Trolinacelnik: no_nazev = "Troli nacelnik"; break;
case id_Vudceprastarychvlku: no_nazev = "Vudce prastarych vlku"; break;
case id_Vladcestinu: no_nazev = "Vladce stinu"; break;
case id_Obrimutant: no_nazev = "Obri mutant"; break;
case id_Padlabojovnice: no_nazev = "Cerny rytir"; break;  ///cerny rytir podle rejtyho ICQ 7.srpna
case id_Kralovnacelistnatek: no_nazev = "Kralovna celistnatek"; break;
case id_Nacelnikvzdusnychelementalu: no_nazev = "Nacelnik vzdusnych elementalu"; break;
case id_Starymykoid: no_nazev = "Stary mykonid"; break;
case id_Pekelnyzplozenec: no_nazev = "Pekelny zplozenec"; break;
case id_Samanpralesnichtrollu: no_nazev = "Saman pralesnich trollu"; break;

///////////////////////////pridano 11.2:2009////////////////
case id_Starydrider: no_nazev = "Stary drider"; break;
case id_Zlobriarcimag: no_nazev = "Zlobri arcimaga"; break;
case id_ledovywyrm : no_nazev = "Ledovy wyrm"; break;
case id_Balor : no_nazev = "Balor"; break;
case id_Temnydruid : no_nazev = "Temny druid"; break;
case id_Veleknezkapaniledu : no_nazev = "Veleknezka pani ledu"; break;
case id_samankyselinovychliliputu : no_nazev = "Saman kyselinovych liliputu"; break;
case id_pankamene : no_nazev = "Pan kamene"; break;
case id_Belibith : no_nazev = "Belibith"; break;
case id_Kapitanpalacovestraze : no_nazev = "Kapitan palacove straze"; break;
case id_ld_asabi_hlava : no_nazev =  "Vudce Asabi"; break;
case id_ld_laerti_luk : no_nazev = "Zruda Asabi"; break;
case id_ld_sarrukh_kuz : no_nazev = "Sarrukh"; break;


}

/*
if (no_nazev == "no_boruvka") { no_nazev = "boruvek";   }    //musi se vepsta nazvy veci podle resref
if (no_nazev == "no_malina") { no_nazev = "malin";   }
*/

if (no_pocet==0 ) SpeakString(" Momentalne neni vypsana odmena na zadnou nestvuru. ");   // kdyz nic nechce

else SpeakString(" Mas stesti prave je lovecke obdobi. V tomto obdobi se lovi  " +  no_nazev + " . Kdyz mi prineses dukaz o smrti teto nestvury, tak ti za nej vyplatim ctyrnasobnou odmenu, nez by ti dal kdokoliv jiny. " );
}
