void SafeJump(object oPC, location lLoc){
    SetLocalInt(oPC, "JA_WAITING", 0);

    string sAre = GetTag(GetArea(oPC));
    if(sAre == "VitejtevThalii"){
        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oPC, JumpToLocation(lLoc));
    }
}

void main()
{
   object oPC = GetPCSpeaker();

   object oWhere = GetWaypointByTag(GetLocalString(oPC, "CHRAM"));

   SetLocalInt(oPC, "JA_WAITING", 1);
   DelayCommand(30.0f, SafeJump(oPC, GetLocation(oWhere)));
}
