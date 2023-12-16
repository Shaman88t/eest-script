//#include "nwnx_events"

/**
 * Pozn�mky k time fc�m a hudb�:
 * - hour 06:     GetIsDay = 0, GetIsNight = 0, GetIsDawn = 1, GetIsDusk = 0, hraje BackgroundDay hudba;
 * - hour 07-21:  GetIsDay = 1, GetIsNight = 0, GetIsDawn = 0, GetIsDusk = 0, hraje BackgroundDay hudba;
 * - hour 22:     GetIsDay = 0, GetIsNight = 0, GetIsDawn = 0, GetIsDusk = 1, hraje BackgroundNight hudba;
 * - hour 23-05:  GetIsDay = 0, GetIsNight = 1, GetIsDawn = 0, GetIsDusk = 0, hraje BackgroundNight hudba;
 */

// index of area original music track (day & night)
const string INT_INSTRUMENTAL_ORIGINAL_AREA_MUSIC_DAY = "iOriginalAreaMusicDay";
const string INT_INSTRUMENTAL_ORIGINAL_AREA_MUSIC_NIGHT = "iOriginalAreaMusicNight";
// number of instruments currently playing in area
const string INT_INSTRUMENTAL_INSTRUMENTS_PLAYING = "iInstrumentsPlaying";
// index of track currently playing in area
const string INT_INSTRUMENTAL_TRACK_PLAYING = "iInstrumentTrackPlaying";

void ResetToOriginalAreaMusic(object oArea, int iTrack)
{
    int iTrackPlaying = GetLocalInt(oArea, INT_INSTRUMENTAL_TRACK_PLAYING);
    int iInstrumentsPlaying = GetLocalInt(oArea, INT_INSTRUMENTAL_INSTRUMENTS_PLAYING);

    SetLocalInt(oArea, INT_INSTRUMENTAL_INSTRUMENTS_PLAYING, iInstrumentsPlaying - 1);

    // Prevents playing same music until last delaycommand executed.
    if (iTrack == iTrackPlaying)
    {
        MusicBackgroundStop(oArea);
        DeleteLocalInt(oArea, INT_INSTRUMENTAL_TRACK_PLAYING);
    }

    if (iInstrumentsPlaying <= 1)
    {
        int iOriginalAreaMusicDay = GetLocalInt(oArea, INT_INSTRUMENTAL_ORIGINAL_AREA_MUSIC_DAY);
        int iOriginalAreaMusicNight = GetLocalInt(oArea, INT_INSTRUMENTAL_ORIGINAL_AREA_MUSIC_NIGHT);

        MusicBackgroundChangeDay(oArea, iOriginalAreaMusicDay);
        MusicBackgroundChangeNight(oArea, iOriginalAreaMusicNight);
    }
}

void PlayInstrumentalMusic(object oArea, int iInstrumentalMusic, int iMinutes, int iSeconds)
{
    // music tracks (of this system) starts at row 301 (ambientmusic.2da)
    iInstrumentalMusic += 300;
    float fDelay = IntToFloat(60 * iMinutes + iSeconds);

    int iInstrumentsPlaying = GetLocalInt(oArea, INT_INSTRUMENTAL_INSTRUMENTS_PLAYING);

    if (!iInstrumentsPlaying)
    {
        int iOriginalAreaMusicDay = MusicBackgroundGetDayTrack(oArea);
        int iOriginalAreaMusicNight = MusicBackgroundGetNightTrack(oArea);

        SetLocalInt(oArea, INT_INSTRUMENTAL_ORIGINAL_AREA_MUSIC_DAY, iOriginalAreaMusicDay);
        SetLocalInt(oArea, INT_INSTRUMENTAL_ORIGINAL_AREA_MUSIC_NIGHT, iOriginalAreaMusicNight);
    }

    SetLocalInt(oArea, INT_INSTRUMENTAL_INSTRUMENTS_PLAYING, iInstrumentsPlaying + 1);
    SetLocalInt(oArea, INT_INSTRUMENTAL_TRACK_PLAYING, iInstrumentalMusic);

    if (GetIsDay() || GetIsDawn())
    {
        MusicBackgroundChangeDay(oArea, iInstrumentalMusic);
        MusicBackgroundPlay(oArea);
        // if not assigned to module, delaycommand is assigned to object_self, i guess, which is pc and if pc leaves,
        // delaycommand will not fire.
        AssignCommand(GetModule(), DelayCommand(fDelay, ResetToOriginalAreaMusic(oArea, iInstrumentalMusic)));
    }
    else
    {
        MusicBackgroundChangeNight(oArea, iInstrumentalMusic);
        MusicBackgroundPlay(oArea);
        AssignCommand(GetModule(), DelayCommand(fDelay, ResetToOriginalAreaMusic(oArea, iInstrumentalMusic)));
    }
}

void main()
{
    string sText = "";
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);

    // *************************************************************************
    // Loutna
    // *************************************************************************

    if (sText == "2:12 �ern� o�i")
    {
        PlayInstrumentalMusic(oArea, 1, 2,12);
    }
    else if (sText == "2:38 Lehkost byt�")
    {
        PlayInstrumentalMusic(oArea, 2, 2,38);
    }
    else if (sText == "1:40 Lo�ka")
    {
        PlayInstrumentalMusic(oArea, 3, 1,40);
    }
    else if (sText == "1:24 Pohle� mi do o��")
    {
        PlayInstrumentalMusic(oArea, 4, 1,24);
    }
    else if (sText == "1:38 Ruk�vy")
    {
        PlayInstrumentalMusic(oArea, 5, 1,38);
    }
    else if (sText == "2:05 S tebou, m�j mil�")
    {
        PlayInstrumentalMusic(oArea, 6, 2,05);
    }
    else if (sText == "2:30 Galliard")
    {
        PlayInstrumentalMusic(oArea, 7, 2,30);
    }
    else if (sText == "1:37 Panenky u hr�dku")
    {
        PlayInstrumentalMusic(oArea, 8, 1,37);
    }
    else if (sText == "1:12 Dorensk� hvozd")
    {
        PlayInstrumentalMusic(oArea, 9, 1,12);
    }
    else if (sText == "1:29 Favaryt")
    {
        PlayInstrumentalMusic(oArea, 10, 1,29);
    }
    else if (sText == "2:19 Pod les�kem na ml�z�")
    {
        PlayInstrumentalMusic(oArea, 11, 2,19);
    }
    else if (sText == "0:47 Fale�n� Niegl")
    {
        PlayInstrumentalMusic(oArea, 12, 0,47);
    }
    else if (sText == "4:12 Pod stromy")
    {
        PlayInstrumentalMusic(oArea, 13, 4,12);
    }
    else if (sText == "1:25 Rozmarn�")
    {
        PlayInstrumentalMusic(oArea, 14, 1,25);
    }
    else if (sText == "1:44 Ve st�nu strom� kdysi")
    {
        PlayInstrumentalMusic(oArea, 15, 1,44);
    }
    else if (sText == "2:23 Allison Gross")
    {
        PlayInstrumentalMusic(oArea, 16, 2,23);
    }
    else if (sText == "1:05 Margali")
    {
        PlayInstrumentalMusic(oArea, 17, 1,05);
    }
    else if (sText == "1:55 Putov�n�")
    {
        PlayInstrumentalMusic(oArea, 18, 1,55);
    }
    else if (sText == "1:05 Lesn� tanec")
    {
        PlayInstrumentalMusic(oArea, 19, 1,05);
    }
    else if (sText == "3:55 Mandol�na")
    {
        PlayInstrumentalMusic(oArea, 20, 3,55);
    }
    else if (sText == "1:16 Rozhodov�n�")
    {
        PlayInstrumentalMusic(oArea, 21, 1,16);
    }
    else if (sText == "2:52 Gavotta")
    {
        PlayInstrumentalMusic(oArea, 22, 2,52);
    }
    else if (sText == "1:24 Patron")
    {
        PlayInstrumentalMusic(oArea, 23, 1,24);
    }
    else if (sText == "5:08 Mistrovsk�")
    {
        PlayInstrumentalMusic(oArea, 24, 5,08);
    }
    else if (sText == "3:35 Terega")
    {
        PlayInstrumentalMusic(oArea, 25, 3,35);
    }

    // *************************************************************************
    // Harfa
    // *************************************************************************

    else if (sText == "1:42 Zamy�len�")
    {
        PlayInstrumentalMusic(oArea, 26, 1,42);
    }
    else if (sText == "2:27 V Doubkov� na ja�e")
    {
        PlayInstrumentalMusic(oArea, 27, 2,27);
    }
    else if (sText == "1:52 Kr�sn� Alienor")
    {
        PlayInstrumentalMusic(oArea, 28, 1,52);
    }
    else if (sText == "2:17 Kde jsem nechal o�i")
    {
        PlayInstrumentalMusic(oArea, 29, 2,17);
    }
    else if (sText == "3:02 V sedle")
    {
        PlayInstrumentalMusic(oArea, 30, 3,02);
    }
    else if (sText == "2:29 Na hrotu kop�")
    {
        PlayInstrumentalMusic(oArea, 31, 2,29);
    }
    else if (sText == "3:18 Vzpom�nka na mrtv� hrdiny")
    {
        PlayInstrumentalMusic(oArea, 32, 3,18);
    }
    else if (sText == "2:51 Na tv�ch k��dlech")
    {
        PlayInstrumentalMusic(oArea, 33, 2,51);
    }
    else if (sText == "3:43 Kaval�r a pan�")
    {
        PlayInstrumentalMusic(oArea, 34, 3,43);
    }
    else if (sText == "3:20 Rann� ticho")
    {
        PlayInstrumentalMusic(oArea, 35, 3,20);
    }
    else if (sText == "2:50 Toulky")
    {
        PlayInstrumentalMusic(oArea, 36, 2,50);
    }
    else if (sText == "3:43 Pouta l�sky")
    {
        PlayInstrumentalMusic(oArea, 37, 3,43);
    }
    else if (sText == "3:44 Kerridwen")
    {
        PlayInstrumentalMusic(oArea, 38, 3,44);
    }
    else if (sText == "3:43 Za�arovan� les")
    {
        PlayInstrumentalMusic(oArea, 39, 3,43);
    }
    else if (sText == "3:40 P�es slzy")
    {
        PlayInstrumentalMusic(oArea, 40, 3,40);
    }
    else if (sText == "3:00 �to�i�t�")
    {
        PlayInstrumentalMusic(oArea, 41, 3,00);
    }
    else if (sText == "4:38 Sen harfen�ka")
    {
        PlayInstrumentalMusic(oArea, 42, 4,38);
    }
    else if (sText == "1:34 Jen tak na smutek")
    {
        PlayInstrumentalMusic(oArea, 43, 1,34);
    }
    else if (sText == "1:41 Ztr�c�m t�")
    {
        PlayInstrumentalMusic(oArea, 44, 1,41);
    }
    else if (sText == "3:00 Maelly")
    {
        PlayInstrumentalMusic(oArea, 45, 3,00);
    }
    else if (sText == "1:15 Nikdy nejsem s�m")
    {
        PlayInstrumentalMusic(oArea, 46, 1,15);
    }
    else if (sText == "2:21 Nem�m jen jednu panenku")
    {
        PlayInstrumentalMusic(oArea, 47, 2,21);
    }
    else if (sText == "3:27 Triumf�ln� pochod")
    {
        PlayInstrumentalMusic(oArea, 48, 3,27);
    }
    else if (sText == "3:28 K tanci")
    {
        PlayInstrumentalMusic(oArea, 49, 3,28);
    }
    else if (sText == "2:07 Petries a Atelheid")
    {
        PlayInstrumentalMusic(oArea, 50, 2,07);
    }
    else if (sText == "3:22 V zahrad� Eranin�")
    {
        PlayInstrumentalMusic(oArea, 51, 3,22);
    }

    // *************************************************************************
    // P횝ala
    // *************************************************************************

    else if (sText == "1:23 Divokej tymi�n")
    {
        PlayInstrumentalMusic(oArea, 52, 1,23);
    }
    else if (sText == "2:00 Poh�eb kr�le")
    {
        PlayInstrumentalMusic(oArea, 53, 2,00);
    }
    else if (sText == "6:18 Nad lesem bambusu")
    {
        PlayInstrumentalMusic(oArea, 54, 6,18);
    }
    else if (sText == "2:33 Odpo�inek")
    {
        PlayInstrumentalMusic(oArea, 55, 2,33);
    }
    else if (sText == "2:17 Touha po nad�ji")
    {
        PlayInstrumentalMusic(oArea, 56, 2,17);
    }
    else if (sText == "1:10 Noc na pl�n�ch")
    {
        PlayInstrumentalMusic(oArea, 57, 1,10);
    }
    else if (sText == "4:57 Ostrov volnosti")
    {
        PlayInstrumentalMusic(oArea, 58, 4,57);
    }
    else if (sText == "2:44 Fl�tna z bambusu")
    {
        PlayInstrumentalMusic(oArea, 59, 2,44);
    }
    else if (sText == "1:19 Medv�d� tanec")
    {
        PlayInstrumentalMusic(oArea, 60, 1,19);
    }
    else if (sText == "2:27 Po�ehn�n�")
    {
        PlayInstrumentalMusic(oArea, 61, 2,27);
    }
    else if (sText == "0:50 Lou�en�")
    {
        PlayInstrumentalMusic(oArea, 62, 0,50);
    }
    else if (sText == "1:18 Tam do kopc�")
    {
        PlayInstrumentalMusic(oArea, 63, 1,18);
    }
    else if (sText == "5:30 Sen Prian�v")
    {
        PlayInstrumentalMusic(oArea, 64, 5,30);
    }
    else if (sText == "1:27 Z v��ky pt�k�")
    {
        PlayInstrumentalMusic(oArea, 65, 1,27);
    }
    else if (sText == "2:23 ���n� tanec")
    {
        PlayInstrumentalMusic(oArea, 66, 2,23);
    }
    else if (sText == "1:27 Pod m�s�cem")
    {
        PlayInstrumentalMusic(oArea, 67, 1,27);
    }
    else if (sText == "3:23 Alansujsk� vrchovina")
    {
        PlayInstrumentalMusic(oArea, 68, 3,23);
    }
    else if (sText == "3:13 Lapa� sn�")
    {
        PlayInstrumentalMusic(oArea, 69, 3,13);
    }
    else if (sText == "2:20 Josieho noc")
    {
        PlayInstrumentalMusic(oArea, 70, 2,20);
    }
    else if (sText == "2:05 V popelu")
    {
        PlayInstrumentalMusic(oArea, 71, 2,05);
    }
    else if (sText == "4:41 Chlapci od �eky")
    {
        PlayInstrumentalMusic(oArea, 72, 4,41);
    }

    // *************************************************************************
    // Klav�r
    // *************************************************************************

    else if (sText == "4:40 Sout�zkou")
    {
        PlayInstrumentalMusic(oArea, 73, 4,40);
    }
    else if (sText == "4:21 Pod vrbou")
    {
        PlayInstrumentalMusic(oArea, 74, 4,21);
    }
    else if (sText == "2:33 Tallis Meyer")
    {
        PlayInstrumentalMusic(oArea, 75, 2,33);
    }
    else if (sText == "3:40 N�co za��n�")
    {
        PlayInstrumentalMusic(oArea, 76, 3,40);
    }
    else if (sText == "1:35 Touha po nad�ji")
    {
        PlayInstrumentalMusic(oArea, 77, 1,35);
    }
    else if (sText == "3:05 Paprsek")
    {
        PlayInstrumentalMusic(oArea, 78, 1,35);
    }
    else if (sText == "3:44 St��brn� pt��ek")
    {
        PlayInstrumentalMusic(oArea, 79, 3,04);
    }
    else if (sText == "2:23 Melancholie")
    {
        PlayInstrumentalMusic(oArea, 80, 2,23);
    }
    else if (sText == "5:09 Krystal")
    {
        PlayInstrumentalMusic(oArea, 81, 5,09);
    }
    else if (sText == "6:27 P�se� pro tebe")
    {
        PlayInstrumentalMusic(oArea, 82, 6,27);
    }
    else if (sText == "2:40 P�cha")
    {
        PlayInstrumentalMusic(oArea, 83, 2,40);
    }
    else if (sText == "2:33 Domlouv�n�")
    {
        PlayInstrumentalMusic(oArea, 84, 2,33);
    }
    else if (sText == "4:29 U maj�ku")
    {
        PlayInstrumentalMusic(oArea, 85, 4,29);
    }
    else if (sText == "3:22 Tul�k")
    {
        PlayInstrumentalMusic(oArea, 86, 3,22);
    }
    else if (sText == "2:55 Posledn� den")
    {
        PlayInstrumentalMusic(oArea, 87, 2,55);
    }
    else if (sText == "1:54 Lucidovy sny")
    {
        PlayInstrumentalMusic(oArea, 88, 1,54);
    }
    else if (sText == "2:20 Sn�n�")
    {
        PlayInstrumentalMusic(oArea, 89, 2,20);
    }
    else if (sText == "4:38 P�edehra")
    {
        PlayInstrumentalMusic(oArea, 90, 4,38);
    }
    else if (sText == "3:00 Vzpom�nky")
    {
        PlayInstrumentalMusic(oArea, 91, 3,00);
    }
    else if (sText == "3:09 U Hrumbur�ce")
    {
        PlayInstrumentalMusic(oArea, 92, 3,09);
    }
    else if (sText == "1:56 Samota v hor�ch")
    {
        PlayInstrumentalMusic(oArea, 93, 1,56);
    }
    else if (sText == "3:48 More�v z�kon")
    {
        PlayInstrumentalMusic(oArea, 94, 3,48);
    }
    else if (sText == "4:10 Mot�l� sen")
    {
        PlayInstrumentalMusic(oArea, 95, 4,10);
    }
    else if (sText == "2:26 �ance")
    {
        PlayInstrumentalMusic(oArea, 96, 2,26);
    }
    else if (sText == "4:10 Nocturne")
    {
        PlayInstrumentalMusic(oArea, 97, 4,10);
    }
    else if (sText == "3:11 Pod hv�zdami")
    {
        PlayInstrumentalMusic(oArea, 98, 3,11);
    }
    else if (sText == "3:09 N�vraty")
    {
        PlayInstrumentalMusic(oArea, 99, 3,09);
    }
    else if (sText == "4:27 Promen�da")
    {
        PlayInstrumentalMusic(oArea, 100, 4,27);
    }
    else if (sText == "3:39 Julietta")
    {
        PlayInstrumentalMusic(oArea, 101, 3,39);
    }
    else if (sText == "2:58 Poslen� v�spa")
    {
        PlayInstrumentalMusic(oArea, 102, 2,58);
    }
    else if (sText == "3:28 Improvizace")
    {
        PlayInstrumentalMusic(oArea, 103, 3,28);
    }
    else if (sText == "4:33 Balanc")
    {
        PlayInstrumentalMusic(oArea, 104, 4,33);
    }
    else if (sText == "3:01 Ob� zim�")
    {
        PlayInstrumentalMusic(oArea, 105, 3,01);
    }
    else if (sText == "3:30 Zimn� krajina")
    {
        PlayInstrumentalMusic(oArea, 106, 3,30);
    }
    else if (sText == "3:07 Po v�esovi�ti")
    {
        PlayInstrumentalMusic(oArea, 107, 3,07);
    }
    else if (sText == "1:38 Georgiana")
    {
        PlayInstrumentalMusic(oArea, 108, 1,38);
    }
    else if (sText == "4:56 Mistrovsk�")
    {
        PlayInstrumentalMusic(oArea, 109, 4,56);
    }

    // *************************************************************************
    // Kytara
    // *************************************************************************

    else if (sText == "1:35 Sv�t�n�")
    {
        PlayInstrumentalMusic(oArea, 110, 1,35);
    }
    else if (sText == "2:54 Ukol�bavka")
    {
        PlayInstrumentalMusic(oArea, 111, 2,54);
    }
    else if (sText == "3:11 Albeniz")
    {
        PlayInstrumentalMusic(oArea, 112, 3,11);
    }
    else if (sText == "3:45 Zamy�len�")
    {
        PlayInstrumentalMusic(oArea, 113, 2,45);
    }
    else if (sText == "3:42 K p��b�h�m vyhr�v�m")
    {
        PlayInstrumentalMusic(oArea, 114, 3,42);
    }
    else if (sText == "4:21 Dom�")
    {
        PlayInstrumentalMusic(oArea, 115, 4,21);
    }
    else if (sText == "2:57 Ji�n� v�tr")
    {
        PlayInstrumentalMusic(oArea, 116, 2,57);
    }
    else if (sText == "4:28 Koruna v�tru")
    {
        PlayInstrumentalMusic(oArea, 117, 4,28);
    }
    else if (sText == "3:06 Soledat")
    {
        PlayInstrumentalMusic(oArea, 118, 3,06);
    }
    else if (sText == "3:44 Vyprav��")
    {
        PlayInstrumentalMusic(oArea, 119, 3,44);
    }
    else if (sText == "2:26 Danilly tan��")
    {
        PlayInstrumentalMusic(oArea, 120, 2,26);
    }
    else if (sText == "2:04 D�tstv�")
    {
        PlayInstrumentalMusic(oArea, 121, 2,04);
    }
    else if (sText == "2:09 Pou�tn� sk�ly")
    {
        PlayInstrumentalMusic(oArea, 122, 2,09);
    }
    else if (sText == "2:41 Soleas")
    {
        PlayInstrumentalMusic(oArea, 123, 2,41);
    }
    else if (sText == "2:46 Mal� Rowena")
    {
        PlayInstrumentalMusic(oArea, 124, 2,46);
    }
    else if (sText == "2:21 V�tvi�ka rozmar�ny")
    {
        PlayInstrumentalMusic(oArea, 125, 2,21);
    }
    else if (sText == "5:06 Zatm�n� m�s�ce")
    {
        PlayInstrumentalMusic(oArea, 126, 5,06);
    }
    else if (sText == "3:55 Rodrigo")
    {
        PlayInstrumentalMusic(oArea, 127, 3,55);
    }
    else if (sText == "1:57 Rej sv�tel")
    {
        PlayInstrumentalMusic(oArea, 128, 1,57);
    }
    else if (sText == "5:15 P�ed branami m�sta")
    {
        PlayInstrumentalMusic(oArea, 129, 5,15);
    }
    else if (sText == "3:46 Anjela")
    {
        PlayInstrumentalMusic(oArea, 130, 3,46);
    }
    else if (sText == "4:12 P�ekvapen� cik�n")
    {
        PlayInstrumentalMusic(oArea, 131, 4,12);
    }
    else if (sText == "2:06 Ve tv�ch o��ch")
    {
        PlayInstrumentalMusic(oArea, 132, 2,06);
    }
    else if (sText == "3:03 Nen� dne bez noci")
    {
        PlayInstrumentalMusic(oArea, 133, 3,03);
    }
    else if (sText == "6:04 D�t na st�e�e")
    {
        PlayInstrumentalMusic(oArea, 134, 6,04);
    }
    else if (sText == "2:05 Vyhr�v�m slav�k�m")
    {
        PlayInstrumentalMusic(oArea, 135, 2,05);
    }
    else if (sText == "4:23 Signorie")
    {
        PlayInstrumentalMusic(oArea, 136, 4,23);
    }
    else if (sText == "7:36 Corrientes")
    {
        PlayInstrumentalMusic(oArea, 137, 7,36);
    }
    else if (sText == "3:02 Do rytmu")
    {
        PlayInstrumentalMusic(oArea, 138, 3,02);
    }
    else if (sText == "4:26 Tanec jara")
    {
        PlayInstrumentalMusic(oArea, 139, 4,26);
    }
    else if (sText == "4:50 Kr�ska z pou�tn�ho m�sta")
    {
        PlayInstrumentalMusic(oArea, 140, 4,50);
    }
    else if (sText == "4:41 Seren�da")
    {
        PlayInstrumentalMusic(oArea, 141, 4,41);
    }
    else if (sText == "6:53 Majstr�tik")
    {
        PlayInstrumentalMusic(oArea, 142, 6,53);
    }
    else if (sText == "1:15 Kolib��k")
    {
        PlayInstrumentalMusic(oArea, 143, 1,15);
    }
    else if (sText == "3:36 Prvn� j�zda")
    {
        PlayInstrumentalMusic(oArea, 144, 3,36);
    }

    // *************************************************************************
    // Housle
    // *************************************************************************

    else if (sText == "3:26 Velk� mo�e")
    {
        PlayInstrumentalMusic(oArea, 145, 3,26);
    }
    else if (sText == "2:00 Vesel� houslista")
    {
        PlayInstrumentalMusic(oArea, 146, 2,00);
    }
    else if (sText == "1:16 Pod horami")
    {
        PlayInstrumentalMusic(oArea, 147, 1,16);
    }
    else if (sText == "3:20 Prach a popel")
    {
        PlayInstrumentalMusic(oArea, 148, 3,20);
    }
    else if (sText == "0:37 Carolan�v sen")
    {
        PlayInstrumentalMusic(oArea, 149, 0,37);
    }
    else if (sText == "3:22 Srdce a dech")
    {
        PlayInstrumentalMusic(oArea, 150, 3,22);
    }
    else if (sText == "2:06 Dopis mil�mu")
    {
        PlayInstrumentalMusic(oArea, 151, 2,06);
    }
    else if (sText == "2:36 Pl�� nad Karathou")
    {
        PlayInstrumentalMusic(oArea, 152, 2,36);
    }
    else if (sText == "1:47 N��ek nad mrtv�m")
    {
        PlayInstrumentalMusic(oArea, 153, 1,47);
    }
    else if (sText == "3:29 Pt��ek v Prahvozdu")
    {
        PlayInstrumentalMusic(oArea, 154, 3,29);
    }
    else if (sText == "3:53 �alozp�v za hrab�te")
    {
        PlayInstrumentalMusic(oArea, 155, 3,53);
    }

    // *************************************************************************
    //
    // *************************************************************************
}
