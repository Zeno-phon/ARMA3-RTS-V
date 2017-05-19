// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RemoveActionClient", _this] call Zen_StackAdd;
private ["_index"];

if !([_this, [["SCALAR"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_index = _this select 0;
if (count Zen_Action_Array_Local > _index) then {
    0 = [Zen_Action_Array_Local, _index] call Zen_ArrayRemoveIndex;
};

call Zen_StackRemove;
if (true) exitWith {};
