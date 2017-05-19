// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkLibrary.sqf"

if !(isServer) exitWith {
    ZEN_FMW_MP_REServerOnly("Zen_AddFastRope", _this, call)
};

_Zen_stack_Trace = ["Zen_AddFastRope", _this] call Zen_StackAdd;
private ["_vehicles"];

if !([_this, [["ARRAY", "OBJECT"]], [["OBJECT"]], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_vehicles = [(_this select 0)] call Zen_ConvertToObjectArray;

if (Zen_AddFastRope_Action_ID == "") then {
    Zen_AddFastRope_Action_ID = ["<t color='#2D8CE0'>Fast Rope</t>", "Zen_AddFastRope_Action", [], [6, false, true, "", "(_this in _target) && (_this != driver _target) && (speed _target < 10) && (((getPosATL _target) select 2) > 5)"]] call Zen_CreateAction;
};

0 = [Zen_AddFastRope_Action_ID, _vehicles] call Zen_InvokeAction;

call Zen_StackRemove;
if (true) exitWith {};
