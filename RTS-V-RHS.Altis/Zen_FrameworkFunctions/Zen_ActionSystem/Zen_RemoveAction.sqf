// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkLibrary.sqf"

if !(isServer) exitWith {
    ZEN_FMW_MP_REServerOnly("Zen_RemoveAction", _this, call)
};

_Zen_stack_Trace = ["Zen_RemoveAction", _this] call Zen_StackAdd;
private ["_nameString", "_index"];

if !([_this, [["STRING"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_nameString = _this select 0;

_index = -1;
{
    if (toUpper (_x select 0) isEqualTo toUpper _nameString) exitWith {
        if (count (_x select 5) == 0) then {
            _index = _forEachIndex;
        } else {
            _index = -2;
        };
    };
} forEach Zen_Action_Array_Server;

if (_index == -1) exitWith {
    ZEN_FMW_Code_ErrorExitVoid("Zen_RemoveAction", "Given action does not exist.")
};

if (_index == -2) exitWith {
    ZEN_FMW_Code_ErrorExitVoid("Zen_RemoveAction", "This action is assigned to objects and cannot be removed, use Zen_DeleteAction.")
};

0 = [Zen_Action_Array_Server, _index] call Zen_ArrayRemoveIndex;

_args = [_index];
ZEN_FMW_MP_REAll("Zen_RemoveActionClient", _args, call)

call Zen_StackRemove;
if (true) exitWith {};
