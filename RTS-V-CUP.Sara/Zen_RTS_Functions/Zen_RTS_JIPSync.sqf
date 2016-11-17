//

if (_Zen_Is_JIP) then {
    Zen_Task_Array_Global = 1;
    Zen_MP_Closure_Packet = ["Zen_SyncJIPServer", player];
    publicVariableServer "Zen_MP_Closure_Packet";

    waitUntil {
        (!(isNil "Zen_JIP_Args_Server") && (typeName Zen_Task_Array_Global == "ARRAY"))
    };

    _overcast = Zen_JIP_Args_Server select 0;
    _fog = Zen_JIP_Args_Server select 1;
    _viewDist = Zen_JIP_Args_Server select 2;

    0 = [["overcast", _overcast], ["fog", _fog], ["packet", false]] spawn Zen_SetWeather;
    0 = [_viewDist, -1, -1, false] call Zen_SetViewDistance;

    if (((missionConfigFile >> "disabledAI") isEqualTo 1) || ((count ([player] call Zen_GetUnitTasks)) == 0)) then {
        private ["_refUnit"];
        _refUnitArray = (units group player) - [player];
        if (count _refUnitArray == 0) then {
            _refUnit = (([side player] call Zen_ConvertToObjectArray) - [player]) select 0;
        } else {
            _refUnit = _refUnitArray select 0;
        };

        // Due to the nature of actions in MP, the framework's actions must be added this way
        0 = [([side player] call Zen_ConvertToObjectArray) - [player], false] call Zen_AddGiveMagazine;
        0 = [player] call Zen_AddGiveMagazine;

        0 = [([side player] call Zen_ConvertToObjectArray) - [player], false] call Zen_AddRepackMagazines;
        0 = [player] call Zen_AddRepackMagazines;

        if (vehicle _refUnit != _refUnit) then {
            player moveInAny (vehicle _refUnit);
            if (vehicle player == player) then {
                player setPosATL ([_refUnit, 2 + random 3, random 360] call Zen_ExtendVector);
            };
        } else {
            player setPosATL ([_refUnit, 2 + random 3, random 360] call Zen_ExtendVector);
        };

        {
            0 = [_x, player] call Zen_ReassignTask;
        } forEach ([_refUnit] call Zen_GetUnitTasks);
    } else {
        0 = [_playerGroup, false] call Zen_AddGiveMagazine;
        0 = [_playerGroup, false] call Zen_AddRepackMagazines;

        {
            0 = [(_x select 1), (_x select 4), (_x select 5), (_x select 3), false, (_x select 0), (_x select 6)] call Zen_InvokeTaskClient;
            0 = [(_x select 0)] call Zen_UpdateTask;
            sleep 0.1;
        } forEach Zen_Task_Array_Global;

        _sideKillCounts = (Zen_RTS_TotalKills select ([west, east] find (side player)));
        _localKills = _unit getVariable "Zen_RTS_LocalKills";
        Zen_RTS_LocalKills = _localKills;

        for "_i" from 0 to 3 do {
            _sideKillCounts set [_i, (_sideKillCounts select _i) + (_localKills select _i)];
        };
        publicVariable "Zen_RTS_TotalKills";
    };

    0 = [player] spawn Zen_RTS_F_RespawnActions;
};

if (isServer) then {
    Zen_SyncJIPServer = {
        Zen_JIP_Args_Server set [0, overcast];
        Zen_JIP_Args_Server set [1, fog];

        (owner _this) publicVariableClient "Zen_Task_Array_Global";
        (owner _this) publicVariableClient "Zen_Fire_Support_Array_Global";
        (owner _this) publicVariableClient "Zen_Fire_Support_Action_Array_Global";
        (owner _this) publicVariableClient "Zen_Loadout_Array_Global";
        (owner _this) publicVariableClient "Zen_Damage_Increase";
        (owner _this) publicVariableClient "Zen_Dialog_Classes_Global";
        (owner _this) publicVariableClient "Zen_Control_Classes_Global";
        (owner _this) publicVariableClient "Zen_Fire_Support_Action_Dialog_Data";

        (owner _this) publicVariableClient "Zen_RTS_Territory_Data";
        (owner _this) publicVariableClient "Zen_RTS_SubTerritory_Data";
        (owner _this) publicVariableClient "Zen_RTS_Strategic_Building_Types";
        (owner _this) publicVariableClient "Zen_RTS_Strategic_Building_Objects_Global";
        (owner _this) publicVariableClient "Zen_RTS_Strategic_Asset_Types";
        (owner _this) publicVariableClient "Zen_RTS_TechFlag_East_BuildEnemy";

        (owner _this) publicVariableClient "Zen_RTS_BuildingType_West_HQ";
        (owner _this) publicVariableClient "Zen_RTS_BuildingType_West_CJ";
        (owner _this) publicVariableClient "Zen_RTS_BuildingType_East_HQ";
        (owner _this) publicVariableClient "Zen_RTS_BuildingType_East_CJ";

        (owner _this) publicVariableClient "RTS_Used_Building_Types";
        (owner _this) publicVariableClient "RTS_Building_Type_Levels";
        (owner _this) publicVariableClient "RTS_Building_Spawn_Grid_Markers";
        (owner _this) publicVariableClient "RTS_Used_Building_Types";
        (owner _this) publicVariableClient "RTS_Used_Asset_Types";

        (owner _this) publicVariableClient "Zen_RTS_GiveMoneyDialog_Current_Money_Control";
        (owner _this) publicVariableClient "Zen_RTS_GiveMoneyDialog_Player_List";
        (owner _this) publicVariableClient "Zen_RTS_GiveMoneyDialog_Dialog";
        (owner _this) publicVariableClient "Zen_RTS_TotalKills";

        (owner _this) publicVariableClient "WestCommander";
        (owner _this) publicVariableClient "EastCommander";

        (owner _this) publicVariableClient "rts_Initialized";
        (owner _this) publicVariableClient "Zen_JIP_Args_Server";
    };
};
