void main()
{
  if (GetTag(OBJECT_SELF) == "PlantableField") SetLocalInt(GetEnteringObject(),"iAmInField",0);
  if (GetTag(OBJECT_SELF) == "PlantableWaterField") SetLocalInt(GetEnteringObject(),"iAmInWaterField",0);

}
