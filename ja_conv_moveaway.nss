void main()
{
    ClearAllActions();
    SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, FALSE);
    SetActionMode(OBJECT_SELF, ACTION_MODE_DETECT, FALSE);
    ActionMoveAwayFromObject(GetPCSpeaker(), TRUE, 40.0f);
}
