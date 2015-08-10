/**
    Level 1:
        Zen_RTS_Asset_West_Rifleman
        Zen_RTS_Asset_West_GLSoldier
        Zen_RTS_Asset_West_Autorifleman
        Zen_RTS_Asset_West_Medic
    Level 2:
        Zen_RTS_Asset_West_Marksman
        Zen_RTS_Asset_West_ATSoldier
        Zen_RTS_Asset_West_AASoldier
//*/

// (_this select 1) : Array, spawn position
Zen_RTS_F_West_BarracksConstructor = {
    player sideChat str "West barracks constructor called";
    player sideChat str _this;

    _buildingObjData = _this select 0;
    _spawnPos = _this select 1;
    _buildingTypeData = [(_buildingObjData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;

    _assetsToAdd = [];
    _assetsToAdd pushBack Zen_RTS_Asset_West_Rifleman;
    _assetsToAdd pushBack Zen_RTS_Asset_West_GLSoldier;
    _assetsToAdd pushBack Zen_RTS_Asset_West_Autorifleman;
    _assetsToAdd pushBack Zen_RTS_Asset_West_Medic;

    if (Zen_RTS_TechFlag_West_BuildEnemy) then {
        // ... to do
    };

    {
        (RTS_Used_Asset_Types select 0) pushBack _x;
    } forEach _assetsToAdd;
    publicVariable "RTS_Used_Asset_Types";

    0 = [(_buildingObjData select 1), _assetsToAdd] call Zen_RTS_F_StrategicAddAssetGlobal;

    ZEN_RTS_STRATEGIC_GET_BUILDING_OBJ_ID(Zen_RTS_BuildingType_West_HQ, _ID)
    if (_ID != "") then {
        0 = [_ID, [Zen_RTS_Asset_Tech_West_Upgrade_Barracks]] call Zen_RTS_F_StrategicAddAssetGlobal;
    };

    sleep (call compile ([(_buildingTypeData select 5), "Time: ", ","] call Zen_StringGetDelimitedPart));
    _building = [_spawnPos, "Land_Cargo_House_V1_F"] call Zen_SpawnVehicle;
    _building setVariable ["side", side player, true];

    _building addEventHandler ["Killed", {
        0 = _this spawn {
            _buildingTypeData = [Zen_RTS_BuildingType_West_Barracks] call Zen_RTS_StrategicBuildingTypeGetData;
            _cost = call compile ([(_buildingTypeData select 5), "Cost: ", ","] call Zen_StringGetDelimitedPart);

            _buildingObjData = [Zen_RTS_BuildingType_West_Barracks, true] call Zen_RTS_StrategicBuildingObjectGetDataGlobal;
            0 = [(_buildingObjData select 1)] call Zen_RTS_StrategicBuildingDestroy;

            _building = _this select 0;
            _pos = getPosATL _building;

            _objects = nearestObjects [_pos, ["building"], 5];
            _deadBuilding = objNull;
            {
                if !(alive _x) exitWith {
                    _deadBuilding = _x;
                };
            } forEach _objects;

            if !(isNull _deadBuilding) then {
                _deadBuilding setVariable ["Zen_RTS_IsStrategicDebris", true, true];
                _deadBuilding setVariable ["Zen_RTS_StrategicDebrisValue", _cost, true];
            } else {
                player sidechat ("Destroyed Building" + str _building + " has no dead object");// debug
            };
        };
    }];

    // to-do: || false condition needs building hacking logic
    _args = ["addAction", [_building, ["Purchase Units", Zen_RTS_BuildMenu, (_buildingObjData select 0), 1, false, true, "", "((_target distance _this) < 15) && {(side _this == (_target getVariable 'side')) || (false)}"]]];
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)
    (_building)
};

Zen_RTS_F_West_BarracksDestructor = {
    player sideChat str "West barracks destructor";

    _buildingObjData = _this select 0;

    player commandChat "Building destructor";
    player commandChat str (_buildingObjData select 2);
    player commandChat str (isNull (_buildingObjData select 2));
    player commandChat str (alive (_buildingObjData select 2));
    player commandChat str (getPosATL (_buildingObjData select 2));

    (_buildingObjData select 2) removeAllEventHandlers "Killed";
    (_buildingObjData select 2) setDamage 1;

    // _buildingTypeData = [(_buildingObjData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;
    // _cost = call compile ([(_buildingTypeData select 5), "Cost: ", ","] call Zen_StringGetDelimitedPart);
    // playerMoney = playerMoney + _cost * ZEN_RTS_STRATEGIC_BUIDLING_DESTRUCTOR_REFUND_COEFF;
};

#define UPGRADE(N, A) \
N = { \
    player sideChat str (#N + " called"); \
    player sideChat str _this; \
    _buildingObjData = _this select 0; \
    _assetsToAdd = A; \
    if (Zen_RTS_TechFlag_West_BuildEnemy) then { \
    }; \
    { \
        (RTS_Used_Asset_Types select 0) pushBack _x; \
    } forEach _assetsToAdd; \
    publicVariable "RTS_Used_Asset_Types"; \
    0 = [(_buildingObjData select 1), _assetsToAdd] call Zen_RTS_F_StrategicAddAssetGlobal; \
    (true) \
};

#define ASSETS [Zen_RTS_Asset_West_Marksman, Zen_RTS_Asset_West_ATSoldier]
UPGRADE(Zen_RTS_F_West_BarracksUpgrade01, ASSETS)

#define ASSETS [Zen_RTS_Asset_West_AASoldier]
UPGRADE(Zen_RTS_F_West_BarracksUpgrade02, ASSETS)

Zen_RTS_BuildingType_West_Barracks = ["Zen_RTS_F_West_BarracksConstructor", "Zen_RTS_F_West_BarracksDestructor", ["Zen_RTS_F_West_BarracksUpgrade01", "Zen_RTS_F_West_BarracksUpgrade02"], "Barracks", "Cost: 1000, Time: 10, Picture: pictures\zen.paa,"] call Zen_RTS_StrategicBuildingCreate;
(RTS_Used_Building_Types select 0) pushBack Zen_RTS_BuildingType_West_Barracks;

/////////////////////////////////
// Assets
/////////////////////////////////

#define INFANTRY_CONSTRUCTOR(N, T, S) \
    N = { \
        player sideChat str (#N + " asset constructor called"); \
        player sideChat str _this; \
        _assetData = _this select 1; \
        _assetStrRaw = _assetData select 3; \
        sleep (call compile ([_assetStrRaw, "Time: ", ","] call Zen_StringGetDelimitedPart)); \
        _group = [(_this select 2), T] call Zen_SpawnGroup; \
        0 = [_group, S] call Zen_SetAISkill; \
        (units _group) join (_this select 2); \
    };

INFANTRY_CONSTRUCTOR(Zen_RTS_F_West_AssetRifleman, "B_Soldier_02_f", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_West_AssetGLSoldier, "B_Soldier_GL_F", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_West_AssetAutorifleman, "B_soldier_AR_F", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_West_AssetMedic, "B_medic_F", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_West_AssetMarksman, "B_soldier_M_F", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_West_AssetATSoldier, "B_soldier_AT_F", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_West_AssetAASoldier, "B_soldier_AA_F", "infantry")

Zen_RTS_Asset_West_Rifleman = ["Zen_RTS_F_West_AssetRifleman", "Rifleman", "Cost: 50, Time: 10, Classname: b_soldier_02_f,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_GLSoldier = ["Zen_RTS_F_West_AssetGLSoldier", "Grenadier", "Cost: 100, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_Autorifleman = ["Zen_RTS_F_West_AssetAutorifleman", "Autorifleman", "Cost: 100, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_Medic = ["Zen_RTS_F_West_AssetMedic", "Medic", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_Marksman  = ["Zen_RTS_F_West_AssetMarksman", "Marksman", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_ATSoldier = ["Zen_RTS_F_West_AssetATSoldier", "AT Soldier", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_AASoldier = ["Zen_RTS_F_West_AssetAASoldier", "AA Soldier", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
