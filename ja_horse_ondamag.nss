void main()
{
    object oDamager = GetLastDamager();

    ClearAllActions(TRUE);
    ActionMoveAwayFromObject( oDamager, TRUE );
}
