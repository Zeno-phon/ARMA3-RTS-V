
/**
    Level 1:
        Zen_RTS_F_West_Asset_Hummingbird
        Zen_RTS_F_West_Hummingbird_stripped
    Level 2:
         Zen_RTS_F_West_AH_9_Pawnee
         Zen_RTS_F_West_UH_80_Ghost
//*/

// (_this select 1) : [array, spawn position, scalar, starting level]
Zen_RTS_F_West_AirFactoryConstructor = {
    player sideChat str "West Air_factory constructor called";
    player sideChat str _this;

    _buildingObjData = _this select 0;
    _args = _this select 1;

    _spawnPos = _args select 0;
    _level = _args select 1;
    _buildingTypeData = [(_buildingObjData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;

    _assetsToAdd = [];
    _assetsToAdd pushBack Zen_RTS_Asset_West_RHS_UH1Y_UNARMED;
    _assetsToAdd pushBack Zen_RTS_Asset_West_RHS_UH1Y_UNARMED_d;

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
        0 = [_ID, [Zen_RTS_Asset_Tech_West_Upgrade_AirFactory]] call Zen_RTS_F_StrategicAddAssetGlobal;
    };

    BUILDING_VISUALS("Land_Airport_Tower_F", 1, west)
    ZEN_RTS_STRATEGIC_BUILDING_DESTROYED_EH(Zen_RTS_BuildingType_West_AirFactory)

    // to-do: || false condition needs building hacking logic
    _args = ["addAction", [_building, ["Purchase Units", Zen_RTS_BuildMenu, (_buildingObjData select 0), 1, false, true, "", "((_target distance _this) < 15) && {(side _this == (_target getVariable 'side')) || (false)}"]]];
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)
    (_building)
};

Zen_RTS_F_West_AirFactoryDestructor = {
    player sideChat str "West Air_factory destructor";

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

#define ASSETS [Zen_RTS_Asset_West_RHS_UH1Y, Zen_RTS_Asset_West_RHS_UH1Y_FFAR, Zen_RTS_Asset_West_RHS_UH1Y_FFAR_d]
UPGRADE(Zen_RTS_F_West_AirFactoryUpgrade01, ASSETS)

#define ASSETS [Zen_RTS_Asset_West_RHS_CH_47F_10, Zen_RTS_Asset_West_RHS_UH60M, Zen_RTS_Asset_West_RHS_UH60M_d, Zen_RTS_Asset_West_RHS_UH60M_MEV2_d]
UPGRADE(Zen_RTS_F_West_AirFactoryUpgrade02, ASSETS)

 #define ASSETS [Zen_RTS_Asset_West_RHS_AH64D_GS, Zen_RTS_Asset_West_RHS_AH64D_wd_GS, Zen_RTS_Asset_West_RHS_AH64D_AA, Zen_RTS_Asset_West_RHS_AH64DGrey]
 UPGRADE(Zen_RTS_F_West_AirFactoryUpgrade03, ASSETS)
  #define ASSETS [Zen_RTS_Asset_West_RHS_C130J, Zen_RTS_Asset_West_RHS_AH1Z, Zen_RTS_Asset_West_RHS_A10]

 UPGRADE(Zen_RTS_F_West_AirFactoryUpgrade04, ASSETS)

Zen_RTS_BuildingType_West_AirFactory = ["Zen_RTS_F_West_AirFactoryConstructor", "Zen_RTS_F_West_AirFactoryDestructor", ["Zen_RTS_F_West_AirFactoryUpgrade01", "Zen_RTS_F_West_AirFactoryUpgrade02", "Zen_RTS_F_West_AirFactoryUpgrade03", "Zen_RTS_F_West_AirFactoryUpgrade04"], "Air Factory", "Cost: 2000, Time: 10,"] call Zen_RTS_StrategicBuildingCreate;
(RTS_Used_Building_Types select 0) pushBack  Zen_RTS_BuildingType_West_AirFactory;

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

#define CREW_UNITS ["rhsusf_army_ucp_helipilot", "rhsusf_army_ucp_helipilot"]
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_UH1Y_UNARMED, "RHS_UH1Y_UNARMED", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_UH1Y_UNARMED_d , "RHS_UH1Y_UNARMED_d", CREW_UNITS)

#define CREW_UNITS ["rhsusf_usmc_marpat_wd_helipilot", "rhsusf_usmc_marpat_wd_helipilot"]
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_AH64DGrey, "RHS_AH64DGrey", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_AH64D_AA, "RHS_AH64D_AA", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_AH64D_wd_GS, "RHS_AH64D_wd_GS", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_AH64D_GS, "RHS_AH64D_GS", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_AH1Z, "RHS_AH1Z", CREW_UNITS)

#define CREW_UNITS ["rhsusf_army_ucp_helipilot", "rhsusf_army_ucp_helipilot", "rhsusf_army_ucp_helicrew", "rhsusf_army_ucp_helicrew"]
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_UH1Y, "RHS_UH1Y", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_UH1Y_FFAR_d, "RHS_UH1Y_FFAR_d", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_UH1Y_FFAR, "RHS_UH1Y_FFAR", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_CH_47F_10, "RHS_CH_47F_10", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_UH60M, "RHS_UH60M", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_UH60M_d, "RHS_UH60M_d", CREW_UNITS)

#define CREW_UNITS ["rhsusf_usmc_marpat_wd_helipilot", "rhsusf_assault_eagleaiii_coy_medic"]
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_UH60M_MEV2_d, "RHS_UH60M_MEV2_d", CREW_UNITS)

#define CREW_UNITS ["rhsusf_airforce_pilot"]
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_A10, "RHS_A10", CREW_UNITS)
AIR_CONSTRUCTOR(Zen_RTS_F_West_Asset_RHS_C130J, "RHS_C130J", CREW_UNITS)

Zen_RTS_Asset_West_RHS_UH1Y_UNARMED = ["Zen_RTS_F_West_Asset_RHS_UH1Y_UNARMED", "UH1Y-UNARMED", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_RHS_UH1Y_UNARMED_d = ["Zen_RTS_F_West_Asset_RHS_UH1Y_UNARMED_d", "UH1Y_UNARMED-d", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_RHS_UH1Y = ["Zen_RTS_F_West_Asset_RHS_UH1Y", "UH1Y", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_RHS_UH1Y_FFAR = ["Zen_RTS_F_West_Asset_RHS_UH1Y_FFAR", "UH1Y-FFAR", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_RHS_UH1Y_FFAR_d = ["Zen_RTS_F_West_Asset_RHS_UH1Y_FFAR_d", "UH1Y-FFAR-d", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_RHS_CH_47F_10 = ["Zen_RTS_F_West_Asset_RHS_CH_47F_10", "CH-47F-10", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_RHS_UH60M = ["Zen_RTS_F_West_Asset_RHS_UH60M", "UH60M", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_RHS_UH60M_d = ["Zen_RTS_F_West_Asset_RHS_UH60M_d", "UH60M-d", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_RHS_UH60M_MEV2_d = ["Zen_RTS_F_West_Asset_RHS_UH60M_MEV2_d", "UH60M-MEV2-d", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_RHS_AH64D_GS = ["Zen_RTS_F_West_Asset_RHS_AH64D_GS", "AH64D-GS", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_RHS_AH64D_wd_GS = ["Zen_RTS_F_West_Asset_RHS_AH64D_wd_GS", "AH64D-wd-GS", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_RHS_AH64D_AA = ["Zen_RTS_F_West_Asset_RHS_AH64D_AA", "AH64D-AA", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_RHS_AH64DGrey = ["Zen_RTS_F_West_Asset_RHS_AH64DGrey", "AH64D-Grey", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_RHS_C130J = ["Zen_RTS_F_West_Asset_RHS_C130J", "C130J", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_RHS_AH1Z = ["Zen_RTS_F_West_Asset_RHS_AH1Z", "AH1Z", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_West_RHS_A10 = ["Zen_RTS_F_West_Asset_RHS_A10", "A10", "Cost: 200, Time: 10,"] call Zen_RTS_StrategicAssetCreate;
