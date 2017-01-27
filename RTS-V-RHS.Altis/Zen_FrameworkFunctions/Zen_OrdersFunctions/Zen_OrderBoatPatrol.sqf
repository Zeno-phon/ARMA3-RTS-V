// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_OrderBoatPatrol", _this] call Zen_StackAdd;
private ["_vehicleArray", "_movecenter", "_speedMode", "_mpos", "_limitAnglesSet", "_vehDist", "_cleanupDead", "_crewGroupArray", "_crew", "_positionFilterArgs", "_behavior"];

if !([_this, [["VOID"], ["ARRAY", "OBJECT", "GROUP", "STRING"], ["ARRAY", "SCALAR"], ["ARRAY", "SCALAR"], ["STRING"], ["STRING"], ["BOOL"]], [[], ["ARRAY", "OBJECT", "GROUP", "STRING", "SCALAR"], ["STRING", "ARRAY", "SCALAR"], ["SCALAR", "ARRAY"]], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_vehicleArray = [(_this select 0)] call Zen_ConvertToObjectArray;
_movecenter = _this select 1;

if ((typeName _movecenter == "STRING") && {((markerShape _movecenter) != "ICON")}) then {
    ZEN_STD_Parse_GetArgumentDefault(_positionFilterArgs, 2, [])
} else {
    _defDist = 500;
    ZEN_STD_Parse_GetArgumentDefault(_positionFilterArgs, 2, _defDist)

    if ((typeName _movecenter == "STRING") && {((markerShape _movecenter) == "ICON")}) then {
        _movecenter = [_movecenter] call Zen_ConvertToPosition;
    };
};

ZEN_STD_Parse_GetArgumentDefault(_limitAnglesSet, 3, 0)
ZEN_STD_Parse_GetArgumentDefault(_speedMode, 4, "limited")
ZEN_STD_Parse_GetArgumentDefault(_behavior, 5, "aware")
ZEN_STD_Parse_GetArgumentDefault(_cleanupDead, 6, false)

_vehicleArray = [_vehicleArray] call Zen_ArrayRemoveDead;
_crewGroupArray = [];

{
    private "_veh";
    _veh = _x;
    _crewGroupArray pushBack (group driver _veh);

    #define CALC_POS \
        _mpos = [0,0,0]; \
        if (typeName _movecenter == "STRING") then { \
            _mpos = [_movecenter, 0, _positionFilterArgs , 2, 0, _limitAnglesSet, 0, 0, 0, 0, 0, [1,-10,0]] call Zen_FindGroundPosition; \
        } else { \
            _mpos = [_movecenter, [0, _positionFilterArgs], [], 2, 0, _limitAnglesSet, 0, 0, 0, 0, 0, [1,-10,0]] call Zen_FindGroundPosition; \
        };

    CALC_POS

    (group driver _veh) setCurrentWaypoint ((group driver _veh) addWaypoint [_mpos, -1]);
    (group driver _veh) move _mpos;
    _veh setBehaviour _behavior;
    _veh setCombatMode "Red";
    _veh setSpeedMode _speedMode;
} forEach _vehicleArray;

while {(count _vehicleArray != 0)} do {
    {
        if (isNull _x) then {
            _vehicleArray set [_forEachIndex, 0];
            _crewGroupArray set [_forEachIndex, 0];
        } else {
            private "_veh";
            _veh = _x;
            if (!(alive _veh) || (({alive _x} count crew _veh) == 0)) then {
                _vehicleArray set [_forEachIndex, 0];
                _crew = _crewGroupArray select _forEachIndex;
                _crewGroupArray set [_forEachIndex, 0];
                if (_cleanupDead) then {
                    0 = [_veh, _crew] spawn {
                        sleep 60;
                        deleteVehicle (_this select 0);
                        {
                            deleteVehicle _x;
                        } forEach units (_this select 1);
                    };
                };
            } else {
                if ([_veh] call Zen_IsReady) then {
                    CALC_POS

                    (group driver _veh) setCurrentWaypoint ((group driver _veh) addWaypoint [_mpos, -1]);
                    (group driver _veh) move _mpos;
                    _veh setBehaviour _behavior;
                    _veh setCombatMode "Red";
                    _veh setSpeedMode _speedMode;
                };
            };
        };
    } forEach _vehicleArray;
    0 = [_vehicleArray, 0] call Zen_ArrayRemoveValue;
    0 = [_crewGroupArray, 0] call Zen_ArrayRemoveValue;
    sleep 10;
};

call Zen_StackRemove;
if (true) exitWith {};
