void main()
{
    object oDammager = GetLastDamager(OBJECT_SELF);
    WriteTimestampedLogEntry("Zakopany poklad znicen postavou " + GetName(oDammager));
}
