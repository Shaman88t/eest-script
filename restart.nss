//restarting header

#include "ja_lib"

void finish(){
    object oPC;
    location lLoc;

/*    oPC = GetFirstPC();
    while (GetIsObjectValid(oPC))
    {
        SavePlayer(oPC);
        oPC = GetNextPC();
    }*/
    //ExportAllCharacters();
    SpeakString("Server bude restartovan za 2 minuty!!",TALKVOLUME_SHOUT);
    WriteTimestampedLogEntry("SERVER RESTARTED");

    StoreTime();
}

void warning1(){
    SpeakString("Server bude restartovan za 30 minut!!",TALKVOLUME_SHOUT);
    WriteTimestampedLogEntry("PLAYERS WARNED 1");
}

void warning2(){
    SpeakString("Server bude restartovan za 10 minut!!",TALKVOLUME_SHOUT);
    WriteTimestampedLogEntry("PLAYERS WARNED 2");
}

void warning3(){
    SpeakString("Server bude restartovan za 5 minut!!",TALKVOLUME_SHOUT);
    WriteTimestampedLogEntry("PLAYERS WARNED 3");
}

void kick_players() {

    object oPC;
    location lLoc;
    int i = 0;

    oPC = GetFirstPC();
    while (GetIsObjectValid(oPC))
    {
        DelayCommand(4.0*i,SavePlayer(oPC));
        DelayCommand(4.0*i + 2.0,BootPC(oPC));
        oPC = GetNextPC();
        i++;
    }

}

void restart(float fDelay=42870.0f, float fWarning1=1800.0f, float fWarning2=600.0f, float fWarning3=300.0f){
    DelayCommand(fDelay-fWarning1, warning1());
    DelayCommand(fDelay-fWarning2, warning2());
    DelayCommand(fDelay-fWarning3, warning3());
    DelayCommand(fDelay-fWarning3+100.0f, kick_players());
    DelayCommand(fDelay-120.0f, finish());
}

