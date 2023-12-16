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

    if (sText == "2:12 Èerné oèi")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "2:38 Lehkost bytí")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "1:40 Loïka")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "1:24 Pohleï mi do oèí")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "1:38 Rukávy")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "2:05 S tebou, mùj milı")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "2:30 Galliard")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "1:37 Panenky u hrádku")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "1:12 Dorenskı hvozd")
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
    else if (sText == "2:19 Pod lesíkem na mlází")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "0:47 Falešnı Niegl")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "4:12 Pod stromy")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "1:25 Rozmarná")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "1:44 Ve stínu stromù kdysi")
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
    else if (sText == "1:55 Putování")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "1:05 Lesní tanec")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "3:55 Mandolína")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "1:16 Rozhodování")
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
    else if (sText == "5:08 Mistrovská")
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

    else if (sText == "1:42 Zamyšlení")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "2:27 V Doubkovì na jaøe")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "1:52 Krásná Alienor")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "2:17 Kde jsem nechal oèi")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "3:02 V sedle")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "2:29 Na hrotu kopí")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "3:18 Vzpomínka na mrtvé hrdiny")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "2:51 Na tvıch køídlech")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "3:43 Kavalír a paní")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "3:20 Ranní ticho")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "2:50 Toulky")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "3:43 Pouta lásky")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "3:44 Kerridwen")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "3:43 Zaèarovanı les")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "3:40 Pøes slzy")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "3:00 Útoèištì")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "4:38 Sen harfeníka")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "1:34 Jen tak na smutek")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "1:41 Ztrácím tì")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "3:00 Maelly")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "1:15 Nikdy nejsem sám")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "2:21 Nemám jen jednu panenku")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "3:27 Triumfální pochod")
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
    else if (sText == "3:22 V zahradì Eraninì")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }

    // *************************************************************************
    // Píšala
    // *************************************************************************

    else if (sText == "1:23 Divokej tymián")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "2:00 Pohøeb krále")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "6:18 Nad lesem bambusu")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "2:33 Odpoèinek")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "2:17 Touha po nadìji")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "1:10 Noc na pláních")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "4:57 Ostrov volnosti")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "2:44 Flétna z bambusu")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "1:19 Medvìdí tanec")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "2:27 Poehnání")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "0:50 Louèení")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "1:18 Tam do kopcù")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "5:30 Sen Prianùv")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "1:27 Z vıšky ptákù")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "2:23 Øíèní tanec")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "1:27 Pod mìsícem")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "3:23 Alansujská vrchovina")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "3:13 Lapaè snù")
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
    else if (sText == "4:41 Chlapci od øeky")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }

    // *************************************************************************
    // Klavír
    // *************************************************************************

    else if (sText == "4:40 Soutìzkou")
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
    else if (sText == "3:40 Nìco zaèíná")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "1:35 Touha po nadìji")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "3:05 Paprsek")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "3:44 Støíbrnı ptáèek")
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
    else if (sText == "6:27 Píseò pro tebe")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "2:40 Pıcha")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "2:33 Domlouvání")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "4:29 U majáku")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "3:22 Tulák")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "2:55 Poslední den")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "1:54 Lucidovy sny")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "2:20 Snìní")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "4:38 Pøedehra")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "3:00 Vzpomínky")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "3:09 U Hrumburáce")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "1:56 Samota v horách")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "3:48 Moreùv zákon")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "4:10 Motılí sen")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "2:26 Šance")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "4:10 Nocturne")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "3:11 Pod hvìzdami")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "3:09 Návraty")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "4:27 Promenáda")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "3:39 Julietta")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "2:58 Poslení vıspa")
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
    else if (sText == "3:01 Obì zimì")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }
    else if (sText == "3:30 Zimní krajina")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }
    else if (sText == "3:07 Po vøesovišti")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }
    else if (sText == "1:38 Georgiana")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }
    else if (sText == "4:56 Mistrovská")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }

    // *************************************************************************
    // Kytara
    // *************************************************************************

    else if (sText == "1:35 Svítání")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "2:54 Ukolébavka")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "3:11 Albeniz")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "3:45 Zamyšlení")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "3:42 K pøíbìhùm vyhrávám")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "4:21 Domù")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "2:57 Jiní vítr")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "4:28 Koruna vìtru")
    {
        return GetInstrumentalPerformRank(oPC, 10);
    }
    else if (sText == "3:06 Soledat")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "3:44 Vypravìè")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "2:26 Danilly tanèí")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "2:04 Dìtství")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "2:09 Pouštní skály")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "2:41 Soleas")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "2:46 Malá Rowena")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "2:21 Vìtvièka rozmarıny")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "5:06 Zatmìní mìsíce")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "3:55 Rodrigo")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "1:57 Rej svìtel")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "5:15 Pøed branami mìsta")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "3:46 Anjela")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "4:12 Pøekvapenı cikán")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "2:06 Ve tvıch oèích")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "3:03 Není dne bez noci")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "6:04 Déšt na støeše")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }
    else if (sText == "2:05 Vyhrávám slavíkùm")
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
    else if (sText == "4:50 Kráska z pouštního mìsta")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }
    else if (sText == "4:41 Serenáda")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }
    else if (sText == "6:53 Majstrštik")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }
    else if (sText == "1:15 Kolibøík")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }
    else if (sText == "3:36 První jízda")
    {
        return GetInstrumentalPerformRank(oPC, 35);
    }

    // *************************************************************************
    // Housle
    // *************************************************************************

    else if (sText == "3:26 Velké moøe")
    {
        return GetInstrumentalPerformRank(oPC, 5);
    }
    else if (sText == "2:00 Veselı houslista")
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
    else if (sText == "0:37 Carolanùv sen")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "3:22 Srdce a dech")
    {
        return GetInstrumentalPerformRank(oPC, 15);
    }
    else if (sText == "2:06 Dopis milému")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "2:36 Pláè nad Karathou")
    {
        return GetInstrumentalPerformRank(oPC, 20);
    }
    else if (sText == "1:47 Náøek nad mrtvım")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "3:29 Ptáèek v Prahvozdu")
    {
        return GetInstrumentalPerformRank(oPC, 25);
    }
    else if (sText == "3:53 alozpìv za hrabìte")
    {
        return GetInstrumentalPerformRank(oPC, 30);
    }

    // *************************************************************************
    //
    // *************************************************************************

    return FALSE;
}
