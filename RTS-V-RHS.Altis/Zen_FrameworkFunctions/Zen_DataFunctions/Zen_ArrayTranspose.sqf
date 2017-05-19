// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

_Zen_stack_Trace = ["Zen_ArrayTranspose", _this] call Zen_StackAdd;
private ["_array", "_result", "_element", "_i", "_yDim"];

if !([_this, [["ARRAY"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    ([])
};

_array = _this select 0;

_yDim = ([_array, {(if (typeName _this == "ARRAY") then {count _this} else {1})}] call Zen_ArrayFindExtremum);
if (typeName _yDim != "ARRAY") then {
    _yDim = 1;
} else {
    _yDim = count _yDim;
};

_result = [];
for "_i" from 0 to _yDim - 1 do {
    _element = [];

    {
        if (typeName _x == "ARRAY") then {
            if (count _x > _i) then {
                _element pushBack (_x select _i);
            };
        } else {
            if (_i == 0) then {
                _element pushBack _x;
            };
        };
    } forEach _array;

    if (count _element == 1) then {
        _element = _element select 0;
    };

    _result pushBack _element;
};

call Zen_StackRemove;
(_result)
