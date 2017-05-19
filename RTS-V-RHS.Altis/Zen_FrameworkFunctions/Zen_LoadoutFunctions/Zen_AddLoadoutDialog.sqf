// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkLibrary.sqf"

if !(isServer) exitWith {
    ZEN_FMW_MP_REServerOnly("Zen_AddLoadoutDialog", _this, call)
};

_Zen_stack_Trace = ["Zen_AddLoadoutDialog", _this] call Zen_StackAdd;
private ["_objects", "_kits", "_maxUses", "_id"];

if !([_this, [["ARRAY", "OBJECT"], ["ARRAY"], ["SCALAR"], ["BOOL"]], [["OBJECT"], ["STRING"]], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_objects = _this select 0;
_kits = _this select 1;

_maxUses = -1;

if (count _this > 2) then {
    _maxUses = _this select 2;
} else {
    _this set [2, -1];
};

if (typeName _objects != "ARRAY") then {
    _objects = [_objects];
};

_dialogID = [] call Zen_CreateDialog;

_controlCancel = ["Button", ["Text", "Cancel"], ["Position", [35, 2]], ["Size", [5,2]], ["ActivationFunction", "Zen_CloseDialog"]] call Zen_CreateControl;
_controlList = ["List", ["List", _kits], ["ListData", _kits], ["Position", [0, 0]], ["Size", [35,40]]] call Zen_CreateControl;
_controlOK = ["Button", ["Text", "OK"], ["Position", [35, 0]], ["Size", [5,2]], ["ActivationFunction", "Zen_LoadoutDialogEquip"], ["LinksTo", [_controlList]]] call Zen_CreateControl;

{
    0 = [_dialogID, _x] call Zen_LinkControl;
} forEach [_controlOK, _controlCancel, _controlList];

_actionID = ["<t color='#2D8CE0'>Select Loadout</t>", "Zen_ShowLoadoutDialog", _dialogID, [1, false, true, "", "(alive _target && {((_target distance _this) < (1 + (((boundingBoxReal _target) select 0) distance ((boundingBoxReal _target) select 1)) / 2))})"]] call Zen_CreateAction;
Zen_Loadout_Action_Array_Local pushBack [_actionID, _maxUses, 0];
publicVariable "Zen_Loadout_Action_Array_Local";

0 = [_actionID, _objects] call Zen_InvokeAction;

call Zen_StackRemove;
if (true) exitWith {};
