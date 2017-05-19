// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkLibrary.sqf"

if !(isServer) exitWith {
    ZEN_FMW_MP_REServerOnly("Zen_UpdateAction", _this, call)
};

_Zen_stack_Trace = ["Zen_UpdateAction", _this] call Zen_StackAdd;
private ["_text", "_func", "_args", "_addActionargs", "_nameString", "_actionArray", "_localReset"];

if !([_this, [["STRING"], ["STRING", "SCALAR"], ["STRING", "SCALAR"], ["ARRAY", "SCALAR"], ["VOID"]], [], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_nameString = _this select 0;

ZEN_STD_Parse_GetArgumentDefault(_text, 1, 0)
ZEN_STD_Parse_GetArgumentDefault(_func, 2, 0)
ZEN_STD_Parse_GetArgumentDefault(_addActionargs, 3, [])

_actionArray = [];
{
    if (toUpper (_x select 0) isEqualTo toUpper _nameString) exitWith {
        _actionArray = _x;
    };
} forEach Zen_Action_Array_Server;

if (count _actionArray == 0) exitWith {
    ZEN_FMW_Code_ErrorExitValue("Zen_UpdateAction", "Given action does not exist.", [])
};

_localReset = false;
if (typeName _text == "STRING") then {
    _actionArray set [1, _text];
    _localReset = true;
};

if (typeName _func == "STRING") then {
    _actionArray set [2, _func];
};

if (typeName _addActionargs == "ARRAY") then {
    _actionArray set [4, _addActionargs];
    _localReset = true;
};

if (count _this > 4) then {
    _args = _this select 4;
    _actionArray set [3, _args];
};

if (_localReset) then {
    _oldUnits = _actionArray select 5;
    0 = [_nameString] call Zen_DeleteAction;
    if (isMultiplayer) then {
        sleep 0.5;
    };
    0 = [_nameString, _oldUnits] call Zen_InvokeAction;
};

call Zen_StackRemove;
if (true) exitWith {};
