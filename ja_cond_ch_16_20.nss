int StartingConditional()
{
    int iCh = GetAbilityScore(GetPCSpeaker(),ABILITY_CHARISMA);

    return (iCh >= 16) && (iCh <= 20);
}
