void main()
{
    int iObjTyp = GetLocalInt(OBJECT_SELF,"sy_objtyp");

    switch (iObjTyp) {
     case 1:{   //mysiak nastavi kod, zavrie dvere na kluc a skape
        object oDoor = GetNearestObject(OBJECT_TYPE_DOOR,OBJECT_SELF,1);
        int    iMask   = GetLocalInt(oDoor,"sy_mask");
        int    iRndCode = Random(iMask-1)+1;
        SetLocalInt(oDoor,"sy_levercode",iRndCode);
        SetLocked(oDoor,TRUE);
        SetLockKeyRequired(oDoor,TRUE);
        DestroyObject(OBJECT_SELF);
        break;
     }

     case 2:{   //pri prepnuti paky sa nastavuje prislusny bit
        string sDoor  = GetLocalString(OBJECT_SELF,"sy_door");
        int iBitflag  = GetLocalInt(OBJECT_SELF,"sy_bitflag");
        int iState    = GetLocalInt(OBJECT_SELF,"sy_state");
        object oDoor  = GetObjectByTag(sDoor);
        int iLeverCode= GetLocalInt(oDoor,"sy_levercode_new");

        int iFlag = 255; //1111 1111
        if (iState==0) {
            iLeverCode = iLeverCode | iBitflag;
            iState = 1;
            ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        } else
        {
            iFlag = iFlag - iBitflag;
            iLeverCode = iLeverCode & iFlag;
            iState = 0;
            ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        }

        SetLocalInt(OBJECT_SELF,"sy_state",iState);
        SetLocalInt(oDoor,"sy_levercode_new",iLeverCode);

        //test ci su paky v dobrej polohe -> otvori dvere
        iLeverCode    = GetLocalInt(oDoor,"sy_levercode");
        int iLeverCodeNew = GetLocalInt(oDoor,"sy_levercode_new");
        if (iLeverCode==iLeverCodeNew) {
            SetLocked(oDoor,FALSE);
            SetLockKeyRequired(oDoor,FALSE);
            AssignCommand(oDoor,ActionOpenDoor(OBJECT_SELF));
        }
        break;
     }
    }
}
