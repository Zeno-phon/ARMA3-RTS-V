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

// (_this select 1) : [array, spawn position, scalar, starting level]
Zen_RTS_F_West_BarracksConstructor = {
    player sideChat str "West barracks constructor called";
    player sideChat str _this;

    _buildingObjData = _this select 0;
    _args = _this select 1;

    _spawnPos = _args select 0;
    _level = _args select 1;

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

    _buildingTypeData = [(_buildingObjData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;
    BUILDING_VISUALS("Land_Cargo_House_V2_F", 1, west)
    ZEN_RTS_STRATEGIC_BUILDING_DESTROYED_EH(Zen_RTS_BuildingType_West_Barracks)

    // to-do: || false condition needs building hacking logic
    _args = ["addAction", [_building, ["Purchase Units", Zen_RTS_BuildMenu, (_buildingObjData select 0), 1, false, true, "", "((_target distance _this) < 15) && {(side _this == (_target getVariable 'side')) || (false)}"]]];
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)

    if (_level > 0) then {
        for "_i" from 0 to (_level - 1) do {
            [_buildingObjData] call (missionNamespace getVariable ((_buildingTypeData select 3) select _i));
        };
    };

    (_building)
};

Zen_RTS_F_West_BarracksDestructor = {
    player sideChat str "West barracks destructor";

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
        _buildingData = (_this select 0); \
        _assetData = _this select 1; \
        _assetStrRaw = _assetData select 3; \
        sleep (call compile ([_assetStrRaw, "Time: ", ","] call Zen_StringGetDelimitedPart)); \
        if (alive (_buildingData select 2)) then { \
            _group = [(_this select 2), T] call Zen_SpawnGroup; \
            0 = [_group, S] call Zen_SetAISkill; \
            (units _group) join (_this select 2); \
        }; \
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
