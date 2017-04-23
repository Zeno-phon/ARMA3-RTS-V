// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

disableSerialization;
#include "..\Zen_FrameworkLibrary.sqf"
#include "..\Zen_StandardLibrary.sqf"

#define CONTROL_EHS ["MOUSEENTER", "MOUSEEXIT", "SETFOCUS", "KILLFOCUS", "MOUSEBUTTONDOWN", "MOUSEBUTTONUP", "MOUSEBUTTONDBLCLICK", "MOUSEMOVING", "MOUSEHOLDING", "MOUSEZCHANGED", "KEYDOWN", "KEYUP", "HTMLLINK", "MOUSEBUTTONCLICK"]

_Zen_stack_Trace = ["Zen_InvokeDialog", _this] call Zen_StackAdd;
private ["_dialogID", "_controlsArray", "_Zen_Dialog_Controls_Local", "_idcCur", "_display", "_controlData", "_controlType", "_controlBlocks", "_controlInstanClass", "_control", "_blockID", "_data", "_doRefresh", "_allowActions", "_offset", "_disableEsc", "_mapPos", "_element", "_maxElement", "_controlIDsArray", "_hashes", "__time", "_mapTime", "_unchangedControls", "_newControls", "_controlsToRepeatData"];

if !([_this, [["STRING"], ["ARRAY"], ["BOOL"]], [[], ["SCALAR"]], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_dialogID = _this select 0;
_offset = [0,0];
ZEN_STD_Parse_GetArgument(_offset, 1)
ZEN_STD_Parse_GetArgumentDefault(_allowActions, 2, false)
ZEN_STD_Parse_GetArgumentDefault(_disableEsc, 3, false)

__time = 0;
_mapTime= 1;
if (count _this > 4) then {
    _doRefresh = true;
    _controlsToRepeatData = _this select 4;

    _controlIDsArray = [];
    _controlsArray = [];
    _hashes = [];
    {
        _controlIDsArray pushBack (_x select 0);
        _controlsArray pushBack (_x select 1);
        _hashes pushBack (_x select 2);
    } forEach _controlsToRepeatData;

    _unchangedControls = _this select 5;
    _newControls = _this select 6;
    __time = _this select 7;
    if (__time > 0) then {
        _mapTime = __time;
    };
} else {
    _newControls = [];
    _doRefresh = false;
    _controlIDsArray = [_dialogID] call Zen_GetDialogControls;
};

_Zen_Dialog_Controls_Local = [];
_idcCur = 7600;
#define NEXT_IDC _idcCur]; _idcCur = _idcCur + 1;
#define GRID_DIVISION 0.025
#define COLOR_STEP 255
#define FONT_DIVISION 300

if !(_doRefresh) then {
    (findDisplay 76) closeDisplay 0;
    closeDialog 0;

    _display = (findDisplay 46) createDisplay "Zen_Dialog";
    if !(_allowActions) then {
        createDialog "Zen_Dialog";
    };

    if (_disableEsc) then {
        (findDisplay 76) displayAddEventHandler ["KeyDown", {
            ((_this select 1) == 1)
        }];
    };
} else {
    _display = (findDisplay 76);
    _Zen_Dialog_Controls_Local append _unchangedControls;
};

{
    _controlID = _x;
    _controlData = [_controlID] call Zen_GetControlData;

    if (count _controlData > 0) then {
        _controlType = _controlData select 1;
        _controlBlocks = _controlData select 2;

        _controlInstanClass = switch (toUpper _controlType) do {
            case "BUTTON": {("RSCButton")};
            case "LIST": {("RscListBox")};
            case "TEXT": {("RscText")};
            case "SLIDER": {("RscXSliderH")};
            case "PICTURE": {("RscPicture")};
            case "TEXTFIELD": {("RscEdit")};
            case "DROPLIST": {("RscCombo")};
            case "PROGRESSBAR": {("RscProgress")};
            case "MAP": {("RscMapControl")};
            case "STRUCTUREDTEXT": {("RscStructuredText")};
            default {("")};
        };

        if (_controlInstanClass != "") then {

            _control = objNull;
            if (_doRefresh && {_controlID in _controlIDsArray}) then {
                _control = _controlsArray select _forEachIndex;
                _Zen_Dialog_Controls_Local pushBack [_controlID, _control, _hashes select _forEachIndex];
            } else {
                _control = _display ctrlCreate [_controlInstanClass, NEXT_IDC
                _Zen_Dialog_Controls_Local pushBack [_controlID, _control, ([_controlID] call Zen_HashControlData)];

                if (toUpper _controlType in ["SLIDER"]) then {
                    _control sliderSetPosition 0;
                    _control sliderSetSpeed [1, 5];
                };

                if (toUpper _controlType in ["PROGRESSBAR"]) then {
                    _control progressSetPosition 0;
                };
            };

            if ((toUpper _controlType) in ["LIST","DROPLIST"]) then {
                _element = 0;
                if (_doRefresh && {_controlID in _controlIDsArray}) then {
                    _element = lbCurSel _control;
                    lbClear _control;
                };

                {
                    if ((toUpper (_x select 0)) == "LIST") then {
                        {
                            _control lbAdd _x;
                        } forEach (_x select 1);
                        _maxElement = (count (_x select 1)) - 1;
                    };
                } forEach _controlBlocks;

                _control lbSetCurSel (_element min _maxElement);
            };

            {
                _blockID = _x select 0;
                _data = _x select 1;
                switch (toUpper _blockID) do {
                    case "ACTIVATIONFUNCTION": {
                        switch (toUpper _controlType) do {
                            case "BUTTON": {
                                _control buttonSetAction (format ["['%1', 'ActivationFunction'] spawn Zen_ExecuteEvent", _controlID]);
                            };
                            case "LIST": {
                                _control ctrlSetEventHandler ["LBDblClick", (format ["['%1', 'ActivationFunction'] spawn Zen_ExecuteEvent", _controlID])]
                            };
                        };
                    };
                    case "ANGLE": {
                        _control ctrlSetAngle _data;
                    };
                    case "BACKGROUNDCOLOR": {
                        _control ctrlSetBackgroundColor [(_data select 0) / COLOR_STEP, (_data select 1) / COLOR_STEP, (_data select 2) / COLOR_STEP, (_data select 3) / COLOR_STEP];
                    };
                    case "FONT": {
                        _control ctrlSetFont _data;
                    };
                    case "FONTSIZE": {
                        _control ctrlSetFontHeight _data / FONT_DIVISION;
                    };
                    case "FONTCOLOR": {
                        if ((toUpper _controlType) in ["LIST","DROPLIST"]) then {
                            for "_i" from 0 to (lbSize _control - 1) do {
                                _control lbSetColor [_i, [(_data select 0) / COLOR_STEP, (_data select 1) / COLOR_STEP, (_data select 2) / COLOR_STEP, (_data select 3) / COLOR_STEP]];
                            };
                        } else {
                            _control ctrlSetTextColor [(_data select 0) / COLOR_STEP, (_data select 1) / COLOR_STEP, (_data select 2) / COLOR_STEP, (_data select 3) / COLOR_STEP];
                        };
                    };
                    case "FONTCOLORSELECTED": {
                        if ((toUpper _controlType) in ["LIST","DROPLIST"]) then {
                            for "_i" from 0 to (lbSize _control - 1) do {
                                _control lbSetSelectColor [_i, [(_data select 0) / COLOR_STEP, (_data select 1) / COLOR_STEP, (_data select 2) / COLOR_STEP, (_data select 3) / COLOR_STEP]];
                            };
                        } else {
                            _control ctrlSetActiveColor [(_data select 0) / COLOR_STEP, (_data select 1) / COLOR_STEP, (_data select 2) / COLOR_STEP, (_data select 3) / COLOR_STEP];
                        };
                    };
                    case "FOREGROUNDCOLOR": {
                        _control ctrlSetForegroundColor [(_data select 0) / COLOR_STEP, (_data select 1) / COLOR_STEP, (_data select 2) / COLOR_STEP, (_data select 3) / COLOR_STEP];
                    };
                    case "LISTTOOLTIP": {
                        if ((toUpper _controlType) in ["LIST"]) then {
                            for "_i" from 0 to (lbSize _control - 1) do {
                                _control lbSetTooltip [_i, _data select _i];
                            };
                        };
                    };

                    case "EVENT": {
                        {
                            if (_doRefresh && {_controlID in _controlIDsArray}) then {
                                _control ctrlRemoveAllEventHandlers _x;
                            }
                        } forEach CONTROL_EHS;

                        {
                            if (toUpper (_x select 0) in CONTROL_EHS) then {
                                _control ctrlAddEventHandler [_x select 0, compile format ["
                                        ['%1', 'Event', round %2, (if (count _this > 1) then {[([_this, 1] call Zen_ArrayGetIndexedSlice)]} else {[]})] spawn Zen_ExecuteEvent;
                                ", _controlID, _forEachIndex]];
                            };
                        } forEach _data;
                    };

                    case "MAPPOSITION": {
                        ctrlMapAnimClear _control;
                        _control ctrlMapAnimAdd [_mapTime, ctrlMapScale _control, ([_data] call Zen_ConvertToPosition)];
                        ctrlMapAnimCommit _control;
                    };
                    case "MAPZOOM": {
                        ctrlMapAnimClear _control;
                        _mapPos = ctrlPosition _control;
                        _control ctrlMapAnimAdd [_mapTime, _data, _control ctrlMapScreenToWorld ([(_mapPos select 0) + (_mapPos select 2) / 2, (_mapPos select 1) + (_mapPos select 3) / 2])];
                        ctrlMapAnimCommit _control;
                    };
                    case "PICTURE": {
                        if ((toUpper _controlType) in ["LIST","DROPLIST"]) then {
                            for "_i" from 0 to (lbSize _control - 1) do {
                                _control lbSetPicture [_i, _data select _i];
                            };
                        } else {
                            if ([".paa", _data] call Zen_StringIsInString) then {
                                _control ctrlSetText _data;
                            };
                        };
                    };
                    case "PICTURECOLOR": {
                        if ((toUpper _controlType) in ["LIST","DROPLIST"]) then {
                            for "_i" from 0 to (lbSize _control - 1) do {
                                _control lbSetPictureColor [_i, [(_data select 0) / COLOR_STEP, (_data select 1) / COLOR_STEP, (_data select 2) / COLOR_STEP, (_data select 3) / COLOR_STEP]];
                            };
                        };
                    };
                    case "PICTURECOLORSELECTED": {
                        if ((toUpper _controlType) in ["LIST","DROPLIST"]) then {
                            for "_i" from 0 to (lbSize _control - 1) do {
                                _control lbSetPictureColorSelected [_i, [(_data select 0) / COLOR_STEP, (_data select 1) / COLOR_STEP, (_data select 2) / COLOR_STEP, (_data select 3) / COLOR_STEP]];
                            };
                        };
                    };
                    case "POSITION": {
                        _control ctrlSetPosition [(_data select 0) * GRID_DIVISION + (_offset select 0), (_data select 1) * GRID_DIVISION + (_offset select 1)];
                    };
                    case "PROGRESS": {
                        _control progressSetPosition (((_data max 0) min 255) / 255);
                    };
                    case "SELECTIONFUNCTION": {
                        if ((toUpper _controlType) in ["LIST", "DROPLIST"]) then {
                            _control ctrlSetEventHandler ["LBSelChanged", (format ["['%1', 'SelectionFunction'] spawn Zen_ExecuteEvent", _controlID])];
                        };

                        if ((toUpper _controlType) in ["SLIDER"]) then {
                            _control ctrlSetEventHandler ["SliderPosChanged", (format ["['%1', 'SelectionFunction'] spawn Zen_ExecuteEvent", _controlID])];
                        };
                    };
                    case "SIZE": {
                        _oldPos = ctrlPosition _control;
                        _control ctrlSetPosition (([_oldPos, 0, 1] call Zen_ArrayGetIndexedSlice) + [(_data select 0) * GRID_DIVISION, (_data select 1) * GRID_DIVISION]);
                    };
                    case "SLIDERPOSITIONS": {
                        _control sliderSetRange [0, _data max 1];
                    };
                    case "TEXT": {
                        if ((toUpper _controlType) == "STRUCTUREDTEXT") then {
                            _control ctrlSetStructuredText parseText _data;
                        } else {
                            _control ctrlSetText _data;
                        };
                    };
                    case "TOOLTIPFONTCOLOR": {
                        _control ctrlSetTooltipColorText [(_data select 0) / COLOR_STEP, (_data select 1) / COLOR_STEP, (_data select 2) / COLOR_STEP, (_data select 3) / COLOR_STEP];
                    };
                    case "TOOLTIPBACKGROUNDCOLOR": {
                        _control ctrlSetTooltipColorShade [(_data select 0) / COLOR_STEP, (_data select 1) / COLOR_STEP, (_data select 2) / COLOR_STEP, (_data select 3) / COLOR_STEP];
                    };
                    case "TOOLTIPBORDERCOLOR": {
                        _control ctrlSetTooltipColorBox [(_data select 0) / COLOR_STEP, (_data select 1) / COLOR_STEP, (_data select 2) / COLOR_STEP, (_data select 3) / COLOR_STEP];
                    };
                    case "TOOLTIP": {
                        _control ctrlSetTooltip _data;
                    };
                    case "TRANSPARENCY": {
                        _control ctrlSetFade _data;
                    };
                    default {};
                };
                _control ctrlCommit __time;
            } forEach _controlBlocks;

            // _control ctrlCommit __time;
        };
    };
} forEach (_controlIDsArray + _newControls);

// if !(_doRefresh) then {
    uiNamespace setVariable ["Zen_Dialog_Object_Local", [_dialogID, _Zen_Dialog_Controls_Local, _offset]];
// } else {
    // _oldLocalData = uiNamespace getVariable "Zen_Dialog_Object_Local";
    // _localToAdd = +(_oldLocalData select 1);

    // {
        // _refreshedControlID = _x select 0;
        // {
            // if ((_x select 0) == _refreshedControlID) exitWith {
                // 0 = [_localToAdd, _forEachIndex] call Zen_ArrayRemoveIndex;
            // };
        // } forEach +_localToAdd;
    // } forEach _Zen_Dialog_Controls_Local;

    // uiNamespace setVariable ["Zen_Dialog_Object_Local", [_dialogID, _Zen_Dialog_Controls_Local + _localToAdd, _offset]];
// };

call Zen_StackRemove;
if (true) exitWith {};
