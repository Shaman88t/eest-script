//#include "nwnx_events"

int GetInstrumentalPerformRank(object oPC, int iValue)
{
    return GetSkillRank(SKILL_PERFORM, oPC) >= iValue;
}

int StartingConditional()
{
    string sText = "";
    object oPC = GetPCSpeaker();

    // *************************************************************************
    // Loutna
    // *************************************************************************

    if (sText == "2:12 �ern� o�i")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "2:38 Lehkost byt�")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "1:40 Lo�ka")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "1:24 Pohle� mi do o��")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "1:38 Ruk�vy")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "2:05 S tebou, m�j mil�")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "2:30 Galliard")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "1:37 Panenky u hr�dku")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "1:12 Dorensk� hvozd")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "1:44 Cavendish")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "1:29 Favaryt")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "2:19 Pod les�kem na ml�z�")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "0:47 Fale�n� Niegl")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "4:12 Pod stromy")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "1:25 Rozmarn�")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "1:44 Ve st�nu strom� kdysi")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "2:23 Allison Gross")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "1:05 Margali")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "1:55 Putov�n�")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "1:05 Lesn� tanec")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "3:55 Mandol�na")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "1:16 Rozhodov�n�")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "2:52 Gavotta")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "1:24 Patron")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }
    else if (sText == "5:08 Mistrovsk�")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }
    else if (sText == "3:35 Terega")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }

    // *************************************************************************
    // Harfa
    // *************************************************************************

    else if (sText == "1:42 Zamy�len�")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "2:27 V Doubkov� na ja�e")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "1:52 Kr�sn� Alienor")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "2:17 Kde jsem nechal o�i")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "3:02 V sedle")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "2:29 Na hrotu kop�")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "3:18 Vzpom�nka na mrtv� hrdiny")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "2:51 Na tv�ch k��dlech")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "3:43 Kaval�r a pan�")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "3:20 Rann� ticho")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "2:50 Toulky")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "3:43 Pouta l�sky")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "3:44 Kerridwen")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "3:43 Za�arovan� les")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "3:40 P�es slzy")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "3:00 �to�i�t�")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "4:38 Sen harfen�ka")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "1:34 Jen tak na smutek")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "1:41 Ztr�c�m t�")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "3:00 Maelly")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "1:15 Nikdy nejsem s�m")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "2:21 Nem�m jen jednu panenku")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "3:27 Triumf�ln� pochod")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "3:28 K tanci")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }
    else if (sText == "2:07 Petries a Atelheid")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }
    else if (sText == "3:22 V zahrad� Eranin�")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }

    // *************************************************************************
    // P횝ala
    // *************************************************************************

    else if (sText == "1:23 Divokej tymi�n")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "2:00 Poh�eb kr�le")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "6:18 Nad lesem bambusu")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "2:33 Odpo�inek")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "2:17 Touha po nad�ji")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "1:10 Noc na pl�n�ch")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "4:57 Ostrov volnosti")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "2:44 Fl�tna z bambusu")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "1:19 Medv�d� tanec")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "2:27 Po�ehn�n�")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "0:50 Lou�en�")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "1:18 Tam do kopc�")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "5:30 Sen Prian�v")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "1:27 Z v��ky pt�k�")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "2:23 ���n� tanec")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "1:27 Pod m�s�cem")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "3:23 Alansujsk� vrchovina")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "3:13 Lapa� sn�")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "2:20 Josieho noc")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "2:05 V popelu")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }
    else if (sText == "4:41 Chlapci od �eky")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }

    // *************************************************************************
    // Klav�r
    // *************************************************************************

    else if (sText == "4:40 Sout�zkou")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "4:21 Pod vrbou")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "2:33 Tallis Meyer")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "3:40 N�co za��n�")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "1:35 Touha po nad�ji")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "3:05 Paprsek")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "3:44 St��brn� pt��ek")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "2:23 Melancholie")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "5:09 Krystal")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "6:27 P�se� pro tebe")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "2:40 P�cha")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "2:33 Domlouv�n�")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "4:29 U maj�ku")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "3:22 Tul�k")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "2:55 Posledn� den")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "1:54 Lucidovy sny")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "2:20 Sn�n�")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "4:38 P�edehra")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "3:00 Vzpom�nky")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "3:09 U Hrumbur�ce")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "1:56 Samota v hor�ch")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "3:48 More�v z�kon")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "4:10 Mot�l� sen")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "2:26 �ance")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "4:10 Nocturne")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "3:11 Pod hv�zdami")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "3:09 N�vraty")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "4:27 Promen�da")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "3:39 Julietta")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "2:58 Poslen� v�spa")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "3:28 Improvizace")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "4:33 Balanc")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }
    else if (sText == "3:01 Ob� zim�")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }
    else if (sText == "3:30 Zimn� krajina")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }
    else if (sText == "3:07 Po v�esovi�ti")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }
    else if (sText == "1:38 Georgiana")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }
    else if (sText == "4:56 Mistrovsk�")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }

    // *************************************************************************
    // Kytara
    // *************************************************************************

    else if (sText == "1:35 Sv�t�n�")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "2:54 Ukol�bavka")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "3:11 Albeniz")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "3:45 Zamy�len�")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "3:42 K p��b�h�m vyhr�v�m")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "4:21 Dom�")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "2:57 Ji�n� v�tr")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "4:28 Koruna v�tru")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "3:06 Soledat")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "3:44 Vyprav��")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "2:26 Danilly tan��")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "2:04 D�tstv�")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "2:09 Pou�tn� sk�ly")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "2:41 Soleas")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "2:46 Mal� Rowena")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "2:21 V�tvi�ka rozmar�ny")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "5:06 Zatm�n� m�s�ce")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "3:55 Rodrigo")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "1:57 Rej sv�tel")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "5:15 P�ed branami m�sta")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "3:46 Anjela")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "4:12 P�ekvapen� cik�n")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "2:06 Ve tv�ch o��ch")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "3:03 Nen� dne bez noci")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "6:04 D�t na st�e�e")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "2:05 Vyhr�v�m slav�k�m")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "4:23 Signorie")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "7:36 Corrientes")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "3:02 Do rytmu")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "4:26 Tanec jara")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }
    else if (sText == "4:50 Kr�ska z pou�tn�ho m�sta")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }
    else if (sText == "4:41 Seren�da")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }
    else if (sText == "6:53 Majstr�tik")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }
    else if (sText == "1:15 Kolib��k")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }
    else if (sText == "3:36 Prvn� j�zda")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }

    // *************************************************************************
    // Housle
    // *************************************************************************

    else if (sText == "3:26 Velk� mo�e")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "2:00 Vesel� houslista")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "1:16 Pod horami")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "3:20 Prach a popel")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "0:37 Carolan�v sen")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "3:22 Srdce a dech")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "2:06 Dopis mil�mu")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "2:36 Pl�� nad Karathou")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "1:47 N��ek nad mrtv�m")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "3:29 Pt��ek v Prahvozdu")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "3:53 �alozp�v za hrab�te")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }

    // *************************************************************************
    //
    // *************************************************************************

    return FALSE;
}
