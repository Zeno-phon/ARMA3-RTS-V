/**
    Level 1:
        Zen_RTS_Asset_West_HEMTT_Repair
        Zen_RTS_Asset_West_Quadbike
        Zen_RTS_Asset_West_Offroad
    Level 2:
        Zen_RTS_Asset_West_OffroadArmed
        Zen_RTS_Asset_West_HunterHMG
//*/

// (_this select 1) : [array, spawn position, scalar, starting level]
Zen_RTS_F_West_TankFactoryConstructor = {
    player sideChat str "West Tank_factory constructor called";
    player sideChat str _this;

    _buildingObjData = _this select 0;

    _args = _this select 1;

    _spawnPos = _args select 0;
    _level = _args select 1;
    _buildingTypeData = [(_buildingObjData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;

     _assetsToAdd = [];
    _assetsToAdd pushBack Zen_RTS_Asset_West_rhsusf_m998_w_2dr;
    _assetsToAdd pushBack Zen_RTS_Asset_West_rhsusf_m998_w_2dr_halftop;
    _assetsToAdd pushBack Zen_RTS_Asset_West_rhsusf_m1025_w;
    _assetsToAdd pushBack Zen_RTS_Asset_West_rhsusf_m1025_w_s;

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

    BUILDING_VISUALS("Land_i_Garage_V2_F", -0.5, west)
    ZEN_RTS_STRATEGIC_BUILDING_DESTROYED_EH(Zen_RTS_BuildingType_West_TankFactory)

    // to-do: || false condition needs building hacking logic
    _args = ["addAction", [_building, ["<img size='3'
      image='pictures\build_ca.paa'/>", Zen_RTS_BuildMenu, (_buildingObjData select 0), 1, false, true, "", "((_target distance _this) < 15) && {(side _this == (_target getVariable 'side')) || (false)}"]]];
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)
    (_building)
};

Zen_RTS_F_West_TankFactoryDestructor = {
    player sideChat str "West Tank_factory destructor";

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

#define ASSETS [Zen_RTS_Asset_West_rhsusf_M1083A1P2_B_M2_d_fmtv_usarmy, Zen_RTS_Asset_West_rhsusf_M1078A1P2_B_M2_wd_fmtv_usarmy, Zen_RTS_Asset_West_rhsusf_m1025_w_mk19, Zen_RTS_Asset_rhsusf_m1025_w_s_m2, Zen_RTS_Asset_rhsusf_rg33_usmc_d, Zen_RTS_Asset_rhsusf_rg33_usmc_wd, Zen_RTS_Asset_rhsusf_rg33_m2_usmc_wd]
UPGRADE(Zen_RTS_F_West_TankFactoryUpgrade01, ASSETS)

#define ASSETS [Zen_RTS_Asset_rhsusf_m113d_usarmy, Zen_RTS_Asset_West_RHS_M2A2, Zen_RTS_Asset_West_RHS_M2A2_BUSKI, Zen_RTS_Asset_West_RHS_M2A3, Zen_RTS_Asset_West_RHS_M2A3_BUSKI, Zen_RTS_Asset_West_RHS_M2A3_BUSKIII, Zen_RTS_Asset_West_RHS_M6, Zen_RTS_Asset_West_RHS_M6_wd]
UPGRADE(Zen_RTS_F_West_TankFactoryUpgrade02, ASSETS)

#define ASSETS [Zen_RTS_Asset_West_rhsusf_m1a1aimwd_usarmy, Zen_RTS_Asset_West_rhsusf_m1a1aimd_usarmy, Zen_RTS_Asset_West_rhsusf_m1a1aim_tuski_wd, Zen_RTS_Asset_West_rhsusf_m1a1aim_tuski_d, Zen_RTS_Asset_West_rhsusf_m1a1fep_d, Zen_RTS_Asset_West_rhsusf_m1a1fep_wd, Zen_RTS_Asset_West_rhsusf_m1a1fep_od]
UPGRADE(Zen_RTS_F_West_TankFactoryUpgrade03, ASSETS)

#define ASSETS [Zen_RTS_Asset_West_rhsusf_m1a2sep1d_usarmy, Zen_RTS_Asset_West_rhsusf_m1a2sep1wd_usarmy, Zen_RTS_Asset_West_rhsusf_m1a2sep1tuskid_usarmy, Zen_RTS_Asset_West_rhsusf_m1a2sep1tuskiwd_usarmy, Zen_RTS_Asset_West_rhsusf_m1a2sep1tuskiiwd_usarmy, Zen_RTS_Asset_West_rhsusf_m1a2sep1tuskiid_usarmy]
UPGRADE(Zen_RTS_F_West_TankFactoryUpgrade04, ASSETS)

Zen_RTS_BuildingType_West_TankFactory = ["Zen_RTS_F_West_TankFactoryConstructor", "Zen_RTS_F_West_TankFactoryDestructor", ["Zen_RTS_F_West_TankFactoryUpgrade01","Zen_RTS_F_West_TankFactoryUpgrade02","Zen_RTS_F_West_TankFactoryUpgrade03","Zen_RTS_F_West_TankFactoryUpgrade04"], "Tank factory", "Cost: 2000, Time: 10,"] call Zen_RTS_StrategicBuildingCreate;
(RTS_Used_Building_Types select 0) pushBack  Zen_RTS_BuildingType_West_TankFactory;

/////////////////////////////////
// Assets
/////////////////////////////////

#define VEHCILE_CONSTRUCTOR(N, T, U) \
    N = { \
        player sideChat str ("West " + T + " asset constructor called"); \
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
            _crewGroup = [_vehicle, ([U, 0, _crewCount - 1] call Zen_ArrayGetIndexedSlice)] call Zen_SpawnGroup; \
            0 = [_crewGroup, "crew"] call Zen_SetAISkill; \
            0 = [_crewGroup, _vehicle, "All"] call Zen_MoveInVehicle; \
            (units _crewGroup) join _referenceUnit; \
            doStop (driver _vehicle); \
        }; \
    };

#define CREW_UNITS ["rhsusf_army_ocp_driver", "rhsusf_army_ocp_rifleman"]
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1025_w_s_m2, "rhsusf_m1025_w_s_m2", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1025_w_mk19, "rhsusf_m1025_w_mk19", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_rg33_usmc_d, "rhsusf_rg33_usmc_d", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_rg33_usmc_wd, "rhsusf_rg33_usmc_wd", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rg33_m2_usmc_wd, "rg33_m2_usmc_wd", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_hsusf_m113d_usarmy, "hsusf_m113d_usarmy", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_M1078A1P2_B_M2_wd_fmtv_usarmy, "rhsusf_M1078A1P2_B_M2_wd_fmtv_usarmy", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_M1083A1P2_B_M2_d_fmtv_usarmy, "rhsusf_M1083A1P2_B_M2_d_fmtv_usarmy", CREW_UNITS)

#define CREW_UNITS ["rhsusf_army_ocp_driver"]
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m998_w_2dr, "rhsusf_m998_w_2dr", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m998_w_2dr_halftop, "rhsusf_m998_w_2dr_halftop", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1025_w, "rhsusf_m1025_w", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1025_w_s, "rhsusf_m1025_w_s", CREW_UNITS)

#define CREW_UNITS ["rhsusf_army_ocp_driver", "rhsusf_army_ocp_combatcrewman", "rhsusf_army_ocp_crewman"]
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1a2sep1tuskiid_usarmy, "rhsusf_m1a2sep1tuskiid_usarmy", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1a2sep1tuskiiwd_usarmy, "rhsusf_m1a2sep1tuskiiwd_usarmy", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1a2sep1tuskiwd_usarmy, "rhsusf_m1a2sep1tuskiwd_usarmy", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1a2sep1tuskid_usarmy, "rhsusf_m1a2sep1tuskid_usarmy", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1a2sep1wd_usarmy, "rhsusf_m1a2sep1wd_usarmy", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1a2sep1d_usarmy, "rhsusf_m1a2sep1d_usarmy", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1a1fep_od, "rhsusf_m1a1fep_od", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1a1fep_wd, "rhsusf_m1a1fep_wd", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1a1fep_d, "rhsusf_m1a1fep_d", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1a1aim_tuski_d, "rhsusf_m1a1aim_tuski_d", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1a1aim_tuski_wd, "rhsusf_m1a1aim_tuski_wd", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1a1aimd_usarmy, "rhsusf_m1a1aimd_usarmy", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_rhsusf_m1a1aimwd_usarmy, "rhsusf_m1a1aimwd_usarmy", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_M2A3_BUSKIII, "RHS_M2A3_BUSKIII", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_M2A3_BUSKI, "RHS_M2A3_BUSKI", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_M2A3, "RHS_M2A3", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_M2A2_BUSKI, "RHS_M2A2_BUSKI", CREW_UNITS)
VEHCILE_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_M2A2, "RHS_M2A2", CREW_UNITS)

Zen_RTS_Asset_West_rhsusf_m998_w_2dr = ["Zen_RTS_F_West_Asset_rhsusf_m998_w_2dr","m998-2dr", "Cost: 100, Time: 10, Crew: 1,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_m998_w_2dr_halftop = ["Zen_RTS_F_West_Asset_rhsusf_m998_w_2dr_halftop", "m998-2dr-halftop", "Cost: 200, Time: 10, Crew: 1,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_m1025_w = ["Zen_RTS_F_West_Asset_rhsusf_m1025_w", "m998-2dr-fulltop", "Cost: 200, Time: 10, Crew: 1,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_m1025_w_s = ["Zen_RTS_F_West_Asset_rhsusf_m1025_w_s", "m998-4dr", "Cost: 200, Time: 10, Crew: 1,"] call Zen_RTS_StrategicAssetCreate;

Zen_RTS_Asset_West_rhsusf_M1083A1P2_B_M2_d_fmtv_usarmy = ["Zen_RTS_F_West_Asset_rhsusf_M1083A1P2_B_M2_d_fmtv_usarmy", "M108-m2", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_M1078A1P2_B_M2_wd_fmtv_usarmy = ["Zen_RTS_F_West_Asset_rhsusf_M1078A1P2_B_M2_wd_fmtv_usarmy", "M107-m2", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_m1025_w_mk19 = ["Zen_RTS_F_West_Asset_rhsusf_m1025_w_mk19","m1025-mk19", "Cost: 100, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_rhsusf_m1025_w_s_m2 = ["Zen_RTS_F_West_Asset_rhsusf_m1025_w_s_m2","m1025-m2", "Cost: 100, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_rhsusf_rg33_usmc_d = ["Zen_RTS_F_West_Asset_rhsusf_rg33_usmc_d","rg33-d", "Cost: 100, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_rhsusf_rg33_usmc_wd = ["Zen_RTS_F_West_Asset_rhsusf_rg33_usmc_wd","rg33", "Cost: 100, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_rhsusf_rg33_m2_usmc_wd = ["Zen_RTS_F_West_Asset_rg33_m2_usmc_wd","rg33-m2", "Cost: 100, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_rhsusf_m113d_usarmy = ["Zen_RTS_F_West_Asset_hsusf_m113d_usarmy","m113-d", "Cost: 100, Time: 10, Crew: 2,"] call Zen_RTS_StrategicAssetCreate;

Zen_RTS_Asset_West_RHS_M2A2 = ["Zen_RTS_F_West_Asset_RHS_M2A2","M2A2", "Cost: 100, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_RHS_M2A2_BUSKI = ["Zen_RTS_F_West_Asset_RHS_M2A2_BUSKI","M2A2_BUSKI", "Cost: 100, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_RHS_M2A3 = ["Zen_RTS_F_West_Asset_RHS_M2A3","M2A3", "Cost: 100, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_RHS_M2A3_BUSKI = ["Zen_RTS_F_West_Asset_RHS_M2A3_BUSKI","M2A3_BUSKI", "Cost: 100, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_RHS_M2A3_BUSKIII = ["Zen_RTS_F_West_Asset_RHS_M2A3_BUSKIII","M2A3_BUSKIII", "Cost: 100, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_m1a1aimwd_usarmy = ["Zen_RTS_F_West_Asset_rhsusf_m1a1aimwd_usarmy","rhsusf_m1a1-aim-wd", "Cost: 100, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_m1a1aimd_usarmy = ["Zen_RTS_F_West_Asset_rhsusf_m1a1aimd_usarmy","m1a1-aim-d", "Cost: 100, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_m1a1aim_tuski_wd = ["Zen_RTS_F_West_Asset_rhsusf_m1a1aim_tuski_wd","m1a1aim-tuski-wd", "Cost: 100, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_m1a1aim_tuski_d = ["Zen_RTS_F_West_Asset_rhsusf_m1a1aim_tuski_d","m1a1=aim-tuski-d", "Cost: 100, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_m1a1fep_d = ["Zen_RTS_F_West_Asset_rhsusf_m1a1fep_d","m1a1-fep-d", "Cost: 100, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_m1a1fep_wd = ["Zen_RTS_F_West_Asset_rhsusf_m1a1fep_wd","m1a1fep_wd", "Cost: 100, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_m1a1fep_od = ["Zen_RTS_F_West_Asset_rhsusf_m1a1fep_od","m1a1fep_od", "Cost: 100, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_m1a2sep1d_usarmy = ["Zen_RTS_F_West_Asset_rhsusf_m1a2sep1d_usarmy","m1a2-sep-1d", "Cost: 100, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_m1a2sep1wd_usarmy = ["Zen_RTS_F_West_Asset_rhsusf_m1a2sep1wd_usarmy","m1a2-sep1-wd", "Cost: 100, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_m1a2sep1tuskid_usarmy = ["Zen_RTS_F_West_Asset_rhsusf_m1a2sep1tuskid_usarmy","m1a2-sep1-tuski-d", "Cost: 100, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_m1a2sep1tuskiwd_usarmy = ["Zen_RTS_F_West_Asset_rhsusf_m1a2sep1tuskiwd_usarmy","m1a2-sep1-tuski-wd", "Cost: 100, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_m1a2sep1tuskiiwd_usarmy = ["Zen_RTS_F_West_Asset_rhsusf_m1a2sep1tuskiiwd_usarmy","m1a2-sep1-tuski-iwd", "Cost: 100, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_rhsusf_m1a2sep1tuskiid_usarmy = ["Zen_RTS_F_West_Asset_rhsusf_m1a2sep1tuskiid_usarmy","m1a2-sep1-tuski-id", "Cost: 100, Time: 10, Crew: 3,"] call Zen_RTS_StrategicAssetCreate;
