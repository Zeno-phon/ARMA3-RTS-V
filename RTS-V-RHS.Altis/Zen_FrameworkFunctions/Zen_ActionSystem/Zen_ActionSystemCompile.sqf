// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

Zen_Action_Array_Server = [];
Zen_Action_Array_Local = [];

Zen_CreateAction = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ActionSystem\Zen_CreateAction.sqf";
Zen_DeleteAction = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ActionSystem\Zen_DeleteAction.sqf";
Zen_DeleteActionClient = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ActionSystem\Zen_DeleteActionClient.sqf";
Zen_GetActionArguments = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ActionSystem\Zen_GetActionArguments.sqf";
Zen_GetActionDataGlobal = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ActionSystem\Zen_GetActionDataGlobal.sqf";
Zen_GetActionDataLocal = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ActionSystem\Zen_GetActionDataLocal.sqf";
Zen_GetObjectActions = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ActionSystem\Zen_GetObjectActions.sqf";
Zen_InvokeAction = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ActionSystem\Zen_InvokeAction.sqf";
Zen_InvokeActionClient = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ActionSystem\Zen_InvokeActionClient.sqf";
Zen_RemoveAction = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ActionSystem\Zen_RemoveAction.sqf";
Zen_RemoveActionClient = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ActionSystem\Zen_RemoveActionClient.sqf";
Zen_UpdateAction = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ActionSystem\Zen_UpdateAction.sqf";

if (true) exitWith {};
