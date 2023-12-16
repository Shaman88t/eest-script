/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_spells_inc
//
//  Desc:  This function stands alone to facilitate
//         alternate language translations.
//
//  Author: David Bobeck 01May03
//  Modified:  By forsettii - added more spells 10/01/03
//             Most of the SoU Spells added
/////////////////////////////////////////////////////////
string CnrGetNameForSpell(int nSpell)
{
  string sSpellName = "Unknown Spell";

  switch (nSpell)
  {
    case SPELL_ACID_FOG: { sSpellName = "Acid Fog"; break; }
    case SPELL_ACID_SPLASH: { sSpellName = "Acid Splash"; break; }
    case SPELL_AID: { sSpellName = "Aid"; break; }
    case SPELL_AMPLIFY: { sSpellName = "Amplify"; break; }
    case SPELL_ANIMATE_DEAD: { sSpellName = "Animate Dead"; break; }
    case SPELL_AURA_OF_VITALITY: { sSpellName = "Aura of Vitality"; break; }
    case SPELL_AWAKEN: { sSpellName = "Awaken"; break; }
    case SPELL_BALL_LIGHTNING: { sSpellName = "Ball Lightning"; break; }
    case SPELL_BANE: { sSpellName = "Bane"; break; }
    case SPELL_BANISHMENT: { sSpellName = "Banishment"; break; }
    case SPELL_BARKSKIN: { sSpellName = "Barkskin"; break; }
    case SPELL_BATTLETIDE: { sSpellName = "Battletide"; break; }
    case SPELL_BESTOW_CURSE: { sSpellName = "Bestow Curse"; break; }
    case SPELL_BIGBYS_CLENCHED_FIST: { sSpellName = "Bigby's Clenched Fist"; break; }
    case SPELL_BIGBYS_CRUSHING_HAND: { sSpellName = "Bigby's Crushing Hand"; break; }
    case SPELL_BIGBYS_FORCEFUL_HAND: { sSpellName = "Bigby's Forceful Hand"; break; }
    case SPELL_BIGBYS_GRASPING_HAND: { sSpellName = "Bigby's Grasping Hand"; break; }
    case SPELL_BIGBYS_INTERPOSING_HAND: { sSpellName = "Bigby's Interposing Hand"; break; }
    case SPELL_BLACK_BLADE_OF_DISASTER: { sSpellName = "Black Blade of Disaster"; break; }
    case SPELL_BLACKSTAFF: { sSpellName = "Blackstaff"; break; }
    case SPELL_BLADE_BARRIER: { sSpellName = "Blade Barrier"; break; }
    case SPELL_BLADE_THIRST: { sSpellName = "Blade Thirst"; break; }
    case SPELL_BLESS: { sSpellName = "Bless"; break; }
    case SPELL_BLESS_WEAPON: { sSpellName = "Bless Weapon"; break; }
    case SPELL_BLINDNESS_AND_DEAFNESS: { sSpellName = "Blindness and Deafness"; break; }
    case SPELL_BLOOD_FRENZY: { sSpellName = "Blood Frenzy"; break; }
    case SPELL_BOMBARDMENT: { sSpellName = "Bombardment"; break; }
    case SPELL_BULLS_STRENGTH: { sSpellName = "Bull's Strength"; break; }
    case SPELL_BURNING_HANDS: { sSpellName = "Burning Hands"; break; }
    case SPELL_CALL_LIGHTNING: { sSpellName = "Call Lightning"; break; }
    case SPELL_CATS_GRACE: { sSpellName = "Cat's Grace"; break; }
    case SPELL_CHAIN_LIGHTNING: { sSpellName = "Chain Lightning"; break; }
    case SPELL_CHARM_MONSTER: { sSpellName = "Charm Monster"; break; }
    case SPELL_CHARM_PERSON: { sSpellName = "Charm Person"; break; }
    case SPELL_CHARM_PERSON_OR_ANIMAL: { sSpellName = "Charm Person or Animal"; break; }
    case SPELL_CIRCLE_OF_DEATH: { sSpellName = "Circle of Death"; break; }
    case SPELL_CIRCLE_OF_DOOM: { sSpellName = "Circle of Doom"; break; }
    case SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE: { sSpellName = "Clairaudience and Clairvoyance"; break; }
    case SPELL_CLARITY: { sSpellName = "Clarity"; break; }
    case SPELL_CLOUD_OF_BEWILDERMENT: { sSpellName = "Cloud of Bewilderment"; break; }
    case SPELL_CLOAK_OF_CHAOS: { sSpellName = "Cloak of Chaos"; break; }
    case SPELL_CLOUDKILL: { sSpellName = "Cloudkill"; break; }
    case SPELL_COLOR_SPRAY: { sSpellName = "Color Spray"; break; }
    case SPELL_COMBUST: { sSpellName = "Combust"; break; }
    case SPELL_CONE_OF_COLD: { sSpellName = "Cone of Cold"; break; }
    case SPELL_CONFUSION: { sSpellName = "Confusion"; break; }
    case SPELL_CONTAGION: { sSpellName = "Contagion"; break; }
    case SPELL_CONTINUAL_FLAME: { sSpellName = "Continual Flame"; break; }
    case SPELL_CONTROL_UNDEAD: { sSpellName = "Control Undead"; break; }
    case SPELL_CREATE_GREATER_UNDEAD: { sSpellName = "Create Greater Undead"; break; }
    case SPELL_CREATE_UNDEAD: { sSpellName = "Create Undead"; break; }
    case SPELL_CREEPING_DOOM: { sSpellName = "Creeping Doom"; break; }
    case SPELL_CRUMBLE: { sSpellName = "Crumble"; break; }
    case SPELL_CURE_CRITICAL_WOUNDS: { sSpellName = "Cure Critical Wounds"; break; }
    case SPELL_CURE_LIGHT_WOUNDS: { sSpellName = "Cure Light Wounds"; break; }
    case SPELL_CURE_MINOR_WOUNDS: { sSpellName = "Cure Minor Wounds"; break; }
    case SPELL_CURE_MODERATE_WOUNDS: { sSpellName = "Cure Moderate Wounds"; break; }
    case SPELL_CURE_SERIOUS_WOUNDS: {sSpellName = "Cure Serious Wounds"; break; }
    case SPELL_DARKFIRE: { sSpellName = "Darkfire"; break; }
    case SPELL_DARKNESS: { sSpellName = "Darkness"; break; }
    case SPELL_DARKVISION: { sSpellName = "Darkvision"; break; }
    case SPELL_DAZE: { sSpellName = "Daze"; break; }
    case SPELL_DEATH_WARD: { sSpellName = "Death Ward"; break; }
    case SPELL_DELAYED_BLAST_FIREBALL: { sSpellName = "Delayed Blast Fireball"; break; }
    case SPELL_DESTRUCTION: { sSpellName = "Destruction"; break; }
    case SPELL_DIRGE: { sSpellName = "Dirge";  break; }
    case SPELL_DISMISSAL: { sSpellName = "Dismissal";  break; }
    case SPELL_DISPEL_MAGIC: { sSpellName = "Dispel Magic"; break; }
    case SPELL_DISPLACEMENT: { sSpellName = "Displacement"; break; }
    case SPELL_DIVINE_FAVOR: { sSpellName = "Divine Favor"; break; }
    case SPELL_DIVINE_POWER: { sSpellName = "Divine Power"; break; }
    case SPELL_DOMINATE_ANIMAL: { sSpellName = "Dominate Animal"; break; }
    case SPELL_DOMINATE_MONSTER: { sSpellName = "Dominate Monster"; break; }
    case SPELL_DOMINATE_PERSON: { sSpellName = "Dominate Person";  break; }
    case SPELL_DOOM: { sSpellName = "Doom"; break; }
    case SPELL_DROWN: { sSpellName = "Drown"; break; }
    case SPELL_EAGLE_SPLEDOR: { sSpellName = "Eagle's Splendor";  break; }
    case SPELL_EARTHQUAKE: { sSpellName = "Earthquake";  break; }
    case SPELL_ELECTRIC_JOLT: { sSpellName = "Electric Jolt"; break; }
    case SPELL_ELEMENTAL_SHIELD: { sSpellName = "Elemental Shield"; break; }
    case SPELL_ELEMENTAL_SWARM: { sSpellName = "Elemental Swarm"; break; }
    case SPELL_ENDURANCE: { sSpellName = "Endurance"; break; }
    case SPELL_ENDURE_ELEMENTS: { sSpellName = "Endure Elements"; break; }
    case SPELL_ENERGY_BUFFER: { sSpellName = "Energy Buffer"; break; }
    case SPELL_ENERGY_DRAIN: { sSpellName = "Energy Drain"; break; }
    case SPELL_ENERVATION: { sSpellName = "Enervation"; break; }
    case SPELL_ENTANGLE: { sSpellName = "Entangle"; break; }
    case SPELL_ENTROPIC_SHIELD: { sSpellName = "Entropic Shield"; break; }
    case SPELL_ETHEREAL_VISAGE: { sSpellName = "Ethereal Visage"; break; }
    case SPELL_EVARDS_BLACK_TENTACLES: { sSpellName = "Evard's Black Tentacles"; break; }
    case SPELL_EXPEDITIOUS_RETREAT: { sSpellName = "Expeditious Retreat"; break; }
    case SPELL_FEAR: { sSpellName = "Fear"; break; }
    case SPELL_FEEBLEMIND: { sSpellName = "Feeblemind"; break; }
    case SPELL_FIND_TRAPS: { sSpellName = "Find Traps"; break; }
    case SPELL_FINGER_OF_DEATH: { sSpellName = "Finger of Death"; break; }
    case SPELL_FIRE_STORM: { sSpellName = "Fire Storm"; break; }
    case SPELL_FIREBALL: { sSpellName = "Fireball"; break; }
    case SPELL_FIREBRAND: { sSpellName = "Firebrand"; break; }
    case SPELL_FLAME_ARROW: { sSpellName = "Flame Arrow"; break; }
    case SPELL_FLAME_LASH: { sSpellName = "Flame Lash"; break; }
    case SPELL_FLAME_STRIKE: { sSpellName = "Flame Strike"; break; }
    case SPELL_FLAME_WEAPON: { sSpellName = "Flame Weapon"; break; }
    case SPELL_FLARE: { sSpellName = "Flare"; break; }
    case SPELL_FLESH_TO_STONE: { sSpellName = "Flesh to Stone"; break; }
    case SPELL_FOXS_CUNNING: { sSpellName = "Fox's Cunning"; break; }
    case SPELL_FREEDOM_OF_MOVEMENT: { sSpellName = "Freedom of Movement"; break; }
    case SPELL_GATE: { sSpellName = "Gate"; break; }
    case SPELL_GEDLEES_ELECTRIC_LOOP: { sSpellName = "Gedlee's Electric Loop"; break; }
    case SPELL_GHOSTLY_VISAGE: { sSpellName = "Ghostly Visage"; break; }
    case SPELL_GHOUL_TOUCH: { sSpellName = "Ghoul Touch"; break; }
    case SPELL_GLOBE_OF_INVULNERABILITY: { sSpellName = "Globe of Invulnerability"; break; }
    case SPELL_GLYPH_OF_WARDING: { sSpellName = "Glyph of Warding"; break; }
    case SPELL_GREASE: { sSpellName = "Grease"; break; }
    case SPELL_GREAT_THUNDERCLAP: { sSpellName = "Great Thunderclap"; break; }
    case SPELL_GREATER_BULLS_STRENGTH: { sSpellName = "Greater Bull's Strength"; break; }
    case SPELL_GREATER_CATS_GRACE: { sSpellName = "Greater Cat's Grace"; break; }
    case SPELL_GREATER_DISPELLING: { sSpellName = "Greater Dispelling"; break; }
    case SPELL_GREATER_EAGLE_SPLENDOR: { sSpellName = "Greater Eagle's Splendor"; break; }
    case SPELL_GREATER_ENDURANCE: { sSpellName = "Greater Endurance"; break; }
    case SPELL_GREATER_FOXS_CUNNING: { sSpellName = "Greater Fox's Cunning"; break; }
    case SPELL_GREATER_MAGIC_WEAPON: { sSpellName = "Greater Magic Weapon"; break; }
    case SPELL_GREATER_MAGIC_FANG: { sSpellName = "Greater Magic Fang"; break; }
    case SPELL_GREATER_OWLS_WISDOM: { sSpellName = "Greater Owl's Wisdom"; break; }
    case SPELL_GREATER_PLANAR_BINDING: { sSpellName = "Greater Planar Binding"; break; }
    case SPELL_GREATER_RESTORATION: { sSpellName = "Greater Restoration"; break; }
    case SPELL_GREATER_SHADOW_CONJURATION_ACID_ARROW: { sSpellName = "Greater Shadow Conjuration: Acid Arrow"; break; }
    case SPELL_GREATER_SHADOW_CONJURATION_MINOR_GLOBE: { sSpellName = "Greater Shadow Conjuration: Minor Globe"; break; }
    case SPELL_GREATER_SHADOW_CONJURATION_MIRROR_IMAGE: { sSpellName = "Greater Shadow Conjuration: Mirror Image"; break; }
    case SPELL_GREATER_SHADOW_CONJURATION_SUMMON_SHADOW: { sSpellName = "Greater Shadow Conjuration: Summon Shadow"; break; }
    case SPELL_GREATER_SHADOW_CONJURATION_WEB: { sSpellName = "Greater Shadow Conjuration: Web"; break; }
    case SPELL_GREATER_SPELL_BREACH: { sSpellName = "Greater Spell Breach"; break; }
    case SPELL_GREATER_SPELL_MANTLE: { sSpellName = "Greater Spell Mantle"; break; }
    case SPELL_GREATER_STONESKIN: { sSpellName = "Greater Stoneskin"; break; }
    case SPELL_GUST_OF_WIND: { sSpellName = "Gust of Wind"; break; }
    case SPELL_HAMMER_OF_THE_GODS: { sSpellName = "Hammer of the Gods"; break; }
    case SPELL_HARM: { sSpellName = "Harm"; break; }
    case SPELL_HASTE: { sSpellName = "Haste"; break; }
    case SPELL_HEAL: { sSpellName = "Heal"; break; }
    case SPELL_HEALING_CIRCLE: { sSpellName = "Healing Circle"; break; }
    case SPELL_HEALING_STING: { sSpellName = "Healing Sting"; break; }
    case SPELL_HOLD_ANIMAL: { sSpellName = "Hold Animal"; break; }
    case SPELL_HOLD_MONSTER: { sSpellName = "Hold Monster"; break; }
    case SPELL_HOLD_PERSON: { sSpellName = "Hold Person"; break; }
    case SPELL_HOLY_AURA: { sSpellName = "Holy Aura"; break; }
    case SPELL_HOLY_SWORD: { sSpellName = "Holy Sword"; break; }
    case SPELL_HORIZIKAULS_BOOM: { sSpellName = "Horizikaul's Boom"; break; }
    case SPELL_HORRID_WILTING: { sSpellName = "Horrid Wilting"; break; }
    case SPELL_ICE_STORM: { sSpellName = "Ice Storm"; break; }
    case SPELL_IDENTIFY: { sSpellName = "Identify"; break; }
    case SPELL_IMPLOSION: { sSpellName = "Implosion"; break; }
    case SPELL_IMPROVED_INVISIBILITY: { sSpellName = "Improved Invisibility"; break; }
    case SPELL_INFERNO: { sSpellName = "Inferno"; break; }
    case SPELL_INFESTATION_OF_MAGGOTS: { sSpellName = "Infestation of Maggots"; break; }
    case SPELL_INFLICT_CRITICAL_WOUNDS: { sSpellName = "Inflict Critical Wounds"; break; }
    case SPELL_INFLICT_LIGHT_WOUNDS: { sSpellName = "Inflict Light Wounds"; break; }
    case SPELL_INFLICT_MINOR_WOUNDS: { sSpellName = "Inflict Minor Wounds"; break; }
    case SPELL_INFLICT_MODERATE_WOUNDS: { sSpellName = "Inflict Moderate Wounds"; break; }
    case SPELL_INFLICT_SERIOUS_WOUNDS: {sSpellName = "Inflict Serious Wounds"; break; }
    case SPELL_INCENDIARY_CLOUD: { sSpellName = "Incendiary Cloud"; break; }
    case SPELL_INVISIBILITY: { sSpellName = "Invisibility"; break; }
    case SPELL_INVISIBILITY_PURGE: { sSpellName = "Invisibility Purge"; break; }
    case SPELL_INVISIBILITY_SPHERE: { sSpellName = "Invisibility Sphere"; break; }
    case SPELL_IRONGUTS: { sSpellName = "Ironguts"; break; }
    case SPELL_ISAACS_GREATER_MISSILE_STORM: { sSpellName = "Isaac's Greater Missile Storm"; break; }
    case SPELL_ISAACS_LESSER_MISSILE_STORM: { sSpellName = "Isaac's Lesser Missile Storm"; break; }
    case SPELL_KEEN_EDGE: { sSpellName = "Keen Edge"; break; }
    case SPELL_KNOCK: { sSpellName = "Knock"; break; }
    case SPELL_LEGEND_LORE: { sSpellName = "Legend Lore"; break; }
    case SPELL_LESSER_DISPEL: { sSpellName = "Lesser Dispel"; break; }
    case SPELL_LESSER_MIND_BLANK: { sSpellName = "Lesser Mind Blank"; break; }
    case SPELL_LESSER_PLANAR_BINDING: { sSpellName = "Lesser Planar Binding"; break; }
    case SPELL_LESSER_RESTORATION: { sSpellName = "Lesser Restoration"; break; }
    case SPELL_LESSER_SPELL_BREACH: { sSpellName = "Lesser Spell Breach"; break; }
    case SPELL_LESSER_SPELL_MANTLE: { sSpellName = "Lesser Spell Mantle"; break; }
    case SPELL_LIGHT: { sSpellName = "Light"; break; }
    case SPELL_LIGHTNING_BOLT: { sSpellName = "Lightning Bolt"; break; }
    case SPELL_MAGE_ARMOR: { sSpellName = "Mage Armor"; break; }
    case SPELL_MAGIC_CIRCLE_AGAINST_CHAOS: { sSpellName = "Magic Circle Against Chaos"; break; }
    case SPELL_MAGIC_CIRCLE_AGAINST_EVIL: { sSpellName = "Magic Circle Against Evil"; break; }
    case SPELL_MAGIC_CIRCLE_AGAINST_GOOD: { sSpellName = "Magic Circle Against Good"; break; }
    case SPELL_MAGIC_CIRCLE_AGAINST_LAW: { sSpellName = "Magic Circle Against Law"; break; }
    case SPELL_MAGIC_FANG: { sSpellName = "Magic Fang"; break; }
    case SPELL_MAGIC_MISSILE: { sSpellName = "Magic Missile"; break; }
    case SPELL_MAGIC_VESTMENT: { sSpellName = "Magic Vestment"; break; }
    case SPELL_MAGIC_WEAPON: { sSpellName = "Magic Weapon"; break; }
    case SPELL_MASS_BLINDNESS_AND_DEAFNESS: { sSpellName = "Mass Blindness and Deafness"; break; }
    case SPELL_MASS_CHARM: { sSpellName = "Mass Charm"; break; }
    case SPELL_MASS_HASTE: { sSpellName = "Mass Haste"; break; }
    case SPELL_MASS_HEAL: { sSpellName = "Mass Heal"; break; }
    case SPELL_MELFS_ACID_ARROW: { sSpellName = "Melf's Acid Arrow"; break; }
    case SPELL_MESTILS_ACID_BREATH: { sSpellName = "Mestil's Acid Breath"; break; }
    case SPELL_MESTILS_ACID_SHEATH: { sSpellName = "Mestil's Acid Sheath"; break; }
    case SPELL_METEOR_SWARM: { sSpellName = "Meteor Swarm"; break; }
    case SPELL_MIND_BLANK: { sSpellName = "Mind Blank"; break; }
    case SPELL_MIND_FOG: { sSpellName = "Mind Fog"; break; }
    case SPELL_MINOR_GLOBE_OF_INVULNERABILITY: { sSpellName = "Minor Globe of Invulnerability"; break; }
    case SPELL_MONSTROUS_REGENERATION: { sSpellName = "Monstrous Regeneration"; break; }
    case SPELL_MORDENKAINENS_DISJUNCTION: { sSpellName = "Mordenkainen's Disjunction"; break; }
    case SPELL_MORDENKAINENS_SWORD: { sSpellName = "Mordenkainen's Sword"; break; }
    case SPELL_NATURES_BALANCE: { sSpellName = "Nature's Balance"; break; }
    case SPELL_NEGATIVE_ENERGY_BURST: { sSpellName = "Negative Energy Burst"; break; }
    case SPELL_NEGATIVE_ENERGY_PROTECTION: { sSpellName = "Negative Energy Protection"; break; }
    case SPELL_NEGATIVE_ENERGY_RAY: { sSpellName = "Negative Energy Ray"; break; }
    case SPELL_NEUTRALIZE_POISON: { sSpellName = "Neutralize Poison"; break; }
    case SPELL_ONE_WITH_THE_LAND: { sSpellName = "One with the Land"; break; }
    case SPELL_OWLS_WISDOM: { sSpellName = "Owl's Wisdom"; break; }
    case SPELL_PHANTASMAL_KILLER: { sSpellName = "Phantasmal Killer"; break; }
    case SPELL_PLANAR_ALLY: { sSpellName = "Planar Ally"; break; }
    case SPELL_PLANAR_BINDING: { sSpellName = "Planar Binding"; break; }
    case SPELL_POISON: { sSpellName = "Poison"; break; }
    case SPELL_POLYMORPH_SELF: { sSpellName = "Polymorph Self"; break; }
    case SPELL_POWER_WORD_KILL: { sSpellName = "Power Word Kill"; break; }
    case SPELL_POWER_WORD_STUN: { sSpellName = "Power Word Stun"; break; }
    case SPELL_PRAYER: { sSpellName = "Prayer"; break; }
    case SPELL_PREMONITION: { sSpellName = "Premonition"; break; }
    case SPELL_PRISMATIC_SPRAY: { sSpellName = "Prismatic Spray"; break; }
    case SPELL_PROTECTION_FROM_EVIL: { sSpellName = "Protection from Evil"; break; }
    case SPELL_PROTECTION_FROM_GOOD: { sSpellName = "Protection from Good"; break; }
    case SPELL_PROTECTION_FROM_LAW: { sSpellName = "Protection from Law"; break; }
    case SPELL_PROTECTION_FROM_ELEMENTS: {sSpellName = "Protection from Elements"; break; }
    case SPELL_PROTECTION_FROM_SPELLS: { sSpellName = "Protection from Spells"; break; }
    case SPELL_QUILLFIRE: { sSpellName = "Quillfire"; break; }
    case SPELL_RAISE_DEAD: { sSpellName = "Raise Dead"; break; }
    case SPELL_RAY_OF_ENFEEBLEMENT: { sSpellName = "Ray of Enfeeblement"; break; }
    case SPELL_RAY_OF_FROST: { sSpellName = "Ray of Frost"; break; }
    case SPELL_REGENERATE: { sSpellName = "Regenerate"; break; }
    case SPELL_REMOVE_BLINDNESS_AND_DEAFNESS: { sSpellName = "Remove Blindness and Deafness"; break; }
    case SPELL_REMOVE_CURSE: { sSpellName = "Remove Curse"; break; }
    case SPELL_REMOVE_DISEASE: { sSpellName = "Remove Disease"; break; }
    case SPELL_REMOVE_FEAR: { sSpellName = "Remove Fear"; break; }
    case SPELL_REMOVE_PARALYSIS: { sSpellName = "Remove Paralysis"; break; }
    case SPELL_RESIST_ELEMENTS: { sSpellName = "Resist Elements"; break; }
    case SPELL_RESISTANCE: { sSpellName = "Resistance"; break; }
    case SPELL_RESTORATION: { sSpellName = "Restoration"; break; }
    case SPELL_RESURRECTION: { sSpellName = "Resurrection"; break; }
    case SPELL_SANCTUARY: { sSpellName = "Sanctuary"; break; }
    case SPELL_SCARE: { sSpellName = "Scare"; break; }
    case SPELL_SCINTILLATING_SPHERE: { sSpellName = "Scintillating Sphere"; break; }
    case SPELL_SEARING_LIGHT: { sSpellName = "Searing Light"; break; }
    case SPELL_SEE_INVISIBILITY: { sSpellName = "See Invisibility"; break; }
    case SPELL_SHADES_CONE_OF_COLD: { sSpellName = "Shades Cone of Gold"; break; }
    case SPELL_SHADES_FIREBALL: { sSpellName = "Shades Fireball"; break; }
    case SPELL_SHADES_STONESKIN: { sSpellName = "Shades Stoneskin"; break; }
    case SPELL_SHADES_SUMMON_SHADOW: { sSpellName = "Shades Summon Shadow"; break; }
    case SPELL_SHADES_WALL_OF_FIRE: { sSpellName = "Shades Wall of Fire"; break; }
    case SPELL_SHADOW_CONJURATION_DARKNESS: { sSpellName = "Shadow Conjuration: Darkness"; break; }
    case SPELL_SHADOW_CONJURATION_INIVSIBILITY: { sSpellName = "Shadow Conjuration: Invisibility"; break; }
    case SPELL_SHADOW_CONJURATION_MAGE_ARMOR: { sSpellName = "Shadow Conjuration: Mage Armor"; break; }
    case SPELL_SHADOW_CONJURATION_MAGIC_MISSILE: { sSpellName = "Shadow Conjuration: Magic Missile"; break; }
    case SPELL_SHADOW_CONJURATION_SUMMON_SHADOW: { sSpellName = "Shadow Conjuration: Summon Shadow"; break; }
    case SPELL_SHADOW_SHIELD: { sSpellName = "Shadow Shield"; break; }
    case SPELL_SHAPECHANGE: { sSpellName = "Shapechange"; break; }
    case SPELL_SHELGARNS_PERSISTENT_BLADE: { sSpellName = "Shelgarn's Persistent Blade"; break; }
    case SPELL_SHIELD: { sSpellName = "Shield"; break; }
    case SPELL_SHIELD_OF_FAITH: { sSpellName = "Shield of Faith"; break; }
    case SPELL_SHIELD_OF_LAW: { sSpellName = "Shield of Law"; break; }
    case SPELL_SILENCE: { sSpellName = "Silence"; break; }
    case SPELL_SLAY_LIVING: { sSpellName = "Slay Living"; break; }
    case SPELL_SLEEP: { sSpellName = "Sleep"; break; }
    case SPELL_SLOW: { sSpellName = "Slow"; break; }
    case SPELL_SOUND_BURST: { sSpellName = "Sound Burst"; break; }
    case SPELL_SPIKE_GROWTH: { sSpellName = "Spike Growth"; break; }
    case SPELL_SPELL_MANTLE: { sSpellName = "Spell Mantle"; break; }
    case SPELL_SPELL_RESISTANCE: { sSpellName = "Spell Resistance"; break; }
    case SPELL_SPHERE_OF_CHAOS: { sSpellName = "Sphere of Chaos"; break; }
    case SPELL_STINKING_CLOUD: { sSpellName = "Stinking Cloud"; break; }
    case SPELL_STONEHOLD: { sSpellName = "Stonehold "; break; }
    case SPELL_STONESKIN: { sSpellName = "Stoneskin"; break; }
    case SPELL_STONE_BONES: { sSpellName = "Stone Bones"; break; }
    case SPELL_STONE_TO_FLESH: { sSpellName = "Stone to Flesh"; break; }
    case SPELL_STORM_OF_VENGEANCE: { sSpellName = "Storm of Vengeance"; break; }
    case SPELL_SUMMON_CREATURE_I: { sSpellName = "Summon Creature I"; break; }
    case SPELL_SUMMON_CREATURE_II: { sSpellName = "Summon Creature II"; break; }
    case SPELL_SUMMON_CREATURE_III: { sSpellName = "Summon Creature III"; break; }
    case SPELL_SUMMON_CREATURE_IV: { sSpellName = "Summon Creature IV"; break; }
    case SPELL_SUMMON_CREATURE_IX: { sSpellName = "Summon Creature IX"; break; }
    case SPELL_SUMMON_CREATURE_V: { sSpellName = "Summon Creature V"; break; }
    case SPELL_SUMMON_CREATURE_VI: { sSpellName = "Summon Creature VI"; break; }
    case SPELL_SUMMON_CREATURE_VII: { sSpellName = "Summon Creature VII"; break; }
    case SPELL_SUMMON_CREATURE_VIII: { sSpellName = "Summon Creature VIII"; break; }
    case SPELL_SUNBEAM: { sSpellName = "Sunbeam"; break; }
    case SPELL_SUNBURST: { sSpellName = "Sunburst"; break; }
    case SPELL_TASHAS_HIDEOUS_LAUGHTER: { sSpellName = "Tasha's Hideous Laughter"; break; }
    case SPELL_TENSERS_TRANSFORMATION: { sSpellName = "Tenser's Transformation"; break; }
    case SPELL_TIME_STOP: { sSpellName = "Time Stop"; break; }
    case SPELL_TRUE_SEEING: { sSpellName = "True Seeing"; break; }
    case SPELL_TRUE_STRIKE: { sSpellName = "True Strike"; break; }
    case SPELL_UNHOLY_AURA: { sSpellName = "Unholy Aura"; break; }
    case SPELL_UNDEATH_TO_DEATH: { sSpellName = "Undeath to Death"; break; }
    case SPELL_UNDEATHS_ETERNAL_FOE: { sSpellName = "Undeath's Eternal Foe"; break; }
    case SPELL_VAMPIRIC_TOUCH: { sSpellName = "Vampiric Touch"; break; }
    case SPELL_VINE_MINE: { sSpellName = "Vine Mine"; break; }
    case SPELL_VIRTUE: { sSpellName = "Virtue"; break; }
    case SPELL_WAIL_OF_THE_BANSHEE: { sSpellName = "Wail of the Banshee"; break; }
    case SPELL_WALL_OF_FIRE: { sSpellName = "Wall of Fire"; break; }
    case SPELL_WAR_CRY: { sSpellName = "War Cry"; break; }
    case SPELL_WEB: { sSpellName = "Web"; break; }
    case SPELL_WEIRD: { sSpellName = "Weird"; break; }
    case SPELL_WORD_OF_FAITH: { sSpellName = "Word of Faith"; break; }
    case SPELL_WOUNDING_WHISPERS: { sSpellName = "Wounding Whispers"; break; }
  }

  return sSpellName;
}
