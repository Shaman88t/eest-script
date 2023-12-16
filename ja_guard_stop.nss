void backUp(){
    SetLocalInt( OBJECT_SELF, "JA_GUARD_STOP", 0 );
}

int StartingConditional()
{
    SetLocalInt( OBJECT_SELF, "JA_GUARD_STOP", 1 );

    DelayCommand( 5.0f, backUp() );

    return TRUE;
}
