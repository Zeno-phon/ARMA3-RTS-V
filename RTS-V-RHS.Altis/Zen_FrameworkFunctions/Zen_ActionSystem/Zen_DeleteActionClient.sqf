// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkLibrary.sqf"

if (isDedicated || !hasInterface) exitWith {};

_Zen_stack_Trace = ["Zen_DeleteActionClient", _this] call Zen_StackAdd;
private ["_nameString", "_objsToRemove", "_idsArray", "_actionDataLocal", "_objsLocal", "_indexesToRemove", "_obj"];

if !([_this, [["STRING"], ["ARRAY"]], [], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_nameString = _this select 0;
_objsToRemove = _this select 1;

_actionDataLocal = [_nameString] call Zen_GetActionDataLocal;
if (count _actionDataLocal > 0) then {
    _objsLocal = _actionDataLocal select 1;
    _idsArray = _actionDataLocal select 2;
    _indexesToRemove = [];
    {
        _obj = _x;
        {
            if (isNull _x) then {
                _indexesToRemove pushBack _forEachIndex;
            } else {
                if (_x == _obj) then {
                    _indexesToRemove pushBack _forEachIndex;
                    _x removeAction (_idsArray select _forEachIndex);
                };
            };
        } forEach _objsLocal;
    } forEach _objsToRemove;

    ZEN_FMW_Array_RemoveIndexes(_objsLocal, _indexesToRemove)
    ZEN_FMW_Array_RemoveIndexes(_idsArray, _indexesToRemove)
};

call Zen_StackRemove;
if (true) exitWith {};
