// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_GetObjectActions", _this] call Zen_StackAdd;
private ["_actions", "_obj"];

if !([_this, [["OBJECT"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    ([])
};

_obj = _this select 0;

_actions = [];
if (isServer) then {
    {
        if (_obj in (_x select 5)) then {
            _actions pushBack (_x select 0);
        };
    } forEach Zen_Action_Array_Server;
} else {
    {
        if (_obj in (_x select 1)) then {
            _actions pushBack (_x select 0);
        };
    } forEach Zen_Action_Array_Local;
};

call Zen_StackRemove;
(_actions)
