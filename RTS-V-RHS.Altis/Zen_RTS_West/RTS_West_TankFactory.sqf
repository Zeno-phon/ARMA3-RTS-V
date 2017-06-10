
// (_this select 1) : [array, spawn position, scalar, starting level]
Zen_RTS_F_West_TankFactoryConstructor = {
    diag_log "West Tank_factory constructor called";
    diag_log _this;

    _buildingObjData = _this select 0;
    _args = _this select 1;

    ZEN_RTS_STRATEGIC_BUILDING_CONSTRUCTOR_ARGS()
    _buildingTypeData = [(_buildingObjData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;

    _assetsToAdd = [];
    _assetsToAdd pushBack Zen_RTS_Asset_West_rhsusf_m998_w_2dr;
    _assetsToAdd pushBack Zen_RTS_Asset_West_rhsusf_m998_w_2dr_halftop;
    _assetsToAdd pushBack Zen_RTS_Asset_West_CJ;

    // if (Zen_RTS_TechFlag_West_BuildEnemy) then {
        // ... to do
    // };

    {
        (RTS_Used_Asset_Types select 0) pushBack _x;
    } forEach _assetsToAdd;
    publicVariable "RTS_Used_Asset_Types";

    0 = [(_buildingObjData select 1), _assetsToAdd] call Zen_RTS_F_StrategicAddAssetGlobal;

    ZEN_RTS_STRATEGIC_GET_BUILDING_OBJ_ID(Zen_RTS_BuildingType_West_HQ, _ID)
    if (_ID != "") then {
        0 = [_ID, [Zen_RTS_Asset_Tech_West_Upgrade_TankFactory]] call Zen_RTS_F_StrategicAddAssetGlobal;
    };

    BUILDING_VISUALS("Land_i_Garage_V1_F", -0.5, WestCommander, _dir, "Tank Factory", "b_armor")
    ZEN_RTS_STRATEGIC_BUILDING_DESTROYED_EH(Zen_RTS_BuildingType_West_TankFactory, West)

    // to-do: || false condition needs building hacking logic
    _args = ["addAction", [_building, ["<img size='3' image='pictures\build_CA.paa'/>", Zen_RTS_BuildMenu, [(_buildingObjData select 0), (_buildingObjData select 1)], 1, false, true, "", "((_target distance _this) < 15) && {(side _this == (_target getVariable 'Zen_RTS_StrategicBuildingSide')) || (false)}"]]];
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)
    (_building)
};

Zen_RTS_F_West_TankFactoryDestructor = {
    diag_log "West Tank_factory destructor";

    _buildingObjData = _this select 0;
    _level = _buildingObjData select 3;
    diag_log _level;

    _index = [(_buildingObjData select 0), (RTS_Used_Building_Types select 0)] call Zen_ValueFindInArray;
    _array = RTS_Building_Type_Levels select 0;
    _array set [_index, _level];

    (_buildingObjData select 2) setDamage 1;
};

#define UPGRADE(N, A) \
N = { \
    diag_log (#N + " called"); \
    diag_log _this; \
    _buildingData = _this select 0; \
    _assetsToAdd = A; \
    if (Zen_RTS_TechFlag_West_BuildEnemy) then { \
    }; \
    { \
        (RTS_Used_Asset_Types select 0) pushBack _x; \
    } forEach _assetsToAdd; \
    publicVariable "RTS_Used_Asset_Types"; \
    0 = [(_buildingData select 1), _assetsToAdd] call Zen_RTS_F_StrategicAddAssetGlobal; \
    (true) \
};

#define ASSETS [Zen_RTS_Asset_West_rhsusf_m1025_w_mk19, Zen_RTS_Asset_rhsusf_m1025_w_s_m2, Zen_RTS_Asset_rhsusf_rg33_usmc_d]
UPGRADE(Zen_RTS_F_West_TankFactoryUpgrade01, ASSETS)

#define ASSETS [Zen_RTS_Asset_rhsusf_m113d_usarmy, Zen_RTS_Asset_West_RHS_M2A2, Zen_RTS_Asset_West_RHS_M2A3, Zen_RTS_Asset_West_RHS_M6, Zen_RTS_Asset_West_RHS_M6_wd]
UPGRADE(Zen_RTS_F_West_TankFactoryUpgrade02, ASSETS)

#define ASSETS [Zen_RTS_Asset_West_rhsusf_m1a1aimwd_usarmy, Zen_RTS_Asset_West_rhsusf_m1a1aimd_usarmy, Zen_RTS_Asset_West_rhsusf_m1a1aim_tuski_wd, Zen_RTS_Asset_West_rhsusf_m1a1aim_tuski_d, Zen_RTS_Asset_West_rhsusf_m1a1fep_d, Zen_RTS_Asset_West_rhsusf_m1a1fep_wd, Zen_RTS_Asset_West_rhsusf_m1a1fep_od]
UPGRADE(Zen_RTS_F_West_TankFactoryUpgrade03, ASSETS)

#define ASSETS [Zen_RTS_Asset_West_rhsusf_m1a2sep1d_usarmy, Zen_RTS_Asset_West_rhsusf_m1a2sep1wd_usarmy, Zen_RTS_Asset_West_rhsusf_m1a2sep1tuskid_usarmy, Zen_RTS_Asset_West_rhsusf_m1a2sep1tuskiwd_usarmy, Zen_RTS_Asset_West_rhsusf_m1a2sep1tuskiiwd_usarmy, Zen_RTS_Asset_West_rhsusf_m1a2sep1tuskiid_usarmy]
UPGRADE(Zen_RTS_F_West_TankFactoryUpgrade04, ASSETS)

Zen_RTS_BuildingType_West_TankFactory = ["Zen_RTS_F_West_TankFactoryConstructor", "Zen_RTS_F_West_TankFactoryDestructor", ["Zen_RTS_F_West_TankFactoryUpgrade01","Zen_RTS_F_West_TankFactoryUpgrade02","Zen_RTS_F_West_TankFactoryUpgrade03","Zen_RTS_F_West_TankFactoryUpgrade04"], "Tank factory", "Cost: 10000, Time: 120, Picture: pictures\tank_ca.paa, Classname: Land_i_Garage_V1_F,"] call Zen_RTS_StrategicBuildingCreate;
(RTS_Used_Building_Types select 0) pushBack Zen_RTS_BuildingType_West_TankFactory;

/////////////////////////////////
// Assets
/////////////////////////////////

Zen_RTS_Asset_West_rhsusf_m998_w_2dr = ["Zen_RTS_F_West_Asset_rhsusf_m998_w_2dr","m998-2dr", "Cost: 100, Time: 10, Crew: 1,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_m998_w_2dr_halftop = ["Zen_RTS_F_West_Asset_rhsusf_m998_w_2dr_halftop", "m998-2dr-halftop", "Cost: 200, Time: 10, Crew: 1,"] call Zen_RTS_StrategicAssetCreate;

Zen_RTS_Asset_West_rhsusf_m1025_w_mk19 = ["Zen_RTS_F_West_Asset_rhsusf_m1025_w_mk19","m1025-mk19", "Cost: 100, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_rhsusf_m1025_w_s_m2 = ["Zen_RTS_F_West_Asset_rhsusf_m1025_w_s_m2","m1025", "Cost: 100, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_rhsusf_rg33_usmc_d = ["Zen_RTS_F_West_Asset_rhsusf_rg33_usmc_d","rg33-d", "Cost: 100, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;

Zen_RTS_Asset_rhsusf_m113d_usarmy = ["Zen_RTS_F_West_Asset_rhsusf_m113d_usarmy","m113-d", "Cost: 100, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_RHS_M2A2 = ["Zen_RTS_F_West_Asset_RHS_M2A2","M2A2", "Cost: 100, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_RHS_M2A3 = ["Zen_RTS_F_West_Asset_RHS_M2A3","M2A3", "Cost: 100, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_RHS_M6 = ["Zen_RTS_F_West_Asset_RHS_M6","RHS_M6", "Cost: 100, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_RHS_M6_wd = ["Zen_RTS_F_West_Asset_RHS_M6_wd","RHS_M6_wd", "Cost: 100, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;

Zen_RTS_Asset_West_rhsusf_m1a1aimwd_usarmy = ["Zen_RTS_F_West_Asset_rhsusf_m1a1aimwd_usarmy","M1A1-AIM-WD", "Cost: 4000, Time: 30, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_m1a1aimd_usarmy = ["Zen_RTS_F_West_Asset_rhsusf_m1a1aimd_usarmy","M1A1-AIM-D", "Cost: 4500, Time: 30, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_m1a1aim_tuski_wd = ["Zen_RTS_F_West_Asset_rhsusf_m1a1aim_tuski_wd","TUSKI-WD", "Cost: 6000, Time: 30, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_m1a1aim_tuski_d = ["Zen_RTS_F_West_Asset_rhsusf_m1a1aim_tuski_d","M1A1-[AUTO]", "Cost: 7000, Time: 45, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_m1a1fep_d = ["Zen_RTS_F_West_Asset_rhsusf_m1a1fep_d","M1A1-FEP-D", "Cost: 7000, Time: 45, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_m1a1fep_wd = ["Zen_RTS_F_West_Asset_rhsusf_m1a1fep_wd","M1A1FEP_WD", "Cost: 7000, Time: 45, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;

Zen_RTS_Asset_West_rhsusf_m1a2sep1tuskid_usarmy = ["Zen_RTS_F_West_Asset_rhsusf_m1a2sep1tuskid_usarmy","M1A2-SEP1-TUSKI-D", "Cost: 8000, Time: 45, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_m1a2sep1tuskiwd_usarmy = ["Zen_RTS_F_West_Asset_rhsusf_m1a2sep1tuskiwd_usarmy","M1A2-SEP1-TUSKI-WD", "Cost: 8000, Time: 45, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_m1a2sep1tuskiiwd_usarmy = ["Zen_RTS_F_West_Asset_rhsusf_m1a2sep1tuskiiwd_usarmy","M1A2-SEP1-TUSKI-IWD", "Cost: 8000, Time: 45, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;

Zen_RTS_Asset_West_CJ = ["Zen_RTS_F_West_Asset_CJ","CJ", "Cost: 5000, Time: 20, Crew: 0,"] call Zen_RTS_StrategicAssetCreate;
