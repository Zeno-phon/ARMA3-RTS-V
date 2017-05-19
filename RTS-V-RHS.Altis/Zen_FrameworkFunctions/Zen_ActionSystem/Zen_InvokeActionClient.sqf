// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkLibrary.sqf"

if (isDedicated || !hasInterface) exitWith {};

_Zen_stack_Trace = ["Zen_InvokeActionClient", _this] call Zen_StackAdd;
private ["_nameString", "_objs", "_text", "_addActionArgs", "_idsArray", "_id", "_actionDataLocal"];

if !([_this, [["STRING"], ["ARRAY"], ["STRING"], ["ARRAY"]], [], 4] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_nameString = _this select 0;
_objs = _this select 1;
_text = _this select 2;
_addActionArgs = _this select 3;

_idsArray = [];
{
    _id = _x addAction ([_text, Zen_GetActionArguments, _nameString] + _addActionArgs);
    _idsArray pushBack _id;
} forEach _objs;

_actionDataLocal = [_nameString] call Zen_GetActionDataLocal;

if (count _actionDataLocal == 0) then {
    Zen_Action_Array_Local pushBack [_nameString, _objs, _idsArray];
} else {
    (_actionDataLocal select 1) append _objs;
    (_actionDataLocal select 2) append _idsArray;
};

call Zen_StackRemove;
if (true) exitWith {};
