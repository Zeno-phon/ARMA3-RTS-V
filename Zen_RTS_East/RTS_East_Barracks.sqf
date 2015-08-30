/**
    Level 1:
        Zen_RTS_Asset_East_Rifleman
        Zen_RTS_Asset_East_GLSoldier
        Zen_RTS_Asset_East_Autorifleman
        Zen_RTS_Asset_East_Medic
    Level 2:
        Zen_RTS_Asset_East_Marksman
        Zen_RTS_Asset_East_ATSoldier
        Zen_RTS_Asset_East_AASoldier
//*/

// (_this select 1) : [array, spawn position, scalar, starting level]
Zen_RTS_F_East_BarracksConstructor = {
    player sideChat str "East barracks constructor called";
    player sideChat str _this;

    _buildingObjData = _this select 0;
    _args = _this select 1;

    _spawnPos = _args select 0;
    _level = _args select 1;
    _buildingTypeData = [(_buildingObjData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;

    _assetsToAdd = [];
    _assetsToAdd pushBack Zen_RTS_Asset_East_rhs_msv_rifleman;
    _assetsToAdd pushBack Zen_RTS_Asset_East_rhs_msv_grenadier;
    _assetsToAdd pushBack Zen_RTS_Asset_East_rhs_msv_machinegunner;
    _assetsToAdd pushBack Zen_RTS_Asset_East_rhs_msv_medic;

    if (Zen_RTS_TechFlag_East_BuildEnemy) then {
        // ... to do 
    };

    {
        (RTS_Used_Asset_Types select 0) pushBack _x;
    } forEach _assetsToAdd;
    publicVariable "RTS_Used_Asset_Types";

    0 = [(_buildingObjData select 1), _assetsToAdd] call Zen_RTS_F_StrategicAddAssetGlobal;

    ZEN_RTS_STRATEGIC_GET_BUILDING_OBJ_ID(Zen_RTS_BuildingType_East_HQ, _ID)
    if (_ID != "") then {
        0 = [_ID, [Zen_RTS_Asset_Tech_East_Upgrade_Barracks]] call Zen_RTS_F_StrategicAddAssetGlobal;
    };

    BUILDING_VISUALS("Land_Cargo_House_V1_F", 1, east)
    ZEN_RTS_STRATEGIC_BUILDING_DESTROYED_EH(Zen_RTS_BuildingType_East_Barracks)

    // to-do: || false condition needs building hacking logic
    _args = ["addAction", [_building, ["Purchase Units", Zen_RTS_BuildMenu, (_buildingObjData select 0), 1, false, true, "", "((_target distance _this) < 15) && {(side _this == (_target getVariable 'side')) || (false)}"]]];
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)
    (_building)
};

Zen_RTS_F_East_BarracksDestructor = {
    player sideChat str "East barracks destructor";

    _buildingObjData = _this select 0;
    _level = _buildingObjData select 3;
    player commandChat str _level;

    _index = [(_buildingObjData select 0), (RTS_Used_Building_Types select 1)] call Zen_ValueFindInArray;
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
    if (Zen_RTS_TechFlag_East_BuildEnemy) then { \
    }; \
    { \
        (RTS_Used_Asset_Types select 1) pushBack _x; \
    } forEach _assetsToAdd; \
    publicVariable "RTS_Used_Asset_Types"; \
    0 = [(_buildingObjData select 1), _assetsToAdd] call Zen_RTS_F_StrategicAddAssetGlobal; \
    (true) \
};

#define ASSETS [Zen_RTS_Asset_East_rhs_msv_marksman, Zen_RTS_Asset_East_rhs_msv_at]
UPGRADE(Zen_RTS_F_East_BarracksUpgrade01, ASSETS)

#define ASSETS [Zen_RTS_Asset_East_rhs_msv_aa, Zen_RTS_Asset_East_rhs_msv_officer, Zen_RTS_Asset_East_rhs_msv_sergeant, Zen_RTS_Asset_East_rhs_msv_junior_sergeant, Zen_RTS_Asset_East_rhs_msv_engineer]
UPGRADE(Zen_RTS_F_East_BarracksUpgrade02, ASSETS)

#define ASSETS [Zen_RTS_Asset_East_rhs_msv_LAT, Zen_RTS_Asset_East_rhs_msv_RShG2, Zen_RTS_Asset_East_rhs_msv_strelok_rpg_assist, Zen_RTS_Asset_East_rhs_msv_machinegunner_assistant, Zen_RTS_Asset_East_rhs_msv_grenadier_rpg, Zen_RTS_Asset_East_rhs_msv_efreitor]
UPGRADE(Zen_RTS_F_East_BarracksUpgrade03, ASSETS)

Zen_RTS_BuildingType_East_Barracks = ["Zen_RTS_F_East_BarracksConstructor", "Zen_RTS_F_East_BarracksDestructor", ["Zen_RTS_F_East_BarracksUpgrade01", "Zen_RTS_F_East_BarracksUpgrade02", "Zen_RTS_F_East_BarracksUpgrade03"], "Barracks", "Cost: 1000, Time: 10,"] call Zen_RTS_StrategicBuildingCreate;
(RTS_Used_Building_Types select 1) pushBack Zen_RTS_BuildingType_East_Barracks;

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

INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_rifleman, "rhs_msv_rifleman", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_grenadier, "rhs_msv_grenadier", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_machinegunner, "rhs_msv_machinegunner", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_medic, "rhs_msv_medic", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_marksman, "rhs_msv_marksman", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_at, "rhs_msv_at", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_aa, "rhs_msv_aa", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_officer, "rhs_msv_officer", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_sergeant, "rhs_msv_sergeant", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_junior_sergeant, "rhs_msv_junior_sergeant", "infantry") 
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_engineer, "rhs_msv_engineer", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_LAT, "rhs_msv_LAT", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_RShG2, "rhs_msv_RShG2", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_strelok_rpg_assist, "rhs_msv_strelok_rpg_assist", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_machinegunner_assistant, "rhs_msv_machinegunner_assistant", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_grenadier_rpg, "rhs_msv_grenadier_rpg", "infantry")
INFANTRY_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_msv_efreitor, "rhs_msv_efreitor", "infantry")

Zen_RTS_Asset_East_rhs_msv_rifleman = ["Zen_RTS_F_East_Asset_rhs_msv_rifleman", "Rifleman", "Cost: 50, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_msv_grenadier = ["Zen_RTS_F_East_Asset_rhs_msv_grenadier", "Grenadier", "Cost: 100, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_msv_machinegunner = ["Zen_RTS_F_East_Asset_rhs_msv_machinegunner", "Autorifleman", "Cost: 100, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_msv_medic = ["Zen_RTS_F_East_Asset_rhs_msv_medic", "Medic", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_msv_marksman  = ["Zen_RTS_F_East_Asset_rhs_msv_marksman", "Marksman", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_msv_at = ["Zen_RTS_F_East_Asset_rhs_msv_at", "AT Soldier", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_msv_aa = ["Zen_RTS_F_East_Asset_rhs_msv_aa", "AA Soldier", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_msv_officer = ["Zen_RTS_F_East_Asset_rhs_msv_officer", "officer", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_msv_sergeant = ["Zen_RTS_F_East_Asset_rhs_msv_sergeant", "sergeant", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_msv_junior_sergeant = ["Zen_RTS_F_East_Asset_rhs_msv_junior_sergeant", "junior_sergeant", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_msv_engineer = ["Zen_RTS_F_East_Asset_rhs_msv_engineer", "engineer", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_msv_LAT = ["Zen_RTS_F_East_Asset_rhs_msv_LAT", "LAT", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_msv_RShG2 = ["Zen_RTS_F_East_Asset_rhs_msv_RShG2", "RShG2", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_msv_strelok_rpg_assist = ["Zen_RTS_F_East_Asset_rhs_msv_strelok_rpg_assist", "strelok_rpg_assist", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_msv_machinegunner_assistant = ["Zen_RTS_F_East_Asset_rhs_msv_machinegunner_assistant", "machinegunner_assistant", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_msv_grenadier_rpg = ["Zen_RTS_F_East_Asset_rhs_msv_grenadier_rpg", "grenadier_rpg", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_msv_efreitor = ["Zen_RTS_F_East_Asset_rhs_msv_efreitor", "efreitor", "Cost: 150, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
