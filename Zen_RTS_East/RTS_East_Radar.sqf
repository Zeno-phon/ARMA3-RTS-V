
Zen_RTS_F_East_RadarConstructor = {
    player sideChat str "East Radar constructor called";
     player sideChat str _this;

    _buildingObjData = _this select 0;
    _spawnPos = _this select 1;
    _buildingTypeData = [(_buildingObjData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;

    _assetsToAdd = [];

    {
        (RTS_Used_Asset_Types select 0) pushBack _x;
    } forEach _assetsToAdd;
    publicVariable "RTS_Used_Asset_Types";

    0 = [(_buildingObjData select 1), _assetsToAdd] call Zen_RTS_F_StrategicAddAssetGlobal;

    ZEN_RTS_STRATEGIC_GET_BUILDING_OBJ_ID(Zen_RTS_BuildingType_East_HQ, _ID)
    if (_ID != "") then {
       0 = [_ID, [Zen_RTS_Asset_Tech_East_Upgrade_Radar]] call Zen_RTS_F_StrategicAddAssetGlobal;
    };

    BUILDING_VISUALS("rhs_prv13", 1, east)
    ZEN_RTS_STRATEGIC_BUILDING_DESTROYED_EH(Zen_RTS_BuildingType_East_Radar)

    (_building)
};

Zen_RTS_F_East_RadarDestructor = {
    player sideChat str "East Radar destructor";

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

#define ASSETS []
UPGRADE(Zen_RTS_F_East_RadarUpgrade01, ASSETS)

// #define ASSETS []
// UPGRADE(Zen_RTS_F_East_RadarUpgrade02, ASSETS)
Zen_RTS_BuildingType_East_Radar = ["Zen_RTS_F_East_RadarConstructor", "Zen_RTS_F_East_RadarDestructor", ["Zen_RTS_F_East_RadarUpgrade01"], "Radar", "Cost: 2000, Time: 10,"] call Zen_RTS_StrategicBuildingCreate;
(RTS_Used_Building_Types select 1) pushBack  Zen_RTS_BuildingType_East_Radar;