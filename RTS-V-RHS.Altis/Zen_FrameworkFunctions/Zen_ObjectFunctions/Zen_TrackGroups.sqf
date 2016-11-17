// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_TrackGroups", _this] call Zen_StackAdd;
private ["_groups", "_textType", "_unit", "_color", "_marker", "_txt", "_unitMarkers", "_thread", "_destMarkers", "_destMarker", "_markerShape", "_markerShapeDot", "_markerDot", "_unitMarkersDot", "_group", "_groupPos", "_showDestination", "_hideFromUnits", "_count", "_interval"];

if !([_this, [["VOID"], ["STRING"], ["BOOL"], ["VOID"], ["SCALAR"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    ([])
};

_groups = [(_this select 0)] call Zen_ConvertToGroupArray;

ZEN_STD_Parse_GetArgumentDefault(_textType, 1, "group")
ZEN_STD_Parse_GetArgumentDefault(_showDestination, 2, false)
ZEN_STD_Parse_GetArgumentDefault(_hideFromUnits, 3, 0)
ZEN_STD_Parse_GetArgumentDefault(_interval, 4, 10)

_unitMarkersDot = [];
_unitMarkers = [];
_destMarkers = [];

{
    _group = _x;
    _unit = objNull;
    {
        if !(isNull _x) exitWith {
            _unit = _x;
        };
    } forEach (units _group);

    if (isNull _unit) then {
        _groups set [_forEachIndex, 0];
    } else {
        switch (toLower _textType) do {
            case "object": {
                _txt = str _unit;
            };
            case "group": {
                _txt = str _group;
            };
            case "name": {
                _txt = "";
                if (isPlayer _unit && alive _unit) then {
                    _txt = name _unit;
                };
            };
            case "number": {
                _txt = str (_forEachIndex + 1);
            };
            default {
                _txt = "";
            };
        };

        switch ([_unit] call Zen_GetSide) do {
            case west: {
                _markerShape = "b_inf";
            };
            case east: {
                _markerShape = "o_inf";
            };
            case resistance: {
                _markerShape = "n_inf";
            };
            case civilian: {
                _markerShape = "c_unknown";
            };
            default {
                _markerShape = "";
                0 = ["Zen_TrackGroups", "Object is of invalid side", _this] call Zen_PrintError;
                call Zen_StackPrint;
            };
        };

        _count = count units _group;
        switch (true) do {
            case (_count < 4): {
                _markerShapeDot = "group_0";
            };
            case (_count < 12): {
                _markerShapeDot = "group_1";
            };
            case (_count < 25): {
                _markerShapeDot = "group_2";
            };
            default {
                _markerShapeDot = "group_3";
            };
        };

        _color = [_unit] call Zen_GetSideColor;
        _marker = [(getPosATL _unit), _txt,_color,[0.85, 0.85],_markerShape,0, 1] call Zen_SpawnMarker;
        _markerDot = [(getPosATL _unit), "", _color, [1.3, 1.3], _markerShapeDot, 0, 1] call Zen_SpawnMarker;

        if (_showDestination) then {
            _destMarker = [[0,0,0], _txt,_color,[.8,.8],"mil_arrow", 180, 1] call Zen_SpawnMarker;
        } else {
            _destMarker = [[0,0,0], _txt,_color,[.8,.8],"mil_arrow", 180, 0] call Zen_SpawnMarker;
        };

        _unitMarkers pushBack _marker;
        _unitMarkersDot pushBack _markerDot;
        _destMarkers pushBack _destMarker;
    };
} forEach _groups;

0 = [_groups, 0] call Zen_ArrayRemoveValue;

if (isMultiplayer) then {
    0 = [(_unitMarkers + _destMarkers + _unitMarkersDot), 0, _hideFromUnits] call Zen_ShowHideMarkers;
};

_thread = [_groups, _unitMarkers, _unitMarkersDot, _destMarkers, _textType, _showDestination, _interval] spawn {

    _Zen_stack_Trace = ["Zen_TrackGroups", _this] call Zen_StackAdd;
    private ["_groups", "_marker", "_unitMarkers", "_unit", "_textType", "_destMarkers", "_destMarker", "_unitMarkersDot", "_markerDot", "_markerShapeDot", "_showDestination", "_count", "_group"];

    _groups = _this select 0;
    _unitMarkers = _this select 1;
    _unitMarkersDot = _this select 2;
    _destMarkers = _this select 3;
    _textType = _this select 4;
    _showDestination = _this select 5;
    _interval = _this select 6;

    while {((count _groups) != 0)} do {
        {
            _group = _x;
            _marker = _unitMarkers select _forEachIndex;
            _markerDot = _unitMarkersDot select _forEachIndex;
            _destMarker = _destMarkers select _forEachIndex;
            if (({alive _x} count units _group) == 0) then {
                deleteMarker _marker;
                deleteMarker _markerDot;
                deleteMarker _destMarker;

                _groups set [_forEachIndex, 0];
                _unitMarkers set [_forEachIndex, 0];
                _unitMarkersDot set [_forEachIndex, 0];
                _destMarkers set [_forEachIndex, 0];
            } else {

                _unit = leader _group;
                switch (toLower _textType) do {
                    case "object": {
                        _marker setMarkerText (str _unit);
                    };
                    case "group": {
                        _marker setMarkerText (str _group);
                    };
                    case "name": {
                        if (isPlayer _unit && alive _unit) then {
                            _marker setMarkerText (name _unit);
                        } else {
                            _marker setMarkerText "";
                        };
                    };
                };

                _markerShapeDot = "";
                _count = count units _group;
                switch (true) do {
                    case (_count < 4): {
                        _markerShapeDot = "group_0";
                    };
                    case (_count < 12): {
                        _markerShapeDot = "group_1";
                    };
                    case (_count < 25): {
                        _markerShapeDot = "group_2";
                    };
                    default {
                        _markerShapeDot = "group_3";
                    };
                };

                _groupPos = (units _group) call Zen_FindAveragePosition;

                _marker setMarkerPos _groupPos;
                _markerDot setMarkerPos _groupPos;
                _markerDot setMarkerType _markerShapeDot;

                if (_showDestination) then {
                    if (([_unit, _destMarker] call Zen_Find2dDistance) > 10 && ((behaviour _unit) != "COMBAT")) then {
                        _destMarker setMarkerPos ((expectedDestination _unit) select 0);
                    };
                };
            };
        } forEach _groups;

        0 = [_groups, 0] call Zen_ArrayRemoveValue;
        0 = [_unitMarkers, 0] call Zen_ArrayRemoveValue;
        0 = [_unitMarkersDot, 0] call Zen_ArrayRemoveValue;
        0 = [_destMarkers, 0] call Zen_ArrayRemoveValue;

        sleep _interval;
    };
    call Zen_StackRemove;
    if (true) exitWith {};
};

call Zen_StackRemove;
[(_unitMarkers + _destMarkers + _unitMarkersDot), _thread]
