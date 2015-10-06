/**
    Level 1:
        MG
//*/

// (_this select 1) : [array, spawn position, scalar, starting level]
Zen_RTS_F_West_CJConstructor = {
    player sideChat str "West CJ constructor called";
    player sideChat str _this;

    _buildingObjData = _this select 0;
    _args = _this select 1;

    _spawnPos = _args select 0;
    _level = _args select 1;

    _assetsToAdd = [];
    _assetsToAdd pushBack Zen_RTS_Asset_West_MG;

    if (Zen_RTS_TechFlag_West_BuildEnemy) then {
        // ... to do
    };

    {
        (RTS_Used_Asset_Types select 0) pushBack _x;
    } forEach _assetsToAdd;
    publicVariable "RTS_Used_Asset_Types";

    0 = [(_buildingObjData select 1), _assetsToAdd] call Zen_RTS_F_StrategicAddAssetGlobal;

    // ZEN_RTS_STRATEGIC_GET_BUILDING_OBJ_ID(Zen_RTS_BuildingType_West_HQ, _ID)
    // if (_ID != "") then {
        // 0 = [_ID, [Zen_RTS_Asset_Tech_West_Upgrade_Barracks]] call Zen_RTS_F_StrategicAddAssetGlobal;
    // };

    _buildingTypeData = [(_buildingObjData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;
    _assetStrRaw = _buildingTypeData select 5;

    sleep (call compile ([_assetStrRaw, "Time: ", ","] call Zen_StringGetDelimitedPart));
    _vehicle = [_spawnPos, "B_MRAP_01_F"] call Zen_SpawnVehicle;
    _vehicle setVariable ["side", west, true];
    ZEN_RTS_STRATEGIC_ASSET_DESTROYED_EH

    // to-do: || false condition needs building hacking logic
    _args = ["addAction", [_vehicle, ["Purchase Objects", Zen_RTS_BuildMenu, (_buildingObjData select 0), 1, false, true, "", "(_this in _target)"]]];
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)

    _args = ["addAction", [_vehicle, ["<t color='#D80000'>Repair</t>", Zen_RTS_Repair, [], 1, false, true, "", "(_this in _target)"]]];
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)

    _args = ["addAction", [_vehicle, ["<t color='#D80000'>Recycle</t>", Zen_RTS_Recycle, [], 1, false, true, "", "(_this in _target)"]]];
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)

    if (_level > 0) then {
        for "_i" from 0 to (_level - 1) do {
            [_buildingObjData] call (missionNamespace getVariable ((_buildingTypeData select 3) select _i));
        };
    };

    (_vehicle)
};

Zen_RTS_F_West_CJDestructor = {
    player sideChat str "West CJ destructor";

    _buildingObjData = _this select 0;
    _level = _buildingObjData select 3;
    player commandChat str _level;

    _index = [(_buildingObjData select 0), (RTS_Used_Building_Types select 0)] call Zen_ValueFindInArray;
    _array = RTS_Building_Type_Levels select 0;
    _array set [_index, _level];

    (_buildingObjData select 2) setDamage 1;
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

// #define ASSETS []
// UPGRADE(Zen_RTS_F_West_CJUpgrade01, ASSETS)

Zen_RTS_BuildingType_West_CJ = ["Zen_RTS_F_West_CJConstructor", "Zen_RTS_F_West_CJDestructor", [], "CJ", "Cost: 1000, Time: 10,"] call Zen_RTS_StrategicBuildingCreate;
(RTS_Used_Building_Types select 0) pushBack Zen_RTS_BuildingType_West_CJ;

/////////////////////////////////
// Assets
/////////////////////////////////

#define FORT_CONSTRUCTOR(N, T) \
    N = { \
        player sideChat str ("West " + T + " asset constructor called"); \
        player sideChat str _this; \
        _buildingObjData = _this select 0; \
        _assetData = _this select 1; \
        _assetStrRaw = _assetData select 3; \
        _building = _buildingObjData select 2; \
        Zen_RTS_CJ_DoPlace = false; \
        _redArrow = "Sign_Arrow_F" createVehicleLocal [0,0,0]; \
        _building addAction ["<t color='#D80000'>Place</t>", {Zen_RTS_CJ_DoPlace = true; (_this select 0) removeAction (_this select 2);}, [], 1, false, true, "", "(_this in _target)"]; \
        waitUntil { \
            sleep 1; \
            _redArrow setPosATL ([_building, 10, getDir _building, "compass", 1] call Zen_ExtendPosition); \
            (Zen_RTS_CJ_DoPlace) \
        }; \
        sleep (call compile ([_assetStrRaw, "Time: ", ","] call Zen_StringGetDelimitedPart)); \
        deleteVehicle _redArrow; \
        _vehicle = [_redArrow, T, 0, getDir _building, false]  call Zen_SpawnVehicle; \
        ZEN_RTS_STRATEGIC_ASSET_DESTROYED_EH \
    };

FORT_CONSTRUCTOR(Zen_RTS_F_West_AssetMG, "B_HMG_01_high_F")

Zen_RTS_Asset_West_MG = ["Zen_RTS_F_West_AssetMG", "MG", "Cost: 50, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
