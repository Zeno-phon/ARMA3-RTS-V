// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_GetActionDataGlobal", _this] call Zen_StackAdd;
private ["_actionArray", "_nameString", "_index"];

if !([_this, [["STRING"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    ([])
};

_nameString = _this select 0;

_actionArray = [];
if (isServer) then {
    {
        if (toUpper (_x select 0) isEqualTo toUpper _nameString) exitWith {
            _actionArray =+ _x;
        };
    } forEach Zen_Action_Array_Server;
} else {
    Zen_GetActionDataGlobal_Array_MP = nil;
    ZEN_FMW_Code_GetRemoteVarArrayT("Zen_Action_Array_Server", 0, "Zen_GetActionDataGlobal_Array_MP", 0)
    if (typeName Zen_GetActionDataGlobal_Array_MP != "ARRAY") then {
        Zen_GetActionDataGlobal_Array_MP = [Zen_GetActionDataGlobal_Array_MP];
    };

    _index = Zen_GetActionDataGlobal_Array_MP find _nameString;
    Zen_GetActionDataGlobal_Array_MP = nil;
    if (_index > -1) then {
        ZEN_FMW_Code_GetRemoteVarArray("Zen_Action_Array_Server", _index, "Zen_GetActionDataGlobal_Array_MP", 0)
        _actionArray =+ Zen_GetActionDataGlobal_Array_MP;
    };
};

if (count _actionArray == 0) exitWith {
    ZEN_FMW_Code_ErrorExitValue("Zen_GetActionDataGlobal", "Given action does not exist.", [])
};

call Zen_StackRemove;
([_actionArray, 0, (count _actionArray) - 3] call Zen_ArrayGetIndexedSlice)

///////////////////////////////////
///////////////////////////////////
///////////////////////////////////

/**
if !(isServer) then {
    Zen_Action_Array_Server = nil;
    ZEN_FMW_Code_GetRemoteVar("Zen_Action_Array_Server", 0)
};

{
    if (toUpper (_x select 0) isEqualTo toUpper _nameString) exitWith {
        _actionArray =+ _x;
    };
} forEach Zen_Action_Array_Server;

if (count _actionArray == 0) exitWith {
    ZEN_FMW_Code_ErrorExitValue("Zen_GetActionDataGlobal", "Given action does not exist.", [])
};

call Zen_StackRemove;
([_actionArray, 0, (count _actionArray) - 3] call Zen_ArrayGetIndexedSlice)
//*/
