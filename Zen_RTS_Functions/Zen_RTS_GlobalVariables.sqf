rts_debug = TRUE;
mapDebug = TRUE;
param3 = 0;
StopMsg = false;
ShowStats = false;
Dedicated = isDedicated;
ColorCivilian = "ColorCivilian";
// ListFlag6 = ListFlag7;
updbg = false;
WESTGearLevel1 = [];
WESTPrimaryLevel1 = [];
westPrimaryLevel3 = [];
arms_refresh = true;
noBuildZone = [];

aiLimit = 10;
rts_unitnum = 0;
westSoldiers = [];

vd = 500;
oilWest = 1;
oreWest = 1;
energyWest = 1;

oilEast = 1;
oreEast = 1;
energyEast = 1;

westBaseUnits = 0;
eastBaseUnits = 0;

westtransport1  = [];
easttransport1  = [];
westLightGround = [];
eastLightGround = [];
westair4        = [];
eastair4        = [];
westair5        = [];
eastair5        = [];
westair6        = [];
eastair6        = [];
westAllGround   = [];
westAllAir      = [];
AllGround       = [];
westMedium1     = [];
eastMedium1     = [];
westSupport     = [];
eastSupport     = [];
westAAA         = [];
eastAAA         = [];
westHeavyGround = [];
eastHeavyGround = [];

// These variable set all build queue info.  Forward base variables are initialized in the territory monitor file.
rts_maxQueueSize = 10;

westBarracksQActive = FALSE;
westLightFacQActive = FALSE;
westHeavyFacQActive = FALSE;
westAirFacQActive = FALSE;

eastBarracksQActive = FALSE;
eastLightFacQActive = FALSE;
eastHeavyFacQActive = FALSE;
eastAirFacQActive = FALSE;

westBarracksQNum = 0;
westLightFacQNum = 0;
westHeavyFacQNum = 0;
westAirFacQNum = 0;

eastBarracksQNum = 0;
eastLightFacQNum = 0;
eastHeavyFacQNum = 0;
eastAirFacQNum = 0;

// Upgrade Variables
westBarracksLevel = 0;
westLightFacLevel = 0;
westHeavyFacLevel = 0;
westAirFacLevel = 0;
westForwardBaseLevel = 0;
westGearLevel = 1;

eastBarracksLevel = 0;
eastLightFacLevel = 0;
eastHeavyFacLevel = 0;
eastAirFacLevel = 0;
eastForwardBaseLevel = 0;
eastGearLevel = 1;

rts_hq = [SIDE Player,"HQ"];

//--- Global Client Variables.
if !(isDedicated) then {
    call compile format ["xp%1 = 0",Player];
    sideJoined = side player;
    sideJoinedText = str sideJoined;
    sideID = sideJoined Call GetSideID;
    clientID = player Call GetClientID;
    clientTeam = group player;
    clientTeams = (Format["WFBE_%1TEAMS",sideJoinedText] Call GetNamespace);
    playerType = typeOf player;
    rts_camSides = [SIDE player];
};

GUER = Independent;
CIV = CIVILIAN;
undefined_var = "scalar bool array string 0xe0ffffef";
undefined_any = "any";

rts_Initialized = FALSE;
rts_arrays_initialized = FALSE;
rts_PlayerInit = FALSE;

rts_buildDistLimit = 800;
rts_viewdistanceindex = 0;

customSquadSizeLimit = 15;

// Vars if the player wants manned vehicles to have gunners/commanders/driver
rts_driver = true;
rts_gunner = true;
rts_commander = true;

rts_killedSld = ["killed",{_this execVM "rts-event-RemoveDeadEH.sqf"}];
rts_killedBase = ["killed",{_this execVM "rts-event-baseKilledEH.sqf"}];
rts_killedRsc = ["killed",{_this exec "rts-event-resourceKilled.sqs"}];

// Amount of time til player can re-deploy - set in description.ext parameters
rts_playerRespawnDelay = 1;

// Economy
rts_moneyMonitorActive = FALSE;
idMoney = 1037;
idSupply = 1038;
idFPS = 666;
// SupplyFactor - Increases with level of captured territories and increases supply income
westSupplyFactor = 0;
eastSupplyFactor = 0;
CIVSupplyFactor = 0;

if (rts_debug) then {
    playerMoney = 100000;
    eastsupply = 100000;
    westSupply = 100000;
};
