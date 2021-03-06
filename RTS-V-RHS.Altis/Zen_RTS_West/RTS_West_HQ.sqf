/**
    Upgrade Tank Factory
    Upgrade Barracks
    Upgrade Air Factory
    Build Enemy Units
//*/

Zen_RTS_F_West_HQConstructor = {
    diag_log "West HQ constructor called";
    diag_log _this;

    _buildingObjData = _this select 0;
    _args = _this select 1;

    ZEN_RTS_STRATEGIC_BUILDING_CONSTRUCTOR_ARGS()

    _assetsToAdd = [];
    _assetsToAddLocal = [];
    _assetsToAddLocal pushBack Zen_RTS_Asset_Tech_West_Enemy;

    DETECT_BUILDING( Zen_RTS_BuildingType_West_TankFactory , Zen_RTS_Asset_Tech_West_Upgrade_TankFactory )
    DETECT_BUILDING( Zen_RTS_BuildingType_West_Barracks , Zen_RTS_Asset_Tech_West_Upgrade_Barracks )
    DETECT_BUILDING( Zen_RTS_BuildingType_West_Radar , Zen_RTS_Asset_Tech_West_Upgrade_Radar )
    DETECT_BUILDING( Zen_RTS_BuildingType_West_AirFactory , Zen_RTS_Asset_Tech_West_Upgrade_AirFactory )
    DETECT_BUILDING( Zen_RTS_BuildingType_West_NavalFactory , Zen_RTS_Asset_Tech_West_Upgrade_NavalFactory )
    //DETECT_BUILDING( Zen_RTS_BuildingType_West_SupportFactory , Zen_RTS_Asset_Tech_West_Upgrade_SupportFactory )

    0 = [(_buildingObjData select 1), _assetsToAdd] call Zen_RTS_F_StrategicAddAssetGlobal;

    _args = [(_buildingObjData select 1), _assetsToAddLocal];
    ZEN_FMW_MP_RENonDedicated("Zen_RTS_F_StrategicAddAssetLocal", _args, call)

    _buildingTypeData = [(_buildingObjData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;
    BUILDING_VISUALS("Land_Research_HQ_F", -1, WestCommander, _dir, "HQ", "b_hq")
    ZEN_RTS_STRATEGIC_BUILDING_DESTROYED_EH(Zen_RTS_BuildingType_West_HQ, West)

    // to-do: || false condition needs building hacking logic
    _args = ["addAction", [_building, ["Purchase Technologies", Zen_RTS_BuildMenu, [(_buildingObjData select 0), (_buildingObjData select 1)], 1, false, true, "", "((_target distance _this) < 15) && {(side _this == (_target getVariable 'Zen_RTS_StrategicBuildingSide')) || (false)}"]]];
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)
    (_building)
};

Zen_RTS_F_West_HQDestructor = {
    diag_log "West HQ destructor";

    _buildingObjData = _this select 0;
    _level = _buildingObjData select 3;
    diag_log _level;

    _index = [(_buildingObjData select 0), (RTS_Used_Building_Types select 0)] call Zen_ValueFindInArray;
    _array = RTS_Building_Type_Levels select 0;
    _array set [_index, _level];

    (_buildingObjData select 2) setDamage 1;
};

Zen_RTS_BuildingType_West_HQ = ["Zen_RTS_F_West_HQConstructor", "Zen_RTS_F_West_HQDestructor", [], "HQ", "Cost: 5000, Time: 30, picture: pictures\icon_remote.paa, Classname: Land_Research_HQ_F,"] call Zen_RTS_StrategicBuildingCreate;
(RTS_Used_Building_Types select 0) pushBack Zen_RTS_BuildingType_West_HQ;

/////////////////////////////////
// Assets
/////////////////////////////////

Zen_RTS_TechFlag_West_BuildEnemy = false;
publicVariable "Zen_RTS_TechFlag_West_BuildEnemy";

Zen_RTS_Asset_Tech_West_Enemy = ["Zen_RTS_F_West_Tech_Enemy", "Build Enemy Units", "Cost: 50, Time: 10,", "Commander"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_Tech_West_Upgrade_TankFactory = ["Zen_RTS_F_West_Tech_Upgrade_TankFactory", "Upgrade Tank Factory", "Cost: 5000, Time: 60,", "Commander"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_Tech_West_Upgrade_Barracks = ["Zen_RTS_F_West_Tech_Upgrade_Barracks", "Upgrade Barracks", "Cost: 2000, Time: 35,", "Commander"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_Tech_West_Upgrade_Radar = ["Zen_RTS_F_West_Tech_Upgrade_Radar", "Upgrade Radar", "Cost: 10000, Time: 120,", "Commander"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_Tech_West_Upgrade_AirFactory = ["Zen_RTS_F_West_Tech_Upgrade_AirFactory", "Upgrade Air Factory", "Cost: 7000, Time: 120,", "Commander"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_Tech_West_Upgrade_NavalFactory = ["Zen_RTS_F_West_Tech_Upgrade_NavalFactory", "Upgrade Naval Factory", "Cost: 1000, Time: 35,", "Commander"] call Zen_RTS_StrategicAssetCreate;
//Zen_RTS_Asset_Tech_West_Upgrade_SupportFactory = ["Zen_RTS_F_West_Tech_Upgrade_SupportFactory", "Upgrade Support Factory", "Cost: 50, Time: 10,", "Commander"] call Zen_RTS_StrategicAssetCreate;
