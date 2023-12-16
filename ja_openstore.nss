// * Looks for the nearest store and opens it
#include "nw_i0_plot"

void main()
{
    object oStore;
    if(GetLocalInt(OBJECT_SELF,"ku_shop_warehouse") == 1) {
      SpeakString("Pozor! Oteviram primo sklad zbozi!");
      OpenStore(GetNearestObjectByTag("ku_shop_warehouse"),GetPCSpeaker());
      SpeakString("Pozor! Oteviram primo sklad zbozi!");
      return;
    }

    oStore = GetNearestObject(OBJECT_TYPE_STORE);
    int i=1;
    /* Nikdy neotvirat obchod s timto tagem */
    while(GetTag(oStore)=="ku_shop_warehouse") {
      i++;
      oStore = GetNearestObject(OBJECT_TYPE_STORE,OBJECT_SELF,i);
    }
    if (GetIsObjectValid(oStore) == TRUE)
    {
        if(GetLocalInt(OBJECT_SELF,"DISABLE_APPRAISE") || GetLocalInt(oStore,"DISABLE_APPRAISE")) {
          OpenStore(oStore, GetPCSpeaker());
        }
        else {
          gplotAppraiseOpenStore(oStore, GetPCSpeaker());
        }
//        OpenStore(oStore, GetPCSpeaker());
    }
    else
        PlayVoiceChat(VOICE_CHAT_CUSS);
}


