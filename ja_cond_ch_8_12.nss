int StartingConditional()
{
    int iCh = GetAbilityScore(GetPCSpeaker(),ABILITY_CHARISMA);

    return (iCh >= 8) && (iCh <= 12);
}

