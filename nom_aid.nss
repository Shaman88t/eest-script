void main()
{
object oTarget = GetPCSpeaker();
int nSpell =SPELL_AID;
int nMetaMagic=METAMAGIC_ANY;
int bCheat=TRUE;
int nDomainLevel=0;
int nProjectilePathType=PROJECTILE_PATH_TYPE_DEFAULT;
int bInstantSpell=TRUE;


ActionCastSpellAtObject(nSpell,oTarget,nMetaMagic, bCheat,nDomainLevel,nProjectilePathType,bInstantSpell);
}


