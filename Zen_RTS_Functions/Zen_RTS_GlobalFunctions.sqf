GetSideID = {
    (0)
};

GetClientID = {
    (0)
};

GetNamespace = {
    (0)
};

Zen_RTS_F_RequestEconomyData = {
    (owner _this) publicVariableClient "Zen_RTS_Economy_Data";
};

Zen_RTS_F_RespawnActions = {
    // player sideChat "Respawn Actions Running";
    while {true} do {
        0 = [player] spawn Zen_RTS_DeployPlayer;

        waitUntil {
            sleep 2;
            (alive player)
        };

        0 = [player, player, 0] spawn RTS_FNC_INIT_PLAYERACTIONS;

        waitUntil {
            sleep 2;
            !(alive player)
        };
    };
};

Zen_RTS_F_ModifyMoney = {
    playerMoney = playerMoney + _this;
};

Zen_RTS_F_SetMoney = {
    playerMoney = _this;
};

Zen_RTS_F_PrintMoney = {
    _moneyPerMinute = _this select 0;
    _supply = _this select 1;
    _supplyPerMinute = _this select 2;
    _side = _this select 3;

    if ((side player) == _side) then {
        ctrlSetText [idMoney, format ["Funds : %1 +%2/min", floor playerMoney, _moneyPerMinute]];
        ctrlSetText [idSupply, format ["Supply: %1 +%2/min", floor _supply, _supplyPerMinute]];
        ctrlSetText [idFPS, format ["FPS: %1", round diag_fps]];
    };
};
