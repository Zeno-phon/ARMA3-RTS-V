/**
    Zen_RTS_SubTerritoryEventCaptured
    by Zenophon
    for RTS V

    Proxy event function for Zen_RTS_SubTerritoryManager thread.
    Called when the side of a sub-territory changes.
    Usage : Spawn
    Params: 1. String, the sub-territory
            2. Array, the previous sub-territory data
    Return: Void
//*/

#include "..\Zen_FrameworkFunctions\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkFunctions\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_RTS_SubTerritoryEventCaptured", _this] call Zen_StackAdd;
private ["_marker", "_oldData", "_newData"];

if !([_this, [["STRING"], ["ARRAY"]], [[], ["STRING", "SIDE", "SCALAR", "ARRAY"]], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_marker = _this select 0;
_oldData = _this select 1;
_newData = [_marker] call Zen_RTS_SubTerritoryGetData;

// Debug
diag_log ("Zen_RTS_SubTerritoryEventCaptured :" + str time);
diag_log _oldData;
diag_log _newData;

_players = [_marker, [], [(_newData select 1)]] call Zen_GetAllInArea;
_players = [_players, {!(isPlayer _this)}] call Zen_ArrayFilterCondition;

{
    ZEN_FMW_MP_REClient("Zen_RTS_F_ModifyMoney", 5, call, _x)
    ZEN_FMW_MP_REClient("Zen_RTS_F_AddSubTerritoryCaptured", _marker, call, _x)
} forEach _players;

{
    if (isPlayer _x) then {
        ZEN_FMW_MP_REClient("Zen_RTS_F_RemoveSubTerritoryCaptured", _marker, call, _x)
    };
} forEach ([(_oldData select 1)] call Zen_ConvertToObjectArray);

_args = [west, east];
ZEN_FMW_MP_REAll("Zen_RTS_F_EconomyComputeSupply", _args, call)

if ((_newData select 3) == 0) then {
    // _FOBobjectsOrg = nearestObjects [getMarkerPos "mkFOB1", ["All"], 50];

    // _avgCenter = _FOBobjectsOrg call Zen_FindAveragePosition;
    // _FOBobjectsMove = [];
    // {
        // _pos = (getPosATL _x) vectorDiff _avgCenter;
        // _obj = [_pos, (typeOf _x), 0, (getDir _x) + _angle, true] call Zen_SpawnVehicle;
        // _FOBobjectsMove pushBack _obj;
    // } forEach _FOBobjectsOrg;

    _spawnedTemplate = [_marker, Zen_RTS_FOB_Template] call Zen_SpawnTemplate;
    _FOBObjects = [Zen_RTS_FOB_Template, _spawnedTemplate] call Zen_GetTemplateObjects;

    _angle = random 360;
    0 = [_FOBObjects, _angle, true] call Zen_RotateAsSet;
    0 = [_FOBObjects, _marker] call Zen_MoveAsSet;

    _newData set [3, 1];
};

_infantry = [_marker, (_newData select 1), "infantry", 4] call Zen_SpawnInfantry;
0 = [_infantry, _marker] spawn Zen_OrderInfantryPatrol;

call Zen_StackRemove;
if (true) exitWith {};
