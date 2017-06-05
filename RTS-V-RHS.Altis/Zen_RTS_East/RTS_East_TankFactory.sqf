
// (_this select 1) : [array, spawn position, scalar, starting level]
Zen_RTS_F_East_TankFactoryConstructor = {
    diag_log "East Tank_factory constructor called";
    diag_log _this;

    _buildingObjData = _this select 0;
    _args = _this select 1;

    ZEN_RTS_STRATEGIC_BUILDING_CONSTRUCTOR_ARGS()
    _buildingTypeData = [(_buildingObjData select 0)] call Zen_RTS_StrategicBuildingTypeGetData;

    _assetsToAdd = [];

    _assetsToAdd pushBack Zen_RTS_Asset_East_rhs_uaz_vdv;
    _assetsToAdd pushBack Zen_RTS_Asset_East_rhs_uaz_open_vdv;
    _assetsToAdd pushBack Zen_RTS_Asset_East_CJ;

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
        0 = [_ID, [Zen_RTS_Asset_Tech_East_Upgrade_TankFactory]] call Zen_RTS_F_StrategicAddAssetGlobal;
    };

    BUILDING_VISUALS("Land_i_Garage_V1_F", -0.5, EastCommander, _dir, "Tank Factory", "o_armor")
    ZEN_RTS_STRATEGIC_BUILDING_DESTROYED_EH(Zen_RTS_BuildingType_East_TankFactory, East)

    // to-do: || false condition needs building hacking logic
    _args = ["addAction", [_building, ["<img size='3'image='pictures\build_CA.paa'/>", Zen_RTS_BuildMenu, [(_buildingObjData select 0), (_buildingObjData select 1)], 1, false, true, "", "((_target distance _this) < 15) && {(side _this == (_target getVariable 'Zen_RTS_StrategicBuildingSide')) || (false)}"]]];
    ZEN_FMW_MP_REAll("Zen_ExecuteCommand", _args, call)
    (_building)
};

Zen_RTS_F_East_TankFactoryDestructor = {
    diag_log "East Tank_factory destructor";

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

#define ASSETS [Zen_RTS_Asset_East_rhs_tigr_3camo_vmf, Zen_RTS_Asset_East_rhs_gaz66_ap2_vdv, Zen_RTS_Asset_East_rhs_btr80_vdv]
UPGRADE(Zen_RTS_F_East_TankFactoryUpgrade01, ASSETS)

#define ASSETS [Zen_RTS_Asset_East_rhs_brm1k_vdv, Zen_RTS_Asset_East_rhs_bmp1_vmf, Zen_RTS_Asset_East_rhs_bmp2e_vdv, Zen_RTS_Asset_East_rhs_bmp3_late_msv, Zen_RTS_Asset_East_rhs_bmp3mera_msv]
UPGRADE(Zen_RTS_F_East_TankFactoryUpgrade02, ASSETS)

#define ASSETS [Zen_RTS_Asset_East_rhs_bmd1, Zen_RTS_Asset_East_rhs_bmd2, Zen_RTS_Asset_East_rhs_bmd4ma_vdv, Zen_RTS_Asset_East_rhs_sprut_vdv, Zen_RTS_Asset_East_rhs_t72bc_tv, Zen_RTS_Asset_East_rhs_zsu234_aa]
UPGRADE(Zen_RTS_F_East_TankFactoryUpgrade03, ASSETS)

#define ASSETS [Zen_RTS_Asset_East_rhs_t80, Zen_RTS_Asset_East_rhs_t80a, Zen_RTS_Asset_East_rhs_t90_tv]
UPGRADE(Zen_RTS_F_East_TankFactoryUpgrade04, ASSETS)

Zen_RTS_BuildingType_East_TankFactory = ["Zen_RTS_F_East_TankFactoryConstructor", "Zen_RTS_F_East_TankFactoryDestructor", ["Zen_RTS_F_East_TankFactoryUpgrade01", "Zen_RTS_F_East_TankFactoryUpgrade02", "Zen_RTS_F_East_TankFactoryUpgrade03","Zen_RTS_F_East_TankFactoryUpgrade04"], "Tank factory", "Cost: 10000, Time: 120, Picture: pictures\tank_ca.paa, Classname: Land_i_Garage_V1_F,"] call Zen_RTS_StrategicBuildingCreate;
(RTS_Used_Building_Types select 1) pushBack  Zen_RTS_BuildingType_East_TankFactory;

/////////////////////////////////
// Assets
/////////////////////////////////

//tank 0 upgrade assests
Zen_RTS_Asset_East_rhs_uaz_vdv = ["Zen_RTS_F_East_Asset_rhs_uaz_vdv", "UAZ","Cost: 200, Time: 15,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_uaz_open_vdv = ["Zen_RTS_F_East_Asset_rhs_uaz_open_vdv","UAZ (open)", "Cost: 200, Time: 15,"] call Zen_RTS_StrategicAssetCreate;
//tank 1 upgrade assests
Zen_RTS_Asset_East_rhs_tigr_3camo_vmf = ["Zen_RTS_F_East_Asset_rhs_tigr_3camo_vmf", "TIGR","Cost: 800, Time: 15,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_gaz66_ap2_vdv = ["Zen_RTS_F_East_Asset_rhs_gaz66_ap2_vdv", "GAZ","Cost: 1000, Time: 15,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_btr80_vdv = ["Zen_RTS_F_East_Asset_rhs_btr80_vdv", "BTR80","Cost: 2000, Time: 20,"] call Zen_RTS_StrategicAssetCreate;
//tank 2 upgrade assests

Zen_RTS_Asset_East_rhs_brm1k_vdv = ["Zen_RTS_F_East_Asset_rhs_brm1k_vdv", "BRM","Cost: 2500, Time: 20,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_bmp1_vmf = ["Zen_RTS_F_East_Asset_rhs_bmp1_vmf", "BMP1","Cost: 3000, Time: 30,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_bmp2e_vdv = ["Zen_RTS_F_East_Asset_rhs_bmp2e_vdv", "BMP2","Cost: 3500, Time: 30,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_bmp3_late_msv = ["Zen_RTS_F_East_Asset_rhs_bmp3_late_msv", "BMP3-late","Cost: 3600, Time: 30,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_bmp3mera_msv = ["Zen_RTS_F_East_Asset_rhs_bmp3mera_msv", "BMP3","Cost: 3600, Time: 30,"] call Zen_RTS_StrategicAssetCreate;
//tank 3 upgrade assests
Zen_RTS_Asset_East_rhs_bmd1 = ["Zen_RTS_F_East_Asset_rhs_bmd1", "BMD1","Cost: 4000, Time: 30,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_bmd2 = ["Zen_RTS_F_East_Asset_rhs_bmd2", "BMD2","Cost: 4500, Time: 30,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_bmd4ma_vdv = ["Zen_RTS_F_East_Asset_rhs_bmd4ma_vdv", "BMD","Cost: 5000, Time: 30,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_sprut_vdv = ["Zen_RTS_F_East_Asset_rhs_sprut_vdv", "SPURT","Cost: 6000, Time: 30,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_t72bc_tv = ["Zen_RTS_F_East_Asset_rhs_t72bc_tv", "AUTO-T72","Cost: 7000, Time: 45,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_zsu234_aa = ["Zen_RTS_F_East_Asset_rhs_zsu234_aa", "ZSU234-AA","Cost: 7500, Time: 45,"] call Zen_RTS_StrategicAssetCreate;
//tank 4 upgrade assests
Zen_RTS_Asset_East_rhs_t80 = ["Zen_RTS_F_East_Asset_rhs_t80", "T80","Cost: 8000, Time: 45,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_t80a = ["Zen_RTS_F_East_Asset_rhs_t80a", "T80a","Cost: 8500, Time: 45,"] call Zen_RTS_StrategicAssetCreate;
Zen_RTS_Asset_East_rhs_t90_tv = ["Zen_RTS_F_East_Asset_rhs_t90_tv", "T90","Cost: 9000, Time: 45,"] call Zen_RTS_StrategicAssetCreate;

Zen_RTS_Asset_East_CJ = ["Zen_RTS_F_East_Asset_CJ","CJ", "Cost: 5000, Time: 20, Crew: 0,"] call Zen_RTS_StrategicAssetCreate;