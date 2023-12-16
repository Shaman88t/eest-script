// Authors  : TondaLee (AV) - Antonin Vins
// Created  : 05/2005
// Modified : 31/03/2006
// Konfigurace celeho modulu (je v cache)

// *********************
// ** Encouter Config **
// *********************
const float ENCOUNTERS_DESPAWN_TIME = 300.0;

// *************************
// *** Nastaveni modulu ****
// *************************
// Debug
const int       IS_MODULE_DEBUG = 1;
const int       AUTO_RESTART_FEATURE = 1;

// Prestige class
const int       PRESTIGE_CLASS_RESTRICTION = 1;

// Time
const float     TIME_TO_CLOSE_DOOR = 15.0f;
const float     TIME_TO_LOCK_DOOR = 90.0f;
const float     TIME_TO_TRAP_PLAC = 720.0f;

// XP
const int       XP_FOR_SKILL = 0;
const float     MULTICLASS_0_BONUS = 1.30f; //single class
const float     MULTICLASS_1_BONUS = 1.00f; //dual class
const float     MULTICLASS_2_BONUS = 0.80f;
const float     MULTICLASS_3_BONUS = 0.70f;
const float     MULTICLASS_4_BONUS = 0.60f;
const float     MULTICLASS_5_BONUS = 0.50f;
const float     FAVORITED_SUBRACE_BONUS = 1.10f;
const float     FAVORITED_SUBRACE_DECRASE = 0.90f;

// Starting position
const string    STARTING_WAYPOINT = "KA_START_WP";
const string    STARTING_WAYPOINT_UNDERGROUND = "DrowTown_Start_WP";
const string    STARTING_WAYPOINT_WOOD = "WOOD_START_WP";
const string    STARTING_ILEGAL_CHARACTER = "DH_ILEGAL_CHAR_WP";

// Respawn treasure
const float     RESPAWN_TREASURE_10 = 600.0f;
const float     RESPAWN_TREASURE_120 = 7200.0f;
const float     RESPAWN_TREASURE_180 = 7200.0f;

// Damage trigers
const int       LOW_DAMAGE_TRIGERS = 5;
const int       NORMAL_DAMAGE_TRIGERS = 15;
const int       HIGH_DAMAGE_TRIGERS = 50;

// Price system
const int       GOLD_FOR_ADD_USER = 100;
const int       GOLD_FOR_SEND_POSTCARD = 50;
const int       GOLD_FOR_SEND_PACKAGE = 100;
const int       GOLD_FOR_INN = 10;

const string    VARIABLE_PRICE = "goldPrice";

// Economics
const float     ODKUP_CONST = 1.0f;
const float     PRODEJ_CONST = 1.0f;
const int       MAX_ITEM_PER_CHEST = 50;
const int       MAX_ITEM_PER_STORE = 300;
const int       THIEF_POLICE = 0;

// Respawn
const float     PLACEABLE_ITEM_RESPAWN_TIME = 600.0;
const float     PLACEABLE_ITEM_LOCK_TIME = 120.0;

// Faitigue system
const int       MAX_STANDARD_FEATIGURE = 120;

// tyto informace je mozne ukladat do DB (ModuleVariable)
const string    MODULE_VERSION = "2.1.65 CEP 2.0";
const string    MODULE_AUTHOR = "Antonin Vins (TondaLee), LordDragoo (veduci modulu a WB teamu)";
const string    MODULE_DESCRIPTION = "Dragon Hammer je persistentny svet NWN. Jedna sa o RP svet.";
const string    MODULE_WEB_PAGES = "www.dragonhammer.neverwinter.cz\nwww.dragonhammer.neverwinter.cz/log/\nwww.dragonhammer.neverwinter.cz/forum\nwww.dragonhammer.neverwinter.cz/galeria";
const string    MODULE_DATE = "03.01.2008";
const int       MODULE_RESTART_TICK = 300;

// Server info
const string    SERVER_IP =  "195.47.96.239:5121";
const string    SERVER_IS_ON_GP = "Yes";
const string    SERVER_PATH = "C:/Games/NWN_132/"; //GP
//const string    SERVER_PATH = "C:/Hry/NeverwinterNights/"; //Ume

// *************************
// *** Database settings ***
// *************************
// Database table - nutne pouzivat ''
const string TABLE_CHARACTERS = "characters";
const string TABLE_CHARACTERS_VARIABLES = "characters_variables";
const string TABLE_CHARACTERS_QUESTS = "characters_quests";
const string TABLE_CHARACTERS_SKILLS = "characters_skills";
const string TABLE_CHARACTERS_SCHEMATICS = "characters_schematics";
const string TABLE_CHARACTERS_STORED_OBJECTS = "characters_stored_objects";
const string TABLE_CHARACTERS_STORED_ITEMS = "characters_stored_items";
const string TABLE_CHARACTERS_DM_MESSAGES = "characters_dm_messages";

// system pevnych guild
const string TABLE_GUILDS = "guilds";
const string TABLE_GUILDS_MEMBERS = "guilds_members";
const string TABLE_GUILDS_ITEMS = "guilds_items";
const string TABLE_GUILDS_RELATIONS = "guilds_relations";

// system DMFI
const string TABLE_DMFI = "dmfi";

// Tabulka pro system message boardu
const string TABLE_MESSAGE_BOARD = "messages_boards";

// Tabulka pro system posty
const string TABLE_POST_STORED_OBJECTS = "post_stored_objects";
const string TABLE_POST_STORED_LETTERS = "post_stored_letters";

// Tabulka pro nemovitosti
const string TABLE_PROPERTY_ESTATES = "estates";
const string TABLE_PROPERTY_ESTATES_OWNERS = "estates_owners";

// Tabulky ve kterych jsou ulozena nastaveni modulu
const string TABLE_MODULES = "modules";
const string TABLE_MODULES_VARIABLES = "modules_variables";
const string TABLE_MODULES_MESSAGES = "modules_messages";

// Tabulky s predmety
const string TABLE_ITEMS_STARTUP = "items_startup";
const string TABLE_ITEMS_TREASURE = "items_treasure";
const string TABLE_CREATE_STORED_OBJECTS = "creates_stored_objects";

// tabulka s ulozenym seznamem skillu
const string TABLE_SKILLS = "skills";

// Stored local character variables
const string LVS_ONENTER_HURT = "PC_ON_ENTER_HURT";

// **************************
// ** Promene (Databazove) **
// **************************
// Module variable
const string VARIABLE_MODULE_VERSION = "Version";
const string VARIABLE_MODULE_NEWS = "News";
const string VARIABLE_MODULE_INFO = "Info";
const string VARIABLE_MODULE_CREATED_BY = "CreateBy";
const string VARIABLE_MODULE_RESTART_TICK = "RestartTick";
const string VARIABLE_MODULE_LAST_UPDATE = "LastUpdate";
const string VARIABLE_MODULE_HOUR = "ModuleDateHour";
const string VARIABLE_MODULE_DAY = "ModuleDateDay";
const string VARIABLE_MODULE_MONTH = "ModuleDateMonth";
const string VARIABLE_MODULE_YEAR = "ModuleDateYear";
const string VARIABLE_MODULE_SAVE_TICK = "SaveTick";
const string VARIABLE_MODULE_SAVE_MODIFIER = "SaveModifier";


// Skill variable
const string VARIABLE_SKILL_CLIMBING = "Climbing";
const string VARIABLE_SKILL_SWIMMING = "Swimming";
const string VARIABLE_SKILL_JUMPING = "Jumping";
const string VARIABLE_SKILL_RESTING = "Resting";

// Character Variable
const string VARIABLE_CHARACTER_KARMA = "Karma";
const string VARIABLE_CHARACTER_HP = "HitPoints";
const string VARIABLE_CHARACTER_LOCATION = "Location";
const string VARIABLE_CHARACTER_RESPAWN_POINT = "RespawnPoint";
const string VARIABLE_CHARACTER_BANK_MONEY = "BankMoney"; //Bezny ucet
const string VARIABLE_CHARACTER_SAVE_MONEY = "SaveMoney"; //Sporiaci ucet

// Global listen (poslouchac konfigurace)
const string VARIABLE_LISTEN_STRING = "listenString";
const int VARIABLE_LISTEN_PATERN = 100;

// *********************
// *** Quests config ***
// *********************
const string QUEST_VARIABLE_BONIFAC = "AVQ_Bonifac"; //nazev promene v DB
const string QUEST_ITEM_BONIFAC = "bonifacoviakcie";
const string QUEST_VARIABLE_FERIANDO = "AVQ_Feriando"; //nazev promene v DB
const string QUEST_VARIABLE_CLAN = "AVQ_ClanKnights"; //nazev promene v DB
const string QUEST_VARIABLE_WIZQ01 = "AVQ_Wizards01"; //nazev promene v DB
const string QUEST_VARIABLE_WIZQ02 = "AVQ_Wizards02"; //nazev promene v DB
const string QUEST_ITEM_WIZQ02 = "avq_wiz02";
const string QUEST_VARIABLE_DUGAR = "AVQ_Dugar";
const string QUEST_ITEM_DUGAR = "cnrNuggetIron";
const string QUEST_VARIABLE_MISTERCRAFTSMAN = "AVQ_MisterCraftsman";
const string QUEST_ITEM_MISTERCRAFTSMAN = "AVQ_miscraft";
const string QUEST_VARIABLE_KULICKA = "AVQ_Kulicka";
const string QUEST_ITEM1_KULICKA = "cnrAnimalMeat";
const string QUEST_ITEM2_KULICKA = "cnrbIronHammer";
const string QUEST_VARIABLE_OCELRAM = "AVQ_Ocelram";
const string QUEST_ITEM1_OCELRAM = "cnrArrowPlain"; //sipy
const string QUEST_ITEM2_OCELRAM = "cnrShortBowHic"; //male luky
const string QUEST_ITEM3_OCELRAM = "cnrLongBowHic"; //velke luky
const string QUEST_VARIABLE_MARENKA = "AVQ_Marenka";
const string QUEST_ITEM1_MARENKA = "cnrGarlicClove"; //cesnek
const string QUEST_ITEM2_MARENKA = "cnrAngelicaLeaf"; //dehel
const string QUEST_VARIABLE_DUGARBLK = "AVG_DugarsBlkSmith";
const string QUEST_ITEM1_DUGARBLK = "cnrDwAxeBron"; //cesnek
const string QUEST_VARIABLE_DUGAR2 = "AVQ_Dugar2";
const string QUEST_ITEM_DUGAR2 = "cnrNuggetGold";
const string QUEST_KEY_DUGAR2 = "dhgoldminekey";
const string QUEST_VARIABLE_RADIM = "AVQ_Radim";
const string QUEST_ITEM_RADIM = "cnrLeathPola";
const string QUEST_VARIABLE_ZIMOVOUS = "AVQ_Zimovous";
const string QUEST_ITEM_ZIMOVOUS = "cnrWheatBread";
const string QUEST_VARIABLE_MASTAN = "AVQ_Mastan";
const string QUEST_ITEM_MASTAN = "cnrCloak";
const string QUEST_VARIABLE_SWAMPINN = "AVQ_SwampInn";
const string QUEST_ITEM_SWAMPINN = "cnrApplePie";
const string QUEST_VARIABLE_GLOIGNAR = "AVQ_Gloignar";
const string QUEST_ITEM_GLOIGNAR = "cnrbSilverBuckle";
const string QUEST_VARIABLE_ENDARINN = "AVQ_EndarInn";
const string QUEST_ITEM_ENDARINN = "cnrPecanPie";
const string QUEST_VARIABLE_BOIDO = "AVQ_Boido";
const string QUEST_ITEM_BOIDO = "cnrBroAdvRing";
const string QUEST_VARIABLE_SIKULKA = "AVQ_Sikulka";
const string QUEST_ITEM_SIKULKA = "cnrLgSwordIron";
const string QUEST_VARIABLE_KING1 = "AVQ_King1";
const string QUEST_ITEM_KING1 = "avqguardsword";
const string QUEST_VARIABLE_IZAARALCHYMISTA = "AVQ_IzaarAlchymista";
const string QUEST_ITEM_IZAARALCHYMISTA = "cnrAloeLeaf";
const string QUEST_VARIABLE_IZAARTEMPLE = "AVQ_IzaarTemple";
const string QUEST_ITEM_IZAARTEMPLE = "avqizaartemple";
const string QUEST_VARIABLE_PRESTIGE = "AVQ_PrestigeClass";
const string QUEST_ITEM_PRESTIGE1 = "avq_prestige1";
const string QUEST_ITEM_PRESTIGE2 = "avq_prestige2";
const string QUEST_ITEM_PRESTIGE3 = "avq_prestige3";
const string QUEST_ITEM_PRESTIGE4 = "avq_prestige4";
const string QUEST_ITEM_PRESTIGE5 = "avq_prestige5";
const string QUEST_VARIABLE_RADNI = "avq_radni";
const string QUEST_VARIABLE_EPIC = "avq_epic";

// RespawnPoint config
// Pocatek nazvu waypointu pro RespawnPoint
const string PREFIX_RESPAWN_POINT_WAYPOINT = "WRP_";

// Dead penalty config (prefix DEAD_)
const int   DEAD_XP_PENALTY_MIN = 50;
const int   DEAD_XP_PENALTY_MAX = 100;
const float DEAD_GOLD_PENALTY_MIN = 0.1f;
const float DEAD_GOLD_PENALTY_MAX = 0.2f;

// Rest system config
const float  MINIMUM_DISTANCE_FROM_CAMP_TO_REST = 8.0f;
const int    MINIMUM_DISTANCE_FROM_HOSTILE_TO_REST = 30;
const string ITEM_RATION = "ration";
const string ITEM_BEDROLL = "bedroll";
const string PLACEABLE_TAG_CAMPSITE = "cnrCampSite";
const string INN_POSTFIX = "_INN"; //pro placenou noc v hospode

// Messages Config
const string TEXT_CHARACTER_POSITION_LOAD = "Pozice charakteru nahrana.";
const string TEXT_CHARACTER_POSITION_NOT_LOAD = "Nelze nahrat pozici charakteru!";
const string TEXT_CHARACTER_POSITION_SAVED = "Pozice charakteru ulozena.";
const string TEXT_CHARACTER_RESPAWNPOINT_SAVED = "RespawnPoint ulozen!";
const string TEXT_CHARACTER_RESPAWNPOINT_LOAD = "Charakter RespawnPoint nahran.";
const string TEXT_CHARACTER_RESPAWNPOINT_DELETED = "Charakter RespawnPoint byl smazan.";

// Dynamicka konverzace pro messageboard
const string VARIABLE_MSG_BOARD_ITEM = "messageID";   //Id schematu
const string VARIABLE_MSG_BOARD_ACTUAL_PAGE = "ActualPage";

// Nastaveni message boardu - zalozeni nove zpravy
const int GOLD_FOR_NEW_MESSAGE = 50;
const string VARIABLE_MSG_NAME = "messageName";
const string VARIABLE_MSG_TEXT = "messageText";

// Dynamicka konverzace pro postu a obecne pro vyber charakteru
const string VARIABLE_POST_ITEM = "PostID";
const string VARIABLE_POST_ACTUAL_PAGE = "ActualPage";
const string VARIABLE_POST_TYPE = "PostType";
const string ITEM_LETTER_PREFIX = "LetterDH_";
const string ITEM_LETTER_RES = "letter";
const string PLACEABLE_POST_TABLE = "PostPlaceTag";

const string VARIABLE_CHARACTER_GUID = "chaGuid";
const string VARIABLE_CHARACTER_TAG = "chaTag";
const string VARIABLE_CHARACTER_NAME = "chaName";
const string VARIABLE_PLAYER_NAME = "plaName";
const string VARIABLE_CHARACTER_FILTER = "chaFilter";

// konverzace s NPC spravcem nemovitosti
const string VARIABLE_ESTATE_CONTROL_TAG = "estateTag";
const string VARIABLE_ESTATE_NAME = "estateName";

// Obecne TOKENY
const int TOKEN_CHARACTER_NAME = 50010;
const int TOKEN_PRICE = 50020;
const int TOKEN_SKILLLIST = 50030;
const int TOKEN_KARMA = 50040;
const int TOKEN_BIRTH_DATE = 60010;
const int TOKEN_GUILDS_MEMBER = 50050;
const int TOKEN_SKILL_VALUE = 20010;
const int TOKEN_MSG_NAME = 41000;
const int TOKEN_MSG_TEXT = 42000;
const int TOKEN_ESTATE_NAME = 40001;
const int TOKEN_ESTATE_OWNER = 40002;
const int TOKEN_ESTATE_MAIN_DOOR = 40003;
const int TOKEN_ESTATE_WORK_DOOR = 40004;
const int TOKEN_ESTATE_ROOM_DOOR = 40005;

// System sporiaceho uctu
const float SAVE_MIN_MODIFIER = 0.95;
const float SAVE_MAX_MODIFIER = 1.25;
const int SAVE_NUM_TICK = 24000;

// System obmedzovania pokladu

string VARNAME_LOCAL_TREASURE_DISABLE = "ModuleDisableTreasure";
string VARNAME_CHARACTER_TREASURE_OPEN = "LastOpenTreasuer";
int TIME_TO_NEXT_TREASURE = 60; //minut
