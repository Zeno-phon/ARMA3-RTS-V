#define true						1
#define false						0
#define Size_Main_Normal 			0.03
#define Size_Text_Default 			Size_Main_Normal
#define Size_Text_Small 			0.025
#define Color_White					{1, 1, 1, 1}
#define Color_Black					{0, 0, 0, 1}
#define Color_Gray					{0.3, 0.3, 0.3, 1}
#define Color_GrayLight 			{0.6, 0.6, 0.6, 1}
#define Color_GrayDark 				{0.2, 0.2, 0.2, 1}
#define Color_Orange				{1, 0.5, 0, 1}
#define Color_LightGreen			{.1, 0.5, 0, .7}
#define Color_Main_Foreground1 	    Color_White
#define Color_Text_Default 			Color_Main_Foreground1
#define ProcTextWhite 				"#(argb,8,8,3)color(1,1,1,1)"
#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUTBUTTON   16
#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_LISTNBOX         102
#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0C

#define ST_TYPE           0xF0
#define ST_SINGLE         0x00
#define ST_MULTI          0x10
#define ST_TITLE_BAR      0x20
#define ST_PICTURE        0x30
#define ST_FRAME          0x40
#define ST_BACKGROUND     0x50
#define ST_GROUP_BOX      0x60
#define ST_GROUP_BOX2     0x70
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE   0x90
#define ST_WITH_RECT      0xA0
#define ST_LINE           0xB0
#define ST_SHADOW         0x100
#define ST_NO_RECT        0x200
#define ST_KEEP_ASPECT_RATIO  0x800                   16
#define ReadAndWrite			    0

#define FontMAIN	"TahomaB"
#define FontHTML "EtelkaMonospacePro"
#define FontHTMLBold "EtelkaMonospacePro"
#define FontMAINCZ "PuristaMedium"
#define FontTITLE "PuristaMedium"
#define FontTITLEHalf "PuristaMedium"
#define FontBOOK "tahomaB"
#define FontNOTES "tahomaB"
#define FontS "tahomaB"
#define FontM "tahomaB"
#define ST_TITLE ST_TITLE_BAR + ST_CENTER
// Predefined controls
#define IDC_OK			1
#define IDC_CANCEL		2

// Colors
#define TextColor	0.08, 0.08, 0.12
#define InvTextColor	0.35, 0.38, 0.36

class RscSmallTitle
{
        type = CT_STATIC;
        idc = -1;
        style = ST_CENTER;
        colorBackground[] = {0, 0, 0, 1};
        colorText[] = {0, 0, 1, 1};
        font = FontTITLEHalf;
        sizeEx = 0.04;
};

class RscSmallTitleBlack
{
        type = CT_STATIC;
        idc = -1;
        style = ST_CENTER;
        colorBackground[] = {0, 0, 0, 0};
        colorText[] = {0, 0, 0, 1};
        font = FontTITLEHalf;
        sizeEx = 0.03;
};


class RscEdit
{
       type = CT_EDIT;
       idc = -1;
       style = ST_LEFT;
       font = FontHTML;
       sizeEx = 0.02;
       colorText[] = {0, 0, 0, 1};
       colorSelection[] = {0.5, 0.5, 0.5, 1};
       autocomplete = false;
       text = "0";
};

