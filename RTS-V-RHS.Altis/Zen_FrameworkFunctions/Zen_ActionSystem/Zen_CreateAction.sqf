// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkLibrary.sqf"

if !(isServer) exitWith {
    ZEN_FMW_MP_REServerOnly("Zen_CreateAction", _this, call)
    ("")
};

_Zen_stack_Trace = ["Zen_CreateAction", _this] call Zen_StackAdd;
private ["_text", "_func", "_args", "_addActionargs", "_nameString"];

if !([_this, [["STRING"], ["FUNCTION"], ["VOID"], ["ARRAY"]], [], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    ("")
};

_text = _this select 0;
_func = _this select 1;

ZEN_STD_Parse_GetArgumentDefault(_args, 2, [])
ZEN_STD_Parse_GetArgumentDefault(_addActionargs, 3, [])

_nameString = "Zen_Action_ID_" + ([10] call Zen_StringGenerateRandom);
Zen_Action_Array_Server pushBack [_nameString, _text, _func, _args, _addActionargs, [], [], []];

call Zen_StackRemove;
(_nameString)
