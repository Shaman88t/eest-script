int StartingConditional()
{
    int iCh = GetAbilityScore(GetPCSpeaker(),ABILITY_CHARISMA);

    return (iCh >= 5) && (iCh <= 7);
}
