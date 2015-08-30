class RscText
{
	type = CT_STATIC;
    idc = -1;
    style = ST_LEFT;
    colorBackground[] = {0, 0, 0, 0};
    colorText[] = {1, 0.1, 0, 1};
    font = FontTITLEHalf;
    sizeEx = 0.04;
    colorDisabled[] = {0,0,0,0};
	colorBorder[] ={0,0,0,1};
    soundPush[] = {"a3\sounds_f\weapons\closure\sfx1.wss", 0.1, 1};
    soundClick[] = {"a3\sounds_f\weapons\closure\sfx3.wss", 0.2, 1};
    soundEscape[] = {"a3\sounds_f\weapons\closure\sfx11.wss", 0.2, 1};
    soundEnter[] = {"a3\sounds_f\weapons\closure\sfx4.wss",0.20,1};
	shadow = 2;
	offsetX = 0.003;
	offsetY = 0.003;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	borderSize = 0;
};

class RscActiveText
	{
		access = ReadAndWrite;
		type = CT_ACTIVETEXT;
		style = ST_CENTER;
		h = 0.05;
		w = 0.10;
		font = FontMAIN;
		sizeEx = 0.03;
        arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		text = "";
		default = 0;
	};

class RscActivePicture
	{
		access = ReadAndWrite;
		type = CT_ACTIVETEXT;
	        idc = -1;
	        style = ST_PICTURE;
	        font = FontMAIN;
	        sizeEx = 0.04;
            soundEnter[] = {"a3\sounds_f\weapons\closure\sfx4.wss",0.45,1};
	        soundPush[] = {"a3\sounds_f\weapons\closure\sfx1.wss", 0.1, 1};
	        soundClick[] = {"a3\sounds_f\weapons\closure\sfx3.wss", 0.2, 1};
	        soundEscape[] = {"a3\sounds_f\weapons\closure\sfx11.wss", 0.2, 1};
	};

class RscStructuredtext
{
		access = ReadAndWrite;
		type = CT_STATIC;
		idc = -1;
		style = ST_LEFT;
		lineSpacing = 0;
		w = 0.1;
		h = 0.05;
		font = TahomaB;
		sizeEx = Size_Text_Small;
		text = "";
};
class RscTitleText
{
	type=0;
	idc=-1;
	style=2;
	colorBackground[] = { 0, 0, 0, 0 };
	colorText[] = { 1, 1, 1, 1 };
	font="PuristaMedium";
	size=1;
};
class RscPicture
	{
	access=0;
	type=0;
	idc=-1;
	style=48;
	colorBackground[]={0,0,0,0};
	colorText[]={1,1,1,1};
	font="PuristaMedium";
	sizeEx=0;
	lineSpacing=0;
	text="";
	};
class RscTitles
  {
	titles[] = {"crewinfomessage", "westIcon","westTaking","eastIcon","eastTaking"};
	
	class Zen_pic
	{
	idd=-1;
	movingEnable=0;
	duration=9999;
	fadein=0;
	name="intro";
	controls[]={"Image_1"};

	  	class Image_1 : RscPicture
	  	  {
			x = safezoneX + safezoneW - 0.40;
			y = safezoneY + safezoneH - 0.21;
			w = 0.40;
			h = 0.21;
			text = "pictures\rtspatch1.paa";
	  	  };
	};
  
			class RscTitleText
           {
	          type=0;
	          idc=-1;
	          style=2;
	          colorBackground[] = { 0, 0, 0, 0 };
	          colorText[] = { 1, 1, 1, 1 };
	          font="EtelkaNarrowMediumPro";
	          size=1;
	};		  
	class Black
	{
	idd=-1;
	movingEnable=0;
	duration=9999;
	fadein=0;
	name="intro";
	controls[]={"title1"};
	 
	  	class title1 : RscText 
	  	  {
	  	  	text="";
	  	  	colorText[]={0.8,0,0,1};
			sizeEx = 0.05;	  	  	
	  	  	x=0.000;
	  	  	y=0.000;
	  	  	w=1.000;
	  	  	h=1.000;
	  	  };
	};

	class Title
	{
	idd=-1;
	movingEnable=0;
	duration=9999;
	fadein=0;
	name="intro";
	controls[]={"Image_1","Image_2","title1","title2","title3","title4","title5","title6"};

	  	class Image_1 : RscPicture
	  	  {
			x = safezoneX + safezoneW - 0.40;
			y = safezoneY + safezoneH - 0.21;
			w = 0.40;
			h = 0.21;
			text = "pictures\rtspatch1.paa";
	  	  };

	  	class Image_2 : RscPicture
	  	  {
			x = 0.300;
			y = 0.060;
			w = 0.380;
			h = 0.500;
			text = "pictures\rtspatch1.paa";
	  	  };

	  	class title1 : RscText 
	  	  {
	  	  	text="Zenophon And";
	  	  	colorText[]={0.5,0.5,0.5,1};
			sizeEx = 0.08;
	  	  	x=0.002;
	  	  	y=0.082;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };
	  	class title2 : RscText 
	  	  {
	  	  	text="Zenophon And";
	  	  	colorText[]={1,1,1,1};
			sizeEx = 0.08;	  	  	
	  	  	x=0.000;
	  	  	y=0.080;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };

	  	class title3 : RscText 
	  	  {
	  	  	text="Dr.Death jm PRESENTS";
	  	  	colorText[]={0.5,0.5,0.5,1};
			sizeEx = 0.08;	  	  	
	  	  	x=0.002;
	  	  	y=0.137;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };
	  	class title4 : RscText 
	  	  {
	  	  	text="Dr.Death jm PRESENTS";
	  	  	colorText[]={1,1,1,1};
			sizeEx = 0.08;	  	  	
	  	  	x=0.000;
	  	  	y=0.134;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };

	  	class title5 : RscText 
	  	  {
	  	  	text="RTS V";
	  	  	colorText[]={0.5,0.5,0.5,1};
			sizeEx = 0.06;	  	  	
	  	  	x=0.002;
	  	  	y=0.252;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };
	  	class title6 : RscText 
	  	  {
	  	  	text="RTS V";
	  	  	colorText[]={1,1,1,1};
			sizeEx = 0.06;	  	  	
	  	  	x=0.000;
	  	  	y=0.250;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };
	};

	class Title2
	{
	idd=-1;
	movingEnable=0;
	duration=9999;
	fadein=0;
	name="intro";
	controls[]={"Image_1","title1","title2","title3","title4","title5","title6"};

	  	class Image_1 : RscPicture
	  	  {
			x = safezoneX + safezoneW - 0.40;
			y = safezoneY + safezoneH - 0.21;
			w = 0.40;
			h = 0.21;
			text = "pictures\rtspatch1.paa";
	  	  };

	  	class title1 : RscText 
	  	  {
	  	  	text="Zenophon And";
	  	  	colorText[]={0.5,0.5,0.5,1};
			sizeEx = 0.08;
	  	  	x=0.002;
	  	  	y=0.082;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };
	  	class title2 : RscText 
	  	  {
	  	  	text="Zenophon And";
	  	  	colorText[]={1,1,1,1};
			sizeEx = 0.08;	  	  	
	  	  	x=0.000;
	  	  	y=0.080;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };

	  	class title3 : RscText 
	  	  {
	  	  	text="Dr.Death jm PRESENTS";
	  	  	colorText[]={0.5,0.5,0.5,1};
			sizeEx = 0.08;	  	  	
	  	  	x=0.002;
	  	  	y=0.137;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };
	  	class title4 : RscText 
	  	  {
	  	  	text="Dr.Death jm PRESENTS";
	  	  	colorText[]={1,1,1,1};
			sizeEx = 0.08;	  	  	
	  	  	x=0.000;
	  	  	y=0.134;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };

	  	class title5 : RscText 
	  	  {
	  	  	text="RTS V";
	  	  	colorText[]={0.5,0.5,0.5,1};
			sizeEx = 0.06;	  	  	
	  	  	x=0.002;
	  	  	y=0.252;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };
	  	class title6 : RscText 
	  	  {
	  	  	text="RTS V";
	  	  	colorText[]={1,1,1,1};
			sizeEx = 0.06;	  	  	
	  	  	x=0.000;
	  	  	y=0.250;
	  	  	w=1.00;
	  	  	h=1.00;
	  	  };
	};
	class crewinfomessage
		{
		idd = 10100;
		movingEnable=0;
		duration = 1000000000; 
		fadein=0;    
		name="crewinfomessage";
		controlsBackground[] = {"crewinfotext", "crewinfoteamtext"};
		onLoad = "uiNamespace setVariable ['crewinfodisplay', _this select 0];";
		onunLoad = "uiNamespace setVariable ['crewinfodisplay', objnull];";    

		class crewinfotext { 
			idc = 10101; 
			type = CT_STRUCTURED_TEXT; 
			style = ST_LEFT; 
			x = (SafeZoneX + 0.02);
			y = (SafeZoneY + 1.25);
			w = 0.3;
			h = 0.6;
			size = 0.018; 
			colorBackground[] = { 0, 0, 0, 0 };
			colortext[] = {0,0,0,0.7};
			text ="";
		};

		class crewinfoteamtext { 
			idc = 10103; 
			type = CT_STRUCTURED_TEXT; 
			style = ST_LEFT; 
			x = (SafeZoneW + SafezoneX) - 0.25;
			y = (1 + ((0 + SafeZoneY) * -1) - 0.14);
			w = 0.25;
			h = 0.14;
			size = 0.02; 
			colorBackground[] = { 0, 0, 0, 0 };
			colortext[] = {0,0,0,0.7};
			text ="";
		};
	};

class westIcon
	{
		idd=-1;
		movingEnable = true;
		duration=2;
		name = "westIcon";
		controls[]=
		{Picture};

		class Picture : RscPicture
		{
			x = 0.88; y=0.01; w = 0.1; h = 0.07;
			text = "pictures\west.paa";
		};
	};
	class westTaking
	{
		idd=-1;
		movingEnable = true;
		duration=2;
		name = "westTaking";
		controls[]={Picture};

		class Picture : RscPicture
		{
			x = 0.88; y=0.01; w = 0.1; h = 0.07;
			text = "pictures\west_taking.paa";
		};
	};
	class eastIcon
	{
		idd=-1;
		movingEnable = true;
		duration=2;
		name = "eastIcon";
		controls[]={Picture};

		class Picture : RscPicture
		{
			x = 0.88; y=0.01; w = 0.1; h = 0.07;
			text = "pictures\east.paa";
		};
	};
	class eastTaking
	{
		idd=-1;
		movingEnable = true;
		duration=2;
		name = "eastTaking";
		controls[]={Picture};

		class Picture : RscPicture
		{
			x = 0.88; y=0.01; w = 0.1; h = 0.07;
			text = "pictures\east_taking.paa";
		};
    }; 
};	
	    

