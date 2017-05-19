// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkLibrary.sqf"

_Zen_stack_Trace = ["Zen_OrderInfantryPatrol", _this] call Zen_StackAdd;
private ["_grpsArray", "_movecenter", "_maxx", "_mpos", "_man", "_speedMode", "_limitAnglesSet", "_target", "_behaviorMode", "_chaseEnemy", "_waterPosition", "_divers", "_joinWeak", "_joined", "_positionFilterArgs", "_indexesToRemove", "_chaseFlags", "_defDist", "_maxDist"];

if !([_this, [["VOID"], ["ARRAY", "OBJECT", "GROUP", "STRING"], ["ARRAY"], ["ARRAY", "SCALAR"], ["STRING"], ["STRING"], ["BOOL"], ["BOOL"], ["BOOL"]], [[], ["ARRAY", "OBJECT", "GROUP", "STRING", "SCALAR"], ["STRING", "ARRAY", "SCALAR"], ["SCALAR", "ARRAY"]], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_grpsArray = [(_this select 0)] call Zen_ConvertToGroupArray;
_movecenter = _this select 1;

if ((typeName _movecenter == "STRING") && {((markerShape _movecenter) != "ICON")}) then {
    ZEN_STD_Parse_GetArgumentDefault(_positionFilterArgs, 2, [])
} else {
    _defDist = [50, 200];
    ZEN_STD_Parse_GetArgumentDefault(_positionFilterArgs, 2, _defDist)

    if ((typeName _movecenter == "STRING") && {((markerShape _movecenter) == "ICON")}) then {
        _movecenter = [_movecenter] call Zen_ConvertToPosition;
    };
};

ZEN_STD_Parse_GetArgumentDefault(_limitAnglesSet, 3, 0)
ZEN_STD_Parse_GetArgumentDefault(_speedMode, 4, "limited")
ZEN_STD_Parse_GetArgumentDefault(_behaviorMode, 5, "aware")
ZEN_STD_Parse_GetArgumentDefault(_chaseEnemy, 6, true)
ZEN_STD_Parse_GetArgumentDefault(_joinWeak, 7, false)
ZEN_STD_Parse_GetArgumentDefault(_divers, 8, false)

_waterPosition = 1;
if (_divers) then {
    _waterPosition = 2;
};

_grpsArray = [_grpsArray] call Zen_ArrayRemoveDead;
_chaseFlags = [];
{
    _chaseFlags pushBack false;
    private "_group";
    _group = _x;
    _man = leader _group;

    #define CALC_POS \
        _mpos = [0,0,0]; \
        if (typeName _movecenter == "STRING") then { \
            _mpos = [_movecenter, 0, _positionFilterArgs, _waterPosition, [1,50], _limitAnglesSet] call Zen_FindGroundPosition; \
        } else { \
            if (([_man, _movecenter] call Zen_Find2dDistance) < (_positionFilterArgs select 0)) then { \
                _mpos = [_movecenter, _positionFilterArgs , [], _waterPosition, [1,50], _limitAnglesSet] call Zen_FindGroundPosition; \
            } else { \
                while {true} do { \
                    _mpos = [_movecenter, _positionFilterArgs , [], _waterPosition, [1,50], _limitAnglesSet] call Zen_FindGroundPosition; \
                    if !([_man, [_man, _mpos] call Zen_Find2dDistance, ([_man, _mpos] call Zen_FindDirection), _movecenter, [(_positionFilterArgs select 0), (_positionFilterArgs select 0)], 0, "ellipse"] call Zen_IsRayInPoly) exitWith {}; \
                }; \
            }; \
        };

    CALC_POS
    _group = group _man;

    if !(isPlayer _man) then {
        if (_divers) then {
            _mpos set [2, -10];
            {
                _x swimInDepth -10;
            } forEach (units _group);
        };

        _group setCurrentWaypoint (_group addWaypoint [_mpos, -1]);
        _group move _mpos;
        _man doMove _mpos;
        _group setCombatMode "Red";
        _group setSpeedMode _speedMode;
        _group setBehaviour _behaviorMode;
        if (side _group == civilian) then {
            _group setBehaviour "careless";
        } else {
            _group setBehaviour _behaviorMode;
        };
    };
} forEach _grpsArray;

while {(count _grpsArray != 0)} do {
    _indexesToRemove = [];
    {
        private "_group";
        _group = _x;
        if (!(isNull _group) && {(({alive _x} count (units _group)) > 0)}) then {
            _joined = false;

            if (_joinWeak && {(({alive _x} count (units _group)) < 3)}) then {
                _nearGroup = [_grpsArray - [_group], compile format["_this distanceSqr %1", getPosATL leader _group]] call Zen_ArrayFindExtremum;

                if (([_group, _nearGroup] call Zen_Find2dDistance) < 100) then {
                    _joined = true;
                    (units _group) join _nearGroup;
                };
            };

            if !(_joined) then {
                _man = leader _group;
                if ((unitReady _man) && {(alive _man)}) then {
                    CALC_POS

                    if !(isPlayer _man) then {
                        if (_divers) then {
                            _mpos set [2, -10];
                            {
                                _x swimInDepth -10;
                            } forEach (units _group);
                        };

                        _group setCurrentWaypoint (_group addWaypoint [_mpos, -1]);
                        _group move _mpos;
                        _man doMove _mpos;
                        _group setBehaviour _behaviorMode;
                        _group setCombatMode "Red";
                        _group setSpeedMode _speedMode;
                    };
                } else {
                    if (_chaseEnemy) then {
                        if (side _group == civilian) then {
                            {
                                civilian setFriend [_x, 0];
                            } forEach [west, east, resistance];
                            _target = _man findNearestEnemy _man;
                            {
                                civilian setFriend [_x, 1];
                            } forEach [west, east, resistance];
                        } else {
                            _target = _man findNearestEnemy _man;
                        };

                        if (typeName _movecenter == "STRING") then {
                            _maxDist = [(markerSize _movecenter)] call Zen_ArrayFindAverage;
                        } else {
                            _maxDist = _positionFilterArgs select 1;
                        };

                        if (!(isNull _target) && {((([_man, _target] call Zen_Find2dDistance) < 1.5*_maxDist) && (_target isKindOf "Man"))}) then {
                            _mpos = [_target, (random (150 / ((_man knowsAbout _target) + 0.1))), (random 360)] call Zen_ExtendVector;
                            _chaseFlags set [_forEachIndex, true];

                            if !(isPlayer _man) then {
                                if (_divers) then {
                                    _mpos set [2, -10];
                                    {
                                        _x swimInDepth -10;
                                    } forEach (units _group);
                                };

                                _group setCurrentWaypoint (_group addWaypoint [_mpos, -1]);
                                _group move _mpos;
                                (leader _group) doMove _mpos;
                                _group setSpeedMode _speedMode;
                                _group setCombatMode "Red";
                                if (side _group == civilian) then {
                                    _group setBehaviour "careless";
                                } else {
                                    _group setBehaviour "combat";
                                };
                            };
                        } else {
                            CALC_POS

                            if (!(isPlayer _man) && {_chaseFlags select _forEachIndex}) then {
                                _chaseFlags set [_forEachIndex, false];
                                if (_divers) then {
                                    _mpos set [2, -10];
                                    {
                                        _x swimInDepth -10;
                                    } forEach (units _group);
                                };

                                _group setCurrentWaypoint (_group addWaypoint [_mpos, -1]);
                                _group move _mpos;
                                (leader _group) doMove _mpos;
                                _group setBehaviour _behaviorMode;
                                _group setCombatMode "Red";
                                _group setSpeedMode _speedMode;
                            };
                        };
                    };
                };
            };
        } else {
            _indexesToRemove pushBack _forEachIndex;
        };
    } forEach _grpsArray;
    sleep 10;
    ZEN_FMW_Array_RemoveIndexes(_grpsArray, _indexesToRemove);
    ZEN_FMW_Array_RemoveIndexes(_chaseFlags, _indexesToRemove);
};

call Zen_StackRemove;
if (true) exitWith {};
