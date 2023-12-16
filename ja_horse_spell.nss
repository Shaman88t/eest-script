void main()
{
    if(GetLastSpellHarmful()){
        object oEnemy = GetLastSpellCaster();

        ActionMoveAwayFromObject(oEnemy, TRUE);
    }
}
