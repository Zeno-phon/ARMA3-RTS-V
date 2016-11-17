if (isMultiplayer) then {
    Start_Money = paramsArray select 0;
    // Start_Supply = paramsArray select 1;
    // Game_Type = paramsArray select 2;
    Respawn_Delay = paramsArray select 3;
    aiLimit = paramsArray select 4;
} else {
    Start_Money = 100000;
    Respawn_Delay = 0;
    aiLimit = 99;
};
