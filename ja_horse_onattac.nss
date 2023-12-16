void main()
{
    object oAttacker = GetLastAttacker(OBJECT_SELF);

    ClearAllActions(TRUE);
    ActionMoveAwayFromObject( oAttacker, TRUE );
}
