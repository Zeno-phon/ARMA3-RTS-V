// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_FrameworkLibrary.sqf"
#include "..\Zen_StandardLibrary.sqf"

if (isNil "_this") then {
    _this = [];
};

_Zen_stack_Trace = ["Zen_RefreshDialog", _this] call Zen_StackAdd;
private ["__time", "_repeat", "_ignore", "_dialogControls", "_controlIDsToIgnore", "_controlIDsToRepeat", "_hashes", "_controlID", "_control", "_oldHash", "_controlsToRepeat", "_newHash", "_controlsToIgnoreData"];

if !([_this, [["SCALAR"], ["ARRAY", "STRING"], ["ARRAY", "STRING"]], [[], ["STRING"], ["STRING"]], 0] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

ZEN_STD_Parse_GetArgumentDefault(__time, 0, 0)
ZEN_STD_Parse_GetArgumentDefault(_repeat, 1, [])
ZEN_STD_Parse_GetArgumentDefault(_ignore, 2, [])

disableSerialization;
with uiNamespace do {
    missionNamespace setVariable ["Zen_Active_Dialog", Zen_Dialog_Object_Local select 0];
    missionNamespace setVariable ["Zen_Active_Dialog_Control_Data", +(Zen_Dialog_Object_Local select 1)];
    missionNamespace setVariable ["Zen_Active_Dialog_Position", (Zen_Dialog_Object_Local select 2)];
};

if (Zen_Active_Dialog != "") then {
    if ((typeName _repeat == "STRING") && {typeName _ignore == "STRING"}) exitWith {
        ZEN_FMW_Code_ErrorExitVoid("Zen_RefreshDialog", "")
    };

    _dialogControls = [Zen_Active_Dialog] call Zen_GetDialogControls;

    if (typeName _repeat == "STRING") then {
        _controlIDsToIgnore = _ignore;

        _controlIDsToRepeat =+ _dialogControls;
        {
            0 = [_controlIDsToRepeat, _x] call Zen_ArrayRemoveValue;
        } forEach _controlIDsToIgnore;
    };

    if (typeName _ignore == "STRING") then {
        _controlIDsToRepeat = _repeat;

        _controlIDsToIgnore =+ _dialogControls;
        {
            0 = [_controlIDsToIgnore, _x] call Zen_ArrayRemoveValue;
        } forEach _controlIDsToRepeat;
    };

    if ((typeName _repeat == "ARRAY") && {typeName _ignore == "ARRAY"}) then {
        _controlIDsToRepeat = _repeat;
        _controlIDsToIgnore = _ignore;
    };

    _controlsToIgnoreData = [];
    _controlsToRepeatData = [];
    {
        _controlID = _x select 0;
        _control = _x select 1;
        _oldHash = _x select 2;

        if (_controlID in _dialogControls) then {
            if (_controlID in _controlIDsToRepeat) then {
                _controlsToRepeatData pushBack [_controlID, _control, _oldHash];
             } else {
                if !(_controlID in _controlIDsToIgnore) then {
                    _newHash = [_controlID] call Zen_HashControlData;
                    if ((_newHash != "") && {_oldHash != _newHash}) then {
                        _controlsToRepeatData pushBack [_controlID, _control, _newHash];
                    } else {
                        _controlsToIgnoreData pushBack [_controlID, _control, _oldHash];
                    };
                } else {
                    _controlsToIgnoreData pushBack [_controlID, _control, _oldHash];
                };
            };

            0 = [_dialogControls, _controlID] call Zen_ArrayRemoveValue;
        } else {
            ctrlDelete (_x select 1);
        };
    } forEach Zen_Active_Dialog_Control_Data;

    0 = [Zen_Active_Dialog, Zen_Active_Dialog_Position, false, false, _controlsToRepeatData, _controlsToIgnoreData, _dialogControls, __time] spawn Zen_InvokeDialog;
};

call Zen_StackRemove;
if (true) exitWith {};
