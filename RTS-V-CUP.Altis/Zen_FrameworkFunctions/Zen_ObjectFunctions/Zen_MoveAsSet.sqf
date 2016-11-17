// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_StandardLibrary.sqf"

_Zen_stack_Trace = ["Zen_MoveAsSet", _this] call Zen_StackAdd;
private ["_moveEntities", "_moveObjects", "_newCenter", "_avgCenter", "_moveMarkers", "_newPos"];

if !([_this, [["VOID"], ["VOID"]], [], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_moveEntities = _this select 0;
_newCenter = [(_this select 1)] call Zen_ConvertToPosition;

if (typeName _moveEntities != "ARRAY") then {
    _moveEntities = [_moveEntities];
};

_moveMarkers = [_moveEntities, ""] call Zen_ArrayGetType;

_moveObjects = [_moveEntities, {typeName _this == "STRING"}, true] call Zen_ArrayFilterCondition;
_moveObjects = [_moveObjects] call Zen_ConvertToObjectArray;

0 = [_moveObjects, _moveMarkers] call Zen_ArrayAppendNested;
_avgCenter = _moveObjects call Zen_FindAveragePosition;
_lowestHeight = (getPosATL ([_moveObjects, {-((getPosATL _this) select 2)}] call Zen_ArrayFindExtremum)) select 2;

{
    _newPos = [_newCenter, ([_avgCenter, _x] call Zen_Find2dDistance), ([_avgCenter, _x] call Zen_FindDirection), "trig", (_newCenter select 2)] call Zen_ExtendVector;
    if (typeName _x == "STRING") then {
        _x setMarkerPos _newPos;
    } else {
        0 = [_x, _newPos, ((getPosATL _x) select 2) - _lowestHeight, 0, (getDir _x), true] call Zen_TransformObject;
    };
} forEach _moveObjects;

call Zen_StackRemove;
if (true) exitWith {};
