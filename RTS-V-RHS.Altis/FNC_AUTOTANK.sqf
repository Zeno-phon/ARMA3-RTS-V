comment "1st step exec global";

FNC_AUTOTANK = {
    params [
        "_vehicle"
    ];

    [_vehicle, [[0], true]] remoteExec ["lockTurret", _vehicle];
    [_vehicle, [[0, 0], true]] remoteExec ["lockTurret", _vehicle];
    [_vehicle, true] remoteExec ["lockCargo", _vehicle];

    // [
        // _vehicle,
        // [
            // "MPKilled",
            // {
                // if (isServer) then
                // {
                    // _d = driver (_this select 0);
                    // _g = gunner (_this select 0);
                    // if (!isNull _d) then {deleteVehicle _d};
                    // if (!isNull _g) then {_g setDamage 1};
                // };
            // }
        // ]
    // ] remoteExec ["addMPEventHandler", 2];

    _vehicle addMPEventHandler ["MPKilled", {
        if (isServer) then {
            _d = driver (_this select 0);
            _g = gunner (_this select 0);
            if (!isNull _d) then {deleteVehicle _d};
            if (!isNull _g) then {_g setDamage 1};
        };
    }];

    // [
        // _vehicle,
        // [
            // "GetIn",
            // {
                // enableSentences false;
                // _tank = _this select 0;
                // _unit = _this select 2;
                // _unit allowDamage false;
                // _unit action ["EngineOn", _tank];
                // _unit action ["MoveToGunner", _tank];
                // _tank lock true;
                // _tank switchCamera "EXTERNAL";

                // _tank addAction
                // [
                    // localize "str_action_getout",
                    // {
                        // _this select 0 removeAction (_this select 2);
                        // _this select 1 action ["GetOut", _this select 0];
                    // },
                    // "",
                    // 3,
                    // false,
                    // true,
                    // "GetOver"
                // ];

                // _tank spawn
                // {
                    // waitUntil {!isNull gunner _this};
                    // _ai = createAgent [typeOf gunner _this, [0,0,0], [], 0, "NONE"];
                    // _ai allowDamage false;
                    // _ai moveInDriver _this;
                // };
            // }
        // ]
    // ] remoteExec ["addEventHandler", -2];

    _args = ["addEventHandler", [_vehicle, ["GetIn", {
        // enableSentences false;
        // _tank = _this select 0;
        // _unit = _this select 2;
        // _unit allowDamage false;
        // _unit action ["EngineOn", _tank];
        // _unit action ["MoveToGunner", _tank];
        // _tank lock true;
        // _tank switchCamera "EXTERNAL";

        // _tank addAction
        // [
            // localize "str_action_getout",
            // {
                // _this select 0 removeAction (_this select 2);
                // _this select 1 action ["GetOut", _this select 0];
            // },
            // "",
            // 3,
            // false,
            // true,
            // "GetOver"
        // ];

        // _tank spawn
        // {
            // waitUntil {!isNull gunner _this};
            // _ai = createAgent [typeOf gunner _this, [0,0,0], [], 0, "NONE"];
            // _ai allowDamage false;
            // _ai moveInDriver _this;
        // };

        0 = [_tank] spawn {
            _Vehicle = _this select 0;

            // to keep it simple if you use a tank as auto, dont also use it for regular spawned tanks.
            // _vehicleType = selectRandom ["uns_M113_XM182" ,"uns_M113A1_M40" ,"uns_m48a3" ,"uns_m551" ,"uns_t55_nva" ,"uns_t55_nva"];
            // _vehicleType = ["put only rhs type"];

            // best to use a class no sides will see as enemy
            _AiType = "I_Survivor_F";

            // _Vehicle = createVehicle [_vehicleType, getMarkerPos "respawn_independent", ["1","2"], 0, "CAN_COLLIDE"];
            _aItyPe = createAgent [_AiType,[0, 0, 0], [],0, "FORM"];
            // _Vehicle setPosATL [getPosATL player select 0, getPosATL player select 1, 0];
            // _Vehicle setDir _dir;
            // _Vehicle modelToWorld [0, 0, 0];

            // _Vehicle setFuel 0.5;
            player moveInGunner _Vehicle;
            _aItyPe moveInDriver _Vehicle;

            _aItyPe lock true;
            _Vehicle lockdriver true;

            // RTS_Vehicle = _Vehicle;

            // this need to be edited to rts respawn or ZEN
            // CLY_rage_respawn = false;

            26 cutText ["", "BLACK IN", 3];
            waitUntil {
                sleep 0.2;
                // this need to be edited to rts respawn or ZEN
                // (!alive player || CLY_rage_respawn)
                !(alive player)
            };

            if !(alive player) then {
                // RTS_Vehicle = objNull;
                deleteVehicle driver _Vehicle;
                deleteVehicle _Vehicle;
            };
        };

    }]]];
    ZEN_FMW_MP_RENonDedicated("Zen_ExecuteCommand", _args, call)

    // [
        // _vehicle,
        // [
            // "GetOut",
            // {
                // _tank = _this select 0;
                // _unit = _this select 2;
                // deleteVehicle driver _tank;
                // _unit allowDamage true;
                // _unit action ["EngineOff", _tank];
                // _tank lock false;
                // enableSentences true;
            // }
        // ]
    // ] remoteExec ["addEventHandler", -2];

    _args = ["addEventHandler", [_vehicle, ["GetOut", {
        _tank = _this select 0;
        _unit = _this select 2;
        deleteVehicle driver _tank;
        _unit allowDamage true;
        _unit action ["EngineOff", _tank];
        _tank lock false;
        enableSentences true;
    }]]];
    ZEN_FMW_MP_RENonDedicated("Zen_ExecuteCommand", _args, call)

};

/**
RTS_Vehicle = objNull;
0 = [] spawn {
    //to keep it simple if you use a tank as auto, dont also use it for regular spawned tanks.
    //_vehicleType = selectRandom ["uns_M113_XM182" ,"uns_M113A1_M40" ,"uns_m48a3" ,"uns_m551" ,"uns_t55_nva" ,"uns_t55_nva"];
    _vehicleType = ["put only rhs type"];

    //best to use a class no sides will see as enemy
    _AiType = selectRandom ["I_Survivor_F","I_Survivor_F","I_Survivor_F"];

    _Vehicle = createVehicle [_vehicleType, getMarkerPos "respawn_independent", ["1","2"], 0, "CAN_COLLIDE"];
    _aItyPe = createAgent [_AiType,[0, 0, 0], [],0, "FORM"];
    _Vehicle setPosATL [getPosATL player select 0, getPosATL player select 1, 0];
    _Vehicle setDir _dir;
    _Vehicle modelToWorld [0, 0, 0];

    _Vehicle setFuel 0.5;
    player moveInGunner _Vehicle;
    _aItyPe moveInDriver _Vehicle;

    _aItyPe lock true;
    _Vehicle lockdriver true;

    // RTS_Vehicle = _Vehicle;

    // this need to be edited to rts respawn or ZEN
    // CLY_rage_respawn = false;

    26 cutText ["", "BLACK IN", 3];
    waitUntil {
        sleep 0.2;
        // this need to be edited to rts respawn or ZEN
        // (!alive player || CLY_rage_respawn)
        !(alive player)
    };

    if !(alive player) then {
        // RTS_Vehicle = objNull;
        deleteVehicle driver _Vehicle;
        deleteVehicle _Vehicle;
    };
};
//*/
