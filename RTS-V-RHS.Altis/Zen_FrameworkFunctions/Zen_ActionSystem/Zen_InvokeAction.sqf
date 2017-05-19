// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkLibrary.sqf"

if !(isServer) exitWith {
    ZEN_FMW_MP_REServerOnly("Zen_InvokeAction", _this, call)
};

_Zen_stack_Trace = ["Zen_InvokeAction", _this] call Zen_StackAdd;
private ["_nameString", "_units", "_actionData", "_text", "_addActionArgs", "_allUnits", "_actionArray", "_args"];

if !([_this, [["STRING"], ["VOID"]], [], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_nameString = _this select 0;
_units = [(_this select 1)] call Zen_ConvertToObjectArray;

_actionData = [_nameString] call Zen_GetActionDataGlobal;
_text = _actionData select 1;
_addActionArgs = _actionData select 4;

_allUnits = [(_actionData select 5) + _units] call Zen_ArrayRemoveDuplicates;

{
    if (toUpper (_x select 0) isEqualTo toUpper _nameString) exitWith {
        _actionArray = _x;
    };
} forEach Zen_Action_Array_Server;

_actionArray set [5, _allUnits];

_args = [_nameString, _units, _text, _addActionArgs];
ZEN_FMW_MP_REAll("Zen_InvokeActionClient", _args, call)

call Zen_StackRemove;
if (true) exitWith {};
