/**
    Level 1:
     Zen_RTS_Asset_East_rhs_gaz66_repair_msv;
     Zen_RTS_Asset_East_rhs_typhoon_vdv;
     Zen_RTS_Asset_East_RHS_Ural_VDV_01;
    Level 2:
        Zen_RTS_Asset_East_rhs_prp3_vdv
        Zen_RTS_Asset_East_IfritHMG
//*/

// (_this select 1) : [array, spawn position, scalar, starting level]
Zen_RTS_F_East_SupportFactoryConstructor = {
    player sideChat str "East Support_factory constructor called";
    player sideChat str _this;

    _buildingObjData = _this select 0;
    _args = _this select 1;

    _spawnPos = _args select 0;
    _level = _args select 1;
    _buildingTypeData = [(_buildingObjData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;

    _assetsToAdd = [];
    _assetsToAdd pushBack Zen_RTS_Asset_East_rhs_gaz66_ammo_msv;	
    _assetsToAdd pushBack Zen_RTS_Asset_East_rhs_gaz66_repair_msv;
    _assetsToAdd pushBack Zen_RTS_Asset_East_RHS_Ural_Fuel_MSV_01;
    _assetsToAdd pushBack Zen_RTS_Asset_East_rhs_typhoon_vdv;
    _assetsToAdd pushBack Zen_RTS_Asset_East_RHS_Ural_VDV_01;
    // if (Zen_RTS_TechFlag_East_BuildEnemy) then {
        // ... to do
    // };

    {
        (RTS_Used_Asset_Types select 0) pushBack _x;
    } forEach _assetsToAdd;
    publicVariable "RTS_Used_Asset_Types";

    0 = [(_buildingObjData select 1), _assetsToAdd] call Zen_RTS_F_StrategicAddAssetGlobal;

    ZEN_RTS_STRATEGIC_GET_BUILDING_OBJ_ID(Zen_RTS_BuildingType_East_HQ, _ID)
    if (_ID != "") then {
        0 = [_ID, [Zen_RTS_Asset_Tech_East_Upgrade_SupportFactory]] call Zen_RTS_F_StrategicAddAssetGlobal;
    };

    BUILDING_VISUALS("rhs_2P3_1", 1, east)
    ZEN_RTS_STRATEGIC_BUILDING_DESTROYED_EH(Zen_RTS_BuildingType_East_SupportFactory)

    // to-do: || false condition needs building hacking logic
    _args = ["addAction", [_building, ["Purchase Units", Zen_RTS_BuildMenu, (_buildingObjData select 0), 1, false, true, "", "((_target distance _this) < 15) && {(side _this == (_target getVariable 'side')) || (false)}"]]];
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)
    (_building)
};

Zen_RTS_F_East_SupportFactoryDestructor = {
    player sideChat str "East Support factory destructor";

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

#define ASSETS [Zen_RTS_Asset_East_rhs_prp3_vdv, Zen_RTS_Asset_East_rhs_gaz66_r142_vdv]
UPGRADE(Zen_RTS_F_East_SupportFactoryUpgrade01, ASSETS)

 #define ASSETS [Zen_RTS_Asset_East_RHS_BM21_MSV_01, Zen_RTS_Asset_East_rhs_9k79, Zen_RTS_Asset_East_rhs_9k79_K, Zen_RTS_Asset_East_rhs_9k79_B]
 UPGRADE(Zen_RTS_F_East_SupportFactoryUpgrade02, ASSETS)

Zen_RTS_BuildingType_East_SupportFactory = ["Zen_RTS_F_East_SupportFactoryConstructor", "Zen_RTS_F_East_SupportFactoryDestructor", ["Zen_RTS_F_East_SupportFactoryUpgrade01", "Zen_RTS_F_East_SupportFactoryUpgrade02"], "Support factory", "Cost: 2000, Time: 10,"] call Zen_RTS_StrategicBuildingCreate;
(RTS_Used_Building_Types select 1) pushBack  Zen_RTS_BuildingType_East_SupportFactory;

/////////////////////////////////
// Assets
/////////////////////////////////

#define VEHCILE_CONSTRUCTOR(N, T, U) \
    N = { \
        player sideChat str ("East " + T + " asset constructor called"); \
        player sideChat str _this; \
        _buildingObjData = _this select 0; \
        _assetData = _this select 1; \
        _assetStrRaw = _assetData select 3; \
        _referenceUnit = _this select 2; \
        _crewCount = _this select 3; \
        _phi = 0; \
        _theta = 0; \
        _building = _buildingObjData select 2; \
        _pos = [_building, 20, getDir _building + _phi] call Zen_ExtendPosition; \
        sleep (call compile ([_assetStrRaw, "Time: ", ","] call Zen_StringGetDelimitedPart)); \
        _vehicle = [_pos, T, 0, getDir _building + _theta, false]  call Zen_SpawnVehicle; \
        ZEN_RTS_STRATEGIC_ASSET_DESTROYED_EH \
        if (_crewCount > 0) then { \
            _crewGroup = [_vehicle, ([U, 0, (_crewCount - 1) min ((count U) - 1)] call Zen_ArrayGetIndexedSlice)] call Zen_SpawnGroup; \
            0 = [_crewGroup, "crew"] call Zen_SetAISkill; \
            0 = [_crewGroup, _vehicle, "All"] call Zen_MoveInVehicle; \
            (units _crewGroup) join _referenceUnit; \
            doStop (driver _vehicle); \
        }; \
    };

#define CREW_UNITS ["rhs_msv_driver"]
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_gaz66_ammo_msv, "rhs_gaz66_ammo_msv", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_gaz66_repair_msv, "rhs_gaz66_repair_msv", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Ural_Fuel_MSV_01,"RHS_Ural_Fuel_MSV_01", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_typhoon_vdv, "rhs_typhoon_vdv", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Ural_VDV_01, "RHS_Ural_VDV_01", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_gaz66_r142_vdv, "rhs_gaz66_r142_vdv", CREW_UNITS)

#define CREW_UNITS ["rhs_msv_driver", "rhs_msv_crew", "rhs_msv_crew"]
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_BM21_MSV_01, "RHS_BM21_MSV_01", CREW_UNITS)

#define CREW_UNITS ["rhs_vdv_driver_armored", "rhs_vdv_crew_commander", "rhs_vdv_armoredcrew", "rhs_vdv_combatcrew","rhs_vdv_combatcrew"]
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_prp3_vdv, "rhs_prp3_vdv", CREW_UNITS)

#define CREW_UNITS ["rhs_vdv_driver_armored", "rhs_vdv_crew_commander", "rhs_vdv_armoredcrew", "rhs_vdv_combatcrew"]
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_9k79, "rhs_9k79", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_9k79_K, "rhs_9k79_k", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_9k79_B, "rhs_9k79_B", CREW_UNITS)

Zen_RTS_Asset_East_rhs_gaz66_ammo_msv = ["Zen_RTS_F_East_Asset_rhs_gaz66_ammo_msv","Ammo", "Cost: 100, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_gaz66_repair_msv = ["Zen_RTS_F_East_Asset_rhs_gaz66_repair_msv","Repair", "Cost: 100, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_RHS_Ural_Fuel_MSV_01 = ["Zen_RTS_F_East_Asset_RHS_Ural_Fuel_MSV_01","ReFuel", "Cost: 100, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_typhoon_vdv = ["Zen_RTS_F_East_Asset_rhs_typhoon_vdv", "typhoon", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_RHS_Ural_VDV_01 = ["Zen_RTS_F_East_Asset_RHS_Ural_VDV_01", "Ural","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_prp3_vdv = ["Zen_RTS_F_East_Asset_rhs_prp3_vdv", "prp3_vdv","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_gaz66_r142_vdv = ["Zen_RTS_F_East_Asset_rhs_gaz66_r142_vdv", "Gaz (future radar extention)", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_RHS_BM21_MSV_01 = ["Zen_RTS_F_East_Asset_RHS_BM21_MSV_01", "test","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_9k79 = ["Zen_RTS_F_East_Asset_rhs_9k79", "missile","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_9k79_K = ["Zen_RTS_F_East_Asset_rhs_9k79_K", "missile","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_9k79_B = ["Zen_RTS_F_East_Asset_rhs_9k79_B", "NUKE","Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate; 
