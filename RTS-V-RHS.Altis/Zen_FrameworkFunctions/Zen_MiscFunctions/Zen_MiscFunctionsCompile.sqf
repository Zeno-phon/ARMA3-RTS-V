// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "..\Zen_StandardLibrary.sqf"
#include "..\Zen_FrameworkLibrary.sqf"

Zen_Damage_Increase = 7;
Zen_AddEject_Action_ID = "";
Zen_AddFastRope_Action_ID = "";

Zen_AddEject = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_MiscFunctions\Zen_AddEject.sqf";
Zen_AddFastRope = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_MiscFunctions\Zen_AddFastRope.sqf";
Zen_CheckArguments = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_MiscFunctions\Zen_CheckArguments.sqf";
Zen_ExecuteCommand = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_MiscFunctions\Zen_ExecuteCommand.sqf";
Zen_MultiplyDamage = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_MiscFunctions\Zen_MultiplyDamage.sqf";
Zen_PrintError = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_MiscFunctions\Zen_PrintError.sqf";
Zen_SetWeather = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_MiscFunctions\Zen_SetWeather.sqf";
Zen_SetViewDistance = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_MiscFunctions\Zen_SetViewDistance.sqf";
Zen_ShowHideMarkers = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_MiscFunctions\Zen_ShowHideMarkers.sqf";
Zen_SpawnMarker = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_MiscFunctions\Zen_SpawnMarker.sqf";
Zen_SubdivideMarker = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_MiscFunctions\Zen_SubdivideMarker.sqf";

Zen_AddEject_Action = {
    _helicopter = _this select 0;
    _unit = _this select 1;
    _unit setPosATL ([(_this select 1), 3, getDir _unit - 90, "compass", ((getPosATL _unit) select 2) - 2] call Zen_ExtendVector);
    _unit setVelocity velocity (_this select 0);

    if (isEngineOn _helicopter) then {
        _helicopter engineOn true;
    };
};

Zen_AddFastRope_Action = {
    ZEN_FMW_MP_REClient("Zen_OrderFastRope", _this, spawn, (_this select 0))
};

if (true) exitWith {};
