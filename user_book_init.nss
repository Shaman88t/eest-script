#include "cnr_recipe_utils"

void main()
{
  string sKeyToBook;
  string sDesc;
  string sKeyToRecipe;

  PrintString("user_book_init");

  /////////////////////////////////////////////////////////
  // Default CNR reference recipe book for cnrInfusingMinor
  /////////////////////////////////////////////////////////
  sKeyToBook = CnrRecipeBookCreateBook("cnrCardsInfMin", "cnrInfusingMinor");
  sDesc = "This tale is used to infuse magic into wands of Power ";
  CnrRecipeBookSetDescription(sKeyToBook, sDesc);

  /////////////////////////////////////////////////////////
  // Default CNR reference recipe book for cnrInfusingMinor
  /////////////////////////////////////////////////////////
  sKeyToBook = CnrRecipeBookCreateBook("cnrCardsInfLes", "cnrInfusingLess");
  sDesc = "This tale is used to infuse magic into wands of Power ";
  CnrRecipeBookSetDescription(sKeyToBook, sDesc);

  /////////////////////////////////////////////////////////
  // Default CNR reference recipe book for cnrInfusingMinor
  /////////////////////////////////////////////////////////
  sKeyToBook = CnrRecipeBookCreateBook("cnrCardsInfAvg", "cnrInfusingAver");
  sDesc = "This tale is used to infuse magic into wands of Power ";
  CnrRecipeBookSetDescription(sKeyToBook, sDesc);

}
