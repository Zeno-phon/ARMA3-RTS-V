#define IDListGroup	1020

class Base_Button : RscButton
    {
        h = 0.040;
        font = FontTITLEHalf;
        colorText[] = {1, 1, 1, 1};
        sizeEx = 0.025;
        w = 0.20;
    };

class RscMoneyLabel : RscText
    {
        idc = 1037;
        x = 0.01;
        y = 0.10;
        w = 0.25;
        h = 0.07;
        sizeEx = 0.020;
        font = "EtelkaNarrowMediumPro";
        text = "";
        colorText[] = {1,1,1,1};
    };

class RscSupplyLabel : RscText
    {
        idc = 1038;
        x = 0.01;
        y = 0.15;
        w = 0.25;
        h = 0.07;
        sizeEx = 0.020;
        font = "EtelkaNarrowMediumPro";
        text = "";
        colorText[] = {1,1,1,1};
    };
    class RscFPSLabel : RscText
    {
        idc = 666;
        x = 0.01;
        y = 0.20;
        w = 0.25;
        h = 0.07;
        sizeEx = 0.025;
        font = "EtelkaNarrowMediumPro";
        text = "";
        colorText[] = {1,1,1,1};
    };


class RscStatList : RscListBox
    {
        idc = 500;
        x = "(SafeZoneW + SafeZoneX) - (0.27)";
        y = "SafeZoneY + 0.55";
        w = 0.25;
        h = 0.25;
        sizeEx = 0.025;
        colorText[] = {0.02, 0.2, 0.7, 0.6};
        rowHeight = 0.025;
        };

class RscStatBackground : RscText
    {
        colorBackground[] = {0,0,0,0};
        color[] = {0,0,0,0};
        text = ;
        x = "(SafeZoneW + SafeZoneX) - (0.27)";
        y = "SafeZoneY + 0.55";
        w = 0.25;
        h = 0.25;
    };


class RscQueueList : RscListBox
    {
        idc = 600;
        x = 0.0;
        y = 0.0;
        w = 0.0;
        h = 0.0;
        colorBackground[] = {0,0,0,0};
        color[] = {0,0,0,0};
        sizeEx = 0.3;
        rowHeight = 0.0;
   };

class RscLabelBarracksQueue : RscText
    {
        idc = 1030;
        x = 0.0;
        y = 0.60;
        w = 0.30;
        h = 0.05;
        colorText[] = {1,0,0,1};
        sizeEx = 0.020;
        text = "Empty";

    };

class RscButtonBarracksQueue : RscButtonSmall
    {
        idc = 1031;
        x = 0.15;
        y = 0.60;
        w = 0.06;
        h = 0.05;
         colorText[] = {1, 1, 1, 1};
        sizeEx = 0.020;
        text = "Cancel";
        action = "";
        // action = "[""Sld""] exec ""rts-build-cancel.sqs""";

    };

class RscLabelLightQueue : RscText
    {
        idc = 1032;
        x = 0.0;
        y = 0.65;
        w = 0.30;
        h = 0.05;
        colorText[] = {1,0,0,1};
        sizeEx = 0.020;
        text = "Empty";
    };

class RscButtonLightQueue : RscButtonSmall
    {
        idc = 1033;
        x = 0.15;
        y = 0.65;
        w = 0.06;
        h = 0.05;
         colorText[] = {1, 1, 1, 1};
        sizeEx = 0.020;
        text = "Cancel";
        action = "";
        // action = "[""Vcl""] exec ""rts-build-cancel.sqs""";
    };

class RscLabelHeavyQueue : RscText
    {
        idc = 1034;
        x = 0.0;
        y = 0.70;
        w = 0.30;
        h = 0.05;
        colorText[] = {1, 0, 0, 1};
        sizeEx = 0.020;
        text = "Empty";
    };

class RscButtonHeavyQueue : RscButtonSmall
    {
        idc = 1035;
        x = 0.15;
        y = 0.70;
        w = 0.06;
        h = 0.05;
         colorText[] = {1, 1, 1, 1};
        sizeEx = 0.020;
        text = "Cancel";
        action = "";
        // action = "[""Vcl""] exec ""rts-build-cancel.sqs""";
    };

class RscLabelAirQueue : RscText
    {
        idc = 1036;
        x = 0.0;
        y = 0.55;
        w = 0.30;
        h = 0.05;
        colorText[] = {1,0,0,1};
        sizeEx = 0.020;
        text = "Empty";

    };

class RscButtonAirQueue : RscButtonSmall
    {
        idc = 1039;
        x = 0.15;
        y = 0.55;
        w = 0.06;
        h = 0.05;
         colorText[] = {1, 1, 1, 1};
        sizeEx = 0.020;
        text = "Cancel";
        action = "";
        // action = "[""Air""] exec ""rts-build-cancel.sqs""";

    };
//class RscLabelNavalQueue : RscText
    //{
    //	idc = 1041;
    //	colorBackground[] = {0.2, 0.2, 0.2, .7};
    //	x = safeZoneX + 0.440;
    //	y = safeZoneY + 0.855 + .110;
    //	w = 0.30;
    //	h = 0.05;
    //	sizeEx = 0.020;
    //	text = "Empty";
    //};

//class RscButtonNavalQueue : RscButton
    //{
        //idc = 1042;
        //x = safeZoneX + 0.750;
    //	y = safeZoneY + 0.855 + .110;
    //	w = 0.05;
    //	h = 0.05;
    //	sizeEx = 0.020;
        //text = "Cancel";
    //	action = "[""Vcl""] exec ""rts-build-cancel.sqs""";
    //};
class RscListBackground : RscText
    {
        text = "";
        x = 0.22;
        y = 0.0;
        w = 0.58;
        h = 0.50;
        colorText[] = {1,1,1,1};
    };

    class RESEARCH_LIST : RscListBoxSmall
    {
        idc = -1;//400;
        rowHeight = 0.035;
        x = 0.22;
        y = 0.1;
        w = 0.58;
        h = 0.25;
    };
    class RESEARCH_TITLE : RscSmallTitleBlack
    {
        idc = -1;
        x = 0.22;
        y = 0.1;
        w = 0.30;
        h = 0.03;
        text = "RESEARCH STATS";
    };
        //class RESEARCH_STATUS_CURRENT : RscSmallTitleBlack
    //{
            //idc = -1;//450;
        //	style = ST_LEFT;
        //	x = 0.37;
        //	y = 0.38;
        //	w = 0.330;
        //	h = 0.03;
        //	font = FontTITLEHalf;
        //	colorText[] = {1, 1, 1, 1};
        //	colorBackground[] = {0, 0, 0, 1};
        //	sizeEx = 0.02;
        //	text = "";

        class RscListMain : RscListBoxSmall
    {
        idc = -1;
        rowHeight = 0.035;
        x = 0.22;
        y = 0.1;
        w = 0.58;
        h = 0.25;
    };
//Dialog for Mission Control  IDs 1000-1050
class DlgStatus
{
    idd = -1;
    movingEnable = true;
    controlsBackground[] =
    {
        CENTER_FRAME_TITLE
        , TOP_RIGHT_TITLE
        , FRAME_BACKGROUND
        //, FRAME_STATS
        , RIGHT_FRAME_BACKGROUND
        , RIGHT_FRAME_BACKGROUND2
        , RIGHT_FRAME_PICTURE
        , RIGHT_FRAME_TEXT
        , RIGHT_FRAME_TEXT2
        , TOP_left_TITLE
        , left_FRAME_BACKGROUND
        , left_FRAME_BACKGROUND2
        , left_FRAME_PICTURE
        , left_FRAME_TEXT
        , left_FRAME_TEXT2
    };

        class CENTER_FRAME_TITLE : RscText
        {
        idc = 1050;
            style = ST_CENTER;
            x = 0.22;
            y = 0.0;
            w = 0.58;
            h = 0.1;
            font = FontTITLE;
            colorText[] = {1, 0, 0, 1};
            colorBackground[] = {0.1, 0.1, 0.1, 1};
            sizeEx = 0.050;
            text = " RTS V Mission Status";
    };

        class FRAME_BACKGROUND : RscText
    {
        colorBackground[] = {0.4, 0.4, 0.4, 0.75};
        text = "";
        x = 0.22;
        y = 0.1;
        w = 0.58;
        h = 0.91;
    };
        //class FRAME_STATS : RscText//not used
    //{
    //	idc = -1;
    //	style = ST_FRAME;
    //	colorText[] = {1, 0, 0, 1};
    //	text = "";
    //};
   class TOP_RIGHT_TITLE : RscText
    {
            idc = -1;
            style = ST_CENTER;
            x = 0.80;
            y = 0.0;
            w = 0.2;
            h = 0.15;
            text = "";
            font = FontTITLE;
            colorText[] = {1, 1, 1, 1};
            colorBackground[] ={0, 0, 1, 0.75};
            sizeEx = 0.03;
    };
    class RIGHT_FRAME_PICTURE : RscPicture
    {
            idc = 50;
            x = 0.80;
            y = 0.12;
            w = 0.2;
            h = 0.15;
            colorText[] = {1, 1, 1, 1};
            colorBackground[] =  {0, 0, 1, 0.75};
            text = "pictures\rtspatch1.paa";
    };

    class RIGHT_FRAME_BACKGROUND : RscText
    {
        colorBackground[] = {0, 0, 1, 0.75};
        text = "";
        x = 0.80;
        y = 0.1;
        w = 0.2;
        h = 0.9;
    };

    class RIGHT_FRAME_BACKGROUND2 : RscText
    {
        colorBackground[] = {0.1, 0.1, 0.1, 0.75};
        text = "";
        x = 0.80;
        y = 0.1;
        w = 0.2;
        h = 0.9;
    };

    class RIGHT_FRAME_TEXT : RscText
    {
        idc = 51;
        colorBackground[] = {0, 0, 0, 1};
        text = "";
        x = 0.80;
        y = 0.3;
        w = 0.2;
        h = 0.05;
        style = ST_CENTER;
    };

    class RIGHT_FRAME_TEXT2 : RscText
    {
        idc = 52;
        colorBackground[] = {0, 0, 0, 1};
        text = "UNIT CONTROL";
        x = 0.80;
        y = 0.35;
        w = 0.2;
        h = 0.05;
        style = ST_CENTER;
    };
class TOP_left_TITLE : RscText
    {
            idc = -1;
            style = ST_CENTER;
            x = 0.02;
            y = 0.0;
            w = 0.2;
            h = 0.1;
            text = "INFOMATION";
            font = FontTITLE;
            colorText[] = {1, 1, 1, 1};
            colorBackground[] = {0, 0, 1, 0.75};
            sizeEx = 0.03;
    };
    class left_FRAME_PICTURE : RscPicture
    {
            idc = 53;
            x = 0.02;
            y = 0.0;
            w = 0.2;
            h = 0.15;
            colorText[] = {1, 1, 1, 1};
            colorBackground[] = {0, 0, 1, 0.75};
            text = "";
    };

    class left_FRAME_BACKGROUND : RscText
    {
        colorBackground[] = {0, 0, 1, 0.75};
        text = "";
        x = 0.02;
        y = 0.1;
        w = 0.2;
        h = 0.9;
    };

    class left_FRAME_BACKGROUND2 : RscText
    {
        colorBackground[] = {0.1, 0.1, 0.1, 0.75};
        text = "";
        x = 0.02;
        y = 0.1;
        w = 0.2;
        h = 0.9;
    };

    class left_FRAME_TEXT : RscText
    {
        idc = 51;
        colorBackground[] = {0, 0, 0, 1};
        text = "";
        x = 0.02;
        y = 0.3;
        w = 0.2;
        h = 0.05;
        style = ST_CENTER;
    };

    class left_FRAME_TEXT2 : RscText
    {
        idc = 52;
        colorBackground[] = {0, 0, 0, 1};
        text = "";
        x = 0.02;
        y = 0.35;
        w = 0.2;
        h = 0.05;
        style = ST_CENTER;
    };
                class List_Background : RscListBackGround {};

                class Group_Background : RscText
                    {
                   idc = 2026;
                    text = "";
                    x = 0.78;
                    y = 0.400;
                    w = 0.400;
                    h = 0.200;

            };

              class Stats_Background : RscStatBackGround {};

    class controls
        {

        class List_Assets : RESEARCH_LIST
        {
            idc = 1000;
            onButtonClick = "[1000] exec ""rts-build-menu.sqs""";
        };

        class Button_Help : base_button
        {
            idc = -1;
           x = 0.02;
           y = 0.91;
           w = 0.2;
           h = 0.10;
            font = FontTITLEHalf;
            colorText[] =  {1, 0, 0, 1};
            text = "HELP MENU";
            action = "[] exec ""rts-z-helpmenu.sqs""";
        };

        class Button_Select : base_button
        {
            idc = 1005;
           x = 0.80;
           y = 0.60;
           w = 0.2;
           h = 0.05;
            sizeEx = 0.030;
            text = "View Units";
            action = "[1000] exec ""rts-build-menu.sqs""";
        };

        class SOLDIERS_TITLE : RscSmallTitleBlack
    {
        idc = -1;
        x = 0.42;
        y = 0.77;
        w = 0.325;
        h = 0.05;
        text = "SOLDIERS IN YOUR GROUP";
    };

        class SOLDIERS_LIST : RscListBoxSmall
        {
        idc = IDListGroup;
        x = 0.40;
        y = 0.810;
        w = 0.400;
        h = 0.200;
        sizeEx = 0.03;
        rowHeight = 0.03;

    };
    class Button_Viewdistance : base_button
        {
        idc = 1010;
        x = 0.80;
        y = 0.410;
        w = 0.2;
        h = 0.04;
        sizeEx = 0.030;
        text = "ViewDistance";
        action = "[1015] call Zen_RTS_SetViewDistance""";
        };

        class List_Viewdistance : RscCombo
        {
        idc = 1015;
        type = CT_COMBO;
        x= "(SafeZoneW + SafeZoneX) - (0.71)";
        y = 0.410;
        w = 0.08;
        h = 0.04;
        wholeHeight = 0.3;
        sizeEx = 0.030;
        };

        class Button_FlyinHeight : base_button
        {
            idc = -1;
           x = 0.80;
            y = 0.510;
            w = 0.2;
            h = 0.04;
            sizeEx = 0.030;
            text = "Set AI Flight Height";
            action = "[1020,1040,1] exec ""rts-units-orders.sqs""";
        };

        class List_Heights : RscCombo
        {
            idc = 1040;
            type = CT_COMBO;
            x= "(SafeZoneW + SafeZoneX) - (0.71)";
            y = 0.510;
            w = 0.08;
            h = 0.04;
            wholeHeight = 0.3;
            sizeEx = 0.030;
            onMouseButtonDblClick= "[1020,1040,1] exec ""rts-units-orders.sqs""";

    };

        class Button_CustomSquads : base_button
        {
            idc = 1003;
        x = 0.80;
        y = 0.610;
        w = 0.2;
        h = 0.05;
            sizeEx = 0.030;
            text = "Customize Squads";
            action = "[] exec ""rts-squads-Menu.sqs""";
        };
            class   BUTTON_PUSH : RscButton
        {
        idc = -1;
         x = 0.80;
        y = 0.650;
        sizeEx = 0.030;
        font = FontTITLEHalf;
        colorText[] = {0, 1, 1, 1};
        text = "PUSH";
        action = "closeDialog 0; call RTS_FNC_PUSH";
        };
                    class BUTTON_UPRIGHT : RscButton
        {
        idc = -1;
         x = 0.80;
        y = 0.710;
        sizeEx = 0.030;
        font = FontTITLEHalf;
        colorText[] = {0, 1, 1, 1};
        text = "Upright Vehicle";
        action = "closeDialog 0; call RTS_FNC_flipACTIONS";
        };
            class Button_Release : RscButtonSmall
        {
            idc = 1025;
           x = 0.80;
           y = 0.810;
           w = 0.2;
           h = 0.05;
            sizeEx = 0.030;
            font = FontTITLEHalf;
        colorText[] = {0, 1, 0, 1};
            text = "Disband Selected Unit";
            action = "[1020] exec ""rts-unit-release.sqs""";
        };

                class BUTTON_CANCEL : RscButton2
        {
        idc = -1;
        x = 0.8;
        y = 0.910;
        w = 0.2;
        h = 0.10;
        sizeEx = 0.030;
        font = FontTITLEHalf;
        colorText[] = {1, 0, 0, 1};
        text = "EXIT MENU";
        action = "closeDialog 0";
        };
        class Label_Money : RscMoneyLabel {};
        class Label_Supply : RscSupplyLabel {};
        class Label_FPS : RscFPSLabel {};
        class List_Stats : RscStatList {};
        class List_Queue : RscQueueList {};

        class LabelBarracksQueue : RscLabelBarracksQueue {};
        class ButtonBarracksQueue : RscButtonBarracksQueue {};
        class LabelLightQueue : RscLabelLightQueue {};
        class ButtonLightQueue : RscButtonLightQueue {};
        class LabelHeavyQueue : RscLabelHeavyQueue {};
        class ButtonHeavyQueue : RscButtonHeavyQueue {};
        class LabelAirQueue : RscLabelAirQueue {};
        class ButtonAirQueue : RscButtonAirQueue {};
        //class LabelNavalQueue : RscLabelNavalQueue {};
        //class ButtonNavalQueue : RscButtonNavalQueue {};

        };//end controls

    };//end dlgStatus
//Dialog for Vehicle Building.  IDs 2000-2050
class DlgBuild
    {
        idd = 2002;
        movingEnable = 1;
    controlsBackground[] =
    {
        CENTER_FRAME_TITLE
        , TOP_RIGHT_TITLE
        , FRAME_BACKGROUND
        , RIGHT_FRAME_BACKGROUND
        , RIGHT_FRAME_BACKGROUND2
        , RIGHT_FRAME_PICTURE
        , RIGHT_FRAME_TEXT
        , RIGHT_FRAME_TEXT2
    };

    class CENTER_FRAME_TITLE : RscText
    {
            idc = 1050;
            style = ST_CENTER;
            x = 0.22;
            y = 0.0;
            w = 0.58;
            h = 0.1;
            font = FontTITLE;
            colorText[] = {1, 0, 0, 1};
            colorBackground[] = {0.1, 0.1, 0.1, 1};
            sizeEx = 0.050;
            text = " COMMAND & CONTROL ";
    };

    class FRAME_BACKGROUND : RscText
    {
        colorBackground[] = {0.4, 0.4, 0.4, 0.75};
        text = "";
        x = 0.22;
        y = 0.1;
        w = 0.58;
        h = 0.99;
    };

    class TOP_RIGHT_TITLE : RscText
    {
            idc = -1;
            style = ST_CENTER;
            x = 0.8;
            y = 0.0;
            w = 0.2;
            h = 0.1;
            font = FontTITLE;
            colorText[] = {1, 1, 1, 1};
            colorBackground[] = {0, 0, 0, 1};
            sizeEx = 0.03;
            text = "R T S - V";
    };

    class RIGHT_FRAME_BACKGROUND : RscText
    {
        colorBackground[] = {0, 0, 1, 0.75};
        text = "";
        x = 0.8;
        y = 0.1;
        w = 0.2;
        h = 0.9;
    };

    class RIGHT_FRAME_BACKGROUND2 : RscText
    {
        colorBackground[] = {0.1, 0.1, 0.1, 0.75};
        text = "";
        x = 0.8;
        y = 0.1;
        w = 0.2;
        h = 0.9;
    };

    class RIGHT_FRAME_PICTURE : RscPicture
    {
        idc = 50;
        colorBackground[] = {0.1, 0.1, 0.1, 0.75};
        colorText[] = {1, 1, 1, 1};
        text = "";
        x = 0.8;
        y = 0.135;
        w = 0.2;
        h = 0.13;
    };

    class RIGHT_FRAME_TEXT : RscText
    {
        idc = 51;
        colorBackground[] = {0, 0, 0, 1};
        text = "";
        x = 0.8;
        y = 0.3;
        w = 0.2;
        h = 0.05;
        style = ST_CENTER;
    };
    class RIGHT_FRAME_TEXT2 : RscText
    {
        idc = 52;
        colorBackground[] = {0, 0, 0, 1};
        text = "BUILD MENU";
        x = 0.8;
        y = 0.35;
        w = 0.2;
        h = 0.05;
        style = ST_CENTER;
    };
            class List_Background : RscListBackGround {};

            class Group_Background : RscText
                {
                    idc = 2026;
                    text = ;
                        x = 0.78; //0.771;
                        y = 0.400;
                        w = 0.400;
                        h = 0.400;
                };

            class Background_CustomSquads : RscText
                {
                    text = ;
                    idc = 2031;
                    x = 0.81;
                    y = 0.35;
                    w = 0.18;
                    h = 0.15;
                };

            class Stats_Background : RscStatBackGround {};

        class controls
            {
            class List_CrewCount : RscCombo {
                idc = 2045;
                type = CT_COMBO;
                x= "(SafeZoneW + SafeZoneX) - (0.71)";
                y = 0.410;
                w = 0.08;
                h = 0.04;
                wholeHeight = 0.3;
                sizeEx = 0.030;
            };

            class List_Vehicles : RscListMain
                {
                    idc = 2000;
                    onButtonClick = "uiNamespace setVariable ['2000', _this select 0] execVM ""rts-build-unit.sqf""";
                };
            class Button_Back : Base_Button
                {
                    idc = 2001;
                    x = 0.8;
                    y = 0.15;
                    text = "<<Back to Main Menu";
                    action = "[Player,Player,0] exec ""rts-alpha-menu.sqs""";
                };

            class Button_Build : Base_Button
                {
                    idc = 2005;
                    x = 0.80;
                    y = 0.2;
                    text = "";
                    action = "[2000,0,False,False] execVM ""rts-build-unit.sqf""";
                };


            class Button_Manned_You : Base_Button
                {
                    idc = 2015;
                    x = 0.80;
                    y = 0.25;
                    text = "";
                        //[ListID,ListID2,Manned,Squad]
                    action = "[2000,0,True,False] execVM ""rts-build-unit.sqf""";
                };

            class Button_Custom_Squad : Base_Button
                {
                    idc = 2016;
                    x = 0.80;
                    y = 0.30;
                    text = "";
                    action = "[2000,2030,False,False] execVM ""rts-build-unit.sqf""";
                };

            class List_CustomSquads : RscListBox
                {
                    idc = 2030;
                    x = 0.81;
                    y = 0.35;
                    w = 0.18;
                    h = 0.15;
                    font = FontMAIN;

        };

            class Button_Manned_Squad : Base_Button
                {
                    idc = 2020;
                    x = 0.80;
                    y = 0.51;
                    text = "";
                    action = "[2000,2025,True,True] execVM ""rts-build-unit.sqf""";
                };

            class List_Squads : RscListBox
                {
                    idc = 2025;
                    x = 0.8;
                    y = 0.56;
                    w = 0.20;
                    h = 0.35;
                    sizeEx = 0.02;
                    font = FontMAIN;
        };

            class Button_Exit : Base_Button
                {
                    idc = -1;
                    x = 0.80;
                    y = 0.92;
                    font = FontMAIN;
                    colorText[] = {1, 1, 1, 1};
                    text = "EXIT MENU";
                    sizeEx = 0.030;
                    action = "closeDialog 0";
                };

            class Label_Money : RscMoneyLabel {};
            class Label_Supply : RscSupplyLabel {};
            class Label_FPS : RscFPSLabel {};
            class List_Stats : RscStatList {};

            class LabelBarracksQueue : RscLabelBarracksQueue {};
            class ButtonBarracksQueue : RscButtonBarracksQueue {};
            class LabelLightQueue : RscLabelLightQueue {};
            class ButtonLightQueue : RscButtonLightQueue {};
            class LabelHeavyQueue : RscLabelHeavyQueue {};
            class ButtonHeavyQueue : RscButtonHeavyQueue {};
            class LabelAirQueue : RscLabelAirQueue {};
            class ButtonAirQueue : RscButtonAirQueue {};
            //class LabelNavalQueue : RscLabelAirQueue {};
            //class ButtonNavalQueue : RscButtonAirQueue {};

        };//End Controls

};//end dlgBuild

//Dialog for Respawn IDs 1310-1312
class DlgRespawn
    {
        idd = -1;
        movingEnable = true;

        class controlsBackground
            {
                class List_Background : RscText
                    {
                        idc = -1;
                        style = ST_CENTER;
                        x = 0.78;
                        y = 0.55;
                        w = 0.2;
                        h = 0.3;
                        font = FontMAIN;
                        colorText[] = {1, 1, 1, 1};
                        sizeEx = 0.03;
                        text = "";
                    };
            };//end controlsBackground



        class controls
            {
                class LABEL_RESPAWN : RscText
                    {
                        idc = -1;
                        style = ST_CENTER;
                        x = 0.25;
                        y = 0.05;
                        w = 0.5;
                        h = 0.07;
                        font = FontMAIN;
                        colorText[] = {1, 1, 1, 1};
                        sizeEx = 0.05;
                        text = "Choose Deployment Location";
                    };

                class LABEL_LOCATION : RscText
                    {
                        idc = 1310;
                        style = ST_CENTER;
                        x = 0.25;
                        y = 0.9;
                        w = 0.5;
                        h = 0.07;
                        font = FontMAIN;
                        colorText[] = {0.02, 0.2, 0.7, 0.6};
                        sizeEx = 0.05;
                        text = "";
                    };

                class LABEL_TIMERTEXT : RscText
                    {
                        idc = -1;
                        style = ST_LEFT;
                        x = 0.78;
                        y = 0.5;
                        w = 0.15;
                        h = 0.05;
                        font = FontMAIN;
                        colorText[] = {1, 1, 1, 1};
                        sizeEx = 0.03;
                        text = "Deploy in:";
                    };

                class LABEL_TIMERNUMBER : RscText
                    {
                        idc = 1311;
                        style = ST_RIGHT;
                        x = 0.93;
                        y = 0.5;
                        w = 0.05;
                        h = 0.05;
                        font = FontMAIN;
                        colorText[] = {1, 1, 1, 1};
                        sizeEx = 0.03;
                        text = "0";
                    };

                class LIST_LOCATION : RscListBox
                    {
                        idc = 1312;
                        x = 0.78;
                        y = 0.55;
                        w = 0.2;
                        h = 0.3;
                        font = FontMAIN;
                        sizeEx = 0.03;
                        colorText[] = {1, 0, 0, 1};
            class ScrollBar
            {
                type = CT_XSLIDER;
                color[] = {0,0,0,0};
                arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
                arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
                border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
                thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
            };
            class ListScrollBar: ScrollBar
            {
                height = 0.021;
                width = 0.021;
                autoScrollEnabled = 0;
            };
        };

                class BUTTON_RESPAWN : RscButton
                    {
                        idc = 1313;
                        x = 0.83;
                        y = 0.9;
                        w = 0.1;
                        h = 0.05;
                        sizeEx = 0.03;
                        font = FontMAIN;
                        colorText[] = {1, 1, 1, 1};
                        text = "Deploy";
                        action = "rts_respawn = TRUE";
                    };
            };//end Controls
    };//end DlgRespawn
//Main HUD
class DlgHUD
    {

        idd = -1;
        movingEnable = 0;
        enableSimulation = 1;
        fadein=2;
        duration=58;
        class controlsBackground
            {
        class Stats_Background : RscStatBackGround {};
            };

        class controls
            {
            class List_Stats : RscStatList {};
            class Label_Money : RscMoneyLabel {};
            class Label_Supply : RscSupplyLabel {};
            class Labe_FPS : RscFPSLabel {};
            };

    };