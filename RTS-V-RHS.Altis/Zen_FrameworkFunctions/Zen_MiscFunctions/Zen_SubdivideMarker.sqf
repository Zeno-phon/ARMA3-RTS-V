// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

_Zen_stack_Trace = ["Zen_SubdivideMarker", _this] call Zen_StackAdd;
private ["_center", "_xDim", "_yDim", "_angle", "_xDiv", "_yDiv", "_xStep", "_yStep", "_markers", "_pos", "_mkr"];

if !([_this, [["VOID"], ["ARRAY"], ["SCALAR"]], [[], ["SCALAR"]], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    ([])
};

_center = _this select 0;
if ((typeName _center == "STRING") && {markerShape _center != "ICON"}) then {
    _xDim = (markerSize _center) select 0;
    _yDim = (markerSize _center) select 1;
    _angle = markerDir _center;
    _center = markerPos _center;

    _xDiv = (_this select 1) select 0;
    _yDiv = (_this select 1) select 1;
} else {
    _center = [(_this select 0)] call Zen_ConvertToPosition;
    _xDim = (_this select 1) select 0;
    _yDim = (_this select 1) select 1;
    _angle = _this select 2;

    _xDiv = (_this select 3) select 0;
    _yDiv = (_this select 3) select 1;
};

_markers = [];
_xStep = _xDim*2 / _xDiv;
_yStep = _yDim*2 / _yDiv;
_origin = _center vectorAdd [-_xDim, -_yDim, 0];

for "_i" from 1 to _xDiv do {
    for "_j" from 1 to _yDiv do {
        _pos = _origin vectorAdd [_i*_xStep - _xStep / 2, _j*_yStep - _yStep / 2, 0];
        _mkr = [_pos, "", "colorBlack", [_xStep / 2, _yStep / 2], "Rectangle", 0, 0] call Zen_SpawnMarker;
        _markers pushBack _mkr;
    };
};

0 = [_markers, _angle, true] call Zen_RotateAsSet;

call Zen_StackRemove;
(_markers)
