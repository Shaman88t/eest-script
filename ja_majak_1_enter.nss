void main()
{
    object oPC = GetEnteringObject();

    if( !GetLocalInt( oPC, "JA_MAJAK1_ENTER" ) ){
        SetLocalInt( oPC, "JA_MAJAK1_ENTER", 1);
    }
    else return;

    string sNotice = "Jakmile vejdes, od nosu se ti zaryje pach starobylosti. Na vsem je radna vrstva prachu. Dvere se za tebou s vrznutim zaklapnou.";

    int iCheck = GetSkillRank( SKILL_LISTEN );
    if( d20() + iCheck > 10 )
        sNotice += " Jinak je tu naproste ticho, neni slyset ani racky zvenci. Cele to nahani strasidelny pocit.";

    iCheck = GetSkillRank( SKILL_SPOT );
    if( d20() + iCheck > 10 )
        sNotice += " Nikde nejsou zadne okna. Vsude je rozbity a prevraceny nabitek, zaujaly te jen schody a padaci dvere, ktere vedou kamsi do temnych hlubin.";

    SendMessageToPC( oPC, sNotice );
}
