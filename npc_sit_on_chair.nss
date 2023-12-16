void main()
{
int nChair = 1;
object oChair;
oChair = GetNearestObjectByTag("Stool", OBJECT_SELF, nChair);
ActionSit(oChair);
}
