// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_FrameworkLibrary.sqf"
#include "..\Zen_StandardLibrary.sqf"

_Zen_stack_Trace = ["Zen_ExtendVector", _this] call Zen_StackAdd;
private ["_center", "_dist", "_phi", "_height", "_angleType"];

if !([_this, [["VOID"], ["SCALAR", "ARRAY"], ["SCALAR", "STRING"], ["STRING"], ["SCALAR"]], [[], ["SCALAR"]], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    (_this select 0)
};

_center = [(_this select 0)] call Zen_ConvertToPosition;

if ((typeName (_this select 1)) == "ARRAY") then {
    _dist = (_this select 1) select 2;
    _phi = (_this select 1) select 2;
    _height = (_this select 1) select 2;

    _angleType = "trig";
} else {
    _dist = _this select 1;
    _phi = _this select 2;

    ZEN_STD_Parse_GetArgumentDefault(_angleType, 3, "Compass")
    ZEN_STD_Parse_GetArgumentDefault(_height, 4, 0)
};

if ([_angleType, "Compass"] call Zen_ValuesAreEqual) then {
    _phi = [_phi] call Zen_FindTrigAngle;
};

call Zen_StackRemove;
([(_center select 0) + (_dist * (cos _phi)),(_center select 1) + (_dist * (sin _phi)), _height])
