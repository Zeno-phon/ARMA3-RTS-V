/**
    Level 1:
        Zen_RTS_Asset_Ka60
        Zen_RTS_Asset_Mi8MT
    Level 2:
        Zen_RTS_Asset_Mi8MTV3
    Level 3:
        Zen_RTS_Asset_Ka52
//*/

// (_this select 1) : [array, spawn position, scalar, starting level]
Zen_RTS_F_East_AirFactoryConstructor = {
    player sideChat str "East Air_factory constructor called";
    player sideChat str _this;

    _buildingObjData = _this select 0;
    _args = _this select 1;

    _spawnPos = _args select 0;
    _level = _args select 1;
    _buildingTypeData = [(_buildingObjData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;

    _assetsToAdd = [];
    _assetsToAdd pushBack Zen_RTS_Asset_East_rhs_ka60_c;
    _assetsToAdd pushBack Zen_RTS_Asset_East_RHS_Mi8mt_vvs;
	_assetsToAdd pushBack Zen_RTS_Asset_East_RHS_Mi8mt_Cargo_vvs;

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
        0 = [_ID, [Zen_RTS_Asset_Tech_East_Upgrade_AirFactory]] call Zen_RTS_F_StrategicAddAssetGlobal;
    };

    BUILDING_VISUALS("Land_Airport_Tower_F", 1, east)
    ZEN_RTS_STRATEGIC_BUILDING_DESTROYED_EH(Zen_RTS_BuildingType_East_AirFactory)

    // to-do: || false condition needs building hacking logic
    _args = ["addAction", [_building, ["Purchase Units", Zen_RTS_BuildMenu, (_buildingObjData select 0), 1, false, true, "", "((_target distance _this) < 15) && {(side _this == (_target getVariable 'side')) || (false)}"]]];
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)
    (_building)
};

Zen_RTS_F_East_AirFactoryDestructor = {
    player sideChat str "East Air_factory destructor";

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
    _buildingData = _this select 0; \
    _assetsToAdd = A; \
    if (Zen_RTS_TechFlag_East_BuildEnemy) then { \
    }; \
    { \
        (RTS_Used_Asset_Types select 1) pushBack _x; \
    } forEach _assetsToAdd; \
    publicVariable "RTS_Used_Asset_Types"; \
    0 = [(_buildingData select 1), _assetsToAdd] call Zen_RTS_F_StrategicAddAssetGlobal; \
    (true) \
};

#define ASSETS [Zen_RTS_Asset_East_RHS_Mi8MTV3_vvs, Zen_RTS_Asset_East_RHS_Mi8MTV3_UPK23_vvs]
UPGRADE(Zen_RTS_F_East_AirFactoryUpgrade01, ASSETS)

#define ASSETS [Zen_RTS_Asset_East_RHS_Mi8AMT_vvs, Zen_RTS_Asset_East_RHS_Mi8AMTSh_vvs, Zen_RTS_Asset_East_RHS_Mi8AMTSh_UPK23_vvs, Zen_RTS_Asset_East_RHS_Mi8AMTSh_FAB_vvs]
UPGRADE(Zen_RTS_F_East_AirFactoryUpgrade02, ASSETS)

#define ASSETS [Zen_RTS_Asset_East_RHS_Mi8MTV3_FAB_vvs, Zen_RTS_Asset_East_RHS_Ka52_vvs, Zen_RTS_Asset_East_RHS_Ka52_UPK23_vvs]
UPGRADE(Zen_RTS_F_East_AirFactoryUpgrade03, ASSETS)

#define ASSETS [Zen_RTS_Asset_East_RHS_Su25SM_vvs, Zen_RTS_Asset_East_RHS_Su25SM_KH29_vvs, Zen_RTS_Asset_East_rhs_pchela1t_vvs]
UPGRADE(Zen_RTS_F_East_AirFactoryUpgrade04, ASSETS)

Zen_RTS_BuildingType_East_AirFactory = ["Zen_RTS_F_East_AirFactoryConstructor", "Zen_RTS_F_East_AirFactoryDestructor", ["Zen_RTS_F_East_AirFactoryUpgrade01", "Zen_RTS_F_East_AirFactoryUpgrade02", "Zen_RTS_F_East_AirFactoryUpgrade03", "Zen_RTS_F_East_AirFactoryUpgrade04"], "Air Factory", "Cost: 2000, Time: 10,"] call Zen_RTS_StrategicBuildingCreate;
(RTS_Used_Building_Types select 1) pushBack  Zen_RTS_BuildingType_East_AirFactory;

/////////////////////////////////
// Assets
/////////////////////////////////

#define AIR_CONSTRUCTOR(N, T, U) \
    N = { \
        player sideChat str (#N + " asset constructor called"); \
        player sideChat str _this; \
        _buildingObjData = _this select 0; \
        _assetData = _this select 1; \
        _assetStrRaw = _assetData select 3; \
        _referenceUnit = _this select 2; \
        _crewCount = _this select 3; \
        _phi = 0; \
        _theta = 0; \
        _building = _buildingObjData select 2; \
        _pos = [_building, [20, 75], [], 1, [3, 15], 0, [1, 20, 0], 0, [1, 20], [1, 15, 10], [1, [0, 1, -1], 20], 0, 2] call Zen_FindGroundPosition; \
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

#define CREW_UNITS ["rhs_pilot_transport_heli", "rhs_pilot_transport_heli"]
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_ka60_c, "rhs_ka60_c", CREW_UNITS)

#define CREW_UNITS ["rhs_pilot_transport_heli", "rhs_pilot_transport_heli", "rhs_msv_rifleman", "rhs_msv_rifleman", "rhs_msv_rifleman"]
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Mi8mt_vvs, "RHS_Mi8mt_vvsc", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Mi8mt_Cargo_vvs, "RHS_Mi8mt_Cargo_vvs", CREW_UNITS)

#define CREW_UNITS ["rhs_pilot_combat_heli", "rhs_pilot_combat_heli", "rhs_msv_rifleman", "rhs_msv_rifleman", "rhs_msv_rifleman"]
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Mi8MTV3_vvs, "RHS_Mi8MTV3_vvs", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Mi8MTV3_UPK23_vvs, "RHS_Mi8MTV3_UPK23_vvs", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Mi8MTV3_FAB_vvs, "RHS_Mi8MTV3_FAB_vvs", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Mi8AMT_vvs, "RHS_Mi8AMT_vvs", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Mi8AMTSh_vvs, "RHS_Mi8AMTSh_vvs", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Mi8AMTSh_UPK23_vvs, "RHS_Mi8AMTSh_UPK23_vvs", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Mi8AMTSh_FAB_vvs, "RHS_Mi8AMTSh_FAB_vvs", CREW_UNITS)

#define CREW_UNITS ["rhs_pilot_combat_heli", "rhs_pilot_combat_heli"]
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Ka52_vvs, "RHS_Ka52_vvs", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Ka52_UPK23_vvs, "RHS_Ka52_UPK23_vvs", CREW_UNITS)
#define CREW_UNITS ["rhs_pilot"]
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Su25SM_vvs, "RHS_Su25SM_vvs", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_RHS_Su25SM_KH29_vvs, "RHS_Su25SM_KH29_vvs", CREW_UNITS)
#define CREW_UNITS []
AIR_CONSTRUCTOR(Zen_RTS_F_East_Asset_rhs_pchela1t_vvs, "rhs_pchela1t_vvs", CREW_UNITS)


Zen_RTS_Asset_East_rhs_ka60_c = ["Zen_RTS_F_East_Asset_rhs_ka60_c", "Ka-60 Unarmed", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_RHS_Mi8mt_vvs = ["Zen_RTS_F_East_Asset_RHS_Mi8mt_vvs", "Mi-8 Unarmed", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_RHS_Mi8mt_Cargo_vvs = ["Zen_RTS_F_East_Asset_RHS_Mi8mt_Cargo_vvs", "Mi-8 cargo", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_RHS_Mi8MTV3_vvs = ["Zen_RTS_F_East_Asset_RHS_Mi8MTV3_vvs", "Mi8 Rockets", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_RHS_Mi8MTV3_UPK23_vvs = ["Zen_RTS_F_East_Asset_RHS_Mi8MTV3_UPK23_vvs", "Mi8-UPK23", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_RHS_Mi8AMT_vvs = ["Zen_RTS_F_East_Asset_RHS_Mi8AMT_vvs", "Mi8-AMT", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_RHS_Mi8AMTSh_vvs = ["Zen_RTS_F_East_Asset_RHS_Mi8AMTSh_vvs", "Mi8-AMT-Sh", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_RHS_Mi8AMTSh_UPK23_vvs = ["Zen_RTS_F_East_Asset_RHS_Mi8AMTSh_UPK23_vvs", "Mi8-AMT-upk23", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_RHS_Mi8AMTSh_FAB_vvs = ["Zen_RTS_F_East_Asset_RHS_Mi8AMTSh_FAB_vvs", "Mi8AMT-FAB", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_RHS_Mi8MTV3_FAB_vvs = ["Zen_RTS_F_East_Asset_RHS_Mi8MTV3_FAB_vvs", "Mi8-FAB", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_RHS_Ka52_vvs = ["Zen_RTS_F_East_Asset_RHS_Ka52_vvs", "Ka-52", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_RHS_Ka52_UPK23_vvs = ["Zen_RTS_F_East_Asset_RHS_Ka52_UPK23_vvs", "Ka-UPK23", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_RHS_Su25SM_vvs = ["Zen_RTS_F_East_Asset_RHS_Su25SM_vvs", "Su25", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_RHS_Su25SM_KH29_vvs = ["Zen_RTS_F_East_Asset_RHS_Su25SM_KH29_vvs", "Su25-KH29", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_pchela1t_vvs = ["Zen_RTS_F_East_Asset_rhs_pchela1t_vvs", "pchela", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
