const string COLORTOKEN = "                  ##################$%&'()*+,-./0123456789:;;==?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[[]^_`abcdefghijklmnopqrstuvwxyz{|}~~€€‚f„…†‡^‰Š‹‹‹ŽŽ‘’“”••–—~™š›››žžžžž¤¤¤¤¦§¨©©«¬¬®®°±±±´µ¶·¸¸¸»»»»»»ÁÂÂÄÄÄÉÉÉËÍÍÎÎÓÓÓÓÔÔÖ××ÚÚÚÜÝÝáááâäääééééëëííîîóóóóôöö÷÷úúúüýýýýýý";

// funkcia vracia "farebne upraveny retazec > podla pola COLORTOKEN
string ColorString(string sText, int nRed=255, int nGreen=255, int nBlue=255)
{
    return "<c" + GetSubString(COLORTOKEN, nRed, 1) + GetSubString(COLORTOKEN, nGreen, 1) + GetSubString(COLORTOKEN, nBlue, 1) + ">" + sText + "</c>";
}

void main()
{
    object oPC = GetPCSpeaker();

    int iStamina = GetLocalInt(oPC,"JA_STAMINA");
    int iMaxStamina = 2500 + 250 * GetHitDice(oPC);
    float fPercent = (IntToFloat(iStamina)/IntToFloat(iMaxStamina))*100.0;
    int iPer = FloatToInt(fPercent);
    int iGraf = FloatToInt(0.2*fPercent);

    int iRed = (iPer > 50) ? (255-4*(iPer-50)) : 255;
    int iGreen = (iPer <= 50) ? (4*iPer) : 150;

    string sText = "|";
    int i;
    for(i=0; i<20;i++)
        if(i<iGraf)
            sText += "#";
        else
            sText += "-";
    sText += ("| " + IntToString(iPer) + "%");
    //sText += IntToString(iRed)+IntToString(iGreen);

    string sVypis = ColorString(sText,iRed,iGreen,0);

    SetCustomToken(200,sVypis);
}
