int StartingConditional()
{
    int iCh = GetAbilityScore(GetPCSpeaker(),ABILITY_CHARISMA);

    return (iCh >= 13) && (iCh <= 15);
}


