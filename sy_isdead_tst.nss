/*
    - zistim ci na dusi bytosti mam IsDead = 1
    - ak ano, postava pojde spet do pekla - ANTICHEAT
*/
#include "sy_main_lib"
#include "aps_include"

int StartingConditional()
{
    object oPC       = GetPCSpeaker();
    object oSoulItem = sy_has_soulitem(oPC);

    if (GetLocalInt(oSoulItem,"isDead")==1)
    {   //hrac je dead a snazi sa dostat z pekla podvodom
        //nejaky krasny vypis do logu alebo shout aby kazdy vedel
        //co sa deje
        //TU VLOZTE KOD PRE ZAPIS DO DATABAZY
        //WriteTimestampedLogEntry("cheat unik z podsvetia - "+GetPCPlayerName(oPC)+" - "+GetName(oPC));

        SQLExecDirect("INSERT INTO cheaters (player, tag, date) VALUES ('"+GetPCPlayerName(oPC)+"', '"+GetName(oPC)+"', NOW())");
        //SendMessageToPC(oPC,"Welcome to hell");
        AssignCommand(oPC, ClearAllActions(FALSE));
        AssignCommand(oPC, JumpToObject(GetWaypointByTag("WP_DEATH")));
    }

    return 0;
}

