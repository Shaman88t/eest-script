void main()
{

if(Random(4) > 1 )
  return;

string sLoc;

int iRand = Random(5);
switch(iRand) {
 case 0: sLoc = "ph_ds1_home"; break;
 case 1: sLoc = "ph_ds1_1"; break;
 case 2: sLoc = "ph_ds1_2"; break;
 case 3: sLoc = "ph_ds1_3"; break;
 case 4: sLoc = "ph_ds1_4"; break;
 case 5: sLoc = "ph_ds1_w"; break;

}

ClearAllActions();

ActionMoveToObject(GetNearestObjectByTag(sLoc));

int ianim1;

switch(iRand) {
 case 0: ianim1 = ANIMATION_LOOPING_GET_MID; break;
 case 1: ianim1 = ANIMATION_LOOPING_GET_LOW;  break;
 case 2: ianim1 = ANIMATION_LOOPING_GET_LOW;  break;
 case 3: ianim1 = ANIMATION_LOOPING_GET_LOW;  break;
 case 4: ianim1 = ANIMATION_LOOPING_GET_MID;  break;
 case 5: ianim1 = ANIMATION_LOOPING_GET_MID;  break;

}

ActionPlayAnimation(ianim1, 1.0f, 30.0f);

ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD);

}
