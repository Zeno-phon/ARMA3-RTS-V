if (_Zen_Is_JIP) then {

    Zen_Task_Array_Global = 1;
    Zen_MP_Closure_Packet = ["Zen_SyncJIPServer", player];
    publicVariableServer "Zen_MP_Closure_Packet";

    waitUntil {
        (!(isNil "Zen_JIP_Args_Server") && (typeName Zen_Task_Array_Global == "ARRAY"))
    };

    _serverArgs = Zen_JIP_Args_Server;
    0 = [["overcast", (_serverArgs select 0)], ["fog", (_serverArgs select 1)], ["packet", false]] spawn Zen_SetWeather;

    0 = [(_serverArgs select 2), -1, -1, false] call Zen_SetViewDistance;

    if ((count ([player] call Zen_GetUnitTasks)) == 0) then {
        private ["_refUnit"];
        _refUnitArray = (units group player) - [player];
        if (count _refUnitArray == 0) then {
            _refUnit = (([side player] call Zen_ConvertToObjectArray) - [player]) select 0;
        } else {
            _refUnit = _refUnitArray select 0;
        };

        if (vehicle _refUnit != _refUnit) then {
            player moveInAny (vehicle _refUnit);
            if (vehicle player == player) then {
                player setPosATL ([_refUnit, 2 + random 3, random 360] call Zen_ExtendPosition);
            };
        } else {
            player setPosATL ([_refUnit, 2 + random 3, random 360] call Zen_ExtendPosition);
        };

        {
            0 = [_x, player] call Zen_ReassignTask;
        } forEach ([_refUnit] call Zen_GetUnitTasks);
    } else {
        {
            0 = [(_x select 1), (_x select 4), (_x select 5), (_x select 3), false, (_x select 0), (_x select 6)] call Zen_InvokeTaskClient;
            0 = [(_x select 0)] call Zen_UpdateTask;
            sleep 0.1;
        } forEach Zen_Task_Array_Global;
    };
};

if (isServer) then {
    Zen_SyncJIPServer = {
        Zen_JIP_Args_Server set [0, overcast];
        Zen_JIP_Args_Server set [1, fog];

        (owner _this) publicVariableClient "Zen_Task_Array_Global";
        (owner _this) publicVariableClient "Zen_Fire_Support_Array_Global";
        (owner _this) publicVariableClient "Zen_Loadout_Array_Global";
        (owner _this) publicVariableClient "Zen_Damage_Increase";
        (owner _this) publicVariableClient "Zen_JIP_Args_Server";

        // Territory Information for JIP Clients
        (owner _this) publicVariableClient "WestFC";
        (owner _this) publicVariableClient "EastFC";
        (owner _this) publicVariableClient "GuerFC";
        (owner _this) publicVariableClient "CivFC";
        (owner _this) publicVariableClient "FlagNumber";

        // Victory Point Information for JIP Clients
        (owner _this) publicVariableClient "rts_vpTickerWest";
        (owner _this) publicVariableClient "rts_vpTickerEast";

        // Resource variables for JIP clients
        (owner _this) publicVariableClient "westSupplyFactor";
        (owner _this) publicVariableClient "westSupply";

        (owner _this) publicVariableClient "eastSupplyFactor";
        (owner _this) publicVariableClient "eastSupply";

        // Building Placeholder Vars so JIP clients will have base buildings
        (owner _this) publicVariableClient "westBarracksTmp";
        (owner _this) publicVariableClient "westLightFacTmp";
        (owner _this) publicVariableClient "westHeavyFacTmp";
        (owner _this) publicVariableClient "westAirFacTmp";
        (owner _this) publicVariableClient "westNavalFacTmp";

        (owner_this)publicVariableClient"eastBarracksTmp";
        (owner_this)publicVariableClient"eastHeavyFacTmp";
        (owner_this)publicVariableClient"eastLightFacTmp";
        (owner_this)publicVariableClient"eastAirFacTmp";
        (owner_this)publicVariableClient"eastNavalFacTmp";
        ;
        (owner_this)publicVariableClient"westBarracksLevel";
        (owner_this)publicVariableClient"westLightFacLevel";
        (owner_this)publicVariableClient"westHeavyFacLevel";
        (owner_this)publicVariableClient"westAirFacLevel";
        ;
        (owner_this)publicVariableClient"eastBarracksLevel";
        (owner_this)publicVariableClient"eastLightFacLevel";
        (owner_this)publicVariableClient"eastHeavyFacLevel";
        (owner_this)publicVariableClient"eastAirFacLevel";

        // Update West Assets with public array
        rts_updateArray = str [WEST,westAssets];
        (owner _this) publicVariableClient "rts_updateArray";

        // Update East Assets with public array
        rts_updateArray = str [EAST,eastAssets];
        (owner _this) publicVariableClient "rts_updateArray";
    };
};
