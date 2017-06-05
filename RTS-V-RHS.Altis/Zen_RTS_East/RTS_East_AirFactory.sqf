
// (_this select 1) : [array, spawn position, scalar, starting level]
Zen_RTS_F_East_AirFactoryConstructor = {
    diag_log "East Air_factory constructor called";
    diag_log _this;

    _buildingObjData = _this select 0;
    _args = _this select 1;

    ZEN_RTS_STRATEGIC_BUILDING_CONSTRUCTOR_ARGS()
    _buildingTypeData = [(_buildingObjData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;

    _assetsToAdd = [];
    _assetsToAdd pushBack Zen_RTS_Asset_East_rhs_ka60_c;
    _assetsToAdd pushBack Zen_RTS_Asset_East_RHS_Mi8mt_vvs;

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

    BUILDING_VISUALS("Land_Airport_Tower_F", -0.5, EastCommander, _dir, "Air Factory", "o_air")
    ZEN_RTS_STRATEGIC_BUILDING_DESTROYED_EH(Zen_RTS_BuildingType_East_AirFactory, East)

    // to-do: || false condition needs building hacking logic
    _args = ["addAction", [_building, ["Purchase Units", Zen_RTS_BuildMenu, [(_buildingObjData select 0), (_buildingObjData select 1)], 1, false, true, "", "((_target distance _this) < 15) && {(side _this == (_target getVariable 'Zen_RTS_StrategicBuildingSide')) || (false)}"]]];
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)
    (_building)
};

Zen_RTS_F_East_AirFactoryDestructor = {
    diag_log "East Air_factory destructor";

    _buildingObjData = _this select 0;
    _level = _buildingObjData select 3;
    diag_log _level;

    _index = [(_buildingObjData select 0), (RTS_Used_Building_Types select 1)] call Zen_ValueFindInArray;
    _array = RTS_Building_Type_Levels select 1;
    _array set [_index, _level];

    (_buildingObjData select 2) setDamage 1;
};

#define UPGRADE(N, A) \
N = { \
    diag_log (#N + " called"); \
    diag_log _this; \
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

#define ASSETS [Zen_RTS_Asset_East_RHS_Mi8AMT_vvs,  Zen_RTS_Asset_East_RHS_Mi8AMTSh_UPK23_vvs, Zen_RTS_Asset_East_RHS_Mi8AMTSh_FAB_vvs]
UPGRADE(Zen_RTS_F_East_AirFactoryUpgrade02, ASSETS)

#define ASSETS [Zen_RTS_Asset_East_RHS_Ka52_vvs, Zen_RTS_Asset_East_RHS_Ka52_UPK23_vvs]
UPGRADE(Zen_RTS_F_East_AirFactoryUpgrade03, ASSETS)

#define ASSETS [Zen_RTS_Asset_East_RHS_Su25SM_vvs, Zen_RTS_Asset_East_RHS_Su25SM_KH29_vvs, Zen_RTS_Asset_East_rhs_pchela1t_vvs]
UPGRADE(Zen_RTS_F_East_AirFactoryUpgrade04, ASSETS)

Zen_RTS_BuildingType_East_AirFactory = ["Zen_RTS_F_East_AirFactoryConstructor", "Zen_RTS_F_East_AirFactoryDestructor", ["Zen_RTS_F_East_AirFactoryUpgrade01", "Zen_RTS_F_East_AirFactoryUpgrade02", "Zen_RTS_F_East_AirFactoryUpgrade03", "Zen_RTS_F_East_AirFactoryUpgrade04"], "Air Factory", "Cost: 20000, Time: 120, Picture: pictures\plane_ca.paa, Classname: Land_Airport_Tower_F,"] call Zen_RTS_StrategicBuildingCreate;
(RTS_Used_Building_Types select 1) pushBack  Zen_RTS_BuildingType_East_AirFactory;

/////////////////////////////////
// Assets
/////////////////////////////////

Zen_RTS_Asset_East_rhs_ka60_c = ["Zen_RTS_F_East_Asset_rhs_ka60_c", "KA-60 (UNARMED)", "Cost: 5000, Time: 120,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_RHS_Mi8mt_vvs = ["Zen_RTS_F_East_Asset_RHS_Mi8mt_vvs", "MI-8 (UNARMED)", "Cost: 5000, Time: 120,"] call Zen_RTS_StrategicAssetCreate;

Zen_RTS_Asset_East_RHS_Mi8MTV3_vvs = ["Zen_RTS_F_East_Asset_RHS_Mi8MTV3_vvs", "MI8 ROCKETS", "Cost: 7000, Time: 120,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_RHS_Mi8MTV3_UPK23_vvs = ["Zen_RTS_F_East_Asset_RHS_Mi8MTV3_UPK23_vvs", "MI8-UPK23", "Cost: 7000, Time: 120,"] call Zen_RTS_StrategicAssetCreate;

Zen_RTS_Asset_East_RHS_Mi8AMT_vvs = ["Zen_RTS_F_East_Asset_RHS_Mi8AMT_vvs", "MI8-AMT", "Cost: 8000, Time: 120,"] call Zen_RTS_StrategicAssetCreate;	
Zen_RTS_Asset_East_RHS_Mi8AMTSh_UPK23_vvs = ["Zen_RTS_F_East_Asset_RHS_Mi8AMTSh_UPK23_vvs", "MI8-AMT-UPK23", "Cost: 8000, Time: 120,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_RHS_Mi8AMTSh_FAB_vvs = ["Zen_RTS_F_East_Asset_RHS_Mi8AMTSh_FAB_vvs", "MI8AMT-FAB", "Cost: 8000, Time: 120,"] call Zen_RTS_StrategicAssetCreate;

Zen_RTS_Asset_East_RHS_Ka52_vvs = ["Zen_RTS_F_East_Asset_RHS_Ka52_vvs", "KA-52", "Cost: 9000, Time: 120,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_RHS_Ka52_UPK23_vvs = ["Zen_RTS_F_East_Asset_RHS_Ka52_UPK23_vvs", "KA-UPK23", "Cost: 9000, Time: 120,"] call Zen_RTS_StrategicAssetCreate;																																					
Zen_RTS_Asset_East_RHS_Su25SM_vvs = ["Zen_RTS_F_East_Asset_RHS_Su25SM_vvs", "SU25", "Cost: 10000, Time: 120,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_RHS_Su25SM_KH29_vvs = ["Zen_RTS_F_East_Asset_RHS_Su25SM_KH29_vvs", "SU25-KH29", "Cost: 10000, Time: 120,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_pchela1t_vvs = ["Zen_RTS_F_East_Asset_rhs_pchela1t_vvs", "PCHELA", "Cost: 15000, Time: 120,"] call Zen_RTS_StrategicAssetCreate;