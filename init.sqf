#include "Zen_FrameworkFunctions\Zen_InitHeader.sqf"

enableSaving [false, false];

#include "Zen_RTS_Functions\Zen_RTS_GlobalFunctions.sqf"
#include "Zen_RTS_Functions\Zen_RTS_GlobalVariables.sqf"
#include "Zen_RTS_Functions\Zen_RTS_ParseParams.sqf"
#include "functions\RTS_FNC_INIT_PLAYERACTIONS.sqf"
#include "functions\RTS_FNC_flipACTIONS.sqf"
#include "functions\RTS_FNC_PUSH.sqf"

// Compile Zen Functions --------------
Zen_RTS_AlphaMenu = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_AlphaMenu.sqf";
Zen_RTS_BuildMenuStructures = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_BuildMenuStructures.sqf";
Zen_RTS_BuildStructure = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_BuildStructure.sqf";
Zen_RTS_BuildMenu = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_BuildMenu.sqf";
Zen_RTS_BuildUnit = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_BuildUnit.sqf";
Zen_RTS_DeployPlayer = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_DeployPlayer.sqf";
Zen_RTS_DisbandUnit = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_DisbandUnit.sqf";
Zen_RTS_DestroyStructure = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_DestroyStructure.sqf";
Zen_RTS_EconomyManager = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_EconomyManager.sqf";
Zen_RTS_Recycle = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_Recycle.sqf";
Zen_RTS_Repair = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_Repair.sqf";
// Zen_RTS_SquadsMenu = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_SquadsMenu.sqf";
Zen_RTS_SetViewDistance = compileFinal preprocessFileLineNumbers "Zen_RTS_Functions\Zen_RTS_SetViewDistance.sqf";

call compileFinal preprocessFileLineNumbers "Zen_RTS_Strategic\Zen_RTS_StrategicCompile.sqf";
call compileFinal preprocessFileLineNumbers "Zen_RTS_Territory\Zen_RTS_TerritoryCompile.sqf";
call compileFinal preprocessFileLineNumbers "Zen_RTS_SubTerritory\Zen_RTS_SubTerritoryCompile.sqf";
// --------------------

// ZKS Respawn Client -----------------------
// [] execVM "ZKS\Code\Player\CodeStarter.sqf";
// ---------------------

// RTS Client ---------------------
// #include "Zen_RTS_Functions\Zen_RTS_ClientExec.sqf"
//[] exec "Karr-SquadMarkers.sqs";
// [] exec "rts-build-addAction.sqs";
// [] execVM "territory\rts-territoryInit.sqf";
// [] exec "economy\rts-moneyMonitor.sqs";
// [] exec "rts-vcl-special.sqs";

// [] exec "rts-build-unitarrays.sqs";
// [] exec "rts-client-updateArrays.sqs";
// [] exec "rts-build-structurePosExec.sqs";
// [] exec "rts-z-endmission.sqs";
rts_arrays_initialized = true;

// 0 = [] execVM "RTS_Build_AddAction.sqf";

// [] execVM "rts-z-intro.sqf";
// [] exec "rts-showMsg.sqs";
[] exec "rts-init-SetRandomPos.sqs";
// onMapSingleClick "[_pos, _units, _shift, _alt] exec ""onMapSingleClick.sqs""";

// 1 setRadioMsg "Null";
// if (param3 > 0) then {
    // [] exec "vicpoint\rts-vpInit.sqs";
// };
// -------------------------

// Data structure for custom squads, this is local to each player and side specific
// indexes pair with names/colors, 0 - Alpha, etc.
RTS_Custom_Squads_Assets = [[], [], [], []];

#include "Zen_RTS_Functions\Zen_RTS_JIPSync.sqf"
if !(isServer) exitWith {};
// TitleRsc ["Title","BLACK FADED"];
// CutRsc ["Black","BLACK FADED"];
sleep 1;

// ZKS Respawn Server -----------------------
// ZKS_Revive_Init = compileFinal preprocessFileLineNumbers "ZKS\Revive\INIT_Start.sqf";
// [] execVM "ZKS\Code\server\CodeStarter.sqf";
// ------------

// RTS Server -------------
// [] exec "economy\rts-supplyMonitor.sqs";
// [] exec "rts-build-serverside.sqs";
[] exec "rts-init-commandermonitor.sqs";
[] exec "test.sqs";
//[] exec "rts-build-serverSideMonitor.sqs";
// rts_hq sideChat "Global Scripts and Variables Initialized";

execVM "R3F_LOG\init.sqf";
[] execVM "VCOM_Driving\init.sqf";
// --------------------------

// Zen Server ------------------
0 = [] spawn Zen_RTS_EconomyManager;
Zen_JIP_Args_Server = [overcast, fog, vd];

{
    call compile format ["xp%1 = 0", _x];
    // _x spawn ZKS_Revive_Init;
    if (isPlayer _x) then {
        ZEN_FMW_MP_REClient("Zen_RTS_F_RespawnActions", _x, spawn, _x)
    };
} forEach ([west, east] call Zen_ConvertToObjectArray);
// ----------------------

// ====================================================================================
// Zen_RTS_SubTerritory
// ====================================================================================

westFC = 0;
eastFC = 0;
civFC = 0;

0 = [] spawn Zen_RTS_SubTerritoryManager;

_flagMarkers = [];
for "_i" from 1 to 32 do {
    _marker = [missionNamespace getVariable ("Flag" + str _i), "", "colorBlack", [100, 100], "ellipse"] call Zen_SpawnMarker;
    _flagMarkers pushBack _marker;
    0 = [_marker, "Flag " + str _i, [0, 5, 10, 20]] call Zen_RTS_SubTerritoryCreate;
};

// ====================================================================================
// Zen_RTS_Territory
// ====================================================================================

#define MKR(I) (_flagMarkers select (I - 1))

0 = [] spawn Zen_RTS_TerritoryManager;

_Zen_TerritorySouth_East_TerritoryMarker = [ListFlag1, "", "colorRed", [0, 0], "rectangle", 0, 1] call Zen_SpawnMarker;
0 = ["South_east", [MKR(1), MKR(2),MKR(3),MKR(4)]] call Zen_RTS_TerritoryCreate;

_Zen_TerritoryEast_TerritoryMarker = [ListFlag5, "", "colorRed", [0, 0], "rectangle", 0, 1] call Zen_SpawnMarker;
0 = ["East", [MKR(5),MKR(6),MKR(7),MKR(26)]] call Zen_RTS_TerritoryCreate;

_Zen_TerritoryDesert_TerritoryMarker = [ListFlag8, "", "colorRed", [0, 0], "rectangle", 0, 1] call Zen_SpawnMarker;
0 = ["Desert", [MKR(8),MKR(9)]] call Zen_RTS_TerritoryCreate;

_Zen_TerritorySouthBay_TerritoryMarker = [ListFlag10, "", "colorRed", [0, 0], "rectangle", 0, 1] call Zen_SpawnMarker;
0 = ["SouthBay", [MKR(10), MKR(11), MKR(12)]] call Zen_RTS_TerritoryCreate;

_Zen_TerritorySouth_West_TerritoryMarker = [ListFlag13, "", "colorRed", [0, 0], "rectangle", 0, 1] call Zen_SpawnMarker;
0 = ["South_West", [MKR(13), MKR(14),MKR(15)]] call Zen_RTS_TerritoryCreate;

_Zen_TerritoryNorthWest_TerritoryMarker = [ListFlag16, "", "colorRed", [0, 0], "rectangle", 0, 1] call Zen_SpawnMarker;
0 = ["North_West", [MKR(16),MKR(17), MKR(18)]] call Zen_RTS_TerritoryCreate;

_Zen_TerritoryNorth_TerritoryMarker = [ListFlag19, "", "colorRed", [0, 0], "rectangle", 0, 1] call Zen_SpawnMarker;
0 = ["North", [MKR(19),MKR(20),MKR(21)]] call Zen_RTS_TerritoryCreate;

_Zen_TerritorynwAir_port_TerritoryMarker = [ListFlag22, "", "colorRed", [0, 0], "rectangle", 0, 1] call Zen_SpawnMarker;
0 = ["N-W_Air_port", [MKR(22)]] call Zen_RTS_TerritoryCreate;

_Zen_TerritoryAir_port_TerritoryMarker = [ListFlag23, "", "colorRed", [0, 0], "rectangle", 0, 1] call Zen_SpawnMarker;
0 = ["Air_port", [MKR(23)]] call Zen_RTS_TerritoryCreate;

_Zen_TerritoryswAir_port_TerritoryMarker = [ListFlag24, "", "colorRed", [0, 0], "rectangle", 0, 1] call Zen_SpawnMarker;
0 = ["S-W_Air_port", [MKR(24)]] call Zen_RTS_TerritoryCreate;

_Zen_TerritoryneAir_port_TerritoryMarker = [ListFlag25, "", "colorRed", [0, 0], "rectangle", 0, 1] call Zen_SpawnMarker;
0 = ["N-E_Air_port", [MKR(25)]] call Zen_RTS_TerritoryCreate;

_Zen_TerritoryNorth_East_TerritoryMarker = [ListFlag27, "", "colorRed", [0, 0], "rectangle", 0, 1] call Zen_SpawnMarker;
0 = ["North_East", [MKR(27),MKR(28), MKR(29)]] call Zen_RTS_TerritoryCreate;

_Zen_TerritoryWest_TerritoryMarker = [ListFlag30, "", "colorRed", [0, 0], "rectangle", 0, 1] call Zen_SpawnMarker;
0 = ["West", [MKR(30),MKR(31), MKR(32)]] call Zen_RTS_TerritoryCreate;

//////////
// Zen RTS Strategic
/////////

#define DETECT_BUILDING(B, U) \
    ZEN_RTS_STRATEGIC_GET_BUILDING_OBJ_ID(B, _ID) \
    if (_ID != "") then { \
        _assetsToAdd pushBack U; \
    };

#define ZEN_RTS_STRATEGIC_GET_BUILDING_OBJ_ID(N, I) \
    _objIndexes = [Zen_RTS_Strategic_Building_Objects_Global, N, 0] call Zen_ArrayGetNestedIndex; \
    I = ""; \
    if (count _objIndexes > 0) then { \
        _objData = Zen_RTS_Strategic_Building_Objects_Global select (_objIndexes select 0); \
        I = _objData select 1; \
    };

#define ZEN_RTS_STRATEGIC_ASSET_DESTROYED_EH \
    _vehicle setVariable ["Zen_RTS_StrategicValue", (call compile ([_assetStrRaw, "Cost: ", ","] call Zen_StringGetDelimitedPart)), true]; \
    _vehicle setVariable ["Zen_RTS_IsStrategicRepairable", true, true]; \
    _vehicle addEventHandler ["Killed", { \
        (_this select 0) setVariable ["Zen_RTS_IsStrategicDebris", true, true]; \
    }];

#define ZEN_RTS_STRATEGIC_BUILDING_DESTROYED_EH(T) \
    _cost = call compile ([(_buildingTypeData select 5), "Cost: ", ","] call Zen_StringGetDelimitedPart); \
    _building setVariable ["Zen_RTS_StrategicValue", _cost, true]; \
    _building setVariable ["Zen_RTS_IsStrategicRepairable", true, true]; \
    _building addEventHandler ["Killed", { \
        0 = _this spawn { \
            _buildingTypeData = [T] call Zen_RTS_StrategicBuildingTypeGetData; \
            _cost = call compile ([(_buildingTypeData select 5), "Cost: ", ","] call Zen_StringGetDelimitedPart); \
            _buildingObjData = [T, true, false] call Zen_RTS_StrategicBuildingObjectGetDataGlobal; \
            if (count _buildingObjData > 0) then { \
                0 = [(_buildingObjData select 1)] call Zen_RTS_StrategicBuildingDestroy; \
            }; \
            _building = _this select 0; \
            _pos = getPosATL _building; \
            sleep 5; \
            _objects = nearestObjects [_pos, ["Ruins"], 10]; \
            _deadBuilding = objNull; \
            { \
                if (alive _x) exitWith { \
                    _deadBuilding = _x; \
                }; \
            } forEach _objects; \
            if !(isNull _deadBuilding) then { \
                player sideChat str _deadBuilding; \
                _deadBuilding setVariable ["Zen_RTS_IsStrategicDebris", true, true]; \
                _deadBuilding setVariable ["Zen_RTS_StrategicValue", _cost, true]; \
            } else { \
                player sidechat ("Destroyed Building" + str _building + " has no dead object"); \
            }; \
        }; \
    }];

#define BUILDING_VISUALS(T, O, S) \
    _buildTime = call compile ([(_buildingTypeData select 5), "Time: ", ","] call Zen_StringGetDelimitedPart); \
    _building = [_spawnPos, T, 0, random 360, true] call Zen_SpawnVehicle; \
    _building setVariable ["side", S, true]; \
    _building setVectorUp (surfaceNormal _spawnPos); \
    _height = ZEN_STD_OBJ_BBZ(_building); \
    ZEN_STD_OBJ_TransformATL(_building, 0, 0, -( _height)) \
    _heightStep = (_height + O) / _buildTime; \
    for "_i" from 0 to _buildTime do { \
        sleep 1; \
        _building setPosATL ((getPosATL _building) vectorAdd [0, 0, _heightStep]); \
    };

// all building types must be added here, or they will not be considered
// must be [[west building types], [east '']]
RTS_Used_Building_Types = [[], []]; // global

// the level of each building type for when the object is destroyed
// must be [[west building levels], [east '']]
RTS_Building_Type_Levels = [[], []]; // global

{
    _array = _x;
    for "_i" from 1 to 8 do {
        _array pushBack 0;
    };
} forEach RTS_Building_Type_Levels;

// all asset types must be added here, or they will not be considered for custom squads
// must be [[west asset types, [east '']]
RTS_Used_Asset_Types = [[], []]; // global

#include "Zen_RTS_West\RTS_West_HQ.sqf"
#include "Zen_RTS_West\RTS_West_Barracks.sqf"
#include "Zen_RTS_West\RTS_West_Radar.sqf"
#include "Zen_RTS_West\RTS_West_TankFactory.sqf"
#include "Zen_RTS_West\RTS_West_AirFactory.sqf"
#include "Zen_RTS_West\RTS_West_NavalFactory.sqf"
#include "Zen_RTS_West\RTS_West_SupportFactory.sqf"
#include "Zen_RTS_West\RTS_West_CJ.sqf"

#include "Zen_RTS_East\RTS_East_HQ.sqf"
#include "Zen_RTS_East\RTS_East_Barracks.sqf"
#include "Zen_RTS_East\RTS_East_Radar.sqf"
#include "Zen_RTS_East\RTS_East_TankFactory.sqf"
#include "Zen_RTS_East\RTS_East_AirFactory.sqf"
#include "Zen_RTS_East\RTS_East_NavalFactory.sqf"
#include "Zen_RTS_East\RTS_East_SupportFactory.sqf"
#include "Zen_RTS_East\RTS_East_CJ.sqf"

westTruck setVariable ["Zen_RTS_IsStrategicRepairable", true, true];
westTruck setVariable ["Zen_RTS_StrategicValue", 1000, true];
eastTruck setVariable ["Zen_RTS_IsStrategicRepairable", true, true];
eastTruck setVariable ["Zen_RTS_StrategicValue", 1000, true];

publicVariable "RTS_Used_Building_Types";
publicVariable "RTS_Building_Type_Levels";
// publicVariable "RTS_Used_Asset_Types";

publicVariable "Zen_RTS_BuildingType_West_HQ";
publicVariable "Zen_RTS_BuildingType_East_HQ";

rts_Initialized = TRUE;
publicVariable "rts_Initialized";
