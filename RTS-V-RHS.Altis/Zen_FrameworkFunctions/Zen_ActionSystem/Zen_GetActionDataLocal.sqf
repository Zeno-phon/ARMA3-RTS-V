// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_GetActionDataLocal", _this] call Zen_StackAdd;
private ["_nameString", "_actionArray"];

if !([_this, [["STRING"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    ([])
};

_nameString = _this select 0;

_actionArray = [];
{
    if (toUpper (_x select 0) isEqualTo toUpper _nameString) exitWith {
        _actionArray = _x;
    };
} forEach Zen_Action_Array_Local;

call Zen_StackRemove;
(_actionArray)
