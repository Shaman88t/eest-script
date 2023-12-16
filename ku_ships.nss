/*
 * release 08.01.2008 kucik
 * rev 30.12.2008 Prepsani na pouzivani zpozdenych volani misto heartbeatu
 */

#include "ku_shipslst"
#include "ku_libtime"

// Constant to note if we are currently debugging. Should be FALSE in release version.
int SHIPS_DEBUG           = FALSE;

// Base field name used to save ships information.
string KU_SHIPS_STRUCT_TAG   = "KU_SHIPS";

// Field name for the number of stored ships.
string KU_SHIPS_COUNT        = "KU_SHIPS_COUNT";

// Departure distance
const float fDepDistance = 15.0;

struct tShips
{
    int m_nID;
    string m_sName;
    int m_nCost;
    int m_nSpent;
    int m_nMaxDelay;
    string m_sMerchant;
    string m_sPort;
    string m_sSea;
    string m_sFinish;
    string m_sCabin;
    string m_sShouter_p;
    string m_sShouter_s;
    float m_fStartTime;
    int m_iInterval;
};

// Odbav odjezd jedne lodi.
void ku_Ship_Departure(int iShip);

// Prijezd lodi
void ku_Ship_Arrival(int iShip);

// Nacasuje odjezd lodi
void ku_Ships_PrepareNextShipDeparture(int ship);

// vrati cislo lode s timto pristavem.
int KU_GetShipByPort(string sPort)
{
 object oMod = GetModule();

 string si;
 int i = 1;

 if(SHIPS_DEBUG) {
   SendMessageToPC(GetFirstPC(),"Pristav :"+sPort);
   SendMessageToPC(GetFirstPC(),"Hledam....");
 }
 int NumOfShips = GetLocalInt(oMod,KU_SHIPS_COUNT);
 while (i <= NumOfShips ) {
   si = IntToString(i);
   if(SHIPS_DEBUG) {
     SendMessageToPC(GetFirstPC(),"cislo linky: "+si);
     SendMessageToPC(GetFirstPC(),"pristav: "+GetLocalString(oMod,KU_SHIPS_STRUCT_TAG + "_Port" + si) );
   }
   if (GetLocalString(oMod,KU_SHIPS_STRUCT_TAG + "_Port" + si) == sPort) {
     if(SHIPS_DEBUG)
      SendMessageToPC(GetFirstPC(),"Match!");
     return i;
   }
 i++;
 }
 return 0;
}

// nastavi vstupenku
void KU_ShipsTicketSold(string sPort, object oPC)
{
     object oMod = GetModule();

     int iShip = KU_GetShipByPort(sPort);
     string si = IntToString(iShip);
     if(SHIPS_DEBUG)
       SendMessageToPC(oPC,"Linka cislo"+si);
     int iCost = GetLocalInt(oMod,KU_SHIPS_STRUCT_TAG + "_Cost" + si);
     iCost = iCost;

     if(GetGold(oPC) < iCost) {
       AssignCommand(OBJECT_SELF,SpeakString("Nemas dost zlata!"));
     }
     else {
       object oShip = GetObjectByTag(GetLocalString(oMod,KU_SHIPS_STRUCT_TAG + "_Port" + si));
       object oTick = CreateItemOnObject("ku_ship_ticket",oPC,1,"ku_ship_ticket"+si);
       SetName(oTick,GetName(oTick)+" "+GetLocalString(oMod,KU_SHIPS_STRUCT_TAG + "_Name" + si));
       //SetLocalInt(oShip,GetPCPlayerName(oPC) + GetName(oPC),1);
       TakeGoldFromCreature(iCost,oPC);
       AssignCommand(OBJECT_SELF,SpeakString("Klidnou plavbu. Kapitan vas bude ocekavat na palube."));
     }
}


/*
 * Funkce pro kontrolu casu a odjezd lodi
 * Vola se jednou za minutu
 */
void ku_ShipsDeparture()
{
   object oMod = GetModule();
   int NumOfShips = GetLocalInt(oMod,KU_SHIPS_COUNT);
   int iHour = GetTimeHour();
   string sHour = IntToString(iHour);
   int iMinute = GetTimeMinute();
   int i = 0;
   int x = 1;
   string si;
   int DelayKoeficient; // = 5; // DelayKoeficient x 6 = max. zpozdeni v minutach. Ne vic nez 9!!! Lod musi vzdy odjizdet v dannou hodinu!!!
   int t = GetLocalInt(OBJECT_SELF, "TIME"); //cas


   if(t % 100 ) { //IC hodina v hb
     if(SHIPS_DEBUG)
       SendMessageToPC(GetFirstPC()," kontrola odjezdu lodi");
//vazba ku_Ships<hodina>H<cislo> -> cislo spoje
     i = GetLocalInt(oMod,KU_SHIPS_STRUCT_TAG + sHour + "H" + IntToString(x));
   //dokud cislo spoje neni 0, = zadny spoj
     while (i > 0 ) {
       si = IntToString(i);

       //stav lodi
       int IsShipDepart = GetLocalInt(oMod,KU_SHIPS_STRUCT_TAG + "_IsDepart" + si);
       //Pokud je cela a zaroven ld neni pripravena k odjezdu, nastav zpozdeni
       if(((IsShipDepart == 0) || (IsShipDepart == 3))) {
         if(SHIPS_DEBUG)
           SendMessageToPC(GetFirstPC(),"Nastavuje se odjezd lince cislo:"+si);
         //Nastavovani zpozdeni odjezdu
         SetLocalInt(oMod,KU_SHIPS_STRUCT_TAG + "_IsDepart" + si,1);

         DelayKoeficient = GetLocalInt(oMod,KU_SHIPS_STRUCT_TAG + "_MaxDelay" + si);
         int Delay = Random(DelayKoeficient);
         Delay = ku_GetTimeStamp(0,Delay+1);
         SetLocalInt(oMod,KU_SHIPS_STRUCT_TAG + "_DepartTime" + si,Delay + 1);
         if(SHIPS_DEBUG)
           SendMessageToPC(GetFirstPC()," timestamp odjezdu nastaven na " + IntToString(Delay + 1));
       }
       x++;
       i = GetLocalInt(oMod,KU_SHIPS_STRUCT_TAG + sHour + "H" + IntToString(x));
     }
   }
   // Konec nastavovani lodi



   // Kontrola vsech linek, jestli maji planovany odjezd.
   i = 1;
   while (i <= NumOfShips ) {
     si = IntToString(i);
     //int SeaDepartHour = GetLocalInt(oMod,KU_SHIPS_STRUCT_TAG + "_SeaDepartTime" + si);
     int IsShipDepart  = GetLocalInt(oMod,KU_SHIPS_STRUCT_TAG + "_IsDepart" + si);

     //Prijezd ... nebo spis odjezd z pristavu jmenem more :P
     if(IsShipDepart == 2) {
       if(SHIPS_DEBUG)
           SendMessageToPC(GetFirstPC(),"Linka "+si+" ma planovan prijezd");
       if (GetLocalInt(oMod,KU_SHIPS_STRUCT_TAG + "_DepartTime" + si) <= ku_GetTimeStamp()) {
//       if(GetLocalInt(oMod,KU_SHIPS_STRUCT_TAG + "_Delay" + si) == iMinute) {
         if(SHIPS_DEBUG)
           SendMessageToPC(GetFirstPC(),"Linka "+si+" prijizdi do pristavu");

         SetLocalInt(oMod,KU_SHIPS_STRUCT_TAG + "_IsDepart" + si,0);

         string tShouter = GetLocalString(oMod,KU_SHIPS_STRUCT_TAG + "_Shouter_s" + si);
         AssignCommand(GetObjectByTag(tShouter),SpeakString("Vypada to, ze jsme tam za chvili."));

         object oShip = GetObjectByTag(GetLocalString(oMod,KU_SHIPS_STRUCT_TAG + "_Sea" + si));
         SetLocalInt(oShip,"ShipLineNumber",i);
         DelayCommand(10.0,ExecuteScript("ku_ship_depart",oShip));

         oShip = GetObjectByTag(GetLocalString(oMod,KU_SHIPS_STRUCT_TAG + "_Cabin" + si));
         SetLocalInt(oShip,"ShipLineNumber",i);
         DelayCommand(10.0,ExecuteScript("ku_ship_depart",oShip));
         //SignalEvent(GetObjectByTag(GetLocalString(oMod,KU_SHIPS_STRUCT_TAG + "_Sea" + si)),EventUserDefined(600 + i));

       }
     }
     //int PortDepartHour = GetLocalInt(oMod,KU_SHIPS_STRUCT_TAG + "_PortDepartTime" + si);
     // odjezd z pristavu

     if(IsShipDepart == 1) {
       if(SHIPS_DEBUG) {
           SendMessageToPC(GetFirstPC(),"Linka "+si+" ma planovany odjezd");
       }
       if (GetLocalInt(oMod,KU_SHIPS_STRUCT_TAG + "_DepartTime" + si) <= ku_GetTimeStamp()) {
         if(SHIPS_DEBUG)
           SendMessageToPC(GetFirstPC(),"Linka "+si+" odjizdi z pristavu");

         SetLocalInt(oMod,KU_SHIPS_STRUCT_TAG + "_IsDepart" + si,2);

         object oShip = GetObjectByTag(GetLocalString(oMod,KU_SHIPS_STRUCT_TAG + "_Port" + si));
         string tShouter = GetLocalString(oMod,KU_SHIPS_STRUCT_TAG + "_Shouter_p" + si);
         if(tShouter == "")
           tShouter = GetLocalString(oMod,KU_SHIPS_STRUCT_TAG + "_Merchant" + si);

         AssignCommand(GetObjectByTag(tShouter),SpeakString("Vsichni na palubu! Lod odplouva!"));
         SetLocalInt(oShip,"ShipLineNumber",i);

         DelayCommand(10.0f,ExecuteScript("ku_ship_depart",oShip));

         //SignalEvent(GetObjectByTag(GetLocalString(oMod,KU_SHIPS_STRUCT_TAG + "_Port" + si)),EventUserDefined(600 + i));

         DelayKoeficient = GetLocalInt(oMod,KU_SHIPS_STRUCT_TAG + "_MaxDelay" + si);
         int Delay = Random(DelayKoeficient) + GetLocalInt(oMod,KU_SHIPS_STRUCT_TAG + "_Spent" + si);
         Delay = ku_GetTimeStamp(0,Delay + 1);

         SetLocalInt(oMod,KU_SHIPS_STRUCT_TAG + "_DepartTime" + si,Delay);
         if(SHIPS_DEBUG)
           SendMessageToPC(GetFirstPC(),"Prijezd linky "+si+" nastaven na "+ IntToString(Delay));

       }
     }

     i++;

   }


}

// Returns a new ships structure and saves it to the global object.
//
struct tShips KU_CreateShip(  )
{

    // The struct we're creating.
    struct tShips stShip;

    // Global object to store the values on.
    object oModule = GetModule();

    // Number of ships already added (highest index is nShipsCount)
    int nShipsCount = GetLocalInt( oModule, KU_SHIPS_COUNT );

    nShipsCount++;

    // Store the values in the new struct.
    stShip.m_nID                    = nShipsCount;
    stShip.m_nCost                  = 100;
    stShip.m_sName                  = "";
    stShip.m_nSpent                 = 7;
    stShip.m_nMaxDelay              = 5;
    stShip.m_sMerchant              = "";
    stShip.m_sPort                  = "";
    stShip.m_sSea                   = "";
    stShip.m_sFinish                = "";
    stShip.m_sCabin                 = "";
    stShip.m_sShouter_p             = "";
    stShip.m_sShouter_s             = "";
    stShip.m_fStartTime             = 0.0;
    stShip.m_iInterval              = 0;

    // Increase the number of added ships.
    SetLocalInt( oModule, KU_SHIPS_COUNT, nShipsCount );

    return stShip;

}






void KU_AddDepartHour( struct tShips a_stShip, int a_nHour )
{

    // Global object to store the values on.
    object oMod = GetModule();

    // The field name to store the new trait under.
    //string sTag = KU_SHIPS_STRUCT_TAG + IntToString(a_nHour) + "H";
    string sTag = KU_SHIPS_STRUCT_TAG + "_"+IntToString(a_stShip.m_nID)+"_H_"+IntToString(a_nHour);
    SetLocalInt(oMod,sTag,TRUE);
    return;

    int x = 1;

    int i = GetLocalInt(oMod,sTag + IntToString(x));
    //dokud cislo spoje neni 0, = zadny spoj
    while (i > 0 ) {
      x++;
      i = GetLocalInt(oMod,sTag + IntToString(x));
    }

    // Store the ship id.
    SetLocalInt(oMod,sTag + IntToString(x),a_stShip.m_nID);

    if(SHIPS_DEBUG)
      SendMessageToPC(GetFirstPC(),"Saving ship "+IntToString(a_stShip.m_nID)+" to possition "+sTag + IntToString(x));



} // End SEI_AddTrait


// Saves the ships struct to the module for later retrieval
//
void KU_SaveShip( struct tShips a_stShip )
{

    // Global object to store the values on.
    object oModule = GetModule();

    // The base field name index.
    string si = IntToString(a_stShip.m_nID);

    // Save the values from the struct.
    SetLocalInt( oModule,KU_SHIPS_STRUCT_TAG + "_Cost" + si,a_stShip.m_nCost);
    SetLocalInt( oModule,KU_SHIPS_STRUCT_TAG + "_Spent" + si,a_stShip.m_nSpent);
    SetLocalInt( oModule,KU_SHIPS_STRUCT_TAG + "_MaxDelay" + si,a_stShip.m_nMaxDelay);
    SetLocalInt( oModule,KU_SHIPS_STRUCT_TAG + "_Iterval" + si,a_stShip.m_iInterval);

    SetLocalFloat( oModule,KU_SHIPS_STRUCT_TAG + "_StartTime" + si,a_stShip.m_fStartTime);

    SetLocalString( oModule,KU_SHIPS_STRUCT_TAG + "_Name" + si,a_stShip.m_sName);
    SetLocalString( oModule,KU_SHIPS_STRUCT_TAG + "_Merchant" + si,a_stShip.m_sMerchant);
    SetLocalString( oModule,KU_SHIPS_STRUCT_TAG + "_Port" + si,a_stShip.m_sPort);
    SetLocalString( oModule,KU_SHIPS_STRUCT_TAG + "_Sea" + si,a_stShip.m_sSea);
    SetLocalString( oModule,KU_SHIPS_STRUCT_TAG + "_Finish" + si,a_stShip.m_sFinish);
    SetLocalString( oModule,KU_SHIPS_STRUCT_TAG + "_Cabin" + si,a_stShip.m_sCabin);
    SetLocalString( oModule,KU_SHIPS_STRUCT_TAG + "_Shouter_p" + si,a_stShip.m_sShouter_p);
    SetLocalString( oModule,KU_SHIPS_STRUCT_TAG + "_Shouter_s" + si,a_stShip.m_sShouter_s);

    if(SHIPS_DEBUG)
      WriteTimestampedLogEntry("Define "+si+" with port "+a_stShip.m_sPort);
//      SendMessageToPC(GetFirstPC(),"Define "+si+" with port "+a_stShip.m_sPort);

    /* Execute ship departure */
    ku_Ships_PrepareNextShipDeparture(a_stShip.m_nID);

} // End SEI_SaveSubraceIdx

void ku_Ships_PrepareNextShipDeparture(int ship) {
 object oMod = GetModule();
 float fHour = GetFTimeHour();
 string sShip = IntToString(ship);
 float fShipStartTime = GetLocalFloat( oMod,KU_SHIPS_STRUCT_TAG + "_StartTime" + sShip);
 int iInterval = GetLocalInt( oMod,KU_SHIPS_STRUCT_TAG + "_Iterval" + sShip);
 float fInt = IntToFloat(iInterval) / 10;

 if(iInterval) {
   // Najdi pristi nejblizsi odjezd
   while(fShipStartTime <= fHour) {
     fShipStartTime = fShipStartTime + fInt;
   }
 }
 // Najdi nejblizsi hodinu odjezdu
 else {
   int iHour = GetTimeHour() + 1;
   string sTag = KU_SHIPS_STRUCT_TAG + "_"+IntToString(ship)+"_H_";
   fShipStartTime=0.0;
   while(!GetLocalInt(oMod,sTag+IntToString(iHour))) {
     iHour++;
     if(iHour > 23) {
       iHour=0;
       fShipStartTime = fShipStartTime + 24.0;
     }
   }
   fShipStartTime = fShipStartTime + iHour;
 }

 iInterval = FloatToInt((fShipStartTime - fHour) * 10 * 60 );
 iInterval = iInterval + 20;  // zpozdit pro jistotu jeste o par vterin
 SetLocalInt(oMod,KU_SHIPS_STRUCT_TAG + "_DepartTime" + sShip,ku_GetTimeStamp(iInterval));
 SetLocalInt(OBJECT_SELF,KU_SHIPS_STRUCT_TAG + "_IsDepart" + sShip,1);
 fInt = IntToFloat(iInterval);
 DelayCommand(fInt,ku_Ship_Departure(ship));

 if(SHIPS_DEBUG)
      SendMessageToPC(GetFirstPC(),"Lod "+IntToString(ship)+ " pripravena na odjezd za "+FloatToString(fInt)+" vterin.");
}

void ku_Ship_Departure(int iShip) {

  int i = 1;
  string sShip = IntToString(iShip);
  object oMod = GetModule();
  location lShip_s;
  location lShip_p;
  location lShip_f;
  string tShouter = GetLocalString(oMod,KU_SHIPS_STRUCT_TAG + "_Shouter_p" + sShip);
  object oShouter;
  if(GetLocalInt(oMod,KU_SHIPS_STRUCT_TAG + "_objects_init_" + sShip) != 1) {
    lShip_s = GetLocation(GetObjectByTag(GetLocalString(oMod,KU_SHIPS_STRUCT_TAG + "_Sea" + sShip)));
    lShip_p = GetLocation(GetObjectByTag(GetLocalString(oMod,KU_SHIPS_STRUCT_TAG + "_Port" + sShip)));
    lShip_f = GetLocation(GetObjectByTag(GetLocalString(oMod,KU_SHIPS_STRUCT_TAG + "_Finish" + sShip)));
    SetLocalLocation(oMod,KU_SHIPS_STRUCT_TAG + "_Sea_loc" + sShip,lShip_s);
    SetLocalLocation(oMod,KU_SHIPS_STRUCT_TAG + "_Port_loc" + sShip,lShip_p);
    SetLocalLocation(oMod,KU_SHIPS_STRUCT_TAG + "_Finish_loc" + sShip,lShip_f);

    oShouter = GetObjectByTag(tShouter);
    SetLocalObject(oMod,KU_SHIPS_STRUCT_TAG + "_Shouter" + sShip,oShouter);

    SetLocalInt(oMod,KU_SHIPS_STRUCT_TAG + "_objects_init_" + sShip,1);
  }
  else {
    lShip_s = GetLocalLocation(oMod,KU_SHIPS_STRUCT_TAG + "_Sea_loc" + sShip);
    lShip_p = GetLocalLocation(oMod,KU_SHIPS_STRUCT_TAG + "_Port_loc" + sShip);
    oShouter = GetLocalObject(oMod,KU_SHIPS_STRUCT_TAG + "_Shouter" + sShip);
  }

  string sTicket = "ku_ship_ticket"+sShip;

  if(SHIPS_DEBUG)
      SendMessageToPC(GetFirstPC(),"Lod "+sShip+ " odjizdi z pristavu");

//  string tShouter = GetLocalString(oMod,KU_SHIPS_STRUCT_TAG + "_Shouter_p" + sShip);
  if(tShouter == "")
    tShouter = GetLocalString(oMod,KU_SHIPS_STRUCT_TAG + "_Merchant" + sShip);
  AssignCommand(oShouter,SpeakString("Vsichni na palubu! Lod odplouva!"));

//  object oPassanger = GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,i);
  object oPassanger = GetFirstObjectInShape(SHAPE_SPHERE,
                                            fDepDistance,
                                            lShip_p,
                                            FALSE,
                                            OBJECT_TYPE_CREATURE);
  while(GetIsObjectValid(oPassanger) ) {
    if(SHIPS_DEBUG)
        SendMessageToPC(GetFirstPC(),"kontroluji"+GetName(oPassanger));
    if(GetIsObjectValid(GetItemPossessedBy(oPassanger,sTicket))) {
//      SendMessageToPC(GetFirstPC(),"ma listek"+GetName(oPassanger));
      int takehorse = FALSE;
      object oHorse = GetLocalObject(oPassanger, "JA_HORSE_OBJECT");
      if(GetIsObjectValid(oHorse)) {
        float fHorseDist = GetDistanceBetween(oPassanger,oHorse);
        if((fHorseDist <= fDepDistance) && (fHorseDist > 0.0 )) {
          takehorse = TRUE;
        }
      }
      AssignCommand(oPassanger,ClearAllActions(TRUE));
      AssignCommand(oPassanger, JumpToLocation(lShip_s));
      SetLocalInt(oPassanger,"KU_SHIPABOARD",iShip);

//      object oHorse = GetLocalObject(oPassanger, "JA_HORSE_OBJECT");
      if(takehorse) {
//        float fHorseDist = GetDistanceBetween(oPassanger,oHorse);
//        if(GetDistanceToObject(oHorse) <= fDepDistance ) {
          CopyItem(GetItemPossessedBy(oPassanger,sTicket),oHorse);
          AssignCommand(oHorse,ClearAllActions(TRUE));
          AssignCommand(oHorse, JumpToLocation(lShip_s));
//        }
      }

    }

    i++;
//    oPassanger = GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,i);
    oPassanger = GetNextObjectInShape(SHAPE_SPHERE,
                                            fDepDistance,
                                            lShip_p,
                                            FALSE,
                                            OBJECT_TYPE_CREATURE);
  }

  /* Nastavime pripluti lode do pristavu */
  i = GetLocalInt( oMod,KU_SHIPS_STRUCT_TAG + "_Spent" + IntToString(iShip)) * 60;
  if(SHIPS_DEBUG)
      SendMessageToPC(GetFirstPC(),"Spent "+IntToString(iShip)+" = "+ IntToString(i));
  DelayCommand(IntToFloat(i),ku_Ship_Arrival(iShip));
  /* Nastavime dalsi odpluti */
  ku_Ships_PrepareNextShipDeparture(iShip);

}

void ku_RemoveTicket(object oTicket) {

  if(GetItemStackSize(oTicket) > 1) {
    SetItemStackSize(oTicket,GetItemStackSize(oTicket)-1);
  }
  else {
    DestroyObject(oTicket);
  }
}

void ku_Ship_Arrival(int iShip) {

  int i = 1;
  string sShip = IntToString(iShip);
  object oMod = GetModule();
  location lShip_s;// = GetLocation(GetObjectByTag(GetLocalString(oMod,KU_SHIPS_STRUCT_TAG + "_Sea" + sShip)));
  location lShip_f;// = GetLocation(GetObjectByTag(GetLocalString(oMod,KU_SHIPS_STRUCT_TAG + "_Finish" + sShip)));

  lShip_s = GetLocalLocation(oMod,KU_SHIPS_STRUCT_TAG + "_Sea_loc" + sShip);
  lShip_f = GetLocalLocation(oMod,KU_SHIPS_STRUCT_TAG + "_Finish_loc" + sShip);
//  object oShouter = GetLocalObject(oMod,KU_SHIPS_STRUCT_TAG + "_Shouter" + sShip);

  if(SHIPS_DEBUG)
      SendMessageToPC(GetFirstPC(),"Lod "+sShip+ " prijizdi do pristavu");

  string sTicket = "ku_ship_ticket"+sShip;

//  object oPassanger = GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,i);
  object oPassanger = GetFirstObjectInShape(SHAPE_SPHERE,
                                            20.0,
                                            lShip_s,
                                            FALSE,
                                            OBJECT_TYPE_CREATURE);
  while(GetIsObjectValid(oPassanger) ) {
    if(GetIsObjectValid(GetItemPossessedBy(oPassanger,sTicket))) {
      AssignCommand(oPassanger,ClearAllActions(TRUE));
      AssignCommand(oPassanger, JumpToLocation(lShip_f));
      ku_RemoveTicket(GetItemPossessedBy(oPassanger,sTicket));
    }
    if(GetLocalInt(oPassanger,"KU_SHIPABOARD") == iShip ) {
      AssignCommand(oPassanger,ClearAllActions(TRUE));
      AssignCommand(oPassanger, JumpToLocation(lShip_f));
      DeleteLocalInt(oPassanger,"KU_SHIPABOARD");
    }
    if(GetIsPC(oPassanger) && !GetIsDM(oPassanger)) {
      AssignCommand(oPassanger,ClearAllActions(TRUE));
      AssignCommand(oPassanger, JumpToLocation(lShip_f));
    }
    i++;
    oPassanger = GetNextObjectInShape(SHAPE_SPHERE,
                                      20.0,
                                      lShip_s,
                                      FALSE,
                                      OBJECT_TYPE_CREATURE);
//    oPassanger = GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,i);
  }
}

void ku_ShipsTellDepartureTime(string si, object oPC)
{
  if(GetLocalInt(OBJECT_SELF,KU_SHIPS_STRUCT_TAG + "_IsDepart" + si) == 0 ) {
    int iHour = GetTimeHour();
    int iShip = StringToInt(si);
    int x=0,i=0,j;
    string sHour;
    while(x < 24) {
      sHour = IntToString((x + iHour) % 24);
      if(SHIPS_DEBUG)
        SendMessageToPC(GetFirstPC(),"Kontrola hodiny:"+sHour+" pro lod "+si);

      i = 1;
      j = GetLocalInt(OBJECT_SELF,KU_SHIPS_STRUCT_TAG + sHour + "H" + IntToString(i));
      while( (j != 0) && (j != iShip) ) {
        if(SHIPS_DEBUG)
          SendMessageToPC(GetFirstPC(),"V hodine "+sHour+" jede "+IntToString(j));
        i++;
        j = GetLocalInt(OBJECT_SELF,KU_SHIPS_STRUCT_TAG + sHour + "H" + IntToString(i));
        if(SHIPS_DEBUG)
          SendMessageToPC(GetFirstPC(),"V hodine "+sHour+" jede "+IntToString(j));

      }
      if(j != 0)
        break;
      x++;
    }
    if(j != 0)
      SendMessageToPC(oPC,"Lod jede priblizne v "+sHour+" hodin.");
    else
      SendMessageToPC(oPC,"Takova lod nejede");

    return;
  }

  int odjezd = GetLocalInt(OBJECT_SELF,KU_SHIPS_STRUCT_TAG + "_DepartTime" + si);
  string sMessage = ku_GetStringTimeBetween(odjezd,ku_GetTimeStamp(),0);
  SendMessageToPC(oPC,"Lod odjede za "+sMessage);

}
