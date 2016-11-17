//

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

GetSideID = {
    (0)
};

GetClientID = {
    (0)
};

GetNamespace = {
    (0)
};

Zen_RTS_F_RequestEconomyData = {
    (owner _this) publicVariableClient "Zen_RTS_Economy_Data";
};

Zen_RTS_F_RespawnActions = {
    // player sideChat "Respawn Actions Running";
    while {true} do {
        0 = [player] spawn Zen_RTS_DeployPlayer;

        waitUntil {
            sleep 2;
            (alive player)
        };

        0 = [player, player, 0] spawn RTS_FNC_INIT_PLAYERACTIONS;

        waitUntil {
            sleep 2;
            !(alive player)
        };
    };
};

Zen_RTS_F_ModifyMoney = {
    playerMoney = playerMoney + _this;
};

Zen_RTS_F_SetMoney = {
    playerMoney = _this;
};

Zen_RTS_F_PrintMoney = {
    _moneyPerMinute = _this select 0;
    _supply = _this select 1;
    _supplyPerMinute = _this select 2;
    _side = _this select 3;

    if ((side player) == _side) then {
        ctrlSetText [idMoney, format ["Funds : %1 +%2/min", floor playerMoney, _moneyPerMinute]];
        ctrlSetText [idSupply, format ["Supply: %1 +%2/min", floor _supply, _supplyPerMinute]];
        ctrlSetText [idFPS, format ["FPS: %1", round diag_fps]];
    };
};

Zen_RTS_F_CommanderQueueAdd = {
    _unit = _this select 0;
    _side = _this select 1;

    _subArray = Zen_RTS_CommanderQueue select ([west, east] find _side);
    _subArray pushBack _unit;
};

Zen_RTS_F_GiveMoneyDialogOK = {
    _moneyString = _this select 0;
    _receivingPlayer = _this select 1;

    _invalidEntry = false;
    if (count toArray _moneyString == 0) then {
        _invalidEntry = true;
    } else {
        {
            if (_x < 48 || _x > 57) exitWith {
                _invalidEntry = true;
            };
        } forEach (toArray _moneyString);
    };

    if (_invalidEntry) exitWith {
        player groupChat "Invalid characters entered.";
        // 0 = [] call Zen_RefreshDialog;
    };

    _money = call compile _moneyString;

    if (_money > playerMoney) exitWith {
        player groupChat "You don't have that much money.";
        // 0 = [] call Zen_RefreshDialog;
    };

    (-_money) call Zen_RTS_F_ModifyMoney;
    ZEN_FMW_MP_REClient("Zen_RTS_F_ModifyMoney", _money, call, _receivingPlayer)

    player groupChat ("You donated $" + str _money + " to " + name _receivingPlayer);
    0 = [] call Zen_CloseDialog;
    0 = [] spawn Zen_RTS_AlphaMenu;
};

Zen_RTS_F_GiveMoneyDialogCancel = {
    0 = [] call Zen_CloseDialog;
    0 = [] spawn Zen_RTS_AlphaMenu;
};

Zen_RTS_F_GiveMoneyDialogRefresh = {
    0 = [] call Zen_CloseDialog;
    0 = [] spawn Zen_RTS_GiveMoney;
};

Zen_RTS_F_AddSpawnGridMarker = {
    _marker = _this select 0;
    _side = _this select 1;

    if (isNil "RTS_Building_Spawn_Grid_Markers") then {
        RTS_Building_Spawn_Grid_Markers = [[], []];
    };

    (RTS_Building_Spawn_Grid_Markers select ([west, east] find _side)) pushBack _marker;
};

Zen_RTS_F_RemoveSpawnGridMarker = {
    _marker = _this select 0;
    _side = _this select 1;

    0 = [(RTS_Building_Spawn_Grid_Markers select ([west, east] find _side)), _marker] call Zen_ArrayRemoveValue;
};

Zen_RTS_F_AddRecycleQueue = {
    _vehicle = _this select 0;
    (RTS_Recycle_Queue select (([west, east] find ([_vehicle] call Zen_GetSide)) max 0)) pushBack _vehicle;
};

Zen_RTS_F_RemoveRepairQueue = {
    _building = _this select 0;
    _side = _this select 1;

    0 = [(RTS_Repair_Queue select ([west, east] find _side)), _building] call Zen_ArrayRemoveValue;
};

// Zen_RTS_F_RemoveRecycleQueue = {
    // _vehicle = _this select 0;
    // _side = _this select 1;

    // 0 = [(RTS_Recycle_Queue select ([west, east] find _side)), _vehicle] call Zen_ArrayRemoveValue;
// };

Zen_RTS_F_StrategicBuildingVisualLocal = {
    _dir = _this select 0;
    _buildingTypeData = _this select 1;
    _spawnPos = _this select 2;
    _type = _this select 3;
    _offset = _this select 4;
    _buildingType = _this select 5;
    _commanderSide = _this select 6;

    _building = _type createVehicleLocal _spawnPos;
    _building setDir _dir;

    _building setVectorUp (surfaceNormal _spawnPos);
    _height = abs(ZEN_STD_OBJ_BBZ(_building));
    ZEN_STD_OBJ_TransformATL(_building, 0, 0, -(_height))
    _orgPos = getPosATL _building;

    _commander = call compile (str _commanderSide + "Commander");
    _supply = [_commander] call Zen_RTS_F_EconomyGetPlayerSupply;
    _times = [_buildingType] call Zen_RTS_F_StrategicGetBuildTimesBuilding;
    _buildTimeOld = (_times + [_supply]) call Zen_RTS_F_EconomyStrategicBuildTime;
    _buildTimeRemainingOld = _buildTimeOld;

    while {true} do {
        sleep 2;
        _commander = call compile (str _commanderSide + "Commander");
        if (alive _commander) then {
            _supply = [_commander] call Zen_RTS_F_EconomyGetPlayerSupply;
        };

        _buildTimeRemainingOld = _buildTimeRemainingOld - 2;
        _buildTimeCurrent = (_times + [_supply]) call Zen_RTS_F_EconomyStrategicBuildTime;

        _buildTimeRemainingCurrent = _buildTimeCurrent * _buildTimeRemainingOld / _buildTimeOld;

        if (_buildTimeRemainingCurrent <= 1) exitWith {};

        _buildTimeOld = _buildTimeCurrent;
        _buildTimeRemainingOld = _buildTimeRemainingCurrent;

        if !(alive _building) exitWith {};
        _building setPosATL (_orgPos vectorAdd [0, 0, abs((1-(_buildTimeRemainingOld / _buildTimeOld)) * (_height + _offset))]);
    };

    sleep 1;
    deleteVehicle _building;
};

Zen_RTS_F_EconomyKilledEH = {
    _unit = _this select 0;
    _killer = _this select 1;

    if ((count _this > 2) && {!(isNull (_this select 2))}) then {
        _killer = _this select 2;
    };

    if (side _killer != side _unit) then {
        _args = [_unit, _killer];
        ZEN_FMW_MP_REClient("Zen_RTS_F_EconomyKillerReward", _args, call, _killer)
    };
};

Zen_RTS_F_EconomyStoreKillsServer = {
    _obj = _this select 0;
    _kills = _this select 1;

    _obj setVariable ["Zen_RTS_LocalKills", _kills];
};

Zen_RTS_F_EconomyHandleDisconnect = {
    _unit = _this select 0;

    _sideKillCounts = (Zen_RTS_TotalKills select ([west, east] find (side _unit)));
    _localKills = _unit getVariable "Zen_RTS_LocalKills";

    for "_i" from 0 to 3 do {
        _sideKillCounts set [_i, (_sideKillCounts select _i) - (_localKills select _i)];
    };
    publicVariable "Zen_RTS_TotalKills";
};

Zen_RTS_F_AddSubTerritoryCaptured = {
    Zen_RTS_CapturedSubTerritories pushBack _this;
};

Zen_RTS_F_RemoveSubTerritoryCaptured = {
    [Zen_RTS_CapturedSubTerritories, _this] call Zen_ArrayRemoveValue;
};

Zen_RTS_F_EconomyKillerReward = {
    _unit = _this select 0;
    _killer = _this select 1;

    _sideKillCounts = (Zen_RTS_TotalKills select ([west, east] find (side _killer)));
    switch (true) do {
        case ((isPlayer _unit) && (isPlayer _killer)): {
            100 call Zen_RTS_F_ModifyMoney;
            _sideKillCounts set [0, (_sideKillCounts select 0) + 1];
            Zen_RTS_LocalKills set [0, (Zen_RTS_LocalKills select 0) + 1];
        };
        case ((isPlayer _killer) && !(isPlayer _unit)): {
            50 call Zen_RTS_F_ModifyMoney;
            _sideKillCounts set [1, (_sideKillCounts select 1) + 1];
            Zen_RTS_LocalKills set [1, (Zen_RTS_LocalKills select 1) + 1];
        };
        case (!(isPlayer _killer) && (isPlayer _unit)): {
            100 call Zen_RTS_F_ModifyMoney;
            _sideKillCounts set [2, (_sideKillCounts select 2) + 1];
            Zen_RTS_LocalKills set [2, (Zen_RTS_LocalKills select 2) + 1];
        };
        case (!(isPlayer _unit) && !(isPlayer _killer)): {
            50 call Zen_RTS_F_ModifyMoney;
            _sideKillCounts set [3, (_sideKillCounts select 3) + 1];
            Zen_RTS_LocalKills set [3, (Zen_RTS_LocalKills select 3) + 1];
        };
    };

    player setVariable ["Zen_RTS_LocalKills", Zen_RTS_LocalKills];
    _args = [player, Zen_RTS_LocalKills];
    ZEN_FMW_MP_REServerOnly("Zen_RTS_F_EconomyStoreKillsServer", _args, call)

    publicVariable "Zen_RTS_TotalKills";
    _args = [(side _killer)];
    ZEN_FMW_MP_REAll("Zen_RTS_F_EconomyComputeSupply", _args, call)
};

Zen_RTS_F_EconomyComputeSupply = {
    if (isDedicated || !(hasInterface)) exitWith {};
    _side = _this;

    if ((side player) in _side) then {
        _sideKillCounts = (Zen_RTS_TotalKills select ([west, east] find (side player)));

        #define CATCH_ZERO(V, I) \
            if ((_sideKillCounts select I) == 0) then { \
                V = 0; \
            } else { \
                V = (Zen_RTS_LocalKills select I) / (_sideKillCounts select I); \
            };

        private ["_PvPFraction", "_PvAIFraction","_AIvPFraction", "_AIvAIFraction", "_subTerrFraction"];
        CATCH_ZERO(_PvPFraction, 0)
        CATCH_ZERO(_PvAIFraction, 1)
        CATCH_ZERO(_AIvPFraction, 2)
        CATCH_ZERO(_AIvAIFraction, 3)

        _sideHash = [[0,2], [2,4]] select ([west, east] find (side player));
        _terrFraction = (count ([[1], [_sideHash], [{(switch (_this) do { case west : {(1)}; case east : {(3)}; default {(-1)}; })}]] call Zen_RTS_TerritorySearch)) / (count ([[1], [[0, 2]], [{1}]] call Zen_RTS_TerritorySearch));

        _sideSubTerrCount = count ([[1], [_sideHash], [{(switch (_this) do { case west : {(1)}; case east : {(3)}; default {(-1)}; })}]] call Zen_RTS_SubTerritorySearch);
        if (_sideSubTerrCount == 0) then {
            _subTerrFraction = 0;
        } else {
            _subTerrFraction = (count Zen_RTS_CapturedSubTerritories) / _sideSubTerrCount;
        };

        playerSupply = (1/124) * (9*_PvPFraction + 3*_PvAIFraction + 3*_AIvPFraction + _AIvAIFraction + 27*_terrFraction + 81*_subTerrFraction)
    };
};

Zen_RTS_F_EconomyStrategicBuildTime = {
    private ["_supply", "_tMax", "_tMin"];

    _tMin = _this select 0;
    _tMax = _this select 1;

    _N = 2;
    ZEN_STD_Parse_GetArgumentDefault(_supply, 2, playerSupply)
    ((_tMin - _tMax) / (2^(-_N) - 1) * (_supply + 1)^(-_N) + _tMax - (_tMin - _tMax) / (2^(-_N) - 1))
};

Zen_RTS_F_EconomyGetPlayerSupply = {
    _player = _this select 0;

    Zen_RTS_Economy_Supply = nil;
    ZEN_FMW_MP_REClient("Zen_RTS_F_EconomyGetPlayerSupplyRE", [], call, _player)

    waitUntil {
        !(isNil "Zen_RTS_Economy_Supply")
    };

    (Zen_RTS_Economy_Supply)
};

Zen_RTS_F_EconomyGetPlayerSupplyRE = {
    Zen_RTS_Economy_Supply = playerSupply;
    publicVariable "Zen_RTS_Economy_Supply";
};

Zen_RTS_F_EconomyStrategicBuildDelayBuilding = {
    private ["_building", "_times", "_buildTimeCurrent", "_buildTimeRemainingOld", "_buildTimeOld", "_buildTimeRemainingCurrent", "_supply", "_commanderSide", "_commander"];

    _building = _this select 0;
    _commanderSide = _this select 1;

    if (typeName _commanderSide == "SIDE") then {
        _commander = call compile (str _commanderSide + "Commander");
    } else {
        _commander = player;
    };

    _supply = [_commander] call Zen_RTS_F_EconomyGetPlayerSupply;
    _times = [_building] call Zen_RTS_F_StrategicGetBuildTimesBuilding;
    _buildTimeOld = (_times + [_supply]) call Zen_RTS_F_EconomyStrategicBuildTime;
    _buildTimeRemainingOld = _buildTimeOld;

    while {true} do {
        sleep 2;

        if (typeName _commanderSide == "SIDE") then {
            _commander = call compile (str _commanderSide + "Commander");
            if (alive _commander) then {
                _supply = [_commander] call Zen_RTS_F_EconomyGetPlayerSupply;
            };
        } else {
            _commander = player;
        };

        _buildTimeRemainingOld = _buildTimeRemainingOld - 2;
        _buildTimeCurrent = (_times + [_supply]) call Zen_RTS_F_EconomyStrategicBuildTime;

        _buildTimeRemainingCurrent = _buildTimeCurrent * _buildTimeRemainingOld / _buildTimeOld;

        if (_buildTimeRemainingCurrent <= 1) exitWith {};

        _buildTimeOld = _buildTimeCurrent;
        _buildTimeRemainingOld = _buildTimeRemainingCurrent;
    };
};

Zen_RTS_F_EconomyStrategicBuildDelayAsset = {
    private ["_asset", "_times", "_buildTimeCurrent", "_buildTimeRemainingOld", "_buildTimeOld", "_buildTimeRemainingCurrent"];

    _asset = _this select 0;

    _times = [_asset] call Zen_RTS_F_StrategicGetBuildTimesAsset;
    _buildTimeOld = _times call Zen_RTS_F_EconomyStrategicBuildTime;
    _buildTimeRemainingOld = _buildTimeOld;

    while {true} do {
        sleep 2;
        _buildTimeRemainingOld = _buildTimeRemainingOld - 2;
        _buildTimeCurrent = _times call Zen_RTS_F_EconomyStrategicBuildTime;

        _buildTimeRemainingCurrent = _buildTimeCurrent * _buildTimeRemainingOld / _buildTimeOld;

        if (_buildTimeRemainingCurrent <= 1) exitWith {};

        _buildTimeOld = _buildTimeCurrent;
        _buildTimeRemainingOld = _buildTimeRemainingCurrent;
    };
};

Zen_RTS_F_StrategicGetBuildTimesBuilding = {
    private ["_building", "_descrRaw", "_tMax", "_tMin"];
    _building = _this select 0;

    _descrRaw = ([_building] call Zen_RTS_StrategicBuildingTypeGetData) select 5;

    _tMax = [_descrRaw, "Max Time: ", ","] call Zen_StringGetDelimitedPart;
    if (_tMax == "") then {
        _tMax = [_descrRaw, "Time: ", ","] call Zen_StringGetDelimitedPart;
        _tMax = call compile _tMax;
        _tMin = _tMax / 2;
    } else {
        _tMin = [_descrRaw, "Min Time: ", ","] call Zen_StringGetDelimitedPart;
        _tMax = call compile _tMax;
        _tMin = call compile _tMin;
    };

    ([_tMin, _tMax])
};

Zen_RTS_F_StrategicGetBuildTimesAsset = {
    private ["_asset", "_descrRaw", "_tMax", "_tMin"];
    _asset = _this select 0;

    _descrRaw = ([_asset] call Zen_RTS_StrategicAssetGetData) select 3;

    _tMax = [_descrRaw, "Max Time: ", ","] call Zen_StringGetDelimitedPart;
    if (_tMax == "") then {
        _tMax = [_descrRaw, "Time: ", ","] call Zen_StringGetDelimitedPart;
        _tMax = call compile _tMax;
        _tMin = _tMax / 2;
    } else {
        _tMin = [_descrRaw, "Min Time: ", ","] call Zen_StringGetDelimitedPart;
        _tMax = call compile _tMax;
        _tMin = call compile _tMin;
    };

    ([_tMin, _tMax])
};
