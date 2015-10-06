//

#include "Zen_StandardLibrary.sqf"
#include "Zen_FrameworkLibrary.sqf"

#define ZEN_RTS_STRATEGIC_GET_BUILDING_OBJ_ID(N, I) \
    _objIndexes = [Zen_RTS_Strategic_Building_Objects_Global, N, 0] call Zen_ArrayGetNestedIndex; \
    I = ""; \
    if (count _objIndexes > 0) then { \
        _objData = Zen_RTS_Strategic_Building_Objects_Global select (_objIndexes select 0); \
        I = _objData select 1; \
    };

0 = _this spawn {
    _Zen_stack_Trace = ["Zen_RTS_BuildStructure", _this] call Zen_StackAdd;
    _idc = _this;

    _index = lbCurSel _idc;
    _text = lbText [_idc, _index];
    _type = lbData [_idc, _index];

    _buildingObjs = [Zen_RTS_Strategic_Building_Objects_Global, _type, 0] call Zen_ArrayGetNestedIndex;
    if (count _buildingObjs > 0) exitWith {
        player sideChat "This building type has already been constructed.";
    };

    _buildingTypeData = [_type] call Zen_RTS_StrategicBuildingTypeGetData;
    _buildingType = _buildingTypeData select 0;

    _descrRaw = _buildingTypeData select 5;
    _cost = call compile  ([_descrRaw, "Cost: ", ","] call Zen_StringGetDelimitedPart);
    if (playerMoney < _cost) exitWith {
        player sideChat "Insufficient funds.";
    };

    _buildingTypeHQ = missionNamespace getVariable ("Zen_RTS_BuildingType_" + (str side player) + "_HQ");
    ZEN_RTS_STRATEGIC_GET_BUILDING_OBJ_ID(_buildingTypeHQ, _ID)

    _isNaval = (_buildingTypeData select 4) isEqualTo "Naval Factory";
    _exit = false;
    _HQObject = vehicle player;
    if (_type != _buildingTypeHQ) then {
        if (_ID == "") exitWith {
            player sideChat "HQ must be built first.";
            _exit = true;
        };

        _buildingObjData = [_ID] call Zen_RTS_StrategicBuildingObjectGetDataGlobal;
        _HQObject = _buildingObjData select 2;
        if (isNull _HQObject) exitWith {
            player sideChat "HQ is not finished building.";
            _exit = true;
        };

        if ((([vehicle player, _HQObject] call Zen_Find2dDistance) > 200) && {!(_isNaval)}) exitWith {
            player sideChat "This building must be constructed within 200 meters of the HQ.";
            _exit = true;
        };
    };

    if (_exit) exitWith {};
    cLoseDialog 0;
    playerMoney = playerMoney - _cost;

    hintSilent "When helipad appears,\nbuilding placement is valid\nUse confirm action to build";
    _heliPad = "Land_HelipadCivil_F" createVehicleLocal [0,0,0];
    _vehicle = vehicle player;

    Zen_RTS_Show_Preview = true;
    player addAction ["Confirm Building Placement", {Zen_RTS_Show_Preview = false; (_this select 0) removeAction (_this select 2);}];

    _objectType = [_descrRaw, "Classname", ","] call Zen_StringGetDelimitedPart;
    _objectType = if (_objectType == "") then {("Land_HelipadCivil_F")};

    scopeName "main";
    while {true} do {
        _pos = [_vehicle, 25, getDir _vehicle, "compass", 0] call Zen_ExtendPosition;

        _slope = [_pos, 15] call Zen_FindTerrainSlope;
        _clutter = [_pos, 20] call Zen_GetAmbientClutterCount;
        _objects = nearestObjects [_pos, [""], 20];

        _bool = (if (_isNaval) then {
            // player sidechat "--------";
            // player sidechat str (!(surfaceIsWater _pos));
            // player sidechat str (([_pos, 25, "water"] call Zen_IsNearTerrain));
            // player sidechat str (((_slope < 10) && (count _objects < 2) && {((_clutter vectorDotProduct [1, 1, 0]) < 2)}));
            ((!(surfaceIsWater _pos) && {([_pos, 25, "water"] call Zen_IsNearTerrain)}) && {((_slope < 10) && (count _objects < 2) && {((_clutter vectorDotProduct [1, 1, 0]) < 2)})})
        } else {
            ((!(surfaceIsWater _pos) && {!([_pos, 25, "water"] call Zen_IsNearTerrain)}) && {((_slope < 10) && (count _objects < 2) && {((_clutter vectorDotProduct [1, 1, 0]) < 2)} && {(([_pos, _HQObject] call Zen_Find2dDistance) < 200)})})
            // ((_slope < 10) && (count _objects < 2) && {((_clutter vectorDotProduct [1, 1, 0]) < 2)} && {(([_pos, _HQObject] call Zen_Find2dDistance) < 200)})
        });
        if (_bool) then {
            if (_isNaval) then {
                _heliPad setPosASL _pos;
            } else {
                _heliPad setPosATL _pos;
            };

            if !(Zen_RTS_Show_Preview) then {
                _level = 0;
                _index = [_type, (RTS_Used_Building_Types select 0)] call Zen_ValueFindInArray;
                if (_index == -1) then {
                    _index = [_type, (RTS_Used_Building_Types select 1)] call Zen_ValueFindInArray;
                    _level = (RTS_Building_Type_Levels select 1) select _index;
                } else {
                    _level = (RTS_Building_Type_Levels select 0) select _index;
                };

                _args = [_type, [_pos, _level]];
                ZEN_FMW_MP_REServerOnly("Zen_RTS_StrategicBuildingInvoke", _args, call)
                breakTo "main";
            };
        } else {
            if ((([_pos, _HQObject] call Zen_Find2dDistance) > 200) && {!(_isNaval)}) then {
                hintSilent "Placing this building more than 200m from the HQ is not allowed.";
            };
            _heliPad setPosATL [0,0,0];
            if !(Zen_RTS_Show_Preview) then {
                player sideChat "Building here is not allowed";
                breakTo "main";
            };
        };

        ZEN_STD_Code_SleepFrames(2)
    };

    deleteVehicle _heliPad;
    call Zen_StackRemove;
    if (true) exitWith {};
};

if (true) exitWith {};
