/*
 * 25. 04. 2010 Extended persistent NPCs.
 * 2013-01-13 Opraveno barveni NPC
 */
#include "ja_lib"
#include "ku_libbase"
#include "ku_persist_inc"
#include "ku_libchat"
#include "ku_resizer"
#include "me_lib"
//#include "me_pcneeds_inc"

const int TOTAL_SKILLS = 27;
const int TOTAL_FEATS  = 1268;

const string KU_DLG = "KU_UNI_DIALOG";
const string KU_WAND_TARGET = "KU_WAND_TARGET";
const string KU_WAND_TARGET_LOC = "KU_WAND_TARGET_LOC";



/* Declaration */

/* Subraces */
void KU_subrace_setting(int act);
void KU_DM_Wand(int act);
void KU_DM_Wand_SetTokens(int iState, object oPC = OBJECT_INVALID);
void KU_DM_Persistent_Wand(int iState);
void KU_DM_Persistent_Wand_SetTokens(int iState, object oPC = OBJECT_INVALID);
void KU_DM_NPC_Handling_Wand(int iState);
void KU_DM_NPC_Handling_Wand_SetTokens(int iState, object oPC = OBJECT_INVALID);
void KU_DM_Effects_Wand(int iState);
void KU_DM_Effects_Wand_SetTokens(int iState, object oPC = OBJECT_INVALID);
void KU_DM_CRStatsWand_Wand(int iState);
void KU_DM_CRStatsWand_SetTokens(int iState, object oPC = OBJECT_INVALID);


void LogDMAction(object oPC,object oTarget,string text,int iVal)
{

}


/* Function definitions */

void ku_dlg_act(int act) {
  object oPC = GetPCSpeaker();
  int iDialog = GetLocalInt(oPC,KU_DLG+"dialog");
  switch(iDialog) {
    case 1: KU_subrace_setting(act); break;
    case 2: KU_DM_Wand(act); break;
    case 3: KU_DM_Persistent_Wand(act); break;
    case 4: KU_DM_NPC_Handling_Wand(act); break;
    case 5: KU_DM_Effects_Wand(act); break;
    case 6: KU_DM_CRStatsWand_Wand(act); break;

  }
  return;
}

void ku_dlg_init(int act, object oPC = OBJECT_INVALID) {
  if(oPC == OBJECT_INVALID)
    oPC = GetPCSpeaker();
  SetLocalInt(oPC,KU_DLG+"state",0);
  int iDialog = act; //GetLocalInt(oPC,KU_DLG+"dialog");
  switch(iDialog) {
//    case 1: KU_subrace_setting(act); break;
    case 2:
        KU_DM_Wand_SetTokens(0,oPC);
        SetLocalInt(oPC,KU_DLG+"_allow_0",1);
        SetCustomToken(6300,"DM hulka.");
        break;
    case 3:
        KU_DM_Persistent_Wand_SetTokens(0,oPC);
        SetLocalInt(oPC,KU_DLG+"_allow_0",1);
        SetCustomToken(6300,"DM hulka Persistence.");
        break;
     case 4:
        KU_DM_NPC_Handling_Wand_SetTokens(0,oPC);
        SetLocalInt(oPC,KU_DLG+"_allow_0",1);
        SetCustomToken(6300,"DM hulka uprav NPC.");
        break;
     case 5:
        KU_DM_Effects_Wand_SetTokens(0,oPC);
        SetLocalInt(oPC,KU_DLG+"_allow_0",1);
        SetCustomToken(6300,"DM hulka efektu");
        break;
    case 6:
        KU_DM_CRStatsWand_SetTokens(0,oPC);
//        SetLocalInt(oPC,KU_DLG+"_allow_0",1);
//        SetCustomToken(6300,"DM Statu postavy. Pozor pri hrani s PC!!!");
        break;

  }
  return;
}

int ku_dlg_is(int q) {
  object oPC = GetPCSpeaker();
//  SendMessageToPC(oPC,"Get On "+GetName(oPC)+" State "+IntToString(q)+"="+IntToString(GetLocalInt(oPC,KU_DLG+"_allow_"+IntToString(q))));
  return GetLocalInt(oPC,KU_DLG+"_allow_"+IntToString(q));
}

void ku_dlg_SetAll(int state) {
  object oPC = GetPCSpeaker();
  int i;
  for(i=0;i<=10;i++) {
//    SendMessageToPC(oPC,"Set On "+GetName(oPC)+" State "+IntToString(i)+"="+IntToString(GetLocalInt(oPC,KU_DLG+"_allow_"+IntToString(i))));
    SetLocalInt(oPC,KU_DLG+"_allow_"+IntToString(i),state);
//    SendMessageToPC(oPC,"Set On "+GetName(oPC)+" State "+IntToString(i)+"="+IntToString(GetLocalInt(oPC,KU_DLG+"_allow_"+IntToString(i))));
  }
}

void ku_dlg_SetConv(int conv, int state) {
  object oPC = GetPCSpeaker();

  SetLocalInt(oPC,KU_DLG+"_allow_"+IntToString(conv),state);

//  SendMessageToPC(oPC,"Set On "+GetName(oPC)+" State "+IntToString(conv)+"="+IntToString(GetLocalInt(oPC,KU_DLG+"_allow_"+IntToString(conv))));

}

/* custom dialog functions */

/**********************************************
 *                DM hulka                    *
 **********************************************/
void KU_DM_Wand_SetTokens(int iState, object oPC = OBJECT_INVALID) {
  object oTarget = GetLocalObject(GetPCSpeaker(),KU_WAND_TARGET );
  object oSoul = GetSoulStone(oTarget);
//  SetLocalInt(oPC,KU_DLG+"state",iState);
//  SendMessageToPC(GetPCSpeaker(),"Tokens: state = "+IntToString(iState));

  switch(iState) {
    /* Init hulky */
    case 0:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"DM hulka zamirena na: "+GetName(oTarget));
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Nastavit jako hledanou osobu");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Nastavit phenotyp");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Nastavit FootStepSound");
        ku_dlg_SetConv(4,1);
        if(GetLocalInt(oSoul,"STOP_XP") > 0) {
          SetCustomToken(6304,"Obnovit prisun casovych XP");
        }
        else {
          SetCustomToken(6304,"Zrusit prisun casovych XP");
        }
        if(GetLocalInt(oSoul,"KU_ZLODEJ") < ku_GetTimeStamp()) {
          ku_dlg_SetConv(5,1);
          SetCustomToken(6305,"Oznacit za zlodeje");
        }
        else {
          ku_dlg_SetConv(5,1);
          SetCustomToken(6305,"Zrusit oznaceni za  zlodeje");
        }
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"Nastavit unavu/hlad/zizen/opilost");
        break;
    case 1:
    /* Hledane osoby */
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Kde ma byt "+GetName(oTarget)+ " hledany?");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Straz Karathy");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Ivory");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Garda S'Zai");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"Chmurna straz");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"Murgond");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"Nordova garda");
        ku_dlg_SetConv(7,1);
        SetCustomToken(6307,"Druidove");
        ku_dlg_SetConv(8,1);
        SetCustomToken(6308,"Isilska pevnost");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Dalsi");
        break;
    /* Stale hledane osoby */
    case 10:
//        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Kde ma byt "+GetName(oTarget)+ " hledany?");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Predchozi");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Kel A Hazr");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Khar Durn");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Zpet");
        break;
    case 13:
    /* Hledane osoby */
//        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"S jakou pravdepodobnosti maji jit po "+GetName(oTarget)+ "?");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"0%");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"2%");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"5%");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"10%");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"20%");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"30%");
        ku_dlg_SetConv(7,1);
        SetCustomToken(6307,"50%");
        ku_dlg_SetConv(8,1);
        SetCustomToken(6308,"80%");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Zpet");
        break;
    /* Phenotypy */
    case 2:
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Jaky phenotyp se ma "+GetName(oTarget)+ " nastavit?");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Normal");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Skinny");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Large");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"Normal Mounted");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"Large Mounted");
        ku_dlg_SetConv(7,1);
        SetCustomToken(6307,"Normal Jousting Mounted");
        ku_dlg_SetConv(8,1);
        SetCustomToken(6308,"Zpet");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Normal Jousting Mounted");
        break;
     case 3:
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Jaky zvuk kroku se ma pro "+GetName(oTarget)+ " nastavit?");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Normal");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Large");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Horse");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Zpet");
        break;
     case 6:
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Co chces postave "+GetName(oTarget)+ " nastavit?");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Zrusit hlad, zizen, unavu, opilost a spanek ");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,sy_num_to_percent("Hlad : ", MAX_FOOD, GetLocalFloat(oTarget, "FoodRating"))+" +10%");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,sy_num_to_percent("Zizen : ", MAX_WATER, GetLocalFloat(oTarget, "WaterRating"))+" +10%");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,sy_num_to_percent("Alkohol : ", MAX_ALCOHOL, GetLocalFloat(oTarget, "AlcoholRating"))+" +10%");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,sy_num_to_percent("Unava : ", getMaxStamina(oTarget), getMaxStamina(oTarget))+" +10%");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"zpet");
        break;
  } /* switch act  end */

}

void KU_DM_Wand(int act) {
  object oPC = GetPCSpeaker();
  object oTarget = GetLocalObject(GetPCSpeaker(),KU_WAND_TARGET );
  object oSoul = GetSoulStone(oTarget);
  int iState = GetLocalInt(oPC,KU_DLG+"state");
//  SendMessageToPC(oPC,"state = "+IntToString(iState)+" act = "+IntToString(act));
  switch(iState) {
    /* Spusteni hulky */
    case 0: {
      switch(act) {
        /* Nic nezmacknuto */
        case 0:
          KU_DM_Wand_SetTokens(iState);
          break;
        /* Hledani osob */
        case 1:
        /* Nastaveni Phenotypu */
        case 2:
        /* Nastaveni footstepsound */
        case 3:
          SetLocalInt(oPC,KU_DLG+"state",act);
          KU_DM_Wand_SetTokens(act);
          break;
        case 4:
          if(GetLocalInt(oSoul,"STOP_XP") > 0) {
            DeleteLocalInt(oSoul,"STOP_XP");
          }
          else {
            SetLocalInt(oSoul,"STOP_XP",1);
          }
          break;
        case 5:
          if(GetLocalInt(oSoul,"KU_ZLODEJ") < ku_GetTimeStamp()) {
            SetLocalInt(oSoul,"KU_ZLODEJ",ku_GetTimeStamp(0,0,0,90));
          }
          else {
            SetLocalInt(oSoul,"KU_ZLODEJ",0);
          }
          break;
        case 6:
          SetLocalInt(oPC,KU_DLG+"state",act);
          break;
      } /* switch act  end */
      break;
    } /* case 0 end */
    /* Hledane osoby */
    case 1: {
       switch(act) {
         case 1:
         case 2:
         case 3:
         case 4:
         case 5:
         case 6:
         case 7:
         case 8:
           SetLocalInt(oPC,"dm_wanted",act);
           SetLocalInt(oPC,KU_DLG+"state",13);
           KU_DM_Wand_SetTokens(13);
           break;
         case 9:
           KU_DM_Wand_SetTokens(10);
           SetLocalInt(oPC,KU_DLG+"state",10);
           break;

       }
       break;
    }
    case 10: {
      switch(act) {
         case 1:
           SetLocalInt(oPC,KU_DLG+"state",1);
           KU_DM_Wand_SetTokens(1);
           break;
         case 2:
         case 3:
           SetLocalInt(oPC,"dm_wanted",act+7);
           SetLocalInt(oPC,KU_DLG+"state",13);
           KU_DM_Wand_SetTokens(13);
           break;
         case 9:
           KU_DM_Wand_SetTokens(0);
           SetLocalInt(oPC,KU_DLG+"state",0);
           break;
      }
      break;
    }
    case 13: {
      string sWanted = "KU_WANTED"+IntToString(GetLocalInt(oPC,"dm_wanted"));
//      object oTarget = GetLocalObject(GetPCSpeaker(),KU_WAND_TARGET );
//      object oSoul = GetSoulStone(oTarget);
      switch(act) {
        case 0: KU_DM_Wand_SetTokens(13); return;
        case 1: DeleteLocalInt(oSoul,sWanted); break;
        case 2: SetLocalInt(oSoul,sWanted,2); break;
        case 3: SetLocalInt(oSoul,sWanted,5); break;
        case 4: SetLocalInt(oSoul,sWanted,10); break;
        case 5: SetLocalInt(oSoul,sWanted,20); break;
        case 6: SetLocalInt(oSoul,sWanted,30); break;
        case 7: SetLocalInt(oSoul,sWanted,50); break;
        case 8: SetLocalInt(oSoul,sWanted,80); break;
        case 9:
          KU_DM_Wand_SetTokens(0);
          SetLocalInt(oPC,KU_DLG+"state",0);
          break;
      }
      if(act < 9) {
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Po "+GetName(oTarget)+ " pujdou straze na "+IntToString(GetLocalInt(oSoul,sWanted))+"%");
      }
      break;
    }
    /* Phenotypes */
    case 2: {
//      object oTarget = GetLocalObject(GetPCSpeaker(),KU_WAND_TARGET );
      switch(act) {
        case 0: KU_DM_Wand_SetTokens(2); return;
        case 1:
        case 2:
        case 3:
        case 4:
        case 6:
        case 7:
        case 9:
          SetPhenoType(act-1,oTarget);
          ku_dlg_SetAll(0);
          ku_dlg_SetConv(0,1);
          SetCustomToken(6300,GetName(oTarget)+" Nastaven Phenotype "+IntToString(act));
          break;
        case 8:
          KU_DM_Wand_SetTokens(0);
          SetLocalInt(oPC,KU_DLG+"state",0);
          break;
      }
      break;
    }/*End Phenotypes */
    /* Foootstepsounds */
    case 3: {
//      object oTarget = GetLocalObject(GetPCSpeaker(),KU_WAND_TARGET );

      switch(act) {
        case 0: KU_DM_Wand_SetTokens(3); return;
        case 1:
        case 2:
          SetFootstepType(act-1,oTarget);
          ku_dlg_SetAll(0);
          ku_dlg_SetConv(0,1);
          SetCustomToken(6300,GetName(oTarget)+" Nastaven FootStepSound "+IntToString(act));
          break;
        case 3:
          SetFootstepType(17,oTarget);
          ku_dlg_SetAll(0);
          ku_dlg_SetConv(0,1);
          SetCustomToken(6300,GetName(oTarget)+" Nastaven FootStepSound Horse");
          break;
        case 9:
          KU_DM_Wand_SetTokens(0);
          SetLocalInt(oPC,KU_DLG+"state",0);
          break;
      }
      break;
    }/*End Footstepsounds*/
    case 6: {
      switch(act) {
        case 0: KU_DM_Wand_SetTokens(6); return;
        // zrus opilost,unavu,hlad...
        case 1:
          SetLocalFloat(oTarget, VARNAME_WATER,  MAX_WATER);
          SetLocalFloat(oTarget, VARNAME_FOOD, MAX_FOOD);
          SetLocalFloat(oTarget, VARNAME_ALCOHOL,  MAX_ALCOHOL);
          restoreStamina(oTarget, getMaxStamina(oTarget));
          break;
        //jidlo
        case 2:
          SetLocalFloat(oTarget, VARNAME_FOOD,GetLocalFloat(oTarget, VARNAME_FOOD)- MAX_FOOD/10.0);
          break;
        //zizen
        case 3:
          SetLocalFloat(oTarget, VARNAME_WATER,GetLocalFloat(oTarget, VARNAME_WATER)- MAX_WATER/10.0);
          break;
        //alcohol
        case 4:
          SetLocalFloat(oTarget, VARNAME_ALCOHOL,GetLocalFloat(oTarget, VARNAME_ALCOHOL)- MAX_ALCOHOL/10.0);
          break;
        //unava
        case 5:
          woundStamina(oTarget,getMaxStamina(oTarget)/10);
          break;
        case 9:
          KU_DM_Wand_SetTokens(0);
          SetLocalInt(oPC,KU_DLG+"state",0);
          break;
      }

      break;
    }

  } /* Switch state end */

}


/****************************************************
 ***           Propriety pro upravy subrasy       ***
 ****************************************************/
void KU_subrace_set_tokens(object oPC) {


   int app =  GetLocalInt(oPC,"KU_STANDART_APPEARANCE");

   switch(app) {
      // Halfogre
      case 985: {
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Nastaveni Hlavy. Vyberte vzhled hlavy a ukoncete dialog");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Hlava cislo 1");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Hlava cislo 2");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Hlava cislo 3");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"Hlava cislo 4");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"Hlava cislo 5");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"Hlava cislo 6");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Hotovo");
        break;
      }
      // Kobold
      case 984: {
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Nastaveni Hlavy. Vyberte vzhled hlavy a ukoncete dialog");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Hlava cislo 1");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Hlava cislo 2");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Hlava cislo 3");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"Hlava cislo 4");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Hotovo");
        break;
      }
      default : {
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Nastaveni Hlavy. Vyberte vzhled hlavy a ukoncete dialog");
        ku_dlg_SetConv(7,1);
        SetCustomToken(6307,"Predchozi hlava");
        ku_dlg_SetConv(8,1);
        SetCustomToken(6308,"Nasledujici hlava");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Hotovo");
        break;
      }
   }

}

void KU_subrace_setting(int act) {
  object oPC = GetPCSpeaker();
  int iState = GetLocalInt(oPC,KU_DLG+"state");

  object oTarget = GetLocalObject(GetPCSpeaker(),KU_WAND_TARGET );
  if(!GetIsObjectValid(oTarget) || !GetIsDM(oPC)) {
    oTarget = oPC;
  }

  switch(iState) {
    case 0: {
      switch(act) {
        // Default
        case 0: {
         KU_subrace_set_tokens(oPC);
         break;
        }
        // Predchozi
        case 1: {
         SetCreatureBodyPart(CREATURE_PART_HEAD,1,oTarget);
         KU_subrace_set_tokens(oPC);
         break;
        }
        case 2: {
         SetCreatureBodyPart(CREATURE_PART_HEAD,2,oTarget);
         KU_subrace_set_tokens(oPC);
         break;
        }
        case 3: {
         SetCreatureBodyPart(CREATURE_PART_HEAD,3,oTarget);
         KU_subrace_set_tokens(oPC);
         break;
        }
        case 4: {
         SetCreatureBodyPart(CREATURE_PART_HEAD,4,oTarget);
         KU_subrace_set_tokens(oPC);
         break;
        }
        case 5: {
         SetCreatureBodyPart(CREATURE_PART_HEAD,5,oTarget);
         KU_subrace_set_tokens(oPC);
         break;
        }
        case 6: {
         SetCreatureBodyPart(CREATURE_PART_HEAD,6,oTarget);
         KU_subrace_set_tokens(oPC);
         break;
        }
        case 7: {
         SetCreatureBodyPart(CREATURE_PART_HEAD,GetCreatureBodyPart(CREATURE_PART_HEAD,oTarget) - 1,oTarget);
         KU_subrace_set_tokens(oPC);
         break;
        }
        case 8: {
         SetCreatureBodyPart(CREATURE_PART_HEAD,GetCreatureBodyPart(CREATURE_PART_HEAD,oTarget) + 1,oTarget);
         KU_subrace_set_tokens(oPC);
         break;
        }
        case 9: {
         ku_dlg_SetAll(0);
         break;
        }

      } // 2nd switch end
      break;
    }
  } //st switch end

}



/*************************************************
 *            Persistentni hulka                 *
 *************************************************/

void KU_DM_Persistent_Wand(int act) {
  object oPC = GetPCSpeaker();
  int iState = GetLocalInt(oPC,KU_DLG+"state");
  switch(iState) {
    // Spusteni hulky
    case 0: {
      switch(act) {
        // Nic nezmacknuto
        case 0:
          KU_DM_Persistent_Wand_SetTokens(iState);
          break;
        /// Zpersistentneni
        case 1: {
            object oArea = GetArea(oPC);
            object oPlc = GetFirstObjectInArea(oArea);
            while(GetIsObjectValid(oPlc)) {
              if(GetLocalInt(oPlc,"ku_plc_origin") == 0) {
                switch(GetObjectType(oPlc)) {
                  case OBJECT_TYPE_PLACEABLE:
                    SendMessageToPC(oPC,"Ukladam "+GetName(oPlc));
                    Persist_SavePlaceable(oPlc,oArea);
                    SetLocalInt(oPlc,"ku_plc_origin",2);
                    break;
                  default:
                   break;
                }
              }
              oPlc = GetNextObjectInArea(oArea);
            }
          }
          break;
        // Vymazat objekty z DB
        case 2: {
            object oArea = GetArea(oPC);
            Persist_DeletePlaceablesInArea(oArea);
          }
          break;
        // Odstranit persistentni placeably
        case 3: {
          object oArea = GetArea(oPC);
          Persist_DestroyObjectsInArea(oArea,2,OBJECT_TYPE_PLACEABLE);
        }
        break;
        // Odstranit persistentni placeably
        case 4: {
            object oArea = GetArea(oPC);
            Persist_DestroyObjectsInArea(oArea,0,OBJECT_TYPE_PLACEABLE);
          }
          break;
        case 5: {
          object oArea = GetArea(oPC);
          Persist_DestroyObjectsInArea(oArea,0,OBJECT_TYPE_PLACEABLE);
          Persist_DestroyObjectsInArea(oArea,2,OBJECT_TYPE_PLACEABLE);
          Persist_DestroyObjectsInArea(oArea,2,OBJECT_TYPE_CREATURE);
          Persist_LoadAddedPlaceables(oArea);
          }
          break;
        //Zpersistentni/zrus NPC
        case 6: {
          object oTarget = GetLocalObject(GetPCSpeaker(),KU_WAND_TARGET );
          object oArea = GetArea(oTarget);
          if(GetLocalInt(oTarget,"ku_plc_origin") == 2 ) {
            Persist_DeleteNPCSInArea(oArea,oTarget);
            AssignCommand(oTarget,SpeakString("NPC odstraneno z persistence"));
          }
          else {
            Persist_SavePlaceable(oTarget,oArea);
            AssignCommand(oTarget,SpeakString("NPC zpersistentneno"));
          }
        }
        break;
        //odstran NPC z DB
        case 7: {
            object oArea = GetArea(oPC);
            Persist_DeleteNPCSInArea(oArea);
          }
          break;
        //Vypni spawn
        case 8:
          if(GetLocalInt(GetArea(oPC),"KU_LOC_DISABLE_SPAWN")) {
            Persist_SetSpawnInAreaDisabled(GetArea(oPC),0);
          }
          else {
            Persist_SetSpawnInAreaDisabled(GetArea(oPC),1);
          }
          break;
        //zapni spawn
//        case 9:
//          Persist_SetSpawnInAreaDisabled(GetArea(oPC),0);
//          break;


      }
    } // case 0 end
    break;

  } // Switch state end

}


void KU_DM_Persistent_Wand_SetTokens(int iState, object oPC = OBJECT_INVALID) {
  if(oPC == OBJECT_INVALID) {
    oPC = GetPCSpeaker();
  }
  object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );
  string sTargetName = "Nic";
  if(GetIsObjectValid(oTarget)) {
    sTargetName = GetName(oTarget)+" v lokaci "+GetName(GetArea(oTarget));
  }
//  SetLocalInt(oPC,KU_DLG+"state",iState);
//  SendMessageToPC(GetPCSpeaker(),"Tokens: state = "+IntToString(iState));

  switch(iState) {
    // Init hulky
    case 0:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"DM Persistentni hulka zamirena na: "+sTargetName);
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Zpersistentnit nove placeably");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Zrusit persistenci na placeablech (objekty zustanou do restartu)");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Odstranit ted persistentni objekty z lokace (zustanou v DB a objevi se po restartu)");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"Odstranit nove pridane, nepersistentni placeably");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"Vycistit lokaci a znovunacist persistentni placeably");
        ku_dlg_SetConv(6,1);
        if(GetLocalInt(oTarget,"ku_plc_origin") == 2 ) {
          SetCustomToken(6306,"Odstran z persistence NPC '"+sTargetName+"' ");
        }
        else {
          SetCustomToken(6306,"Zpersistentnit NPC '"+sTargetName+"' ");
        }
        ku_dlg_SetConv(7,1);
        SetCustomToken(6307,"Odstranit persistentni NPC z databaze. (vsechny v lokaci)");
        ku_dlg_SetConv(8,1);
        if(GetLocalInt(GetArea(oPC),"KU_LOC_DISABLE_SPAWN")) {
          SetCustomToken(6308,"Zapnout spawn v lokaci.");
        }
        else {
          SetCustomToken(6308,"Vypnout spawn v lokaci.");
        }
//        ku_dlg_SetConv(9,0);
//        SetCustomToken(6309,"Zapnout spawn v lokaci.");
        break;

  } // switch act  end

}


/**************************************
************ NPC HANDLING ************
**************************************/

void ku_SetDescriptionByPC(object oPC,object oTarget,int iStart) {
  int iStop = GetLocalInt(oPC,"KU_CHAT_CACHE_INDEX");
  string sStr = "";
  SendMessageToPC(oPC,"Nastavuju popis "+sStr);

  int i = iStart;
  while(i != iStop) {
   i = (i + 1) % KU_CHAT_CACHE_SIZE;
   sStr = sStr+" "+ GetLocalString(oPC,KU_CHAT_CACHE+IntToString(i));
  }
     SendMessageToPC(oPC,"Nastavuju popis:"+sStr);
  SetDescription(oTarget,sStr);

}

void ku_SetNameByPC(object oPC,object oTarget) {
  int i = GetLocalInt(oPC,"KU_CHAT_CACHE_INDEX");
  string sStr = GetLocalString(oPC,KU_CHAT_CACHE+IntToString(i));
  SendMessageToPC(oPC,"Nastavuju jmeno "+sStr);
  SetName(oTarget,sStr);
}

void ku_SetPortraitByPC(object oPC,object oTarget) {
  int i = GetLocalInt(oPC,"KU_CHAT_CACHE_INDEX");
  string sStr = GetLocalString(oPC,KU_CHAT_CACHE+IntToString(i));
  SendMessageToPC(oPC,"Nastavuju portret "+sStr);
  SetPortraitResRef(oTarget, sStr);
}

void dmw_changeWings(int change, object oTarget) {
  int iWings = GetCreatureWingType(oTarget) + change;
  if(iWings < 0)
    iWings = 0;

  SetCreatureWingType(iWings, oTarget);
  if(GetIsPC(oTarget) && !GetIsDMPossessed(oTarget) ) {
    SetLocalInt(GetSoulStone(oTarget),"SPECIFIC_WING_TYPE",iWings);
  }
}

void dmw_changeTail(int change, object oTarget) {
  int iWings = GetCreatureTailType(oTarget) + change;
  if(iWings < 0)
    iWings = 0;

  SetCreatureTailType(iWings, oTarget);
  if(GetIsPC(oTarget) && !GetIsDMPossessed(oTarget) ) {
    SetLocalInt(GetSoulStone(oTarget),"SUBRACE_TAIL_TYPE",iWings);
  }
}

void dmw_changeColor(int change,int channel, object oTarget) {
  int iColor = GetColor(oTarget, channel) + change;
  if(iColor < 0)
    iColor = 0;

  if(iColor > 255)
    iColor = 255;

  SetColor(oTarget, channel, iColor);
}

void KU_DM_NPC_Handling_Wand(int act) {
  object oPC = GetPCSpeaker();
  int iState = GetLocalInt(oPC,KU_DLG+"state");
  object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );

  switch(iState) {
    // Spusteni hulky
    case 0: {
      switch(act) {
        // Nic nezmacknuto
        case 0:
          KU_DM_NPC_Handling_Wand_SetTokens(iState);
          break;

        // Kopirovat NPC
        case 1: {
//          object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );
          ku_CopyNPCWithEquipedItems(oTarget,GetLocation(oPC));
          }
          break;
        // Nastavit jmeno, description, portret
        case 2: {
//          object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );
          int indexMark = GetLocalInt(oPC,"KU_CHAT_CACHE_INDEX");
          SetLocalInt(oPC,KU_DLG+"_PARAM_1",indexMark);
          SetLocalInt(oPC,KU_DLG+"state",act);
          KU_DM_NPC_Handling_Wand_SetTokens(act);
          }
          break;
        // Nastav kridla
        case 3:
        // Ocas
        case 4:
        //Barva
        case 5:
        //Velikost
        case 6: {
          SetLocalInt(oPC,KU_DLG+"state",act);
          KU_DM_NPC_Handling_Wand_SetTokens(act);
          }
          break;
      }
      break;
    }
    // nastavovani popis/desc/portrait
    case 2: {
      switch(act){
        case 0:
          KU_DM_NPC_Handling_Wand_SetTokens(iState);
          break;
        // nastav popis
        case 1: {
          SpeakString("Nastavuju popis");
//          object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );
          int iMark = GetLocalInt(oPC,KU_DLG+"_PARAM_1");
          ku_SetDescriptionByPC(oPC,oTarget,iMark);
          SetLocalInt(oPC,KU_DLG+"state",0);
          break;
        }
       // nastav jmeno
       case 2: {
          SpeakString("Nastavuju jmeno");
          int iMark = GetLocalInt(oPC,KU_DLG+"_PARAM_1");
//          object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );
          ku_SetNameByPC(oPC,oTarget);
          SetLocalInt(oPC,KU_DLG+"state",0);
          break;
        }
       // nastav portret
       case 3: {
          SpeakString("Nastavuju portret ");
          int iMark = GetLocalInt(oPC,KU_DLG+"_PARAM_1");
//          object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );
          ku_SetPortraitByPC(oPC,oTarget);
          SetLocalInt(oPC,KU_DLG+"state",0);
          break;
       }
       // back
       case 9: {
          SetLocalInt(oPC,KU_DLG+"state",0);
          KU_DM_NPC_Handling_Wand_SetTokens(0);
          break;
        }
      }
    } // case 0 end
    break;
    case 3: {
      switch(act) {
        case 0:
          KU_DM_NPC_Handling_Wand_SetTokens(iState);
          break;
        case 1:
          dmw_changeWings(1, oTarget);
          break;
        case 2:
          dmw_changeWings(10, oTarget);
          break;
        case 3:
          dmw_changeWings(100, oTarget);
          break;
        case 4:
          dmw_changeWings(-100, oTarget);
          break;
        case 5:
          dmw_changeWings(-10, oTarget);
          break;
        case 6:
          dmw_changeWings(-1, oTarget);
          break;
        // back
        case 9: {
          SetLocalInt(oPC,KU_DLG+"state",0);
          KU_DM_NPC_Handling_Wand_SetTokens(0);
          break;
        }
      }
    }
    break;
    case 4: {
      switch(act) {
        case 0:
          KU_DM_NPC_Handling_Wand_SetTokens(iState);
          break;
        case 1:
          dmw_changeTail(1, oTarget);
          break;
        case 2:
          dmw_changeTail(10, oTarget);
          break;
        case 3:
          dmw_changeTail(100, oTarget);
          break;
        case 4:
          dmw_changeTail(-100, oTarget);
          break;
        case 5:
          dmw_changeTail(-10, oTarget);
          break;
        case 6:
          dmw_changeTail(-1, oTarget);
          break;
        // back
        case 9: {
          SetLocalInt(oPC,KU_DLG+"state",0);
          KU_DM_NPC_Handling_Wand_SetTokens(0);
          break;
        }
      }
    }
    break;
    case 5: {
      switch(act) {
        case 0:
          KU_DM_NPC_Handling_Wand_SetTokens(iState);
          break;
        // back
        case 9: {
          SetLocalInt(oPC,KU_DLG+"state",0);
          KU_DM_NPC_Handling_Wand_SetTokens(0);
          break;
        }
        default :
          SetLocalInt(oPC,KU_DLG+"state",50+act -1);
          KU_DM_NPC_Handling_Wand_SetTokens(50+act - 1);
          break;
      }
    }
    break;
    case 50:
    case 51:
    case 52:
    case 53: {
      switch(act) {
        case 0:
          KU_DM_NPC_Handling_Wand_SetTokens(iState);
          break;
        case 1:
          dmw_changeColor(1, iState - 50, oTarget);
          break;
        case 2:
          dmw_changeColor(10, iState - 50, oTarget);
          break;
        case 3:
          dmw_changeColor(100, iState - 50, oTarget);
          break;
        case 4:
          dmw_changeColor(-100, iState - 50, oTarget);
          break;
        case 5:
          dmw_changeColor(-10, iState - 50, oTarget);
          break;
        case 6:
          dmw_changeColor(-1, iState - 50, oTarget);
          break;
        // back
        case 9: {
          SetLocalInt(oPC,KU_DLG+"state",5);
          KU_DM_NPC_Handling_Wand_SetTokens(5);
          break;
        }
      }
    }
    break;
    case 6: {
      switch(act) {
        case 0:
          KU_DM_NPC_Handling_Wand_SetTokens(iState);
          break;
        case 1:
          SetLocalInt(oPC,KU_DLG+"state",61);
          KU_DM_NPC_Handling_Wand_SetTokens(61);
          break;
        case 8:
          SetLocalInt(oPC,KU_DLG+"state",62);
          KU_DM_NPC_Handling_Wand_SetTokens(62);
          break;
        case 9:
          SetLocalInt(oPC,KU_DLG+"state",0);
          KU_DM_NPC_Handling_Wand_SetTokens(0);
          break;
        default:
          Resizer_ResizeCreature(oTarget,act -5);
          break;
      }
    }
    break;
    case 61: {
      switch(act) {
        case 0:
          KU_DM_NPC_Handling_Wand_SetTokens(iState);
          break;
        case 9:
          SetLocalInt(oPC,KU_DLG+"state",6);
          KU_DM_NPC_Handling_Wand_SetTokens(6);
          break;
        default:
          Resizer_ResizeCreature(oTarget,act -10);
          break;
      }
    }
    break;
    case 62: {
      switch(act) {
        case 0:
          KU_DM_NPC_Handling_Wand_SetTokens(iState);
          break;
        case 1:
          SetLocalInt(oPC,KU_DLG+"state",6);
          KU_DM_NPC_Handling_Wand_SetTokens(6);
          break;
        default:
          Resizer_ResizeCreature(oTarget,act +1);
          break;
      }
    }
    break;
  } // Switch state end

}


void KU_DM_NPC_Handling_Wand_SetTokens(int iState, object oPC = OBJECT_INVALID) {
  if(oPC == OBJECT_INVALID) {
    oPC = GetPCSpeaker();
  }
  object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );
  string sTargetName = "Nic";
  if(GetIsObjectValid(oTarget)) {
    sTargetName = GetName(oTarget)+" v lokaci "+GetName(GetArea(oTarget));
  }
//  SetLocalInt(oPC,KU_DLG+"state",iState);
//  SendMessageToPC(GetPCSpeaker(),"Tokens: state = "+IntToString(iState));

  switch(iState) {
    // Init hulky
    case 0:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"DM hulka uprav NPC zamirena na: "+sTargetName);
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Zkopirovat NPC");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Nastavit jmeno/popis/portert");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Kridla");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"Ocas");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"Barva");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"Velikost");
        break;

    // nastavit name / description
    case 2:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Nyni napis text, stiskni enter a vyber pouziti na "+sTargetName);
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Nastavit jako popis");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Nastavit jako nazev");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Nastavit jako portret");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Zpet");
        break;
    case 3:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Aktualni model kridel: "+IntToString(GetCreatureWingType(oTarget))+" -  "+sTargetName);
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"+1 (Dalsi)");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"+10 ");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"+100");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"-100");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"-10");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"-1 (Predchozi)");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Hotovo");
        break;
     case 4:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Aktualni ocas: "+IntToString(GetCreatureTailType(oTarget))+" -  "+sTargetName);
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"+1 (Dalsi)");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"+10 ");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"+100");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"-100");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"-10");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"-1 (Predchozi)");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Hotovo");
        break;
     case 5:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Aktualni barvy: "+
                           IntToString(GetColor(oTarget,0))+";"+
                           IntToString(GetColor(oTarget,1))+";"+
                           IntToString(GetColor(oTarget,2))+";"+
                           IntToString(GetColor(oTarget,3))+";"+
                           " -  "+sTargetName);
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Kuze");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Vlasy");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Tetovani #1");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"Tetovani #2");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Zpet");
        break;
     case 50:
     case 51:
     case 52:
     case 53:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Aktualni barva: "+IntToString(GetColor(oTarget,iState-50))+" -  "+sTargetName);
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"+1 (Dalsi)");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"+10 ");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"+100");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"-100");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"-10");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"-1 (Predchozi)");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Hotovo");
        break;
     case 6:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Zmena velikosti - funguje jen pro nektere nehumanoidy.");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"< 70%");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"70%");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"80%");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"90%");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"100%");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"110%");
        ku_dlg_SetConv(7,1);
        SetCustomToken(6307,"120%");
        ku_dlg_SetConv(8,1);
        SetCustomToken(6308,"> 130%");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Zpet");
        break;
     case 61:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Zmena velikosti - funguje jen pro nektere nehumanoidy.");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"10%");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"20%");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"30%");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"40%");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"50%");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"60%");
        ku_dlg_SetConv(7,1);
        SetCustomToken(6307,"70%");
        ku_dlg_SetConv(8,1);
        SetCustomToken(6308,"80%");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"> 80%");
        break;
     case 62:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Zmena velikosti - funguje jen pro nektere nehumanoidy.");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"< 130%%");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"130%");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"140%");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"150%");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"160%");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"170%");
        ku_dlg_SetConv(7,1);
        SetCustomToken(6307,"180%");
        ku_dlg_SetConv(8,1);
        SetCustomToken(6308,"190%");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"200%");
        break;
  } // switch act  end


}

/**************************************
************ Hulka efektu ************
**************************************/
void ku_dlg_effect_fake_hellball(location lTarget)
{


    float fDelay;
    effect eExplode = EffectVisualEffect(464);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    effect eVis2 = EffectVisualEffect(VFX_IMP_ACID_L);
    effect eVis3 = EffectVisualEffect(VFX_IMP_SONIC);

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);

    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 20.0f, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);


    while (GetIsObjectValid(oTarget))
    {


        fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20 + 0.5f;

                //This visual effect is applied to the target object not the location as above.  This visual effect
                //represents the flame that erupts on the target not on the ground.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay+0.2f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
                DelayCommand(fDelay+0.5f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis3, oTarget));

       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, 20.0f, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }

}



void KU_DM_Effects_Wand(int act) {
  object oPC = GetPCSpeaker();
  int iState = GetLocalInt(oPC,KU_DLG+"state");
  location lTarget = GetLocalLocation(oPC,KU_WAND_TARGET_LOC);

  switch(iState) {
    // Spusteni hulky
    case 0: {
      switch(act) {
        // Nic nezmacknuto
        case 0:
          KU_DM_Effects_Wand_SetTokens(iState);
          break;

        // instant efekty
        case 1: {
          SetLocalInt(oPC,KU_DLG+"state",act);

          }
          break;
        // perma efekty
        case 2: {
          SetLocalInt(oPC,KU_DLG+"state",act);
          KU_DM_Effects_Wand_SetTokens(act);
          }
          break;
        // niceni efektu
        case 3: {
          SetLocalInt(oPC,KU_DLG+"state",act);
          object oEff = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE,lTarget,1);
          SetLocalObject(oPC,"ku_dlg_targeteffect",oEff);
          SetLocalInt(oPC,"ku_dlg_targeteffect",1);
          KU_DM_Effects_Wand_SetTokens(act);
          }
          break;
      }
      break;
    }
    case 1: {
      switch(act){
        case 0:
          KU_DM_Effects_Wand_SetTokens(iState);
          break;
        // nastav popis
        case 1: {
          ku_dlg_effect_fake_hellball(lTarget);
          break;
        }

      }
    } // case 0 end
    break;
    case 2: {
      switch(act){
        case 0:
          KU_DM_Effects_Wand_SetTokens(iState);
          break;
        // nastav popis
        case 1: {
          SetLocalInt(oPC,KU_DLG+"state",0);
          break;
        }

      }
    } // case 0 end
    break;
    case 3: {
      switch(act){
        case 0:
          KU_DM_Effects_Wand_SetTokens(iState);
          break;
        // znic object
        case 1: {
          DestroyObject(GetLocalObject(oPC,"ku_dlg_targeteffect"));
          break;
        }
        //vyber dalsi object
        case 2: {
          int iCnt = GetLocalInt(oPC,"ku_dlg_targeteffect") + 1;
          object oEff = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE,lTarget,iCnt);
          SetLocalObject(oPC,"ku_dlg_targeteffect",oEff);
          SetLocalInt(oPC,"ku_dlg_targeteffect",iCnt);
        }

      }
    } // case 0 end
    break;
  } // Switch state end

  // back
  if(act==9) {
          SetLocalInt(oPC,KU_DLG+"state",0);
          KU_DM_Effects_Wand_SetTokens(0);
  }

}


void KU_DM_Effects_Wand_SetTokens(int iState, object oPC = OBJECT_INVALID) {
  if(oPC == OBJECT_INVALID) {
    oPC = GetPCSpeaker();
  }
  object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );
  string sTargetName = "Nic";
  if(GetIsObjectValid(oTarget)) {
    sTargetName = GetName(oTarget)+" v lokaci "+GetName(GetArea(oTarget));
  }


  object oTargetEffect = GetLocalObject(GetPCSpeaker(),"ku_dlg_targeteffect");
//  SetLocalInt(oPC,KU_DLG+"state",iState);
//  SendMessageToPC(GetPCSpeaker(),"Tokens: state = "+IntToString(iState));

  switch(iState) {
    // Init hulky
    case 0:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"DM hulka uprav NPC zamirena na: "+sTargetName);
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Vytvor okamzity efekt");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Vytvor trvaly efekt");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Odstran nejblizsi efekt");
        break;

    // okamzity efekt
    case 1:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Vyber efekt");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Hellball");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Nastavit jako nazev");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Zpet");
        break;

  // Vytvorit trvaly efekt
  case 2:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Zadne efekty tu zatim nejsou ;).");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Zpet");
        break;
  // odstranit efekt
  case 3:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Odstranit" +GetName(oTargetEffect)+" ("+GetTag(oTargetEffect)+")");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Dalsi");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Zpet");
        break;
  } // switch act  end


}

/********************************************
******** DM HULKA STATU N(PC) POSTAV ********
*********************************************/


void KU_DMW_GetFeatList(object oPC) {

  int iHD = GetHitDice(oPC);
  int i,iKnown;
  int ifcnt = 0;
  string sFeat;
  string sFeatList = ";";


//  SpeakString("*********** #2 detection ");
  ifcnt = NWNX_Creature_GetFeatCount(oPC);
  for(i=0;i<ifcnt;i++) {
    iKnown = NWNX_Creature_GetFeatByIndex(oPC,i);
    sFeat = IntToString(iKnown);
    SetLocalInt(oPC,KU_DLG+"KNOWN_FEAT_"+IntToString(i),iKnown);
    sFeatList = sFeatList+sFeat+";";
//    SpeakString("Index "+IntToString(i)+" nalezen feat "+Get2DAString("feat","LABEL",iKnown)+"("+IntToString(iKnown)+")");

  }
  SetLocalInt(oPC,KU_DLG+"KNOWN_FEATSCNT",ifcnt);
  SetLocalString(oPC,KU_DLG+"KNOWN_FEATS",sFeatList);

}

void KU_DM_CRStatsWand_Wand(int act) {
  object oPC = GetPCSpeaker();
  int iState = GetLocalInt(oPC,KU_DLG+"state");
  object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );
  int iState2 = GetLocalInt(oPC,KU_DLG+"state_L2");
  int iCursor = GetLocalInt(oPC,KU_DLG+"cursor");


  switch(iState) {
    // Spusteni hulky
    case 0: {
      switch(act) {
        // Nic nezmacknuto
        case 0:
          KU_DM_CRStatsWand_SetTokens(iState);
          break;

        // Nastaveni vlastnosti - vyber vlastnosti
        case 1: {
          SetLocalInt(oPC,KU_DLG+"state",act);
          KU_DM_CRStatsWand_SetTokens(act);
          }
          break;
        // Skilly
        case 2: {
          SetLocalInt(oPC,KU_DLG+"state",3);
          KU_DM_CRStatsWand_SetTokens(3);
          SetLocalInt(oPC,KU_DLG+"state_L2",0);
          SetLocalInt(oPC,KU_DLG+"cursor",0);
          }
          break;
        // Odeber feat
        case 3: {
          SetLocalInt(oPC,KU_DLG+"state",5);
          KU_DM_CRStatsWand_SetTokens(5);
          SetLocalInt(oPC,KU_DLG+"state_L2",0);
          SetLocalInt(oPC,KU_DLG+"cursor",0);
          KU_DMW_GetFeatList(oTarget);
          }
          break;
       // Pridej feat
        case 4: {
          SetLocalInt(oPC,KU_DLG+"state",6);
          KU_DM_CRStatsWand_SetTokens(6);
          SetLocalInt(oPC,KU_DLG+"state_L2",0);
          SetLocalInt(oPC,KU_DLG+"cursor",0);
//          KU_DMW_GetFeatList(oTarget);
          }
          break;
        // Uprav AC
        case 5: {
          SetLocalInt(oPC,KU_DLG+"state",7);
          KU_DM_CRStatsWand_SetTokens(7);
          SetLocalInt(oPC,KU_DLG+"state_L2",0);
          SetLocalInt(oPC,KU_DLG+"cursor",0);
//          KU_DMW_GetFeatList(oTarget);
          }
          break;
        // Nastav savy
        case 6: {
          SetLocalInt(oPC,KU_DLG+"state",8);
          KU_DM_CRStatsWand_SetTokens(8);
          SetLocalInt(oPC,KU_DLG+"state_L2",0);
          SetLocalInt(oPC,KU_DLG+"cursor",0);
          }
          break;
        // Nastav HP
        case 7: {
          SetLocalInt(oPC,KU_DLG+"state",10);
          KU_DM_CRStatsWand_SetTokens(10);
          SetLocalInt(oPC,KU_DLG+"state_L2",0);
          SetLocalInt(oPC,KU_DLG+"cursor",0);
//          KU_DMW_GetFeatList(oTarget);
          }
          break;
      }
      break;
    }
    // Uprava ability - vyber ability
    case 1: {
      if(act == 0) {
        KU_DM_CRStatsWand_SetTokens(iState);
        break;
      }
      if(act <=6 ) {
        SetLocalInt(oPC,KU_DLG+"state_L2",act -1);
        SetLocalInt(oPC,KU_DLG+"state",2);
        KU_DM_CRStatsWand_SetTokens(2);
      }
      // zpet
      if(act == 9) {
        SetLocalInt(oPC,KU_DLG+"state",0);
        KU_DM_CRStatsWand_SetTokens(0);
      }
      break;
    }
    // Uprava ability - zmena hodnoty ability
    case 2: {
      if(act == 0) {
        KU_DM_CRStatsWand_SetTokens(iState);
        break;
      }
      if(iState2 <0 || iState2 > 5) {
          return;
        }
      int iVal = FALSE;
      switch(act) {
        case 0: KU_DM_CRStatsWand_SetTokens(iState);
          break;
        case 1: if(iVal == 0) iVal = 10;
        case 2: if(iVal == 0) iVal = 5;
        case 3: if(iVal == 0) iVal = 1;
        case 4: if(iVal == 0) iVal = -1;
        case 5: if(iVal == 0) iVal = -5;
        case 6: if(iVal == 0) iVal = -10;
          {
            NWNX_Creature_ModifyRawAbilityScore(oTarget,iState2,iVal);
            // Log it
            if(GetIsPC(oTarget)) {
              LogDMAction(oPC,oTarget,"ABILITY "+Get2DAString("iprp_abilities","Label",iState2), iVal);
            }
            KU_DM_CRStatsWand_SetTokens(2);
          }
          break;
        // zpet
        case 9:
          SetLocalInt(oPC,KU_DLG+"state",1);
          KU_DM_CRStatsWand_SetTokens(1);
          break;

      }
      break;
    }

    // Skilly - vyber skillu
    case 3: {
      switch(act) {
        case 0:
          KU_DM_CRStatsWand_SetTokens(iState);
          break;
        //prev
        case 1:
          iCursor = iCursor - 6;
          if(iCursor < 0) {
            iCursor = 0;
          }
          SetLocalInt(oPC,KU_DLG+"cursor",iCursor);
          break;
        case 8:
          iCursor = iCursor + 6;
          if(iCursor > TOTAL_SKILLS) {
            iCursor = TOTAL_SKILLS -5;
          }
          SetLocalInt(oPC,KU_DLG+"cursor",iCursor);
          break;
        case 9:
          SetLocalInt(oPC,KU_DLG+"state",0);
          KU_DM_CRStatsWand_SetTokens(0);
          break;
        default:
          SetLocalInt(oPC,KU_DLG+"state_L2",act - 2+iCursor);
          SetLocalInt(oPC,KU_DLG+"state",4);
          KU_DM_CRStatsWand_SetTokens(4);
          break;


      } //act switch end

    }
    break;
    // Uprava skillu - zmena hodnoty skillu
    case 4: {
      if(act == 0) {
        KU_DM_CRStatsWand_SetTokens(iState);
        break;
      }

      int iVal = FALSE;
      switch(act) {
        case 0: KU_DM_CRStatsWand_SetTokens(iState);
          break;
        case 1: if(iVal == 0) iVal = 10;
        case 2: if(iVal == 0) iVal = 5;
        case 3: if(iVal == 0) iVal = 1;
        case 4: if(iVal == 0) iVal = -1;
        case 5: if(iVal == 0) iVal = -5;
        case 6: if(iVal == 0) iVal = -10;
          {
            // Log it
            if(GetIsPC(oTarget)) {
              LogDMAction(oPC,oTarget,"Skill "+Get2DAString("skills","Label",iState2), iVal);
            }
            NWNX_Creature_SetSkillRank(oTarget,iState2,GetSkillRank(iState2,oTarget)+iVal);
            KU_DM_CRStatsWand_SetTokens(4);
          }
          break;
        // zpet
        case 9:
          SetLocalInt(oPC,KU_DLG+"state",3);
          KU_DM_CRStatsWand_SetTokens(3);
          break;

      }
      break;
    }
    // Featy - odeber feat
    case 5: {
      int iFeatCnt = GetLocalInt(oTarget,KU_DLG+"KNOWN_FEATSCNT");
      switch(act) {
        case 0:
          KU_DM_CRStatsWand_SetTokens(iState);
          break;
        //prev
        case 1:
          iCursor = iCursor - 6;
          if(iCursor < 0) {
            iCursor = 0;
          }
          SetLocalInt(oPC,KU_DLG+"cursor",iCursor);
          break;
        //next
        case 8:
          iCursor = iCursor + 6;
          if(iCursor > iFeatCnt) {
            iCursor = iFeatCnt -5;
          }
          SetLocalInt(oPC,KU_DLG+"cursor",iCursor);
          break;
        //back
        case 9:
          SetLocalInt(oPC,KU_DLG+"state",0);
          KU_DM_CRStatsWand_SetTokens(0);
          break;
        // remove feat
        default: {
          int iPos = act - 2+iCursor;
          int iFeat = GetLocalInt(oTarget,KU_DLG+"KNOWN_FEAT_"+IntToString(iPos));
          if(GetHasFeat(iFeat,oTarget)) {
            NWNX_Creature_RemoveFeat(oTarget,iFeat);
            KU_DMW_GetFeatList(oTarget);
            // Log it
            if(GetIsPC(oTarget)) {
              LogDMAction(oPC,oTarget,"RemFEAT "+Get2DAString("feat","Label",iFeat), -1);
            }
          }
//          SetLocalInt(oPC,KU_DLG+"state_L2",act - 2+iCursor);
          SetLocalInt(oPC,KU_DLG+"state",5);
          KU_DM_CRStatsWand_SetTokens(5);
          }
          break;


      } //act switch end

    }
    break;
    // Featy - pridej feat
    case 6: {
      switch(act) {
        case 0:
          KU_DM_CRStatsWand_SetTokens(iState);
          break;
        //prev
        case 1:
          iCursor = iCursor - 6;
          if(iCursor < 0) {
            iCursor = 0;
          }
          SetLocalInt(oPC,KU_DLG+"cursor",iCursor);
          break;
        //next
        case 8:
          iCursor = iCursor + 6;
          if(iCursor > TOTAL_FEATS) {
            iCursor = TOTAL_FEATS -5;
          }
          SetLocalInt(oPC,KU_DLG+"cursor",iCursor);
          break;
        //back
        case 9:
          SetLocalInt(oPC,KU_DLG+"state",0);
          KU_DM_CRStatsWand_SetTokens(0);
          break;
        // remove feat
        default: {
          int iFeat = GetLocalInt(oPC,KU_DLG+"feat_at_pos"+IntToString(act));
          if(!GetHasFeat(iFeat,oTarget)) {
            NWNX_Creature_AddFeat(oTarget,iFeat);
//            KU_DMW_GetFeatList(oTarget);
            // Log it
            if(GetIsPC(oTarget)) {
              LogDMAction(oPC,oTarget,"AddFEAT "+Get2DAString("feat","Label",iFeat), 1);
            }
          }
//          SetLocalInt(oPC,KU_DLG+"state_L2",act - 2+iCursor);
          SetLocalInt(oPC,KU_DLG+"state",6);
          KU_DM_CRStatsWand_SetTokens(6);
          }
          break;


      } //act switch end

    }
    break;
    // Uprava AC - zmena hodnoty AC
    case 7: {
      if(act == 0) {
        KU_DM_CRStatsWand_SetTokens(iState);
        break;
      }

      int iVal = FALSE;
      switch(act) {
        case 0: KU_DM_CRStatsWand_SetTokens(iState);
          break;
        case 1: if(iVal == 0) iVal = 10;
        case 2: if(iVal == 0) iVal = 5;
        case 3: if(iVal == 0) iVal = 1;
        case 4: if(iVal == 0) iVal = -1;
        case 5: if(iVal == 0) iVal = -5;
        case 6: if(iVal == 0) iVal = -10;
          {

            NWNX_Creature_SetBaseAC(oTarget,NWNX_Creature_GetBaseAC(oTarget)+iVal);
            KU_DM_CRStatsWand_SetTokens(7);
            // Log it
            if(GetIsPC(oTarget)) {
              LogDMAction(oPC,oTarget,"AC change", iVal);
            }
          }
          break;
        // zpet
        case 9:
          SetLocalInt(oPC,KU_DLG+"state",0);
          KU_DM_CRStatsWand_SetTokens(0);
          break;

      }
      break;
    }
    break;
    // Uprava savu - vyber savu
    case 8: {
      if(act == 0) {
        KU_DM_CRStatsWand_SetTokens(iState);
        break;
      }
      if(act <=4 ) {
        SetLocalInt(oPC,KU_DLG+"state_L2",act -1);
        SetLocalInt(oPC,KU_DLG+"state",9);
        KU_DM_CRStatsWand_SetTokens(9);
      }
      // zpet
      if(act == 9) {
        SetLocalInt(oPC,KU_DLG+"state",0);
        KU_DM_CRStatsWand_SetTokens(0);
      }
      break;
    }
    // End AC
    // Uprava savu - zmena hodnoty savu
    case 9: {
      if(act == 0) {
        KU_DM_CRStatsWand_SetTokens(iState);
        break;
      }

      int iVal = FALSE;
      switch(act) {
        case 0: KU_DM_CRStatsWand_SetTokens(iState);
          break;
        case 1: if(iVal == 0) iVal = 10;
        case 2: if(iVal == 0) iVal = 5;
        case 3: if(iVal == 0) iVal = 1;
        case 4: if(iVal == 0) iVal = -1;
        case 5: if(iVal == 0) iVal = -5;
        case 6: if(iVal == 0) iVal = -10;
          {
            NWNX_Creature_SetBaseSavingThrow(oTarget,iState2,NWNX_Creature_GetBaseSavingThrow(oTarget,iState2)+iVal);
            KU_DM_CRStatsWand_SetTokens(9);
            // Log it
            if(GetIsPC(oTarget)) {
              LogDMAction(oPC,oTarget,"Save "+Get2DAString("iprp_savingthrow","NameString",iState2), iVal);
            }
          }
          break;
        // zpet
        case 9:
          SetLocalInt(oPC,KU_DLG+"state",8);
          KU_DM_CRStatsWand_SetTokens(8);
          break;

      }
      break;
    }
     // Uprava HP - zmena hodnoty HP
    case 10: {
      if(act == 0) {
        KU_DM_CRStatsWand_SetTokens(iState);
        break;
      }

      int iVal = FALSE;
      switch(act) {
        case 0: KU_DM_CRStatsWand_SetTokens(iState);
          break;
        case 1: if(iVal == 0) iVal = 100;
        case 2: if(iVal == 0) iVal = 10;
        case 3: if(iVal == 0) iVal = 1;
        case 4: if(iVal == 0) iVal = -1;
        case 5: if(iVal == 0) iVal = -10;
        case 6: if(iVal == 0) iVal = -100;
          {
            NWNX_Object_SetMaxHitPoints(oTarget,GetMaxHitPoints(oTarget)+iVal);
//            SetCurrentHitPoints(oTarget,GetMaxHitPoints(oTarget)+iVal);
            KU_DM_CRStatsWand_SetTokens(10);
            // Log it
            if(GetIsPC(oTarget)) {
              LogDMAction(oPC,oTarget,"HP change", iVal);
            }
          }
          break;
        // zpet
        case 9:
          SetLocalInt(oPC,KU_DLG+"state",0);
          KU_DM_CRStatsWand_SetTokens(0);
          break;

      }
      break;
    }
    break;
  } // Switch state end

}



void KU_DM_CRStatsWand_SetTokens(int iState, object oPC = OBJECT_INVALID) {
  if(oPC == OBJECT_INVALID) {
    oPC = GetPCSpeaker();
  }
  object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );
  string sTargetName = "Nic";
  if(GetIsObjectValid(oTarget)) {
    sTargetName = GetName(oTarget)+" v lokaci "+GetName(GetArea(oTarget));
  }
  int iState2 = GetLocalInt(oPC,KU_DLG+"state_L2");
  int iCursor = GetLocalInt(oPC,KU_DLG+"cursor");
  int iFeatCnt = 0;


  switch(iState) {
    // Init hulky
    case 0:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"DM hulka uprav statu postavy (PC/NPC) zamirena na: "+sTargetName);
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Uprav vlastnost");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Uprav skill");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Odeber feat");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"Pridej feat");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"Uprav AC");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"Uprav savy");
        ku_dlg_SetConv(7,1);
        SetCustomToken(6307,"Uprav HP (nefunguje na PC)");
        break;

    // Ability
/*
int    ABILITY_STRENGTH         = 0; // should be the same as in nwseffectlist.cpp
int    ABILITY_DEXTERITY        = 1;
int    ABILITY_CONSTITUTION     = 2;
int    ABILITY_INTELLIGENCE     = 3;
int    ABILITY_WISDOM           = 4;
int    ABILITY_CHARISMA         = 5;*/
    case 1:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Vyber vlastnost upravovanou na "+sTargetName);
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Strength");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Dexterity");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Constitution");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"Intelligence");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"Wisdom");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"Charisma");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"<<Zpet>>");
        break;
    // Ability - zmen hodnotu
    case 2:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Uprava vlastnosti "+Get2DAString("iprp_abilities","Label",iState2)+" postavy "
                            +sTargetName+" Aktualni hodnota je :"+IntToString(GetAbilityScore(oTarget,iState2,TRUE)));
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"+10");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"+5");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"+1");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"-1");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"-5");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"-10");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"<<Zpet>>");
        break;
    // Skilly
    case 3:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Vyber skill k uprave na "+sTargetName);
        ku_dlg_SetConv(1,0);
        if(iCursor > 0) {
          ku_dlg_SetConv(1,1);
          SetCustomToken(6301,"<<== <Predchozi>");
        }

        //sest skillu
        {
          int i = 0;
//          SpeakString("Cursor = "+IntToString(iCursor));
          while((i < 6) && (i+iCursor <= TOTAL_SKILLS)) {
//            SpeakString("Print skill number ("+IntToString(iCursor)+"+"+IntToString(i)+")");
            ku_dlg_SetConv(2+i,1);
            SetCustomToken(6302+i,Get2DAString("skills","Label",i+iCursor));
            i++;
          }
        }
        ku_dlg_SetConv(8,0);
        if( iCursor+5 < TOTAL_SKILLS) {
          ku_dlg_SetConv(8,1);
          SetCustomToken(6308,"<Dalsi> ==>>");
        }
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"<<Zpet>>");
        break;
    // Skilly - zmen hodnotu
    case 4:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Uprava skillu "+Get2DAString("skills","Label",iState2)+" postavy "
                            +sTargetName+" Aktualni hodnota je :"+IntToString(GetSkillRank(iState2,oTarget,TRUE)));
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"+10");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"+5");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"+1");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"-1");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"-5");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"-10");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"<<Zpet>>");
        break;
     // Odebrani featu - vyber feat
    case 5:
        iFeatCnt = GetLocalInt(oTarget,KU_DLG+"KNOWN_FEATSCNT");
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Odeber feat na "+sTargetName);
        ku_dlg_SetConv(1,0);
        if(iCursor > 0) {
          ku_dlg_SetConv(1,1);
          SetCustomToken(6301,"<<== <Predchozi>");
        }
        //sest featu
        {
//          SetLocalString(oPC,KU_DLG+"KNOWN_FEATS",sFeatList);
          int i = 0;
//          SpeakString("Cursor = "+IntToString(iCursor));
          while((i < 6) && (i+iCursor < iFeatCnt)) {
//            SpeakString("Print skill number ("+IntToString(iCursor)+"+"+IntToString(i)+")");
            ku_dlg_SetConv(2+i,1);
            int iFeat = GetLocalInt(oTarget,KU_DLG+"KNOWN_FEAT_"+IntToString(i+iCursor));
            SetCustomToken(6302+i,Get2DAString("feat","LABEL",iFeat)+"("+IntToString(iFeat)+")");
            i++;
          }
        }
        ku_dlg_SetConv(8,0);
        if( iCursor+5 < iFeatCnt) {
          ku_dlg_SetConv(8,1);
          SetCustomToken(6308,"<Dalsi>> ==>");
        }
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"<<Zpet>>");
        break;
     // Pridej feat
     case 6: {
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Vyber Feat k pridani na "+sTargetName+".     Pro skok na vzdaleny feat napis /dmc cursor <cislo featu> a zmackni dalsi/predchozi");
        ku_dlg_SetConv(1,0);
        if(iCursor > 0) {
          ku_dlg_SetConv(1,1);
          SetCustomToken(6301,"<<== <Predchozi>");
        }

        //list sest featu
        int iList = 0;
        {
          int i = 0;
//          SpeakString("Cursor = "+IntToString(iCursor));
          iList = iCursor;
          while((i < 6) && (iList <= TOTAL_FEATS)) {
//            SpeakString("Print skill number ("+IntToString(iCursor)+"+"+IntToString(i)+")");
            string sFeat = Get2DAString("feat","LABEL",iList);
            if(sFeat == "" ||  GetHasFeat(iList,oTarget)) {
              iList++;
              continue;
            }
            ku_dlg_SetConv(2+i,1);
            SetLocalInt(oPC,KU_DLG+"feat_at_pos"+IntToString(i+2),iList);
            SetCustomToken(6302+i,Get2DAString("feat","LABEL",iList)+" ("+IntToString(iList)+")");
            i++;
            iList++;
          }
        }
        ku_dlg_SetConv(8,0);
        if( iList-1 < TOTAL_FEATS) {
          ku_dlg_SetConv(8,1);
          SetCustomToken(6308,"<Dalsi> ==>>");
        }
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"<<Zpet>>");
        }
        break;
    // AC - uprav AC
    case 7:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Uprav AC postavy "
                            +sTargetName+" Aktualni hodnota je :"+IntToString(NWNX_Creature_GetBaseAC(oTarget)));
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"+10");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"+5");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"+1");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"-1");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"-5");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"-10");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"<<Zpet>>");
        break;
     // Save - vyber save
    case 8:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Uprav AC postavy "
                            +sTargetName+" Aktualni hodnota je :"+IntToString(NWNX_Creature_GetBaseAC(oTarget)));
        ku_dlg_SetConv(1,0);
        SetCustomToken(6301,"All");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Fortitude");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Reflex");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"Will");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"<<Zpet>>");
        break;
     // Save - uprav save
    case 9:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        {
          string sSave = "";
          switch(iState2) {
            case 0: sSave ="All"; break;
            case 1: sSave ="Fortitude"; break;
            case 2: sSave ="Reflex"; break;
            case 3: sSave ="Will"; break;
          }
          SetCustomToken(6300,"Uprav save "+sSave+" postavy "
                             +sTargetName+" Aktualni hodnota je :"+IntToString(NWNX_Creature_GetBaseSavingThrow(oTarget,iState2)));
        }
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"+10");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"+5");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"+1");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"-1");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"-5");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"-10");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"<<Zpet>>");
        break;
    // HP - uprav HP
    case 10:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Uprav HP postavy - funguje pouze pro NPC "
                            +sTargetName+" Aktualni hodnota je :"+IntToString(GetMaxHitPoints(oTarget)));
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"+100");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"+10");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"+1");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"-1");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"-10");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"-100");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"<<Zpet>>");
        break;

  } // switch act  end


}










