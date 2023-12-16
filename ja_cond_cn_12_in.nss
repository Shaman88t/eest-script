int StartingConditional()
{
    int iCon = GetAbilityScore(GetPCSpeaker(),ABILITY_CONSTITUTION);

    return (iCon >= 12);
}
