// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkLibrary.sqf"

if !(isServer) exitWith {
    ZEN_FMW_MP_REServerOnly("Zen_AddGiveMagazine", _this, call)
};

_Zen_stack_Trace = ["Zen_AddGiveMagazine", _this] call Zen_StackAdd;
private ["_units"];

if !([_this, [["VOID"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_units = [(_this select 0)] call Zen_ConvertToObjectArray;

if (Zen_AddGiveMagazine_Action_ID == "") then {
    Zen_AddGiveMagazine_Action_ID = ["<t color='#2D8CE0'>Give Magazine</t>", "Zen_GiveMagazine", [], [1, false, true, "", "((_target == _this) && !(surfaceIsWater (getPosATL _this)) && (vehicle _this == _this) && {(({(side _x == side _this) && ([_this, _x, 120] call Zen_IsFacing)} count (((getPosATL _target) nearEntities ['Man', 3]) - [_this])) > 0)})"]] call Zen_CreateAction;
};

0 = [Zen_AddGiveMagazine_Action_ID, _units] call Zen_InvokeAction;

call Zen_StackRemove;
if (true) exitWith {};
