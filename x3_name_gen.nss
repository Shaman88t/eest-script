void main()
{
     int nRand = Random(100);
     string sType;

     if (nRand < 6) {
        sType = " *vypada nemocne*";
        SetLocalInt(OBJECT_SELF, "IG_ANIMAL_ILL", 1);
        SetLocalString(OBJECT_SELF, "IG_ANIMAL_NAME", GetName(OBJECT_SELF));
     }

     string sName = GetName(OBJECT_SELF) + sType;
     SetLocalString(OBJECT_SELF, "X3_S_RANDOM_NAME", sName);
}
