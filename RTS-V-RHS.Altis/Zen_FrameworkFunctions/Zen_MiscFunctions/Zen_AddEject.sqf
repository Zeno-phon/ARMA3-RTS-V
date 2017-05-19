// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkLibrary.sqf"

if !(isServer) exitWith {
    ZEN_FMW_MP_REServerOnly("Zen_AddEject", _this, call)
};

_Zen_stack_Trace = ["Zen_AddEject", _this] call Zen_StackAdd;
private ["_units"];

if !([_this, [["VOID"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_units = [(_this select 0)] call Zen_ConvertToObjectArray;

if (Zen_AddEject_Action_ID == "") then {
    Zen_AddEject_Action_ID = ["<t color='#2D8CE0'>Eject</t>", "Zen_AddEject_Action", [], [6, false, true, "", "(_this in _target) && !(_this in (assignedCargo _target))"]] call Zen_CreateAction;
};

0 = [Zen_AddEject_Action_ID, _units] call Zen_InvokeAction;

call Zen_StackRemove;
if (true) exitWith {};
