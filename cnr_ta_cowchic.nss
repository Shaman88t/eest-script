/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_ta_cowchic
//
//  Desc:  Alters the greeting text to denote whether
//         the animal has consumed enough food to
//         produce its resource.
//
//  Author: David Bobeck 24Dec02
//
/////////////////////////////////////////////////////////
int StartingConditional()
{
  SetCustomToken(500, "\n");

  int nFoodPoints = GetLocalInt(OBJECT_SELF, "nCnrFoodPoints");

  if (GetTag(OBJECT_SELF) == "cnrChicken")
  {
    if (nFoodPoints >= 6)
    {
      SetCustomToken(22020, "Tato slepicka je dobre nakrmena. Vypada ze je pripravena snest vejce!");
    }
    else
    {
      SetCustomToken(22020, "Tato slepicka je hladova a musi byt nakrmena. Neni ted schopna snest vejce.");
    }
  }
  if (GetTag(OBJECT_SELF) == "cnrCow")
  {
    if (nFoodPoints >= 6)
    {
      SetCustomToken(22020, "Tato krava je dobre nakrmena. Vypada ze je pripravena dat mleko!");
    }
    else
    {
      SetCustomToken(22020, "Tato krava je hladova a musi byt nakrmena. Neni ted schopna dat mleko.");
    }
  }

  // Always show something
  return TRUE;
}
