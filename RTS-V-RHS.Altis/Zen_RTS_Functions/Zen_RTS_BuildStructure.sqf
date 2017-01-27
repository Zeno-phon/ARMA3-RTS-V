//

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

#define HQ_MAX_DIST 500

#define ZEN_RTS_STRATEGIC_GET_BUILDING_OBJ_ID(N, I) \
    _objIndexes = [Zen_RTS_Strategic_Building_Objects_Global, N, 0] call Zen_ArrayGetNestedIndex; \
    I = ""; \
    if (count _objIndexes > 0) then { \
        _objData = Zen_RTS_Strategic_Building_Objects_Global select (_objIndexes select 0); \
        I = _objData select 1; \
    };

#define BB_Volume(O) (ZEN_STD_OBJ_BBX(O) * ZEN_STD_OBJ_BBY(O) * ZEN_STD_OBJ_BBZ(O))
#define BB_AreaXY(O) (ZEN_STD_OBJ_BBX(O) * ZEN_STD_OBJ_BBY(O))

0 = _this spawn {
    _Zen_stack_Trace = ["Zen_RTS_BuildStructure", _this] call Zen_StackAdd;
    _idc = _this;

    _index = lbCurSel _idc;
    _text = lbText [_idc, _index];
    _type = lbData [_idc, _index];

    _buildingObjs = [Zen_RTS_Strategic_Building_Objects_Global, _type, 0] call Zen_ArrayGetNestedIndex;
    if ((count _buildingObjs > 0) && {!(_type in [Zen_RTS_BuildingType_West_CJ, Zen_RTS_BuildingType_East_CJ])}) exitWith {
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

        if ((([vehicle player, _HQObject] call Zen_Find2dDistance) > HQ_MAX_DIST) && {!(_isNaval)}) exitWith {
            player sideChat "This building must be constructed within " + str HQ_MAX_DIST + " meters of the HQ.";
            _exit = true;
        };
    };

    if (_exit) exitWith {};
    cLoseDialog 0;
    playerMoney = playerMoney - _cost;

    _buildingPreviewType = [_buildingTypeData select 5, "Classname: ", ","] call Zen_StringGetDelimitedPart;
    if (_buildingPreviewType == "") then {
        _buildingPreviewType = "Land_HelipadCivil_F";
    };

    _safezoneMarkers = RTS_Building_Spawn_Grid_Markers select ([west, east] find (side player));

    hintSilent "When the preview appears,\nplacement is valid\nUse confirm action to build";
    _vehicle = vehicle player;
    _heliPad = _buildingPreviewType createVehicleLocal ([_vehicle, 31, getDir _vehicle, "compass", 0] call Zen_ExtendVector);

    // _modelCenter = _heliPad modelToWorld [0,0,0];
    // _heliPad attachTo [_vehicle, [0, 31, (_modelCenter select 2) - 2]];

    Zen_RTS_Show_Preview = true;
    // player addAction ["Confirm Building Placement", {Zen_RTS_Show_Preview = false; (_this select 0) removeAction (_this select 2);}];

    _emptyDialog = [] call Zen_CreateDialog;
    0 = [_emptyDialog, [0,0]] call Zen_InvokeDialog;

    _cam = "camera" camCreate [0,0,0];
    _cam cameraEffect ["internal","back"];
    _cam camSetTarget player;
    _cam camSetRelPos [0, 1, 75];
    _cam camCommit 0;

    player sideChat "Press any key to place.";
    (findDisplay 76) displayAddEventHandler ["KeyDown", {
        Zen_RTS_Show_Preview = false;
        (true)
    }];

    scopeName "main";
    while {true} do {
        // _pos = getPosATL _heliPad;
        _pos = screenToWorld getMousePosition;

        _inSafezone = false;
        {
            if ([_pos, _x] call Zen_IsPointInPoly) exitWith {
                _inSafezone = true;
            };
        } forEach _safezoneMarkers;

        _slope = 90 - (([_pos, 15] call Zen_FindTerrainGradient) select 2);
        _clutter = [_pos, 15] call Zen_GetAmbientClutterCount;
        _objects = (nearestTerrainObjects[_pos, ["Building", "House", "Church", "Chapel", "Bunker", "Fortress", "Fountain", "View-Tower", "Lighthouse", "FuelStation", "Hospital", "Wall", "WaterTower"], 30, false]) + (nearestObjects [_pos, ["Land", "Air"], 10]);
        0 = [_objects, _heliPad] call Zen_ArrayRemoveValue;

        {
            if ((BB_Volume(_x) < 4) || (BB_AreaXY(_x) < 1)) then {
                _objects set [_forEachIndex, 0];
            };
        } forEach _objects;
        0 = [_objects, 0] call Zen_ArrayRemoveValue;

        // player sidechat "--------";
        // player sidechat str _slope;
        // player sidechat str _clutter;
        // player sidechat str _objects;
        // player sidechat str _safezoneMarkers;
        // player sidechat str _inSafezone;
        _canPlace = (if (_isNaval) then {
            (!(_inSafezone) && (!(surfaceIsWater _pos) && {([_pos, 10, "water"] call Zen_IsNearTerrain)}) && {((_slope < 15) && {(((count _objects) + (_clutter vectorDotProduct [1, 0, 0])) < 1)})})
        } else {
            (!(_inSafezone) && (!(surfaceIsWater _pos) && {!([_pos, 35, "water"] call Zen_IsNearTerrain)}) && {((_slope < 15) && {(((count _objects) + (_clutter vectorDotProduct [1, 0, 0])) < 1)} && {(([_pos, _HQObject] call Zen_Find2dDistance) < HQ_MAX_DIST)})})
        });

        if (_canPlace) then {
            if (_isNaval) then {
                _heliPad setPosASL _pos;
            } else {
                _heliPad setPosATL _pos;
            };

            _heliPad hideObject false;
            _heliPad setVectorUp (surfaceNormal (getPosATL _heliPad));

            if !(Zen_RTS_Show_Preview) then {
                deleteVehicle _heliPad;
                _level = 0;
                _index = [_type, (RTS_Used_Building_Types select 0)] call Zen_ValueFindInArray;
                if (_index == -1) then {
                    _index = [_type, (RTS_Used_Building_Types select 1)] call Zen_ValueFindInArray;
                    _level = (RTS_Building_Type_Levels select 1) select _index;
                } else {
                    _level = (RTS_Building_Type_Levels select 0) select _index;
                };

                _args = [_type, [_pos, _level, getDir _vehicle]];
                ZEN_FMW_MP_REServerOnly("Zen_RTS_StrategicBuildingInvoke", _args, spawn)
                breakTo "main";
            };
        } else {
            if ((([_pos, _HQObject] call Zen_Find2dDistance) > HQ_MAX_DIST) && {!(_isNaval)}) then {
                hintSilent ("Placing this building more than " + str HQ_MAX_DIST + " meters from the HQ is not allowed.");
            };

            _heliPad setPosATL [0,0,10];
            _heliPad hideObject true;
            if !(Zen_RTS_Show_Preview) then {
                player sideChat "Building here is not allowed";
                breakTo "main";
            };
        };
        ZEN_STD_Code_SleepFrames(2)
    };

    call Zen_CloseDialog;
    player switchCamera "INTERNAL";
    player cameraEffect ["terminate","back"];
    camDestroy _cam;

    call Zen_StackRemove;
    if (true) exitWith {};
};

if (true) exitWith {};
