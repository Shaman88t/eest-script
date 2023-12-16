// * Pokud je rasa zvire, tak je pravdepodobnost ze bude
// * nemocne. Promenna nChance urci kolik % ze 100%
// * bude nemocnych.
// Kucik 19.10.2008 Upraveno jen na NPC z DYN, spawnu

void main()
{
   if(!GetLocalInt(OBJECT_SELF,"KU_DYNAMICALY_SPAWNED"))
     return;

   if((GetRacialType(OBJECT_SELF)) == RACIAL_TYPE_ANIMAL) {

     int nChance = 5;
     int nRand = Random(100);

     if (nRand < nChance) {

        string sType = " *vypada nemocne*";
        string sName = GetName(OBJECT_SELF) + sType;

        SetLocalInt(OBJECT_SELF, "IG_ANIMAL_ILL", 1);
        SetLocalString(OBJECT_SELF, "IG_ANIMAL_NAME", GetName(OBJECT_SELF));
        SetName(OBJECT_SELF,sName);
     }
   }

}
