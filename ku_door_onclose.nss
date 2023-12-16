void main()
{
  int isDay = GetIsDay();
  object oDvere = OBJECT_SELF;
  int iDoorLock = GetLocalInt(oDvere, "DOORLOCK");

   if(!isDay && iDoorLock == 1) //v noci zavrit
   {

       SetLocked(oDvere,TRUE);

   }
   else if(isDay && iDoorLock == 2) //ve dne zavrit
   {
       SetLocked(oDvere,TRUE);
   }
   else if(iDoorLock == 3) //vzdy
   {
//       ActionCloseDoor(oDvere);
       SetLocked(oDvere,TRUE);
   }
}
