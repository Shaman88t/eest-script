void main()
{
    effect ePetrify = EffectPetrify();
    object oSelf = OBJECT_SELF;

    DelayCommand(1.5, ApplyEffectToObject( DURATION_TYPE_PERMANENT, ePetrify, oSelf ));
    SetPlotFlag( OBJECT_SELF, TRUE );
}
