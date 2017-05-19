// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_GetActionArguments", _this] call Zen_StackAdd;
private ["_actionData", "_args", "_nameString"];

// if !([_this, [], [], 1] call Zen_CheckArguments) exitWith {
    // call Zen_StackRemove;
// };

// _activator = _this select 0;
// _host = _this select 1;
// _id = _this select 2;
_nameString = _this select 3;

_actionData = [_nameString] call Zen_GetActionDataGlobal;

_args = (_actionData select 3);
if (typeName _args != "ARRAY") then {
    _args = [_args];
};

0 = (([_this, 0, 1] call Zen_ArrayGetIndexedSlice) + _args + [_nameString]) spawn (missionNamespace getVariable (_actionData select 2));

call Zen_StackRemove;
if (true) exitWith {};
