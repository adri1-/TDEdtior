

#include <a_samp>
#include <sscanf2>
#include <YSF>


/*

	___ __  __
	 | |  \|_  _|.|_ _  _
	 | |__/|__(_|||_(_)|

	TDEditor Credits:
	
	    - adri1                                                                                         USER PROFILE: http://forum.sa-mp.com/member.php?u=106967
	    - iPLEOMAX   																					USER PROFILE: http://forum.sa-mp.com/member.php?u=122705
	    - Sasino97 (IsKeyDown plugin)                                                                   USER PROFILE: http://forum.sa-mp.com/member.php?u=111937
	    - kurta999 (YSF plugin)                                                                         USER PROFILE: http://forum.sa-mp.com/member.php?u=50263
		- Y_Less   (sscanf2 plugin & YSF plugin)                                                        USER PROFILE: http://forum.sa-mp.com/member.php?u=29176
		
		
		
	IsKeyDown plugin was modified by adri1, adding the following functions:

		native PressKeyEnter(key);
		native PressAnyKey(key);
		native GetKeyState(key);
		native GetDoubleClickTime();
		native ActivateAnyKey();
		native ActivateAnyKeyVariable(valor);
		forward OnAnyKeyDown(key);
*/


#define VK_KEY_A	0x41
#define VK_KEY_B	0x42
#define VK_KEY_C	0x43
#define VK_KEY_D	0x44
#define VK_KEY_E	0x45
#define VK_KEY_F	0x46
#define VK_KEY_G	0x47
#define VK_KEY_H	0x48
#define VK_KEY_I	0x49
#define VK_KEY_J	0x4A
#define VK_KEY_K	0x4B
#define VK_KEY_L	0x4C
#define VK_KEY_M	0x4D
#define VK_KEY_N	0x4E
#define VK_KEY_O	0x4F
#define VK_KEY_P	0x50
#define VK_KEY_Q	0x51
#define VK_KEY_R	0x52
#define VK_KEY_S	0x53
#define VK_KEY_T	0x54
#define VK_KEY_U	0x55
#define VK_KEY_V	0x56
#define VK_KEY_W	0x57
#define VK_KEY_X	0x58
#define VK_KEY_Y	0x59
#define VK_KEY_Z	0x5A
#define VK_LBUTTON	0x01
#define VK_MBUTTON	0x04
#define VK_RBUTTON	0x02
#define VK_UP		0x26
#define VK_DOWN		0x28
#define VK_LEFT		0x25
#define VK_RIGHT	0x27
#define VK_LSHIFT	0xA0
#define VK_RSHIFT	0xA1
#define VK_SPACE    0x20
#define VK_CANCEL 0x03
#define VK_BACKSPACE 0x08
#define VK_TAB 0x09
#define VK_CLEAR 0x0C
#define VK_ENTER 0x0D
#define VK_SHIFT 0x10 
#define VK_LSHIFT 0xA0
#define VK_RSHIFT 0xA1
#define VK_CTRL 0x11 
#define VK_LCTRL 0xA2
#define VK_RCTRL 0xA3 
#define VK_ALT 0x12
#define VK_CAPSLOCK 0x14
#define VK_ESCAPE 0x1B
#define VK_SELECT 0x29
#define VK_INSERT 0x2D
#define VK_DELETE 0x2E
#define VK_HELP 0x2F
#define VK_KEYB0 0x30
#define VK_KEYB1 0x31
#define VK_KEYB2 0x32
#define VK_KEYB3 0x33
#define VK_KEYB4 0x34
#define VK_KEYB5 0x35
#define VK_KEYB6 0x36
#define VK_KEYB7 0x37
#define VK_KEYB8 0x38
#define VK_KEYB9 0x39
#define VK_NUMLOCK 0x90
#define VK_NUMPAD0 0x60
#define VK_NUMPAD1 0x61
#define VK_NUMPAD2 0x62
#define VK_NUMPAD3 0x63
#define VK_NUMPAD4 0x64
#define VK_NUMPAD5 0x65
#define VK_NUMPAD6 0x66
#define VK_NUMPAD7 0x67
#define VK_NUMPAD8 0x68
#define VK_NUMPAD9 0x69
#define VK_MULTIPLY 0x6A
#define VK_ADD 0x6B
#define VK_SEPARATOR 0x6C
#define VK_SUBTRACT 0x6D
#define VK_DECIMAL 0x6E
#define VK_DIVIDE 0x6F
#define VK_OEM_PLUS 0xBB
#define VK_OEM_COMMA 0xBC
#define VK_OEM_MINUS 0xBD
#define VK_OEM_PERIOD 0xBE
#define VK_OEM_2 0xBF
#define VK_OEM_4 0xDB
#define VK_OEM_5 0xDC
#define VK_OEM_6 0xDD
#define VK_XBUTTON1 0x05
#define VK_XBUTTON2 0x06
#define VK_OEM_102 0xE2
#define VK_F6 0x75

#define EmptyString(%0)         %0[0] = '\0'
#define INVALID_INDEX_ID        (-1)
#define TDE_CALLBACK:%0(%1) forward %0(%1); public %0(%1)
#define Loop(%0,%1)       for (new c = %0; c < %1; c++)
#define MAX_PROJECT_TEXTDRAWS   (500)

native GetVirtualKeyState(key);
native GetScreenSize(&Width, &Height);
native GetMousePos(&X, &Y);
native PressKeyEnter(key);
native PressAnyKey(key);
native GetKeyState(key);
native GetDoubleClickTime();
native ActivateAnyKey();
native ActivateAnyKeyVariable(valor);
forward OnAnyKeyDown(key);


enum
{
    DIALOG_PROJECT = 6666,
    DIALOG_PROJECT_LIST,
    DIALOG_NEWPROJECT,
	DIALOG_LOADPROJECT,
	DIALOG_CLOSEPROJECT,
	DIALOG_DELETETD,
	DIALOG_TDLIST,
	DIALOG_EDITTEXT,
	DIALOG_EDITOUTLINE,
	DIALOG_EDITSHADOW,
	DIALOG_LETTERX,
	DIALOG_LETTERY,
	DIALOG_POSX,
	DIALOG_POSY,
	DIALOG_CONFIRMEDELETE,
	DIALOG_EDITCOLOR,
	DIALOG_SIZEX,
	DIALOG_SIZEY,
	DIALOG_NEW,
	DIALOG_MODELID,
	DIALOG_MODELS,
	DIALOG_MODELS_MLD,
	DIALOG_MODELS_RX,
	DIALOG_MODELS_RY,
	DIALOG_MODELS_RZ,
	DIALOG_MODELS_ZO,
	DIALOG_MODELS_C1,
	DIALOG_MODELS_C2,
	DIALOG_MANAGE = 7777
};

enum E_KEY_STRUCT
{
	bool:KEY_PRESSED,
	KEY_CODE,
};

enum E_TD_STRUCT
{
	ItsFromTDE,
	Text:ETextDrawID,
	ETextDrawText[800],
	Float:ETextDrawPosX,
	Float:ETextDrawPosY,
	Float:ETextDrawLetterX,
	Float:ETextDrawLetterY,
	Float:ETextDrawTextX,
	Float:ETextDrawTextY,
	ETextDrawOutline,
	ETextDrawShadow,
	ETextDrawModelid,
	Float:ETextDrawRotX,
	Float:ETextDrawRotY,
	Float:ETextDrawRotZ,
	Float:ETextDrawZoom,
	ETextDrawType, //Global/Player
	ETextDrawSelectable,
	ETextDrawColor,
	ETextDrawBGColor,
	ETextDrawBoxColor,
	ETextDrawVehCol1,
	ETextDrawVehCol2
};

enum
{
	EDITMODE_NONE,
	EDITMODE_TEXT,
	EDITMODE_POSITION,
	EDITMODE_OUTLINE,
	EDITMODE_SHADOW,
	EDITMODE_LETTERSIZE,
	EDITMODE_SIZE,
	EDITMODE_COLOR,
	EDITMODE_BGCOLOR,
	EDITMODE_BOXCOLOR,
 	EDITMODE_MODELS,
	EDITMODE_ADJUST
};

enum
{
	COLORMODE_NONE,
	COLORMODE_RED,
	COLORMODE_GREEN,
	COLORMODE_BLUE,
	COLORMODE_ALPHA
};

new PremadeColors[][] =
{
	{ 0xFF0000FF , "Red" },
	{ 0xFFFFFFFF , "White" },
	{ 0x00FFFFFF , "Cyan" },
	{ 0xC0C0C0FF , "Silver" },
	{ 0x0000FFFF , "Blue" },
	{ 0x808080FF , "Grey" },
	{ 0x0000A0FF , "DarkBlue" },
	{ 0x000000FF , "Black" },
	{ 0xADD8E6FF , "LightBlue" },
	{ 0xFFA500FF , "Orange" },
	{ 0x800080FF , "Purple" },
	{ 0xA52A2AFF , "Brown" },
	{ 0xFFFF00FF , "Yellow" },
	{ 0x800000FF , "Maroon" },
	{ 0x00FF00FF , "Lime" },
	{ 0x008000FF , "Green" },
	{ 0xFF00FFFF , "Fuchsia" },
	{ 0x808000FF , "Olive" }
};

new
	ProjectEditor = -1,
    bool:EditorEnabled,
	bool:IsPSel,
	CursorOX, CursorOY,
	CursorX, CursorY,
	ScreenWidth, ScreenHeight,
	VirtualKeys[93][E_KEY_STRUCT],
	ProjectTD[MAX_PROJECT_TEXTDRAWS][E_TD_STRUCT],
	Text:TDE_Menu[36] = {Text:INVALID_TEXT_DRAW, ...},
	Text:TD_Status,
	Text:TDELOGO,
	Float:OffsetZ = 415.0,
	EditIndex = INVALID_INDEX_ID,
	EditMode,
	Float:EditMoveSpeed = 0.1,
	Float:EditLetterSizeSpeed = 0.01,
	Float:EditSizeSpeed = 0.01,
	DeleteTimer, SpeedTimer, /*DoubleClickCount,*/ MoveTDTimer = -1,
	Text:TDEditor_Helper[2], TDEHTimer = -1, OutlineTimer, ShadowTimer,
	LetterSizeTimer = -1, LetterTimer, EditSizeTDTimer = -1, EditSizeSpeedT,
	ColorMode, Colors[4], BackManageDialog[15], PageStart, Float:Zoom = 1.0,
	ProjectFile[64], Pro_Str[5000], File:Handler, str_list[3000], EditorUpdateTimer,
    line[800]
;

public OnFilterScriptInit()
{
    print(" ");
    print(" ");
    print(" ");
	print(" ");
	print("___ __  __");
	print(" | |  \\|_  _|.|_ _  _		");
	print(" | |__/|__(_|||_(_)|			");
    print(" ");
    print("TDEditor V1.12 by adri1");
    print("TDEditor loaded");
    print(" ");

	Loop(0, MAX_PROJECT_TEXTDRAWS) ProjectTD[c][ItsFromTDE] = -1;
	VirtualKeys[0][KEY_CODE] = VK_KEY_A;
    VirtualKeys[1][KEY_CODE] = VK_KEY_B;
    VirtualKeys[2][KEY_CODE] = VK_KEY_C;
    VirtualKeys[3][KEY_CODE] = VK_KEY_D;
    VirtualKeys[4][KEY_CODE] = VK_KEY_E;
    VirtualKeys[5][KEY_CODE] = VK_KEY_F;
    VirtualKeys[6][KEY_CODE] = VK_KEY_G;
    VirtualKeys[7][KEY_CODE] = VK_KEY_H;
    VirtualKeys[8][KEY_CODE] = VK_KEY_I;
    VirtualKeys[9][KEY_CODE] = VK_KEY_J;
    VirtualKeys[10][KEY_CODE] = VK_KEY_K;
    VirtualKeys[11][KEY_CODE] = VK_KEY_L;
    VirtualKeys[12][KEY_CODE] = VK_KEY_M;
    VirtualKeys[13][KEY_CODE] = VK_KEY_N;
    VirtualKeys[14][KEY_CODE] = VK_KEY_O;
    VirtualKeys[15][KEY_CODE] = VK_KEY_P;
    VirtualKeys[16][KEY_CODE] = VK_KEY_Q;
    VirtualKeys[17][KEY_CODE] = VK_KEY_R;
    VirtualKeys[18][KEY_CODE] = VK_KEY_S;
    VirtualKeys[19][KEY_CODE] = VK_KEY_T;
    VirtualKeys[20][KEY_CODE] = VK_KEY_U;
    VirtualKeys[21][KEY_CODE] = VK_KEY_V;
    VirtualKeys[22][KEY_CODE] = VK_KEY_W;
    VirtualKeys[23][KEY_CODE] = VK_KEY_X;
    VirtualKeys[24][KEY_CODE] = VK_KEY_Y;
    VirtualKeys[25][KEY_CODE] = VK_KEY_Z;
    VirtualKeys[26][KEY_CODE] = VK_LBUTTON;
    VirtualKeys[27][KEY_CODE] = VK_MBUTTON;
    VirtualKeys[28][KEY_CODE] = VK_RBUTTON;
    VirtualKeys[29][KEY_CODE] = VK_LEFT;
    VirtualKeys[30][KEY_CODE] = VK_RIGHT;
	VirtualKeys[31][KEY_CODE] = VK_UP;
    VirtualKeys[32][KEY_CODE] = VK_DOWN;
    VirtualKeys[33][KEY_CODE] = VK_LSHIFT;
    VirtualKeys[34][KEY_CODE] = VK_RSHIFT;
    VirtualKeys[35][KEY_CODE] = VK_SPACE;
    VirtualKeys[36][KEY_CODE] = VK_CANCEL; //03
	VirtualKeys[37][KEY_CODE] = VK_BACKSPACE; //08
	VirtualKeys[38][KEY_CODE] = VK_TAB; //09
	VirtualKeys[39][KEY_CODE] = VK_CLEAR; //0C
	VirtualKeys[40][KEY_CODE] = VK_ENTER; //0D
	VirtualKeys[41][KEY_CODE] = VK_SHIFT; //10
	VirtualKeys[42][KEY_CODE] = VK_LSHIFT; //A0
	VirtualKeys[43][KEY_CODE] = VK_RSHIFT; //A1
	VirtualKeys[44][KEY_CODE] = VK_CTRL; //11
	VirtualKeys[45][KEY_CODE] = VK_LCTRL; //A2
	VirtualKeys[46][KEY_CODE] = VK_RCTRL; //A3
	VirtualKeys[47][KEY_CODE] = VK_ALT; //12
	VirtualKeys[48][KEY_CODE] = VK_CAPSLOCK; //14
	VirtualKeys[49][KEY_CODE] = VK_ESCAPE; //1B
	VirtualKeys[50][KEY_CODE] = VK_SELECT; //29
	VirtualKeys[51][KEY_CODE] = VK_INSERT; //2D
	VirtualKeys[52][KEY_CODE] = VK_DELETE; //2E
	VirtualKeys[53][KEY_CODE] = VK_HELP; //2F
	VirtualKeys[54][KEY_CODE] = VK_KEYB0; //30
	VirtualKeys[55][KEY_CODE] = VK_KEYB1; //31
	VirtualKeys[56][KEY_CODE] = VK_KEYB2; //32
	VirtualKeys[57][KEY_CODE] = VK_KEYB3; //33
	VirtualKeys[58][KEY_CODE] = VK_KEYB4; //34
	VirtualKeys[59][KEY_CODE] = VK_KEYB5; //35
	VirtualKeys[60][KEY_CODE] = VK_KEYB6; //36
	VirtualKeys[61][KEY_CODE] = VK_KEYB7; //37
	VirtualKeys[62][KEY_CODE] = VK_KEYB8; //38
	VirtualKeys[63][KEY_CODE] = VK_KEYB9; //39
	VirtualKeys[64][KEY_CODE] = VK_NUMLOCK; //90
	VirtualKeys[65][KEY_CODE] = VK_NUMPAD0; //60
	VirtualKeys[66][KEY_CODE] = VK_NUMPAD1; //61
	VirtualKeys[67][KEY_CODE] = VK_NUMPAD2; //62
	VirtualKeys[68][KEY_CODE] = VK_NUMPAD3; //63
	VirtualKeys[69][KEY_CODE] = VK_NUMPAD4; //64
	VirtualKeys[70][KEY_CODE] = VK_NUMPAD5; //65
	VirtualKeys[71][KEY_CODE] = VK_NUMPAD6; //66
	VirtualKeys[72][KEY_CODE] = VK_NUMPAD7; //67
	VirtualKeys[73][KEY_CODE] = VK_NUMPAD8; //68
	VirtualKeys[74][KEY_CODE] = VK_NUMPAD9; //69
	VirtualKeys[75][KEY_CODE] = VK_MULTIPLY; //6A
	VirtualKeys[76][KEY_CODE] = VK_ADD; //6B
	VirtualKeys[77][KEY_CODE] = VK_SEPARATOR; //6C
	VirtualKeys[78][KEY_CODE] = VK_SUBTRACT; //6D
	VirtualKeys[79][KEY_CODE] = VK_DECIMAL; //6E
	VirtualKeys[80][KEY_CODE] = VK_DIVIDE; //6F
	VirtualKeys[81][KEY_CODE] = VK_OEM_PLUS;
	VirtualKeys[82][KEY_CODE] = VK_OEM_COMMA;
	VirtualKeys[83][KEY_CODE] = VK_OEM_MINUS;
	VirtualKeys[84][KEY_CODE] = VK_OEM_PERIOD;
	VirtualKeys[85][KEY_CODE] = VK_OEM_2;
	VirtualKeys[86][KEY_CODE] = VK_OEM_4;
	VirtualKeys[87][KEY_CODE] = VK_OEM_5;
	VirtualKeys[88][KEY_CODE] = VK_OEM_6;
	VirtualKeys[89][KEY_CODE] = VK_XBUTTON1;
	VirtualKeys[90][KEY_CODE] = VK_XBUTTON2;
	VirtualKeys[91][KEY_CODE] = VK_OEM_102;
	VirtualKeys[92][KEY_CODE] = VK_F6;


    for (new i = 0; i < MAX_PROJECT_TEXTDRAWS; i++) ProjectTD[i][ETextDrawID] = Text:INVALID_TEXT_DRAW;
	return true;
}

public OnFilterScriptExit()
{
    print(" ");
    print(" ");
    print(" ");
	print(" ");
	print("___ __  __");
	print(" | |  \\|_  _|.|_ _  _		");
	print(" | |__/|__(_|||_(_)|			");
    print(" ");
    print("TDEditor V1.12 by adri1");
    print("TDEditor unloaded");
    print(" ");

    KillTimer(EditorUpdateTimer);
    KillTimer(DeleteTimer);
    KillTimer(SpeedTimer);
    KillTimer(MoveTDTimer); MoveTDTimer = -1;
    KillTimer(TDEHTimer); TDEHTimer = -1;
    KillTimer(OutlineTimer);
    KillTimer(ShadowTimer);
    KillTimer(LetterSizeTimer); LetterSizeTimer = -1;
	KillTimer(LetterTimer);
	KillTimer(EditSizeTDTimer); EditSizeTDTimer = -1;
	KillTimer(EditSizeSpeedT);
	KillTimer(ShadowTimer);
	if(ProjectEditor != -1)
	{
	    TogglePlayerControllable(ProjectEditor, true);
	    ShowPlayerDialog(ProjectEditor, -1, 0, "","", "", "" );
	    CancelSelectTextDraw(ProjectEditor);
		if(strlen(ProjectFile))
		{
		    SaveProject();
		    for (new i = 0; i < MAX_PROJECT_TEXTDRAWS; i++) RemoveTextDrawTDEOnly(i);
		}
	}
	DestroyMenuTextDraws();
    EditMode = EDITMODE_NONE;
	ColorMode = COLORMODE_NONE;
	ProjectEditor = -1;
	EditorEnabled = false;
	IsPSel = true;
	CursorOX = 0;
	CursorOY = 0;
	CursorX = 0;
	CursorY = 0;
	ScreenWidth = 0;
	ScreenHeight = 0;
	OffsetZ = 415.0;
	EditIndex = INVALID_INDEX_ID;
	EditMoveSpeed = 0.1;
	EditLetterSizeSpeed = 0.01;
	EditSizeSpeed = 0.01;
	PageStart = 0;
	Zoom = 1.0;
	EmptyString(ProjectFile);
	EmptyString(Pro_Str);
	EmptyString(str_list);
	EmptyString(line);
	return true;
}

public OnPlayerConnect(playerid)
{
	return true;
}

public OnPlayerDisconnect(playerid, reason)
{
    if(ProjectEditor == playerid)
	{
		KillTimer(EditorUpdateTimer);
	    KillTimer(DeleteTimer);
	    KillTimer(SpeedTimer);
	    KillTimer(MoveTDTimer); MoveTDTimer = -1;
	    KillTimer(TDEHTimer); TDEHTimer = -1;
	    KillTimer(OutlineTimer);
	    KillTimer(ShadowTimer);
	    KillTimer(LetterSizeTimer); LetterSizeTimer = -1;
		KillTimer(LetterTimer);
		KillTimer(EditSizeTDTimer); EditSizeTDTimer = -1;
		KillTimer(EditSizeSpeedT);
		KillTimer(ShadowTimer);
	
		if(strlen(ProjectFile))
		{
		    SaveProject();
		    for (new i = 0; i < MAX_PROJECT_TEXTDRAWS; i++) RemoveTextDrawTDEOnly(i);
        }
        
		DestroyMenuTextDraws();
	    EditMode = EDITMODE_NONE;
		ColorMode = COLORMODE_NONE;
		ProjectEditor = -1;
		EditorEnabled = false;
		IsPSel = true;
		CursorOX = 0;
		CursorOY = 0;
		CursorX = 0;
		CursorY = 0;
		ScreenWidth = 0;
		ScreenHeight = 0;
		OffsetZ = 415.0;
		EditIndex = INVALID_INDEX_ID;
		EditMoveSpeed = 0.1;
		EditLetterSizeSpeed = 0.01;
		EditSizeSpeed = 0.01;
		PageStart = 0;
		Zoom = 1.0;
		EmptyString(ProjectFile);
		EmptyString(Pro_Str);
		EmptyString(str_list);
		EmptyString(line);
	}
	return true;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(!strcmp(cmdtext, "/tde", true, 4))
	{
	    if(ProjectEditor == playerid)
	    {
	        if(strlen(cmdtext) >= 6)
			{
			    if( (!strcmp(cmdtext[5], "ayuda", true)) || (!strcmp(cmdtext[5], "help", true))  )
				{
				    SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}/tde box - /tde exit.");
				    return 1;
				}
			    if( (!strcmp(cmdtext[5], "salir", true)) || (!strcmp(cmdtext[5], "exit", true))  )
				{
  					KillTimer(EditorUpdateTimer);
				    KillTimer(DeleteTimer);
				    KillTimer(SpeedTimer);
				    KillTimer(MoveTDTimer); MoveTDTimer = -1;
				    KillTimer(TDEHTimer); TDEHTimer = -1;
				    KillTimer(OutlineTimer);
				    KillTimer(ShadowTimer);
				    KillTimer(LetterSizeTimer); LetterSizeTimer = -1;
					KillTimer(LetterTimer);
					KillTimer(EditSizeTDTimer); EditSizeTDTimer = -1;
					KillTimer(EditSizeSpeedT);
					KillTimer(ShadowTimer);

					if(strlen(ProjectFile))
					{
					    SaveProject();
					    for (new i = 0; i < MAX_PROJECT_TEXTDRAWS; i++) RemoveTextDrawTDEOnly(i);
			        }

					DestroyMenuTextDraws();
				    EditMode = EDITMODE_NONE;
					ColorMode = COLORMODE_NONE;
					ProjectEditor = -1;
					EditorEnabled = false;
					IsPSel = true;
					CursorOX = 0;
					CursorOY = 0;
					CursorX = 0;
					CursorY = 0;
					ScreenWidth = 0;
					ScreenHeight = 0;
					OffsetZ = 415.0;
					EditIndex = INVALID_INDEX_ID;
					EditMoveSpeed = 0.1;
					EditLetterSizeSpeed = 0.01;
					EditSizeSpeed = 0.01;
					PageStart = 0;
					Zoom = 1.0;
					EmptyString(ProjectFile);
					EmptyString(Pro_Str);
					EmptyString(str_list);
					EmptyString(line);
					
					TogglePlayerControllable(playerid, true);
				    ShowPlayerDialog(playerid, -1, 0, "","", "", "" );
				    CancelSelectTextDraw(playerid);
				    return 1;
				}
				if( (!strcmp(cmdtext[5], "box", true)) || (!strcmp(cmdtext[5], "icons", true)) || (!strcmp(cmdtext[5], "adjust", true)) )
				{
				    if(EditMode == EDITMODE_ADJUST)
				    {
				        if(!VirtualKeys[26][KEY_PRESSED]) //Left Mouse Button
						{
					        new Float:pos[2];
				        	for(new i = 1; i < sizeof(TDE_Menu); i++)
				        	{
				        	    TextDrawGetPos(TDE_Menu[i], pos[0], pos[1]);
				        	    TextDrawSetPos(TDE_Menu[i], pos[0], OffsetZ);
				        	    TextDrawShowForPlayer(playerid, TDE_Menu[i]);
				        	}

				 		    TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
				 		    EditMode = EDITMODE_NONE;
				 		    IsPSel = true;
					        return 1;
						}
						return 1;
				    }
				    IsPSel = false;
					TextDrawSetString(TD_Status, "EditMode: EDITMODE_ADJUST");
    				EditMode = EDITMODE_ADJUST;
    				SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}Press 'ESC' to finish this mode.");
					return 1;
				}
				return SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}/tde {e2b960}(box/help)");
			}
			TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
   			EditMode = EDITMODE_NONE;
			CancelSelectTextDraw(playerid);
			IsPSel = false;
			ShowPlayerDialog(playerid, DIALOG_PROJECT, DIALOG_STYLE_LIST, "TDEditor", "Create a new project\nLoad a project\nClose project", ">>", "X");
	    }
	    if(ProjectEditor == -1)
	    {
	        new ip[16];
	        GetPlayerIp(playerid, ip, 16);
	        if(strcmp(ip, "127.0.0.1", false)) return SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}TDEditor only can be used from localhost (127.0.0.1)");
	        IsPSel = true;
	        TogglePlayerControllable(playerid, false);
	        DestroyMenuTextDraws();
  			CreateMenuTextDraws();
	        SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}Click on the image to start...");
	        TextDrawShowForPlayer(playerid, TDELOGO);
	        SelectTextDraw(playerid, -1);
            EmptyString(ProjectFile);
	    }
	    return true;
	}
	return false;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_PROJECT)
	{
		if(response)
		{
		    switch(listitem)
		    {
		        case 0:
				{
				    if(strlen(ProjectFile))
					{
						SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}Closes the current project first.");
						ShowPlayerDialog(playerid, DIALOG_PROJECT, DIALOG_STYLE_LIST, "TDEditor", "Create a new project\nLoad a project\nClose project", ">>", "X");
						return 1;
					}
					ShowPlayerDialog(playerid, DIALOG_NEWPROJECT, DIALOG_STYLE_INPUT, "TDEditor - New project", "Project Name (if exists will load):", ">>", "<<");
				}
		        case 1:
		        {
		            if(strlen(ProjectFile))
					{
						SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}Closes the current project first.");
						ShowPlayerDialog(playerid, DIALOG_PROJECT, DIALOG_STYLE_LIST, "TDEditor", "Create a new project\nLoad a project\nClose project", ">>", "X");
						return 1;
					}
          			new Found;
				    Handler = fopen("tdelist.txt", io_read);
				    if(Handler)
				    {
					    while(fread(Handler, Pro_Str))
					    {
							if(strlen(Pro_Str))
							{
							    if(!Found)
								{
									EmptyString(str_list);
									Found = true;
								}
								strcat(str_list, Pro_Str);
							}
						}
					    fclose(Handler);
				    }
				    else
				    {
				        SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}There isn't list.");
						ShowPlayerDialog(playerid, DIALOG_PROJECT, DIALOG_STYLE_LIST, "TDEditor", "Create a new project\nLoad a project\nClose project", ">>", "X");
				        return 1;
				    }
				    if(!Found)
				    {
				        SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}There isn't list.");
						ShowPlayerDialog(playerid, DIALOG_PROJECT, DIALOG_STYLE_LIST, "TDEditor", "Create a new project\nLoad a project\nClose project", ">>", "X");
				        return 1;
				    }
				    ShowPlayerDialog(playerid, DIALOG_PROJECT_LIST, DIALOG_STYLE_LIST, "TDEditor - Projects list", str_list, ">>", "<<");
		        }
		        case 2: 
		        {
		            if(!strlen(ProjectFile))
					{
						SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}You haven't created/loaded any project.");
						ShowPlayerDialog(playerid, DIALOG_PROJECT, DIALOG_STYLE_LIST, "TDEditor", "Create a new project\nLoad a project\nClose project", ">>", "X");
						return 1;
					}
		            CloseProject();
		            SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}Project closed.");
		            ShowPlayerDialog(playerid, DIALOG_PROJECT, DIALOG_STYLE_LIST, "TDEditor", "Create a new project\nLoad a project\nClose project", ">>", "X");
		        }
		    }
		}
		else
		{
		    if(ProjectEditor == -1)
		    {
		        
			    SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}TDEditor finished.");
			    TextDrawHideForPlayer(playerid, TDELOGO);
			    TogglePlayerControllable(playerid, true);
		        DestroyMenuTextDraws();
		        IsPSel = true;
		        return 1;
			}
			SelectTextDraw(playerid, -1);
			IsPSel = true;
			SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}If you want exit use /tde exit.");
		}
	    return 1;
	}
	else if(dialogid == DIALOG_NEWPROJECT)
	{
	    if(response)
	    {
	        if(!(1 <= strlen(inputtext) <= 32)) return ShowPlayerDialog(playerid, DIALOG_NEWPROJECT, DIALOG_STYLE_INPUT, "TDEditor - New project", "Project Name (if exists will load):", ">>", "<<");
			if(!IsValidProjectName(inputtext)) return ShowPlayerDialog(playerid, DIALOG_NEWPROJECT, DIALOG_STYLE_INPUT, "TDEditor - New project", "Project Name (if exists will load):", ">>", "<<");
			if(strlen(ProjectFile)) CloseProject();
			
			format(ProjectFile, sizeof ProjectFile, "%s.tde", inputtext);
			if(!CheckProject(inputtext)) AddProject(ProjectFile);
			
			ProjectEditor = playerid;
	        EditorEnabled = true;
	        IsPSel = true;
	        ShowEditor();
	        
	        PageStart = 0;
			if(fexist(ProjectFile))
			{
				LoadProject();
				SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}Project loaded.");
			} 
			else
			{
			    Handler = fopen(ProjectFile, io_write);
			    fclose(Handler);
			    SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}Project created.");
			}
			
			if(EditIndex != INVALID_INDEX_ID)
 	    	{
     	    	Loop(1, sizeof(TDE_Menu))
			    {
					TextDrawColor(TDE_Menu[c], 0xDDDDDDFF);
					TextDrawSetSelectable(TDE_Menu[c], true);
			        TextDrawShowForPlayer(ProjectEditor, TDE_Menu[c]);
			    }
			    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
			    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
			    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[20]);
			    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
			    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
			    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
			    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
			    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
			    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[29]);
			    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[33]);
			    UpdateIcons(EditIndex);
			}
			
			EditorUpdateTimer = SetTimerEx("OnEditorUpdate", 25, true, "i", ProjectEditor);
	    }
	    else ShowPlayerDialog(playerid, DIALOG_PROJECT, DIALOG_STYLE_LIST, "TDEditor", "Create a new project\nLoad a project\nClose project", ">>", "X");
	    return 1;
	}
	else if(dialogid == DIALOG_PROJECT_LIST)
	{
	    if(response)
        {
            Handler = fopen("tdelist.txt", io_read);
         	if(!Handler) return 1;

         	new Index = -1;
         	while(fread(Handler, Pro_Str))
         	{
         	    if(!strlen(Pro_Str)) continue;
         	    Index++;

         	    if(Index == listitem)
         	    {
         	    	StripNewLine(Pro_Str);

         	    	if(strlen(ProjectFile))
         	    	{
             	    	SaveProject();
             	    	CloseProject();
         	    	}
         	    	ProjectEditor = playerid;
			        EditorEnabled = true;
			        IsPSel = true;
			        ShowEditor();
			        
         	    	format(ProjectFile, sizeof(ProjectFile), "%s", Pro_Str);
         	    	if(!LoadProject())
					{
					    SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}Couldn't load this project, check .tde file.");
                        ShowPlayerDialog(playerid, DIALOG_PROJECT, DIALOG_STYLE_LIST, "TDEditor", "Create a new project\nLoad a project\nClose project", ">>", "X");
                        return 1;
					}
         	    	if(EditIndex >= INVALID_INDEX_ID)
         	    	{
	         	    	Loop(1, sizeof(TDE_Menu))
					    {
							TextDrawColor(TDE_Menu[c], 0xDDDDDDFF);
							TextDrawSetSelectable(TDE_Menu[c], true);
					        TextDrawShowForPlayer(ProjectEditor, TDE_Menu[c]);
					    }
					    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
					    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
					    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[20]);
					    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
					    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
					    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
					    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
					    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
					    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[29]);
					    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[33]);
					    UpdateIcons(EditIndex);
					}
         	    	
					EditorUpdateTimer = SetTimerEx("OnEditorUpdate", 25, true, "i", ProjectEditor);
         	    }
         	}
        }
        else ShowPlayerDialog(playerid, DIALOG_PROJECT, DIALOG_STYLE_LIST, "TDEditor", "Create a new project\nLoad a project\nClose project", ">>", "X");
        return 1;
	}
    if(!EditorEnabled || ProjectEditor != playerid) return false;
    if(EditMode == EDITMODE_ADJUST) return false;
	switch(dialogid)
	{
	    case DIALOG_NEW:
	    {
	        if(response)
	        {
	            switch(listitem)
	            {
	                case 0: //Normal
	                {
	                    new Index = GetAvailableIndex();
						if(Index == INVALID_INDEX_ID) return SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}You can't create more TextDraws.");
				      	EditIndex = Index;

				      	if(EditIndex == 0)
				      	{
				       		Loop(1, sizeof(TDE_Menu))
						    {
								TextDrawColor(TDE_Menu[c], 0xDDDDDDFF);
								TextDrawSetSelectable(TDE_Menu[c], true);
						        TextDrawShowForPlayer(ProjectEditor, TDE_Menu[c]);
						    }
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[20]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[29]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[33]);
				      	}

						ProjectTD[Index][ETextDrawID] = TextDrawCreate(290.0, 190.0, "TDEditor");
						TextDrawLetterSize(ProjectTD[Index][ETextDrawID], 0.4, 1.6);
						TextDrawAlignment(ProjectTD[Index][ETextDrawID], 1);
						TextDrawColor(ProjectTD[Index][ETextDrawID], -1);
						TextDrawUseBox(ProjectTD[Index][ETextDrawID], 0);
						TextDrawSetShadow(ProjectTD[Index][ETextDrawID], 0);
						TextDrawSetOutline(ProjectTD[Index][ETextDrawID], 0);
						TextDrawBackgroundColor(ProjectTD[Index][ETextDrawID], 255);
						TextDrawFont(ProjectTD[Index][ETextDrawID], 1);
						TextDrawSetProportional(ProjectTD[Index][ETextDrawID], 1);
						TextDrawShowForPlayer(ProjectEditor, ProjectTD[Index][ETextDrawID]);


					    ProjectTD[EditIndex][ItsFromTDE] = 1;
					    format(ProjectTD[EditIndex][ETextDrawText], 800, "TDEditor");
						ProjectTD[EditIndex][ETextDrawPosX] = 290.0;
						ProjectTD[EditIndex][ETextDrawPosY] = 190.0;
						ProjectTD[EditIndex][ETextDrawLetterX] = 0.4;
						ProjectTD[EditIndex][ETextDrawLetterY] = 1.6;
						ProjectTD[EditIndex][ETextDrawColor] = 0xFFFFFFFF;
						ProjectTD[EditIndex][ETextDrawBGColor] = 0x000000FF;
						ProjectTD[EditIndex][ETextDrawBoxColor] = 0x000000FF;

						new string[128];
				        format(string, sizeof(string), "{e2b960}TDEditor: {FFFFFF}TextDraw {e2b960}#%d {FFFFFF}created.", EditIndex);
				        SendClientMessage(ProjectEditor, -1, string);
				        SelectTextDraw(playerid, -1);
				        IsPSel = true;
				        UpdateIcons(EditIndex);
				        
				        if(EditMode == EDITMODE_MODELS)
				        {
				            TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
					    	EditMode = EDITMODE_NONE;
				        }
	                }
	                case 1: //TXD
	                {
						new Index = GetAvailableIndex();
						if(Index == INVALID_INDEX_ID) return SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}You can't create more TextDraws.");
				      	EditIndex = Index;

				      	if(EditIndex == 0)
				      	{
				       		Loop(1, sizeof(TDE_Menu))
						    {
								TextDrawColor(TDE_Menu[c], 0xDDDDDDFF);
								TextDrawSetSelectable(TDE_Menu[c], true);
						        TextDrawShowForPlayer(ProjectEditor, TDE_Menu[c]);
						    }
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[20]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[29]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[33]);
				      	}
				      	
				      	ProjectTD[Index][ETextDrawID] = TextDrawCreate(265.0, 155.0, "LD_SPAC:white");
						TextDrawLetterSize(ProjectTD[Index][ETextDrawID], 0.0, 0.0);
						TextDrawTextSize(ProjectTD[Index][ETextDrawID], 90.0, 90.0);
						TextDrawAlignment(ProjectTD[Index][ETextDrawID], 1);
						TextDrawColor(ProjectTD[Index][ETextDrawID], -1);
						TextDrawUseBox(ProjectTD[Index][ETextDrawID], 0);
						TextDrawSetShadow(ProjectTD[Index][ETextDrawID], 0);
						TextDrawSetOutline(ProjectTD[Index][ETextDrawID], 0);
						TextDrawFont(ProjectTD[Index][ETextDrawID], 4);
						TextDrawShowForPlayer(ProjectEditor, ProjectTD[Index][ETextDrawID]);


					    ProjectTD[EditIndex][ItsFromTDE] = 1;
					    format(ProjectTD[EditIndex][ETextDrawText], 800, "LD_SPAC:white");
						ProjectTD[EditIndex][ETextDrawPosX] = 265.0;
						ProjectTD[EditIndex][ETextDrawPosY] = 155.0;
						ProjectTD[EditIndex][ETextDrawTextX] = 90.0;
						ProjectTD[EditIndex][ETextDrawTextY] = 90.0;
						ProjectTD[EditIndex][ETextDrawLetterX] = 0.0;
						ProjectTD[EditIndex][ETextDrawLetterY] = 0.0;
						ProjectTD[EditIndex][ETextDrawColor] = 0xFFFFFFFF;
						ProjectTD[EditIndex][ETextDrawBGColor] = 0x000000FF;
						ProjectTD[EditIndex][ETextDrawBoxColor] = 0x000000FF;

						new string[128];
				        format(string, sizeof(string), "{e2b960}TDEditor: {FFFFFF}TextDraw {e2b960}#%d {FFFFFF}created.", EditIndex);
				        SendClientMessage(ProjectEditor, -1, string);
				        SelectTextDraw(playerid, -1);
				        IsPSel = true;
				        UpdateIcons(EditIndex);
				        
				        if(EditMode == EDITMODE_MODELS)
				        {
				            TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
					    	EditMode = EDITMODE_NONE;
				        }
	                }
	                case 2: //Previews
	                {
	                    new Index = GetAvailableIndex();
						if(Index == INVALID_INDEX_ID) return SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}You can't create more TextDraws.");
				      	EditIndex = Index;

				      	if(EditIndex == 0)
				      	{
				       		Loop(1, sizeof(TDE_Menu))
						    {
								TextDrawColor(TDE_Menu[c], 0xDDDDDDFF);
								TextDrawSetSelectable(TDE_Menu[c], true);
						        TextDrawShowForPlayer(ProjectEditor, TDE_Menu[c]);
						    }
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[20]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[29]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[33]);
				      	}

				      	ProjectTD[Index][ETextDrawID] = TextDrawCreate(265.0, 155.0, "");
						TextDrawLetterSize(ProjectTD[Index][ETextDrawID], 0.0, 0.0);
						TextDrawTextSize(ProjectTD[Index][ETextDrawID], 90.0, 90.0);
						TextDrawAlignment(ProjectTD[Index][ETextDrawID], 1);
						TextDrawColor(ProjectTD[Index][ETextDrawID], -1);
						TextDrawUseBox(ProjectTD[Index][ETextDrawID], 0);
						TextDrawSetShadow(ProjectTD[Index][ETextDrawID], 0);
						TextDrawSetOutline(ProjectTD[Index][ETextDrawID], 0);
						TextDrawFont(ProjectTD[Index][ETextDrawID], 5);
						TextDrawSetPreviewModel(ProjectTD[Index][ETextDrawID], 0);
						TextDrawSetPreviewRot(ProjectTD[Index][ETextDrawID], 0.0, 0.0, 0.0, 1.0);
						TextDrawBackgroundColor(ProjectTD[Index][ETextDrawID], 0x000000FF);
						TextDrawShowForPlayer(ProjectEditor, ProjectTD[Index][ETextDrawID]);


					    ProjectTD[EditIndex][ItsFromTDE] = 1;
					    format(ProjectTD[EditIndex][ETextDrawText], 800, "");
						ProjectTD[EditIndex][ETextDrawPosX] = 265.0;
						ProjectTD[EditIndex][ETextDrawPosY] = 155.0;
						ProjectTD[EditIndex][ETextDrawTextX] = 90.0;
						ProjectTD[EditIndex][ETextDrawTextY] = 90.0;
						ProjectTD[EditIndex][ETextDrawLetterX] = 0.0;
						ProjectTD[EditIndex][ETextDrawLetterY] = 0.0;
						ProjectTD[EditIndex][ETextDrawColor] = 0xFFFFFFFF;
						ProjectTD[EditIndex][ETextDrawBGColor] = 0x000000FF;
						ProjectTD[EditIndex][ETextDrawBoxColor] = 0x000000FF;
						ProjectTD[EditIndex][ETextDrawModelid] = 0;
						ProjectTD[EditIndex][ETextDrawRotX] = 0.0;
						ProjectTD[EditIndex][ETextDrawRotY] = 0.0;
						ProjectTD[EditIndex][ETextDrawRotZ] = 0.0;
						ProjectTD[EditIndex][ETextDrawZoom] = 1.0;
						ProjectTD[EditIndex][ETextDrawVehCol1] = 1;
	                    ProjectTD[EditIndex][ETextDrawVehCol2] = 1;
						new string[128];
				        format(string, sizeof(string), "{e2b960}TDEditor: {FFFFFF}TextDraw {e2b960}#%d {FFFFFF}created.", EditIndex);
				        SendClientMessage(ProjectEditor, -1, string);
				        SelectTextDraw(playerid, -1);
				        IsPSel = true;
				        UpdateIcons(EditIndex);
	                }
	                case 3:
	                {
	                    new Index = GetAvailableIndex();
						if(Index == INVALID_INDEX_ID) return SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}You can't create more TextDraws.");
				      	EditIndex = Index;

				      	if(EditIndex == 0)
				      	{
				       		Loop(1, sizeof(TDE_Menu))
						    {
								TextDrawColor(TDE_Menu[c], 0xDDDDDDFF);
								TextDrawSetSelectable(TDE_Menu[c], true);
						        TextDrawShowForPlayer(ProjectEditor, TDE_Menu[c]);
						    }
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[20]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[29]);
						    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[33]);
				      	}

						ProjectTD[Index][ETextDrawID] = TextDrawCreate(290.0, 190.0, "box");
						TextDrawLetterSize(ProjectTD[Index][ETextDrawID], 0.0, 10.0);
						TextDrawAlignment(ProjectTD[Index][ETextDrawID], 1);
						TextDrawColor(ProjectTD[Index][ETextDrawID], -1);
						TextDrawUseBox(ProjectTD[Index][ETextDrawID], 1);
						TextDrawTextSize(ProjectTD[Index][ETextDrawID], 350.0, 0.0);
						TextDrawSetShadow(ProjectTD[Index][ETextDrawID], 0);
						TextDrawSetOutline(ProjectTD[Index][ETextDrawID], 0);
						TextDrawBackgroundColor(ProjectTD[Index][ETextDrawID], 255);
						TextDrawBoxColor(ProjectTD[Index][ETextDrawID], 255);
						TextDrawFont(ProjectTD[Index][ETextDrawID], 1);
						TextDrawSetProportional(ProjectTD[Index][ETextDrawID], 1);
						TextDrawShowForPlayer(ProjectEditor, ProjectTD[Index][ETextDrawID]);


					    ProjectTD[EditIndex][ItsFromTDE] = 1;
					    format(ProjectTD[EditIndex][ETextDrawText], 800, "box");
						ProjectTD[EditIndex][ETextDrawPosX] = 290.0;
						ProjectTD[EditIndex][ETextDrawPosY] = 190.0;
						ProjectTD[EditIndex][ETextDrawLetterX] = 0.0;
						ProjectTD[EditIndex][ETextDrawLetterY] = 10.0;
						ProjectTD[EditIndex][ETextDrawTextX] = 350.0;
						ProjectTD[EditIndex][ETextDrawTextY] = 0.0;
						ProjectTD[EditIndex][ETextDrawColor] = 0xFFFFFFFF;
						ProjectTD[EditIndex][ETextDrawBGColor] = 0x000000FF;
						ProjectTD[EditIndex][ETextDrawBoxColor] = 0x000000FF;

						new string[128];
				        format(string, sizeof(string), "{e2b960}TDEditor: {FFFFFF}TextDraw {e2b960}#%d {FFFFFF}created.", EditIndex);
				        SendClientMessage(ProjectEditor, -1, string);
				        SelectTextDraw(playerid, -1);
				        IsPSel = true;
				        UpdateIcons(EditIndex);

				        if(EditMode == EDITMODE_MODELS)
				        {
				            TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
					    	EditMode = EDITMODE_NONE;
				        }
	                }
	            }
	        }
	        else
	        {
	            SelectTextDraw(ProjectEditor, -1);
				IsPSel = true;
	        }
	    }
	    case DIALOG_MANAGE:
	    {
	        if(response)
	        {
	            if(BackManageDialog[listitem] == 1)
				{
                    PageStart -= 10;
                    ShowManage(ProjectEditor);
				    return 1;
				}
				
	            if(listitem == 10)
				{
					PageStart += 10;
                    ShowManage(ProjectEditor);
                    return 1;
				}
				
				new id = 0;
                for(new i = PageStart; i < MAX_PROJECT_TEXTDRAWS; i ++)
                {
                    if(ProjectTD[i][ItsFromTDE] == 1)
                    {
						if(id == listitem)
						{
						    EditIndex = i;
							break;
						}
						id ++;
					}
                }
                UpdateIcons(EditIndex);
                new string[128];
                format(string, sizeof(string), "{e2b960}TDEditor: {FFFFFF}TextDraw {e2b960}#%d {FFFFFF}selected.", EditIndex);
                SendClientMessage(ProjectEditor, -1, string);
                SelectTextDraw(ProjectEditor, -1);
                IsPSel = true;
	        }
	        else
			{
				SelectTextDraw(ProjectEditor, -1);
				IsPSel = true;
			}
	    }
	    case DIALOG_EDITTEXT:
	    {
	        if(response)
	        {
	            if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITTEXT, DIALOG_STYLE_INPUT, "TDEditor - Text", "Insert the TextDraw text:", ">>", "X");
	            format(ProjectTD[EditIndex][ETextDrawText], 800, "%s", inputtext);
	            TextDrawSetString(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawText]);
	            SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
	        }
	        else
			{
				SelectTextDraw(ProjectEditor, -1);
				IsPSel = true;
			}
	    }
	    case DIALOG_MODELID:
	    {
	        if(response)
	        {
	            if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELID, DIALOG_STYLE_INPUT, "TDEditor - ModelID", "Insert the ModelID:", ">>", "X");
	            if(sscanf(inputtext, "d", inputtext[0])) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELID, DIALOG_STYLE_INPUT, "TDEditor - ModelID", "Insert the ModelID:", ">>", "X");
	            if(inputtext[0] < 0) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELID, DIALOG_STYLE_INPUT, "TDEditor - ModelID", "Insert the ModelID:", ">>", "X");
				ProjectTD[EditIndex][ETextDrawModelid] = inputtext[0];
				TextDrawSetPreviewModel(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawModelid]);
				if(IsVehicle(ProjectTD[EditIndex][ETextDrawModelid])) TextDrawSetPreviewVehCol(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawVehCol1], ProjectTD[EditIndex][ETextDrawVehCol2]);
				TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
	        }
	        else
	        {
	            SelectTextDraw(ProjectEditor, -1);
				IsPSel = true;
	        }
	    }
	    case DIALOG_CONFIRMEDELETE:
	    {
	        if(response)
	        {
	            if(EditIndex == INVALID_INDEX_ID) return false;
             	new string[128];
                format(string, sizeof(string), "{e2b960}TDEditor: {FFFFFF}TextDraw {e2b960}#%d {FFFFFF}removed.", EditIndex);
                SendClientMessage(ProjectEditor, -1, string);

	            RemoveTextDrawTDE(EditIndex);
	            SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
	        }
	        else
			{
				SelectTextDraw(ProjectEditor, -1);
				IsPSel = true;
			}
	    }
	    case DIALOG_SIZEX:
		{
            if(response)
			{
			    new Float:SizeX;
			    if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_SIZEX, DIALOG_STYLE_INPUT, "TDEditor - TextSizeX", "Enter the value of TextSizeX:\nNote: to put a decimal value use '.' instead of ',' for example: '18 .8 '", ">>", "X");
	            if(sscanf(inputtext, "f", SizeX)) return ShowPlayerDialog(ProjectEditor, DIALOG_SIZEX, DIALOG_STYLE_INPUT, "TDEditor - TextSizeX", "Enter the value of TextSizeX:\nNote: to put a decimal value use '.' instead of ',' for example: '18 .8 '", ">>", "X");
				ProjectTD[EditIndex][ETextDrawTextX] = SizeX;
	            TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
	            TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
	            ShowPlayerDialog(ProjectEditor, DIALOG_SIZEY, DIALOG_STYLE_INPUT, "TDEditor - TextSizeY", "Enter the value of TextSizeY:\nNote: to put a decimal value use '.' instead of ',' for example: '10 .2 '", ">>", "<<");
			}
			else
			{
				SelectTextDraw(ProjectEditor, -1);
				IsPSel = true;
			}
 		    return 1;
	    }
	    case DIALOG_SIZEY:
	    {
	        if(response)
	        {
	            new Float:SizeY;
			    if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_SIZEY, DIALOG_STYLE_INPUT, "TDEditor - TextSizeY", "Enter the value of TextSizeY:\nNote: to put a decimal value use '.' instead of ',' for example: '10 .2 '", ">>", "<<");
	            if(sscanf(inputtext, "f", SizeY)) return ShowPlayerDialog(ProjectEditor, DIALOG_SIZEY, DIALOG_STYLE_INPUT, "TDEditor - TextSizeY", "Enter the value of TextSizeY:\nNote: to put a decimal value use '.' instead of ',' for example: '10 .2 '", ">>", "<<");
				ProjectTD[EditIndex][ETextDrawTextY] = SizeY;
	            TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
	            TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
	            SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
	        }
	        else ShowPlayerDialog(ProjectEditor, DIALOG_SIZEX, DIALOG_STYLE_INPUT, "TDEditor - TextSizeX", "Enter the value of TextSizeX:\nNote: to put a decimal value use '.' instead of ',' for example: '18 .8 '", ">>", "X");
	    }
	    case DIALOG_EDITOUTLINE:
	    {
	        if(response)
	        {
	            if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITOUTLINE, DIALOG_STYLE_INPUT, "TDEditor - Outline", "Insert an integer value for the outline.\n\n0 to remove the outline.", ">>", "X");
	            if(sscanf(inputtext, "d", inputtext[0])) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITOUTLINE, DIALOG_STYLE_INPUT, "TDEditor - Outline", "Insert an integer value for the outline.\n\n0 to remove the outline.", ">>", "X");
				//if(inputtext[0] < 0) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITOUTLINE, DIALOG_STYLE_INPUT, "TDEditor - Outline", "Insert an integer value for the outline.\n\n0 to remove the outline.", ">>", "X");
                ProjectTD[EditIndex][ETextDrawOutline] = inputtext[0];
				TextDrawSetOutline(ProjectTD[EditIndex][ETextDrawID], inputtext[0]);
	            TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
	            SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
	        }
	        else
			{
				SelectTextDraw(ProjectEditor, -1);
				IsPSel = true;
			}
	    }
	    case DIALOG_MODELS:
	    {
	        if(response)
	        {
	            switch(listitem)
	            {
	                case 0: ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_MLD, DIALOG_STYLE_INPUT, "TDEditor - ModelID", "Insert the ModelID:", ">>", "<<");
	                case 1: ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_RX, DIALOG_STYLE_INPUT, "TDEditor - RotX", "RotationX, to use a decimal use ',' \nFor example '.': '83 .4 ':", ">>", "<<");
	                case 2: ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_RY, DIALOG_STYLE_INPUT, "TDEditor - RotY", "RotationY, to use a decimal use ',' \nFor example '.': '83 .4 ':", ">>", "<<");
	                case 3: ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_RZ, DIALOG_STYLE_INPUT, "TDEditor - RotZ", "RotationZ, to use a decimal use ',' \nFor example '.': '83 .4 ':", ">>", "<<");
	                case 4: ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_ZO, DIALOG_STYLE_INPUT, "TDEditor - Zoom", "Zoom, to use a decimal use ',' \nFor example '.': '1 .4 ':", ">>", "<<");
	                case 5: ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_C1, DIALOG_STYLE_INPUT, "TDEditor - Vehicle Color 1", "Insert vehicle color 1:", ">>", "<<");
	                case 6: ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_C2, DIALOG_STYLE_INPUT, "TDEditor - Vehicle Color 2", "Insert vehicle color 2:", ">>", "<<");
	            }
	        }
	        else
	        {
	            SelectTextDraw(ProjectEditor, -1);
				IsPSel = true;
	        }
	    }
	    case DIALOG_MODELS_MLD:
	    {
	        if(response)
	        {
	            if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_MLD, DIALOG_STYLE_INPUT, "TDEditor - ModelID", "Insert the ModelID:", ">>", "<<");
	            if(sscanf(inputtext, "d", inputtext[0])) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_MLD, DIALOG_STYLE_INPUT, "TDEditor - ModelID", "Insert the ModelID:", ">>", "<<");
	            if(inputtext[0] < 0) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_MLD, DIALOG_STYLE_INPUT, "TDEditor - ModelID", "Insert the ModelID:", ">>", "<<");
				ProjectTD[EditIndex][ETextDrawModelid] = inputtext[0];
				TextDrawSetPreviewModel(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawModelid]);
				if(IsVehicle(ProjectTD[EditIndex][ETextDrawModelid])) TextDrawSetPreviewVehCol(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawVehCol1], ProjectTD[EditIndex][ETextDrawVehCol2]);
				TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
	        }
	        else
			{
			    if(IsVehicle(ProjectTD[EditIndex][ETextDrawModelid])) ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom\nVehicle color 1\nVehicle color 2", ">>", "X");
				else ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom", ">>", "X");
			}
		}
	    case DIALOG_MODELS_RX:
	    {
	        if(response)
	        {
	            new Float:coord;
	            if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_RX, DIALOG_STYLE_INPUT, "TDEditor - RotX", "RotationX, to use a decimal use ',' \nFor example '.': '83 .4 ':", ">>", "<<");
	            if(sscanf(inputtext, "f", coord)) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_RX, DIALOG_STYLE_INPUT, "TDEditor - RotX", "RotationX, to use a decimal use ',' \nFor example '.': '83 .4 ':", ">>", "<<");
				ProjectTD[EditIndex][ETextDrawRotX] = coord;
				TextDrawSetPreviewRot(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawRotX], ProjectTD[EditIndex][ETextDrawRotY], ProjectTD[EditIndex][ETextDrawRotZ], ProjectTD[EditIndex][ETextDrawZoom]);
				TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
	        }
	        else
			{
			    if(IsVehicle(ProjectTD[EditIndex][ETextDrawModelid])) ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom\nVehicle color 1\nVehicle color 2", ">>", "X");
				else ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom", ">>", "X");
			}
		}
	    case DIALOG_MODELS_RY:
	    {
	        if(response)
	        {
	            new Float:coord;
	            if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_RY, DIALOG_STYLE_INPUT, "TDEditor - RotY", "RotationY, to use a decimal use ',' \nFor example '.': '83 .4 ':", ">>", "<<");
	            if(sscanf(inputtext, "f", coord)) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_RY, DIALOG_STYLE_INPUT, "TDEditor - RotY", "RotationY, to use a decimal use ',' \nFor example '.': '83 .4 ':", ">>", "<<");
				ProjectTD[EditIndex][ETextDrawRotY] = coord;
				TextDrawSetPreviewRot(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawRotX], ProjectTD[EditIndex][ETextDrawRotY], ProjectTD[EditIndex][ETextDrawRotZ], ProjectTD[EditIndex][ETextDrawZoom]);
				TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
	        }
	        else
			{
			    if(IsVehicle(ProjectTD[EditIndex][ETextDrawModelid])) ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom\nVehicle color 1\nVehicle color 2", ">>", "X");
				else ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom", ">>", "X");
			}
		}
	    case DIALOG_MODELS_RZ:
	    {
	        if(response)
	        {
	            new Float:coord;
	            if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_RZ, DIALOG_STYLE_INPUT, "TDEditor - RotZ", "RotationZ, to use a decimal use ',' \nFor example '.': '83 .4 ':", ">>", "<<");
	            if(sscanf(inputtext, "f", coord)) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_RZ, DIALOG_STYLE_INPUT, "TDEditor - RotZ", "RotationZ, to use a decimal use ',' \nFor example '.': '83 .4 ':", ">>", "<<");
				ProjectTD[EditIndex][ETextDrawRotZ] = coord;
				TextDrawSetPreviewRot(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawRotX], ProjectTD[EditIndex][ETextDrawRotY], ProjectTD[EditIndex][ETextDrawRotZ], ProjectTD[EditIndex][ETextDrawZoom]);
				TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
	        }
	        else
			{
			    if(IsVehicle(ProjectTD[EditIndex][ETextDrawModelid])) ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom\nVehicle color 1\nVehicle color 2", ">>", "X");
				else ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom", ">>", "X");
			}
		}
	    case DIALOG_MODELS_ZO:
	    {
	        if(response)
	        {
	            new Float:coord;
	            if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_ZO, DIALOG_STYLE_INPUT, "TDEditor - Zoom", "Zoom, to use a decimal use ',' \nFor example '.': '1 .4 ':", ">>", "<<");
	            if(sscanf(inputtext, "f", coord)) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_ZO, DIALOG_STYLE_INPUT, "TDEditor - Zoom", "Zoom, to use a decimal use ',' \nFor example '.': '1 .4 ':", ">>", "<<");
				ProjectTD[EditIndex][ETextDrawZoom] = coord;
				TextDrawSetPreviewRot(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawRotX], ProjectTD[EditIndex][ETextDrawRotY], ProjectTD[EditIndex][ETextDrawRotZ], ProjectTD[EditIndex][ETextDrawZoom]);
				TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
	        }
	        else
			{
			    if(IsVehicle(ProjectTD[EditIndex][ETextDrawModelid])) ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom\nVehicle color 1\nVehicle color 2", ">>", "X");
				else ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom", ">>", "X");
			}
		}
		case DIALOG_MODELS_C1:
	    {
	        if(response)
	        {
	            if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_C1, DIALOG_STYLE_INPUT, "TDEditor - Vehicle Color 1", "Insert vehicle color 1:", ">>", "<<");
	            if(sscanf(inputtext, "d", inputtext[0])) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_C1, DIALOG_STYLE_INPUT, "TDEditor - Vehicle Color 1", "Insert vehicle color 1:", ">>", "<<");
				ProjectTD[EditIndex][ETextDrawVehCol1] = inputtext[0];
				TextDrawSetPreviewVehCol(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawVehCol1], ProjectTD[EditIndex][ETextDrawVehCol2]);
				TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
	        }
	        else
			{
			    if(IsVehicle(ProjectTD[EditIndex][ETextDrawModelid])) ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom\nVehicle color 1\nVehicle color 2", ">>", "X");
				else ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom", ">>", "X");
			}
		}
		case DIALOG_MODELS_C2:
	    {
	        if(response)
	        {
	            if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_C2, DIALOG_STYLE_INPUT, "TDEditor - Vehicle Color 2", "Insert vehicle color 2:", ">>", "<<");
	            if(sscanf(inputtext, "d", inputtext[0])) return ShowPlayerDialog(ProjectEditor, DIALOG_MODELS_C2, DIALOG_STYLE_INPUT, "TDEditor - Vehicle Color 2", "Insert vehicle color 2:", ">>", "<<");
				ProjectTD[EditIndex][ETextDrawVehCol2] = inputtext[0];
				TextDrawSetPreviewVehCol(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawVehCol1], ProjectTD[EditIndex][ETextDrawVehCol2]);
				TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
	        }
	        else
			{
			    if(IsVehicle(ProjectTD[EditIndex][ETextDrawModelid])) ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom\nVehicle color 1\nVehicle color 2", ">>", "X");
				else ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom", ">>", "X");
			}
		}
	    case DIALOG_EDITSHADOW:
	    {
	        if(response)
	        {
	            if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITSHADOW, DIALOG_STYLE_INPUT, "TDEditor - Shadow", "Insert an integer value for the shadow.\n\n0 to remove the shadow.", ">>", "X");
	            if(sscanf(inputtext, "d", inputtext[0])) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITSHADOW, DIALOG_STYLE_INPUT, "TDEditor - Shadow", "Insert an integer value for the shadow.\n\n0 to remove the shadow.", ">>", "X");
				//if(inputtext[0] < 0) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITOUTLINE, DIALOG_STYLE_INPUT, "TDEditor - Outline", "Insert an integer value for the outline.\n\n0 to remove the outline.", ">>", "X");
                ProjectTD[EditIndex][ETextDrawShadow] = inputtext[0];
				TextDrawSetShadow(ProjectTD[EditIndex][ETextDrawID], inputtext[0]);
	            TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
	            SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
	        }
	        else
			{
				SelectTextDraw(ProjectEditor, -1);
				IsPSel = true;
			}
	    }
	    case DIALOG_LETTERX:
	    {
			if(response)
			{
			    new Float:LetterSizeX;
			    if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_LETTERX, DIALOG_STYLE_INPUT, "TDEditor - LetterSizeX", "Insert the value of LetteSizeX:\nNote: to insert a decimal value use '.' instead of ',' for example '0.4'", ">>", "X");
	            if(sscanf(inputtext, "f", LetterSizeX)) return ShowPlayerDialog(ProjectEditor, DIALOG_LETTERX, DIALOG_STYLE_INPUT, "TDEditor - LetterSizeX", "Insert the value of LetteSizeX:\nNote: to insert a decimal value use '.' instead of ',' for example '0.4'", ">>", "X");
				ProjectTD[EditIndex][ETextDrawLetterX] = LetterSizeX;
	            TextDrawLetterSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);
	            TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
	            ShowPlayerDialog(ProjectEditor, DIALOG_LETTERY, DIALOG_STYLE_INPUT, "TDEditor - LetterSizeY", "Insert the value of LetteSizeY:\nNote: to insert a decimal value use '.' instead of ',' for example '0.4'", ">>", "<<");
			}
			else
			{
				SelectTextDraw(ProjectEditor, -1);
				IsPSel = true;
			}
	    }
	    case DIALOG_LETTERY:
	    {
			if(response)
			{
			    new Float:LetterSizeY;
			    if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_LETTERY, DIALOG_STYLE_INPUT, "TDEditor - LetterSizeY", "Insert the value of LetteSizeY:\nNote: to insert a decimal value use '.' instead of ',' for example '0.4'", ">>", "X");
	            if(sscanf(inputtext, "f", LetterSizeY)) return ShowPlayerDialog(ProjectEditor, DIALOG_LETTERY, DIALOG_STYLE_INPUT, "TDEditor - LetterSizeY", "Insert the value of LetteSizeY:\nNote: to insert a decimal value use '.' instead of ',' for example '0.4'", ">>", "X");
				ProjectTD[EditIndex][ETextDrawLetterY] = LetterSizeY;
	            TextDrawLetterSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);
	            TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
	            SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
			}
			else ShowPlayerDialog(ProjectEditor, DIALOG_LETTERX, DIALOG_STYLE_INPUT, "TDEditor - LetterSizeX", "Insert the value of LetteSizeX:\nNote: to insert a decimal value use '.' instead of ',' for example '0.4'", ">>", "X");
	    }
	    case DIALOG_POSX:
	    {
			if(response)
			{
			    new Float:LetterSizeX;
			    if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_POSX, DIALOG_STYLE_INPUT, "TDEditor - PositionX", "Insert the value of PositionX:\nNote: to insert a decimal value use '.' instead of ',' for example '298.73'", ">>", "X");
	            if(sscanf(inputtext, "f", LetterSizeX)) return ShowPlayerDialog(ProjectEditor, DIALOG_POSX, DIALOG_STYLE_INPUT, "TDEditor - PositionX", "Insert the value of PositionX:\nNote: to insert a decimal value use '.' instead of ',' for example '298.73'", ">>", "X");
				ProjectTD[EditIndex][ETextDrawPosX] = LetterSizeX;
	            TextDrawSetPos(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawPosX], ProjectTD[EditIndex][ETextDrawPosY]);
	            TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
	            ShowPlayerDialog(ProjectEditor, DIALOG_POSY, DIALOG_STYLE_INPUT, "TDEditor - PositionY", "Insert the value of PositionY:\nNote: to insert a decimal value use '.' instead of ',' for example '32.3'", ">>", "X");
			}
			else
			{
				SelectTextDraw(ProjectEditor, -1);
				IsPSel = true;
			}
	    }
	    case DIALOG_POSY:
	    {
			if(response)
			{
			    new Float:LetterSizeY;
			    if(!strlen(inputtext)) return ShowPlayerDialog(ProjectEditor, DIALOG_POSY, DIALOG_STYLE_INPUT, "TDEditor - PositionY", "Insert the value of PositionY:\nNote: to insert a decimal value use '.' instead of ',' for example '32.3'", ">>", "X");
	            if(sscanf(inputtext, "f", LetterSizeY)) return ShowPlayerDialog(ProjectEditor, DIALOG_POSY, DIALOG_STYLE_INPUT, "TDEditor - PositionY", "Insert the value of PositionY:\nNote: to insert a decimal value use '.' instead of ',' for example '32.3'", ">>", "X");
				ProjectTD[EditIndex][ETextDrawPosY] = LetterSizeY;
	            TextDrawSetPos(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawPosX], ProjectTD[EditIndex][ETextDrawPosY]);
	            TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
	            SelectTextDraw(ProjectEditor, -1);
	            IsPSel = true;
			}
			else ShowPlayerDialog(ProjectEditor, DIALOG_POSX, DIALOG_STYLE_INPUT, "TDEditor - PositionX", "Insert the value of PositionX:\nNote: to insert a decimal value use '.' instead of ',' for example '298.73'", ">>", "X");
	    }
	    case DIALOG_EDITCOLOR:
		{
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 0:
		            {
                        new str[1024];
						Loop(0, sizeof(PremadeColors))
						{
						    format(str, sizeof(str), "%s{%06x}%s\n", str, PremadeColors[c][0] >>> 8, PremadeColors[c][1]);
						}
						ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+100, DIALOG_STYLE_LIST, "TDEditor - BG/Box/Color", str, ">>", "<<");
		            }
		            case 1: ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+101, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "Insert the color in HEX RRGGBBAA formar, for example: FF0000FF", ">>", "<<");
		            case 2: ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+102, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Red", ">>", "<<");
		        }
		    }
		    else
			{
				EditMode = EDITMODE_NONE;
				SelectTextDraw(ProjectEditor, -1);
				IsPSel = true;
			}
		}
		case DIALOG_EDITCOLOR+100:
		{
		    if(response)
		    {
		        switch(EditMode)
		        {
		        	case EDITMODE_COLOR:
					{
						ProjectTD[EditIndex][ETextDrawColor] = PremadeColors[listitem][0];
		        		TextDrawColor(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawColor]);
					}
					case EDITMODE_BGCOLOR:
					{
						ProjectTD[EditIndex][ETextDrawBGColor] = PremadeColors[listitem][0];
		        		TextDrawBackgroundColor(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawBGColor]);
					}
					case EDITMODE_BOXCOLOR:
					{
						ProjectTD[EditIndex][ETextDrawBoxColor] = PremadeColors[listitem][0];
		        		TextDrawBoxColor(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawBoxColor]);
					}
				}
				EditMode = EDITMODE_NONE;
		        TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
		        SelectTextDraw(ProjectEditor, -1);
		        IsPSel = true;
		    }
		    else ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR, DIALOG_STYLE_LIST, "TDEditor - BG/Box/Color", "Main colors\nWrite the exact value (HEX)\nColor combinator (RGBA)", ">>", "X");
		}
		case DIALOG_EDITCOLOR+101:
		{
		    if(response)
		    {
		        if(strlen(inputtext) < 8) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+101, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "Insert the color in HEX RRGGBBAA formar, for example: FF0000FF", ">>", "<<");
		        
				if(inputtext[0] == '0' && inputtext[1] == 'x') Colors[0] = HexToInt(inputtext[2]); 
				if(inputtext[0] == '#') Colors[0] = HexToInt(inputtext[1]);
		        else Colors[0] = HexToInt(inputtext);
		        switch(EditMode)
		        {
			        case EDITMODE_COLOR:
					{
						ProjectTD[EditIndex][ETextDrawColor] = Colors[0];
		        		TextDrawColor(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawColor]);
					}
					case EDITMODE_BGCOLOR:
					{
						ProjectTD[EditIndex][ETextDrawBGColor] = Colors[0];
		        		TextDrawBackgroundColor(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawBGColor]);
					}
					case EDITMODE_BOXCOLOR:
					{
						ProjectTD[EditIndex][ETextDrawBoxColor] = Colors[0];
		        		TextDrawBoxColor(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawBoxColor]);
					}
				}
				EditMode = EDITMODE_NONE;
		        TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
		        SelectTextDraw(ProjectEditor, -1);
		        IsPSel = true;
		    }
		    else ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR, DIALOG_STYLE_LIST, "TDEditor - BG/Box/Color", "Main colors\nWrite the exact value (HEX)\nColor combinator (RGBA)", ">>", "X");
		}
		case DIALOG_EDITCOLOR+102:
		{
			if(response)
			{
			    if(sscanf(inputtext, "d", inputtext[0])) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+102, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Red", ">>", "<<");
			    if(inputtext[0] < 0 || inputtext[0] > 255) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+102, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Red", ">>", "<<");
			    Colors[0] = inputtext[0];
			    ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+103, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Green", ">>", "<<");
			}
			else ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR, DIALOG_STYLE_LIST, "TDEditor - BG/Box/Color", "Main colors\nWrite the exact value (HEX)\nColor combinator (RGBA)", ">>", "X");
		}
		case DIALOG_EDITCOLOR+103:
		{
			if(response)
			{
			    if(sscanf(inputtext, "d", inputtext[0])) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+103, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Green", ">>", "X");
			    if(inputtext[0] < 0 || inputtext[0] > 255) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+103, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Green", ">>", "X");
			    Colors[1] = inputtext[0];
			    ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+104, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Blue", ">>", "<<");
			}
			else ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+102, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Red", ">>", "<<");
		}
		case DIALOG_EDITCOLOR+104:
		{
			if(response)
			{
			    if(sscanf(inputtext, "d", inputtext[0])) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+104, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Blue", ">>", "X");
			    if(inputtext[0] < 0 || inputtext[0] > 255) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+104, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Blue", ">>", "X");
			    Colors[2] = inputtext[0];
			    ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+105, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Alpha", ">>", "<<");
			}
			else ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+103, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Green", ">>", "<<");
		}
		case DIALOG_EDITCOLOR+105:
		{
			if(response)
			{
			    if(sscanf(inputtext, "d", inputtext[0])) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+105, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Alpha", ">>", "<<");
			    if(inputtext[0] < 0 || inputtext[0] > 255) return ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+105, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Alpha", ">>", "<<");
			    Colors[3] = inputtext[0];
			    new color = RGB(Colors[0], Colors[1], Colors[2], Colors[3]);
			    switch(EditMode)
		        {
			        case EDITMODE_COLOR:
					{
						ProjectTD[EditIndex][ETextDrawColor] = color;
		        		TextDrawColor(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawColor]);
					}
					case EDITMODE_BGCOLOR:
					{
						ProjectTD[EditIndex][ETextDrawBGColor] = color;
		        		TextDrawBackgroundColor(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawBGColor]);
					}
					case EDITMODE_BOXCOLOR:
					{
						ProjectTD[EditIndex][ETextDrawBoxColor] = color;
		        		TextDrawBoxColor(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawBoxColor]);
					}
				}
				EditMode = EDITMODE_NONE;
		        TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
		        SelectTextDraw(ProjectEditor, -1);
		        IsPSel = true;
			}
			else ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR+104, DIALOG_STYLE_INPUT, "TDEditor - BG/Box/Color", "0 to 255, enter the amount of Blue", ">>", "<<");
		}
	}
	return false;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == Text:INVALID_TEXT_DRAW)
	{
	    if(!EditorEnabled && ProjectEditor == -1)
	    {
	        if(!IsPSel) return false;
	    	TogglePlayerControllable(playerid, true);
	    	TextDrawHideForPlayer(playerid, TDELOGO);
	        DestroyMenuTextDraws();
	        SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}TDEditor closed.");
	        return 1;
	    }
	}
	if(clickedid == TDELOGO)
	{
	    if(!IsPSel) return false;
	    IsPSel = false;
	    TextDrawHideForPlayer(playerid, TDELOGO);
	    CancelSelectTextDraw(playerid);
	    ShowPlayerDialog(playerid, DIALOG_PROJECT, DIALOG_STYLE_LIST, "TDEditor", "Create a new project\nLoad a project\nClose project", ">>", "X");
        SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}TDEditor started, if you need help you can use /tde help...");
		return 1;
	}
	
	if(!EditorEnabled || ProjectEditor != playerid) return false;
	if(EditMode == EDITMODE_ADJUST) return false;
	if(clickedid == Text:INVALID_TEXT_DRAW)
	{
	    if(!IsPSel) return false;
		SelectTextDraw(playerid, -1);
	    return 1;
	}
	if(clickedid == TDE_Menu[1])
	{
	    if(EditIndex == INVALID_INDEX_ID) return SendClientMessage(ProjectEditor, -1, "Error");
	    if(EditMode == EDITMODE_COLOR || EditMode == EDITMODE_BGCOLOR || EditMode == EDITMODE_BOXCOLOR || EditMode == EDITMODE_MODELS) return SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}Finish first this EditMode.");
	    TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
	    EditMode = EDITMODE_NONE;
	    IsPSel = false;
	    CancelSelectTextDraw(ProjectEditor);
	    //CheckManageDialog();
     	new d, c, e = -1, dialog[310], str[31];
	    for (d = PageStart; d < MAX_PROJECT_TEXTDRAWS; d++)
		{
		    if(ProjectTD[d][ItsFromTDE] == 1)
		    {
			    e = 1;
				BackManageDialog[c] = 0;
				c ++;
				if(c == 11)
				{
					if(PageStart >= 10)
				    {
						format(str, 30, ">>\n");
						strcat(dialog, str);
					}
					else
					{
					    format(str, 30, ">>");
					    strcat(dialog, str);
					}
					break;
				}
				if(TextDrawGetFont(ProjectTD[d][ETextDrawID]) == 5) format(str, 31, "%s(%i)ModelPreview: %d\n", EditIndex == d ? ("{FFCC00}"):("{CCCCCC}"), d, ProjectTD[d][ETextDrawModelid]);
				else format(str, 31, "%s(%i)%s\n", EditIndex == d ? ("{FFCC00}"):("{CCCCCC}"), d, ProjectTD[d][ETextDrawText]);
				if(strlen(str) >= 30)
				{
					strdel(str, 28, 30);
					strcat(str, "\n");
				}
				strcat(dialog, str);
			}
		}
		if(PageStart >= 10)
		{
		    BackManageDialog[c] = 1;
			format(str, 30, "<<");
			strcat(dialog, str);
		}
		if(e == -1)
		{
		    
		    new d1, c1, e1 = -1, dialog1[310], str1[31], DC = PageStart - 10;
		    for (d1 = DC; d1 < DC+11; d1++)
			{
			    if(ProjectTD[d1][ItsFromTDE] == 1)
			    {
				    e1 = 1;
					
					BackManageDialog[c] = 0;
					c1 ++;
					if(c1 == 11)
					{
					    if(DC >= 10)
					    {
							format(str1, 30, ">>\n");
							strcat(dialog1, str1);
						}
						else
						{
						    format(str1, 30, ">>");
						    strcat(dialog1, str1);
						}
						break;
					}
					if(TextDrawGetFont(ProjectTD[d][ETextDrawID]) == 5) format(str1, 31, "%s(%i)ModelPreview: %d\n", EditIndex == d ? ("{FFCC00}"):("{CCCCCC}"), d, ProjectTD[d][ETextDrawModelid]);
					else format(str1, 31, "%s(%i)%s\n", EditIndex == d ? ("{FFCC00}"):("{CCCCCC}"), d, ProjectTD[d][ETextDrawText]);
					
					if(strlen(str1) >= 30)
					{
						strdel(str1, 28, 30);
						strcat(str1, "\n");
					}
					strcat(dialog1, str1);
				}
			}
			if(DC >= 10)
			{
			    BackManageDialog[c1] = 1;
			    format(str1, 30, "<<");
				strcat(dialog1, str1);
			}
			if(e1 == -1) return SelectTextDraw(ProjectEditor, -1), IsPSel = true, SendClientMessage(ProjectEditor, -1, "Error");
			PageStart -= 10;
		    ShowPlayerDialog(ProjectEditor, DIALOG_MANAGE, DIALOG_STYLE_LIST, "TDEditor - Manage", dialog1, ">>", "X");
		    IsPSel = false;
		    return 1;
		}
		ShowPlayerDialog(ProjectEditor, DIALOG_MANAGE, DIALOG_STYLE_LIST, "TDEditor - Manage", dialog, ">>", "X");
		IsPSel = false;
	}
	if(clickedid == TDE_Menu[2])
	{
        new Index = GetAvailableIndex();
		if(Index == INVALID_INDEX_ID) return SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}You can't create more TextDraws.");
      	EditIndex = Index;

      	if(EditIndex == 0)
      	{
       		Loop(1, sizeof(TDE_Menu))
		    {
				TextDrawColor(TDE_Menu[c], 0xDDDDDDFF);
				TextDrawSetSelectable(TDE_Menu[c], true);
		        TextDrawShowForPlayer(ProjectEditor, TDE_Menu[c]);
		    }
		    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
		    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
		    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[20]);
		    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
		    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
		    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
		    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
		    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
		    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[29]);
		    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[33]);
      	}

		ProjectTD[Index][ETextDrawID] = TextDrawCreate(290.0, 190.0, "TDEditor");
		TextDrawLetterSize(ProjectTD[Index][ETextDrawID], 0.4, 1.6);
		TextDrawAlignment(ProjectTD[Index][ETextDrawID], 1);
		TextDrawColor(ProjectTD[Index][ETextDrawID], -1);
		TextDrawUseBox(ProjectTD[Index][ETextDrawID], 0);
		TextDrawSetShadow(ProjectTD[Index][ETextDrawID], 0);
		TextDrawSetOutline(ProjectTD[Index][ETextDrawID], 0);
		TextDrawBackgroundColor(ProjectTD[Index][ETextDrawID], 255);
		TextDrawFont(ProjectTD[Index][ETextDrawID], 1);
		TextDrawSetProportional(ProjectTD[Index][ETextDrawID], 1);
		TextDrawShowForPlayer(ProjectEditor, ProjectTD[Index][ETextDrawID]);
		

	    ProjectTD[EditIndex][ItsFromTDE] = 1;
	    format(ProjectTD[EditIndex][ETextDrawText], 800, "TDEditor");
		ProjectTD[EditIndex][ETextDrawPosX] = 290.0;
		ProjectTD[EditIndex][ETextDrawPosY] = 190.0;
		ProjectTD[EditIndex][ETextDrawLetterX] = 0.4;
		ProjectTD[EditIndex][ETextDrawLetterY] = 1.6;
		ProjectTD[EditIndex][ETextDrawColor] = 0xFFFFFFFF;
		ProjectTD[EditIndex][ETextDrawBGColor] = 0x000000FF;
		ProjectTD[EditIndex][ETextDrawBoxColor] = 0x000000FF;
		
		new string[128];
        format(string, sizeof(string), "{e2b960}TDEditor: {FFFFFF}TextDraw {e2b960}#%d {FFFFFF}created.", EditIndex);
        SendClientMessage(ProjectEditor, -1, string);
        UpdateIcons(EditIndex);
        
        if(EditMode == EDITMODE_MODELS)
        {
            TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
	    	EditMode = EDITMODE_NONE;
        }
	    return 1;
	}
	if(EditIndex == INVALID_INDEX_ID) return false;
	if(clickedid == TDE_Menu[3])
	{
	    IsPSel = false;
		CancelSelectTextDraw(ProjectEditor);
		TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
		EditMode = EDITMODE_NONE;
	    ShowPlayerDialog(ProjectEditor, DIALOG_CONFIRMEDELETE, DIALOG_STYLE_MSGBOX, "TDEditor - Remove TextDraw", "Are you sure you want to delete this TextDraw?", "Remove", "X");
	    IsPSel = false;
	    return 1;
	}
	if(clickedid == TDE_Menu[4])
	{
	    ExportProject();
	    return 1;
	}
	if(clickedid == TDE_Menu[8])
	{
        new Index = GetAvailableIndex();
		if(Index == INVALID_INDEX_ID) return SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}You can't create more TextDraws.");
		DuplicateTextDraw(EditIndex, Index);
		
		new string[128];
        format(string, sizeof(string), "{e2b960}TDEditor: {FFFFFF}TextDraw {e2b960}#%d {FFFFFF}was duplicated on TextDraw{e2b960} #%d.", EditIndex, Index);
        SendClientMessage(ProjectEditor, -1, string);
      	EditIndex = Index;
	    return 1;
	}
	if(clickedid == TDE_Menu[9])
	{
		if(EditMode != EDITMODE_POSITION)
		{
			TextDrawSetString(TD_Status, "EditMode: EDITMODE_POSITION");
			EditMode = EDITMODE_POSITION;
		}
		else TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE"), EditMode = EDITMODE_NONE;
		return 1;
	}
	if(clickedid == TDE_Menu[10])
	{
	    if(EditMode != EDITMODE_SIZE)
		{
			TextDrawSetString(TD_Status, "EditMode: EDITMODE_SIZE");
			EditMode = EDITMODE_SIZE;
		}
		else TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE"), EditMode = EDITMODE_NONE;
		return 1;
	}
	if(clickedid == TDE_Menu[11] || clickedid == TDE_Menu[35])
	{
 		/*if((GetTickCount() - DoubleClickCount) <= 180)
 		{
 		    ShowPlayerDialog(ProjectEditor, DIALOG_EDITTEXT, DIALOG_STYLE_INPUT, "TDEditor - Español", "Introduzca el texto aquí:", ">>", "X");
 		    TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
 		    EditMode = EDITMODE_NONE;
 		    IsPSel = false;
 		    CancelSelectTextDraw(ProjectEditor);
 		    return 1;
 		}
	    DoubleClickCount = GetTickCount();
	    */
	    if(TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 5)
	    {
	        IsPSel = false;
			CancelSelectTextDraw(ProjectEditor);
			TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
			EditMode = EDITMODE_NONE;
		    ShowPlayerDialog(ProjectEditor, DIALOG_MODELID, DIALOG_STYLE_INPUT, "TDEditor - ModelID", "Insert the ModelID:", ">>", "X");
	        return 1;
	    }
		if(EditMode != EDITMODE_TEXT)
		{
			TextDrawSetString(TD_Status, "EditMode: EDITMODE_TEXT");
			EditMode = EDITMODE_TEXT;
	    }
		else TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE"), EditMode = EDITMODE_NONE;
		return 1;
	}
	if(clickedid == TDE_Menu[14])
	{
	    if(EditMode != EDITMODE_COLOR)
		{
	    	TextDrawSetString(TD_Status, "EditMode: EDITMODE_COLOR");
	    	EditMode = EDITMODE_COLOR;
		}
		else
		{
		    TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
	    	EditMode = EDITMODE_NONE;
		}
	    return 1;
	}
	if(clickedid == TDE_Menu[15])
	{
	    if(EditMode != EDITMODE_BGCOLOR)
		{
	    	TextDrawSetString(TD_Status, "EditMode: EDITMODE_BGCOLOR");
	    	EditMode = EDITMODE_BGCOLOR;
		}
		else
		{
		    TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
	    	EditMode = EDITMODE_NONE;
		}
	    return 1;
	}
	if(clickedid == TDE_Menu[32])
	{
	    if(EditMode != EDITMODE_BOXCOLOR)
		{
	    	TextDrawSetString(TD_Status, "EditMode: EDITMODE_BOXCOLOR");
	    	EditMode = EDITMODE_BOXCOLOR;
		}
		else
		{
		    TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
	    	EditMode = EDITMODE_NONE;
		}
	    return 1;
	}
	if(clickedid == TDE_Menu[16])
	{
	    if(EditMode != EDITMODE_LETTERSIZE)
		{
	    	TextDrawSetString(TD_Status, "EditMode: EDITMODE_LETTERSIZE");
	    	EditMode = EDITMODE_LETTERSIZE;
		}
		else
		{
		    TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
	    	EditMode = EDITMODE_NONE;
		}
	    return 1;
	}
	if(clickedid == TDE_Menu[17])
	{
	    if(EditMode != EDITMODE_OUTLINE)
		{
	    	TextDrawSetString(TD_Status, "EditMode: EDITMODE_OUTLINE");
	    	EditMode = EDITMODE_OUTLINE;
		}
		else
		{
		    TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
	    	EditMode = EDITMODE_NONE;
		}
	    return 1;
	}
	if(clickedid == TDE_Menu[18])
	{
	    if(EditMode != EDITMODE_SHADOW)
		{
	    	TextDrawSetString(TD_Status, "EditMode: EDITMODE_SHADOW");
	    	EditMode = EDITMODE_SHADOW;
		}
		else
		{
		    TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
	    	EditMode = EDITMODE_NONE;
		}
	    return 1;
	}
	if(clickedid == TDE_Menu[12] || clickedid == TDE_Menu[13] || clickedid == TDE_Menu[24] || clickedid == TDE_Menu[25] || clickedid == TDE_Menu[26] || clickedid == TDE_Menu[27])
	{
	    if(TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 5)
	    {
	        if(EditMode != EDITMODE_MODELS)
			{
		 		Colors[0] = floatround(ProjectTD[EditIndex][ETextDrawRotX]);
	            Colors[1] = floatround(ProjectTD[EditIndex][ETextDrawRotY]);
	            Colors[2] = floatround(ProjectTD[EditIndex][ETextDrawRotZ]);
	            Zoom = ProjectTD[EditIndex][ETextDrawZoom];
	            
		    	TextDrawSetString(TD_Status, "EditMode: EDITMODE_MODELS");
		    	EditMode = EDITMODE_MODELS;
			}
			else
			{
			    TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
		    	EditMode = EDITMODE_MODELS;
			}
	        return 1;
	    }
	    new font = TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]);
	    switch(font)
	    {
	        case 0:
	        {
	            TextDrawFont(ProjectTD[EditIndex][ETextDrawID], 1);
				TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
				TextDrawShowForPlayer(ProjectEditor, TDE_Menu[25]);
	        }
	        case 1:
	        {
	            TextDrawFont(ProjectTD[EditIndex][ETextDrawID], 2);
				TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				TextDrawHideForPlayer(ProjectEditor, TDE_Menu[25]);
				TextDrawShowForPlayer(ProjectEditor, TDE_Menu[26]);
	        }
	        case 2:
	        {
	            TextDrawFont(ProjectTD[EditIndex][ETextDrawID], 3);
				TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
				TextDrawShowForPlayer(ProjectEditor, TDE_Menu[27]);
	        }
	        case 3:
	        {
	            TextDrawFont(ProjectTD[EditIndex][ETextDrawID], 0);
				TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
				TextDrawShowForPlayer(ProjectEditor, TDE_Menu[24]);
	        }
	    }
	    return 1;
	}
    if(clickedid == TDE_Menu[19] || clickedid == TDE_Menu[20] || clickedid == TDE_Menu[34])
	{
		if(TextDrawIsBox(ProjectTD[EditIndex][ETextDrawID]))
		{
			TextDrawUseBox(ProjectTD[EditIndex][ETextDrawID], 0);
			TextDrawBoxColor(ProjectTD[EditIndex][ETextDrawID], 0);
			TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[20]);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[19]);
		}
		else
		{
		    TextDrawUseBox(ProjectTD[EditIndex][ETextDrawID], 1);
		    new alignment = TextDrawGetAlignment(ProjectTD[EditIndex][ETextDrawID]);
		    if(ProjectTD[EditIndex][ETextDrawTextX] == 0.0)
			{
			    switch(alignment)
			    {
			    	case 1: ProjectTD[EditIndex][ETextDrawTextX] = floatadd(ProjectTD[EditIndex][ETextDrawPosX], 5.0);
			    	case 2: ProjectTD[EditIndex][ETextDrawTextX] = 10.0;
			    	case 3: ProjectTD[EditIndex][ETextDrawTextX] = floatadd(ProjectTD[EditIndex][ETextDrawPosX], 5.0); //SA-MP BUG?
				}
			}
		    if(alignment == 2) TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextY], ProjectTD[EditIndex][ETextDrawTextX]);
		    else TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
		    TextDrawBoxColor(ProjectTD[EditIndex][ETextDrawID], 255);
			TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[19]);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[20]);
		}
		return 1;
	}
    if(clickedid == TDE_Menu[21] || clickedid == TDE_Menu[22] || clickedid == TDE_Menu[23])
	{
	    new alignment = TextDrawGetAlignment(ProjectTD[EditIndex][ETextDrawID]);
	    switch(alignment)
	    {
	        case 1:
	        {
	            TextDrawAlignment(ProjectTD[EditIndex][ETextDrawID], 2);
	            if(TextDrawIsBox(ProjectTD[EditIndex][ETextDrawID])) TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextY], ProjectTD[EditIndex][ETextDrawTextX]);
				TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				TextDrawHideForPlayer(ProjectEditor, TDE_Menu[21]);
				TextDrawShowForPlayer(ProjectEditor, TDE_Menu[22]);
	        }
	        case 2:
	        {
	            TextDrawAlignment(ProjectTD[EditIndex][ETextDrawID], 3);
	            if(TextDrawIsBox(ProjectTD[EditIndex][ETextDrawID])) TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
				TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
				TextDrawShowForPlayer(ProjectEditor, TDE_Menu[23]);
	        }
	        case 3:
	        {
	            TextDrawAlignment(ProjectTD[EditIndex][ETextDrawID], 1);
	            if(TextDrawIsBox(ProjectTD[EditIndex][ETextDrawID])) TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
				TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
				TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
				TextDrawShowForPlayer(ProjectEditor, TDE_Menu[21]);
	        }
	    }
	    return 1;
	}
    if(clickedid == TDE_Menu[28] || clickedid == TDE_Menu[29])
	{
	    if(ProjectTD[EditIndex][ETextDrawSelectable] == 0)
	    {
	        TextDrawHideForPlayer(ProjectEditor, TDE_Menu[28]);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[29]);
			ProjectTD[EditIndex][ETextDrawSelectable] = 1;
	    }
	    else
	    {
	        TextDrawHideForPlayer(ProjectEditor, TDE_Menu[29]);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[28]);
			ProjectTD[EditIndex][ETextDrawSelectable] = 0;
	    }
	    return 1;
	}
	if(clickedid == TDE_Menu[5] || clickedid == TDE_Menu[33])
	{
	    if(ProjectTD[EditIndex][ETextDrawType] == 0)
	    {
	        TextDrawHideForPlayer(ProjectEditor, TDE_Menu[5]);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[33]);
			ProjectTD[EditIndex][ETextDrawType] = 1;
	    }
	    else
	    {
	        TextDrawHideForPlayer(ProjectEditor, TDE_Menu[33]);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[5]);
			ProjectTD[EditIndex][ETextDrawType] = 0;
	    }
	    return 1;
	}
	if(clickedid == TDE_Menu[30] || clickedid == TDE_Menu[31])
	{
	    if(EditMode == EDITMODE_COLOR || EditMode == EDITMODE_BGCOLOR || EditMode == EDITMODE_BOXCOLOR || EditMode == EDITMODE_MODELS) return SendClientMessage(playerid, -1, "{e2b960}TDEditor: {FFFFFF}Finish first this EditMode.");
	    new proportional = TextDrawIsProportional(ProjectTD[EditIndex][ETextDrawID]);
		if(proportional == 0)
		{
			TextDrawSetProportional(ProjectTD[EditIndex][ETextDrawID], 1);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[30]);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[31]);
		}
		else
		{
			TextDrawSetProportional(ProjectTD[EditIndex][ETextDrawID], 0);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[31]);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[30]);
		}
		TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
		return 1;
	}
	return false;
}

stock ActivateCallback_OnAnyKeyDown()
{
    ActivateAnyKeyVariable(1);
    ActivateAnyKey();
    return 1;
}

public OnAnyKeyDown(key)
{
 	printf("%d %c", key, key);
	return 1;
}

TDE_CALLBACK:OnEditorUpdate(playerid)
{
    if(IsPlayerPaused(playerid)) return 0;
    for(new c = 0; c < sizeof(VirtualKeys); c++)
	{
		if(GetVirtualKeyState(VirtualKeys[c][KEY_CODE]) & 0x8000)
		{
		    if(!VirtualKeys[c][KEY_PRESSED])
		    {
		        CallLocalFunction("OnVirtualKeyDown", "id", playerid, VirtualKeys[c][KEY_CODE]);
		        VirtualKeys[c][KEY_PRESSED] = true;
		    }
		}
		else if(VirtualKeys[c][KEY_PRESSED])
		{
		    CallLocalFunction("OnVirtualKeyRelease", "id", playerid, VirtualKeys[c][KEY_CODE]);
		    VirtualKeys[c][KEY_PRESSED] = false;
		}
	}

	GetScreenSize(ScreenWidth, ScreenHeight);
	GetMousePos(CursorX, CursorY);

	if(CursorOX != CursorX || CursorOY != CursorY)
	{
	    CallLocalFunction("OnCursorPositionChange", "idd", playerid, CursorX, CursorY);
	    CursorOX = CursorX;
	    CursorOY = CursorY;
	}
	return 1;
}

TDE_CALLBACK:OnCursorPositionChange(playerid, NewX, NewY)
{
    if(!EditorEnabled || ProjectEditor != playerid) return false;
    if(TDEHTimer == 1)
	{
	 	TextDrawSetPos(TDEditor_Helper[0], ((floatdiv(float(NewX), ScreenWidth) * 640.0)+0.15), -6.000000);
		TextDrawLetterSize(TDEditor_Helper[0], 0.000000, (((floatdiv(float(NewY), ScreenHeight) * 448.0)/9.0)+0.4));
		TextDrawSetPos(TDEditor_Helper[1], ((floatdiv(float(NewX), ScreenWidth) * 640.0)+1.0), (floatdiv(float(NewY), ScreenHeight) * 448.0));

	    TextDrawShowForPlayer(ProjectEditor, TDEditor_Helper[0]);
	    TextDrawShowForPlayer(ProjectEditor, TDEditor_Helper[1]);
    }
    if(EditMode == EDITMODE_ADJUST)
    {
        if(VirtualKeys[26][KEY_PRESSED]) //Left Mouse Button
		{
        	OffsetZ -= floatdiv(floatsub(CursorOY, NewY), ScreenHeight) * 448.0;
    	    TextDrawSetPos(TDE_Menu[0], 0.0, OffsetZ - 2.0);
    	    TextDrawShowForPlayer(playerid, TDE_Menu[0]);
        	if(OffsetZ < 10.0) TextDrawSetPos(TD_Status, 2.0, OffsetZ+35.14);
        	else TextDrawSetPos(TD_Status, 2.0, OffsetZ-10.14);
    	    TextDrawShowForPlayer(playerid, TD_Status);
            return 1;
		}
		return 1;
    }
    
	if(EditIndex == INVALID_INDEX_ID) return false;
    switch(EditMode)
    {
        case EDITMODE_POSITION:
        {
            if(VirtualKeys[26][KEY_PRESSED]) //Left Mouse Button
			{
	            ProjectTD[EditIndex][ETextDrawPosX] -= floatdiv(floatsub(CursorOX, NewX), ScreenWidth) * 640.0;
	   			ProjectTD[EditIndex][ETextDrawPosY] -= floatdiv(floatsub(CursorOY, NewY), ScreenHeight) * 448.0;
	   			TextDrawSetPos(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawPosX], ProjectTD[EditIndex][ETextDrawPosY]);
	   			
	   			if(TextDrawIsBox(ProjectTD[EditIndex][ETextDrawID]))
	   			{
				    if(TextDrawGetAlignment(ProjectTD[EditIndex][ETextDrawID]) != 2)
					{
						ProjectTD[EditIndex][ETextDrawTextX] -= floatdiv(floatsub(CursorOX, NewX), ScreenWidth) * 640.0;
				    	TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
					}
				}
				TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
			}
		}
		case EDITMODE_SIZE:
        {
            if(VirtualKeys[26][KEY_PRESSED]) //Left Mouse Button
			{
			    ProjectTD[EditIndex][ETextDrawTextX] -= floatdiv(floatsub(CursorOX, NewX), ScreenWidth) * 640.0;
				if(TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 4 || TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 5) ProjectTD[EditIndex][ETextDrawTextY] -= floatdiv(floatsub(CursorOY, NewY), ScreenHeight) * 448.0;
				if(TextDrawIsBox(ProjectTD[EditIndex][ETextDrawID]) && ProjectTD[EditIndex][ETextDrawLetterX] == 0.0)
				{
                    ProjectTD[EditIndex][ETextDrawLetterY] -= (floatdiv(floatsub(CursorOY, NewY), ScreenWidth) * 640.0)/10.0;
                    TextDrawLetterSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);
				}
				new alignment = TextDrawGetAlignment(ProjectTD[EditIndex][ETextDrawID]);
			    switch(alignment)
			    {
			    	case 1, 3: TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
			    	case 2: TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextY], ProjectTD[EditIndex][ETextDrawTextX]);
				}
		    	TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
			}
		}
		case EDITMODE_MODELS:
		{
		    if(VirtualKeys[26][KEY_PRESSED]) //Left Mouse Button
			{
			    switch(ColorMode)
	            {
	                case COLORMODE_RED: Colors[0] = floatround(  floatdiv((NewY - 1), (ScreenHeight - 2)) * 360.0  );
	                case COLORMODE_GREEN: Colors[1] = floatround(  floatdiv((NewX - 1), (ScreenWidth - 2)) * 360.0  );
	                case COLORMODE_BLUE: Colors[2] = floatround(  floatdiv((NewY - 1), (ScreenHeight - 2)) * 360.0 );
	                case COLORMODE_ALPHA: Zoom = floatdiv((NewX - 1), (ScreenWidth - 2)) * 10.0;
				}
				new str[64];
				format(str, sizeof str, "~n~RX%i~n~RY%i~n~RZ%i~n~Z%.2f", Colors[0], Colors[1], Colors[2], Zoom);
				GameTextForPlayer(ProjectEditor, str, 1000, 5);
	            ProjectTD[EditIndex][ETextDrawRotX] = float(Colors[0]);
	            ProjectTD[EditIndex][ETextDrawRotY] = float(Colors[1]);
	            ProjectTD[EditIndex][ETextDrawRotZ] = float(Colors[2]);
	            ProjectTD[EditIndex][ETextDrawZoom] = Zoom;
	            TextDrawSetPreviewRot(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawRotX], ProjectTD[EditIndex][ETextDrawRotY], ProjectTD[EditIndex][ETextDrawRotZ], ProjectTD[EditIndex][ETextDrawZoom]);
				TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
			}
		}
		case EDITMODE_COLOR, EDITMODE_BGCOLOR, EDITMODE_BOXCOLOR:
		{
		    if(VirtualKeys[26][KEY_PRESSED]) //Left Mouse Button
			{
			    
			    if(EditMode == EDITMODE_COLOR) HexToRGBA(ProjectTD[EditIndex][ETextDrawColor], Colors[0], Colors[1], Colors[2], Colors[3]);
			    else if(EditMode == EDITMODE_BGCOLOR) HexToRGBA(ProjectTD[EditIndex][ETextDrawBGColor], Colors[0], Colors[1], Colors[2], Colors[3]);
			    else if(EditMode == EDITMODE_BOXCOLOR) HexToRGBA(ProjectTD[EditIndex][ETextDrawBoxColor], Colors[0], Colors[1], Colors[2], Colors[3]);
	            switch(ColorMode)
	            {
	                case COLORMODE_RED: Colors[0] = floatround(  floatdiv((NewY - 1), (ScreenHeight - 2)) * 255.0  );
	                case COLORMODE_GREEN: Colors[1] = floatround(  floatdiv((NewX - 1), (ScreenWidth - 2)) * 255.0  );
                    case COLORMODE_BLUE: Colors[2] = floatround(  floatdiv((NewY - 1), (ScreenHeight - 2)) * 255.0 );
                    case COLORMODE_ALPHA: Colors[3] = floatround(  floatdiv((NewX - 1), (ScreenWidth - 2)) * 255.0  );
				}
				new str[64];
				format(str, sizeof(str), "~n~~r~R%i~n~~g~G%i~n~~b~B%i~n~~w~A%i", Colors[0], Colors[1], Colors[2], Colors[3]);
				GameTextForPlayer(ProjectEditor, str, 1000, 5);
				switch(EditMode)
				{
				    case EDITMODE_COLOR:
				    {
						ProjectTD[EditIndex][ETextDrawColor] = RGBAToHex(Colors[0], Colors[1], Colors[2], Colors[3]);
			            TextDrawColor(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawColor]);
					}
					case EDITMODE_BGCOLOR:
				    {
						ProjectTD[EditIndex][ETextDrawBGColor] = RGBAToHex(Colors[0], Colors[1], Colors[2], Colors[3]);
			            TextDrawBackgroundColor(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawBGColor]);
					}
					case EDITMODE_BOXCOLOR:
				    {
						ProjectTD[EditIndex][ETextDrawBoxColor] = RGBAToHex(Colors[0], Colors[1], Colors[2], Colors[3]);
			            TextDrawBoxColor(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawBoxColor]);
					}
				}
	            TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
			}
		}
		case EDITMODE_OUTLINE:
		{
		    if(VirtualKeys[26][KEY_PRESSED]) //Left Mouse Button
			{
	            ProjectTD[EditIndex][ETextDrawOutline] -= floatround(floatdiv(floatsub(CursorOX, NewX), ScreenWidth) * 640.0);
			    ProjectTD[EditIndex][ETextDrawOutline] -= floatround(floatdiv(floatsub(CursorOY, NewY), ScreenHeight) * 448.0);
			    TextDrawSetOutline(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawOutline]);
		    	TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
			}
		}
		case EDITMODE_SHADOW:
		{
		    if(VirtualKeys[26][KEY_PRESSED]) //Left Mouse Button
			{
	            ProjectTD[EditIndex][ETextDrawShadow] -= floatround(floatdiv(floatsub(CursorOX, NewX), ScreenWidth) * 640.0);
			    ProjectTD[EditIndex][ETextDrawShadow] -= floatround(floatdiv(floatsub(CursorOY, NewY), ScreenHeight) * 448.0);
			    TextDrawSetShadow(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawShadow]);
		    	TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
			}
		}
		case EDITMODE_LETTERSIZE:
		{
		    if(VirtualKeys[26][KEY_PRESSED]) //Left Mouse Button
			{
	            ProjectTD[EditIndex][ETextDrawLetterX] -= floatdiv(floatsub(CursorOX, NewX), ScreenWidth) * 640.0 * 0.001;
			    ProjectTD[EditIndex][ETextDrawLetterY] -= floatdiv(floatsub(CursorOY, NewY), ScreenHeight) * 448.0 * 0.01;
			    TextDrawLetterSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);
		    	TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
			}
		}
	}
	return true;
}

TDE_CALLBACK:OnVirtualKeyRelease(playerid, key)
{
  	if(!EditorEnabled || ProjectEditor != playerid) return false;
  	if(key == VK_ESCAPE)
  	{
  	    if(EditMode == EDITMODE_ADJUST)
	    {
	        SelectTextDraw(playerid, -1);
	        if(!VirtualKeys[26][KEY_PRESSED]) //Left Mouse Button
			{
	          	new Float:pos[2];
	        	for(new i = 1; i < sizeof(TDE_Menu); i++)
	        	{
	        	    TextDrawGetPos(TDE_Menu[i], pos[0], pos[1]);
	        	    TextDrawSetPos(TDE_Menu[i], pos[0], OffsetZ);
	        	    TextDrawShowForPlayer(playerid, TDE_Menu[i]);
	        	}

	 		    TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
	 		    EditMode = EDITMODE_NONE;
	 		    IsPSel = true;
				return 1;
			}
	    }
  	}
  	if(key == VK_LBUTTON)
	{
        if(ColorMode) ColorMode = 0;
        if(IsPSel) SaveProject();
	}
  	if(EditMode == EDITMODE_ADJUST) return false;
	if(key == VK_RBUTTON)
	{
	    if(!IsPSel) return false;
		new Float:ConvertedX, Float:ConvertedY;
		ConvertedX = ((floatdiv(float(CursorX), ScreenWidth) * 640.0));
		ConvertedY = (((floatdiv(float(CursorY), ScreenHeight) * 448.0)));
		if( (ConvertedX > 64.01 && ConvertedX < 32.0+64.01) && (ConvertedY > OffsetZ && ConvertedY < 32.0+OffsetZ) ) //New
	    {
	        ShowPlayerDialog(ProjectEditor, DIALOG_NEW, DIALOG_STYLE_LIST, "TDEditor - New TextDraw", "Normal TextDraw\nSprite TextDraw (TXD)\nPreview Models (objects, vehicles, skins)\nBox TextDraw", ">>", "X");
	        IsPSel = false;
 		    TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
 		    EditMode = EDITMODE_NONE;
 		    CancelSelectTextDraw(ProjectEditor);
 		    return 1;
	    }
		if(EditIndex == INVALID_INDEX_ID) return false;
		if( (ConvertedX > 192.01 && ConvertedX < 32.0+192.01) && (ConvertedY > OffsetZ && ConvertedY < 32.0+OffsetZ) ) //Position
	    {
            ShowPlayerDialog(ProjectEditor, DIALOG_POSX, DIALOG_STYLE_INPUT, "TDEditor - PositionX", "Insert the value of PositionX:\nNote: to insert a decimal value use '.' instead of ',' for example '298.73'", ">>", "X");
            IsPSel = false;
 		    TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
 		    EditMode = EDITMODE_NONE;
 		    CancelSelectTextDraw(ProjectEditor);
 		    return 1;
	    }
	    if( (ConvertedX > 160.01 && ConvertedX < 32.0+160.01) && (ConvertedY > OffsetZ && ConvertedY < 32.0+OffsetZ) ) //Models/Font
	    {
	        if(TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 5)
	        {
			    if(IsVehicle(ProjectTD[EditIndex][ETextDrawModelid])) ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom\nVehicle color 1\nVehicle color 2", ">>", "X");
				else ShowPlayerDialog(ProjectEditor, DIALOG_MODELS, DIALOG_STYLE_LIST, "TDEditor - Preview Models", "Change ModelID\nRotationX\nRotationY\nRotationZ\nZoom", ">>", "X");
	            IsPSel = false;
	 		    TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
	 		    EditMode = EDITMODE_NONE;
	 		    CancelSelectTextDraw(ProjectEditor);
	 		    return 1;
			}
			return 1;
	    }
	    if( (ConvertedX > 224.01 && ConvertedX < 32.0+224.01) && (ConvertedY > OffsetZ && ConvertedY < 32.0+OffsetZ) ) //TextSize
	    {
            ShowPlayerDialog(ProjectEditor, DIALOG_SIZEX, DIALOG_STYLE_INPUT, "TDEditor - TextSizeX", "Enter the value of TextSizeX:\nNote: to put a decimal value use '.' instead of ',' for example: '18 .8 '", ">>", "X");
            IsPSel = false;
 		    TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
 		    EditMode = EDITMODE_NONE;
 		    CancelSelectTextDraw(ProjectEditor);
 		    return 1;
	    }
	    if( (ConvertedX > 256.01 && ConvertedX < 32.0+256.01) && (ConvertedY > OffsetZ && ConvertedY < 32.0+OffsetZ) ) //Text
	    {
	        if(TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 5) return false;
            ShowPlayerDialog(ProjectEditor, DIALOG_EDITTEXT, DIALOG_STYLE_INPUT, "TDEditor - Text", "Insert the TextDraw text:", ">>", "X");
            IsPSel = false;
 		    TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
 		    EditMode = EDITMODE_NONE;
 		    CancelSelectTextDraw(ProjectEditor);
 		    return 1;
	    }
	    if( (ConvertedX > 384.01 && ConvertedX < 32.0+384.01) && (ConvertedY > OffsetZ && ConvertedY < 32.0+OffsetZ) ) //LetterSize
	    {
	        if(TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 4 || TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 5) return false;
            ShowPlayerDialog(ProjectEditor, DIALOG_LETTERX, DIALOG_STYLE_INPUT, "TDEditor - LetterSizeX", "Insert the value of LetteSizeX:\nNote: to insert a decimal value use '.' instead of ',' for example '0.4'", ">>", "X");
            IsPSel = false;
 		    TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
 		    EditMode = EDITMODE_NONE;
 		    CancelSelectTextDraw(ProjectEditor);
 		    return 1;
	    }
	    if( (ConvertedX > 416.01 && ConvertedX < 32.0+416.01) && (ConvertedY > OffsetZ && ConvertedY < 32.0+OffsetZ) ) //Outline
	    {
	        if(TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 4 || TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 5) return false;
            ShowPlayerDialog(ProjectEditor, DIALOG_EDITOUTLINE, DIALOG_STYLE_INPUT, "TDEditor - Outline", "Insert an integer value for the outline.\n\n0 to remove the outline.", ">>", "X");
            IsPSel = false;
 		    TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
 		    EditMode = EDITMODE_NONE;
 		    CancelSelectTextDraw(ProjectEditor);
 		    return 1;
	    }
	    if( (ConvertedX > 448.01 && ConvertedX < 32.0+448.01) && (ConvertedY > OffsetZ && ConvertedY < 32.0+OffsetZ) ) //Shadow
	    {
	        if(TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 4 || TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 5) return false;
            ShowPlayerDialog(ProjectEditor, DIALOG_EDITSHADOW, DIALOG_STYLE_INPUT, "TDEditor - Shadow", "Insert an integer value for the shadow.\n\n0 to remove the shadow.", ">>", "X");
            IsPSel = false;
 		    TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
 		    EditMode = EDITMODE_NONE;
 		    CancelSelectTextDraw(ProjectEditor);
 		    return 1;
	    }
	    if( (ConvertedX > 288.01 && ConvertedX < 32.0+288.01) && (ConvertedY > OffsetZ && ConvertedY < 32.0+OffsetZ) ) //Colors
	    {
            ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR, DIALOG_STYLE_LIST, "TDEditor - Color", "Main colors\nWrite the exact value (HEX)\nColor combinator (RGBA)", ">>", "X");
            IsPSel = false;
 		    TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
 		    EditMode = EDITMODE_COLOR;
 		    CancelSelectTextDraw(ProjectEditor);
 		    return 1;
	    }
	    if( (ConvertedX > 320.01 && ConvertedX < 32.0+320.01) && (ConvertedY > OffsetZ && ConvertedY < 32.0+OffsetZ) ) //BGColors
	    {
	        if(TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 4) return false;
            ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR, DIALOG_STYLE_LIST, "TDEditor - BGColor", "Main colors\nWrite the exact value (HEX)\nColor combinator (RGBA)", ">>", "X");
            IsPSel = false;
 		    TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
 		    EditMode = EDITMODE_BGCOLOR;
 		    CancelSelectTextDraw(ProjectEditor);
 		    return 1;
	    }
	    if( (ConvertedX > 352.01 && ConvertedX < 32.0+352.01) && (ConvertedY > OffsetZ && ConvertedY < 32.0+OffsetZ) ) //BoxColors
	    {
	        if(TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 4 || TextDrawGetFont(ProjectTD[EditIndex][ETextDrawID]) == 5) return false;
            ShowPlayerDialog(ProjectEditor, DIALOG_EDITCOLOR, DIALOG_STYLE_LIST, "TDEditor - BoxColor", "Main colors\nWrite the exact value (HEX)\nColor combinator (RGBA)", ">>", "X");
            IsPSel = false;
 		    TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
 		    EditMode = EDITMODE_BOXCOLOR;
 		    CancelSelectTextDraw(ProjectEditor);
 		    return 1;
	    }
	}
    switch(EditMode)
    {
	    case EDITMODE_TEXT:
	    {
	        if(key == VK_DELETE || key == VK_BACKSPACE) KillTimer(DeleteTimer);
		}
		case EDITMODE_POSITION:
		{
			if(key == VK_OEM_PLUS || key == VK_ADD || key == VK_OEM_MINUS || key == VK_SUBTRACT) KillTimer(SpeedTimer);
		}
		case EDITMODE_SIZE:
		{
			if(key == VK_OEM_PLUS || key == VK_ADD || key == VK_OEM_MINUS || key == VK_SUBTRACT) KillTimer(EditSizeSpeedT);
		}
		case EDITMODE_OUTLINE:
		{
			if(key == VK_OEM_PLUS || key == VK_ADD || key == VK_UP || key == VK_RIGHT || key == VK_OEM_MINUS || key == VK_SUBTRACT || key == VK_DOWN || key == VK_LEFT) KillTimer(OutlineTimer);
		}
		case EDITMODE_SHADOW:
		{
			if(key == VK_OEM_PLUS || key == VK_ADD || key == VK_UP || key == VK_RIGHT || key == VK_OEM_MINUS || key == VK_SUBTRACT || key == VK_DOWN || key == VK_LEFT) KillTimer(ShadowTimer);
		}
		case EDITMODE_LETTERSIZE:
		{
		    if(key == VK_OEM_PLUS || key == VK_ADD || key == VK_OEM_MINUS || key == VK_SUBTRACT) KillTimer(LetterTimer);
		}
	}
	return 1;
}

TDE_CALLBACK:OnVirtualKeyDown(playerid, key)
{
    
    if(!EditorEnabled || ProjectEditor != playerid) return false;
    
    if(key == VK_RBUTTON)
    {
        if(TDEHTimer == 1)
		{
		    TDEHTimer = 2;
		    SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}Right click again to unfreeze the red lines.");
		}
		else if(TDEHTimer == 2)
		{
		    new X, Y;
		    GetMousePos(X, Y);
 			TextDrawSetPos(TDEditor_Helper[0], ((floatdiv(float(X), ScreenWidth) * 640.0)+0.15), -6.000000);
			TextDrawLetterSize(TDEditor_Helper[0], 0.000000, (((floatdiv(float(Y), ScreenHeight) * 448.0)/9.0)+0.4));
			TextDrawSetPos(TDEditor_Helper[1], ((floatdiv(float(X), ScreenWidth) * 640.0)+1.0), (floatdiv(float(Y), ScreenHeight) * 448.0));
		    TextDrawShowForPlayer(ProjectEditor, TDEditor_Helper[0]);
		    TextDrawShowForPlayer(ProjectEditor, TDEditor_Helper[1]);
			TDEHTimer = 1;
		}
    }

	if(VirtualKeys[44][KEY_PRESSED])
	{
	    if(key == VK_KEY_R)
	    {
	        if(TDEHTimer == -1)
			{
			    new X, Y;
			    GetMousePos(X, Y);
	 			TextDrawSetPos(TDEditor_Helper[0], ((floatdiv(float(X), ScreenWidth) * 640.0)+0.15), -6.000000);
				TextDrawLetterSize(TDEditor_Helper[0], 0.000000, (((floatdiv(float(Y), ScreenHeight) * 448.0)/9.0)+0.4));
				TextDrawSetPos(TDEditor_Helper[1], ((floatdiv(float(X), ScreenWidth) * 640.0)+1.0), (floatdiv(float(Y), ScreenHeight) * 448.0));
				SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}Right click to freeze the red lines.");
			    TextDrawShowForPlayer(ProjectEditor, TDEditor_Helper[0]);
			    TextDrawShowForPlayer(ProjectEditor, TDEditor_Helper[1]);
				TDEHTimer = 1;
			}
	        else
			{
				TDEHTimer = -1;
				TextDrawHideForPlayer(ProjectEditor, TDEditor_Helper[0]);
    			TextDrawHideForPlayer(ProjectEditor, TDEditor_Helper[1]);
			}
	        return 1;
	    }
	    if(EditMode == EDITMODE_ADJUST) return false;
	    if(key == VK_KEY_C)
	    {
	        if(EditIndex == INVALID_INDEX_ID) return false;
	        if(!IsPSel) return false;
	        new Index = GetAvailableIndex();
			if(Index == INVALID_INDEX_ID) return SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}You can't create more TextDraws.");
			DuplicateTextDraw(EditIndex, Index);

			new string[128];
	        format(string, sizeof(string), "{e2b960}TDEditor: {FFFFFF}TextDraw {e2b960}#%d {FFFFFF}was duplicated on TextDraw{e2b960} #%d.", EditIndex, Index);
	        SendClientMessage(ProjectEditor, -1, string);
	      	EditIndex = Index;
	        return 1;
	    }
	    if(key == VK_KEY_X)
	    {
	        if(EditIndex == INVALID_INDEX_ID) return false;
	        if(!IsPSel) return false;
	        new string[128];
            format(string, sizeof(string), "{e2b960}TDEditor: {FFFFFF}TextDraw {e2b960}#%d {FFFFFF}removed.", EditIndex);
            SendClientMessage(ProjectEditor, -1, string);

            RemoveTextDrawTDE(EditIndex);
            SelectTextDraw(ProjectEditor, -1);
		}
	}
	if(EditMode == EDITMODE_ADJUST) return false;
	if(EditIndex == INVALID_INDEX_ID) return false;
    switch(EditMode)
    {
        case EDITMODE_TEXT:
        {
       		if(key == VK_KEY_T || key == VK_F6) PressKeyEnter(VK_ENTER);
            if(key == VK_DELETE || key == VK_BACKSPACE)
            {
                new len = strlen(ProjectTD[EditIndex][ETextDrawText]);
                if(len == 0) return 1;
                if(ProjectTD[EditIndex][ETextDrawText][len-1] == '~' && ProjectTD[EditIndex][ETextDrawText][len-2] == 'n' && ProjectTD[EditIndex][ETextDrawText][len-3] == '~')
				{
					strdel(ProjectTD[EditIndex][ETextDrawText], len-3, len);
				}
				else strdel(ProjectTD[EditIndex][ETextDrawText], len-1, len);
         		TextDrawSetString(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawText]);
         		DeleteTimer = SetTimer("DeleteTextDrawLetter", 500, 0);
                return 1;
            }
            /*new KEYT[24];                     NO HAVE GOOD WORK
            /format(KEYT, 24, "%c", key);*/
         	strcat(ProjectTD[EditIndex][ETextDrawText], KeyToString(key), 800);
         	TextDrawSetString(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawText]);
        }
        case EDITMODE_POSITION:
        {
            switch(key)
            {
                case VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT: if(MoveTDTimer == -1) MoveTDTimer = SetTimer("MoveTextDrawEDITOR", 50, 0);
 				case VK_OEM_PLUS, VK_ADD:
			 	{
			 	    if(EditMoveSpeed == 0.05)
				 	{
				 		EditMoveSpeed = 0.1;
				 		new SpeedSTR[24];
				 		format(SpeedSTR, 24, "%.1f", EditMoveSpeed);
				 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
				 		SpeedTimer = SetTimerEx("EditMovementSpeed", 500, 0, "d", 0);
				 		return 1;
					}
			 		EditMoveSpeed += 0.1;
			 		new SpeedSTR[24];
			 		format(SpeedSTR, 24, "%.1f", EditMoveSpeed);
			 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
			 		SpeedTimer = SetTimerEx("EditMovementSpeed", 500, 0, "d", 0);
				}
				case VK_OEM_MINUS, VK_SUBTRACT:
				{
					if(EditMoveSpeed <= 0.1)
					{
						EditMoveSpeed = 0.05;
						new SpeedSTR[24];
				 		format(SpeedSTR, 24, "~r~%.2f", EditMoveSpeed);
				 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
				 		SpeedTimer = SetTimerEx("EditMovementSpeed", 500, 0, "d", 1);
				 		return 1;
					}
					EditMoveSpeed -= 0.1;
					new SpeedSTR[24];
			 		format(SpeedSTR, 24, "%.1f", EditMoveSpeed);
			 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
			 		SpeedTimer = SetTimerEx("EditMovementSpeed", 500, 0, "d", 1);
				}
            }
        }
        case EDITMODE_SIZE:
        {
            switch(key)
            {
                case VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT: if(EditSizeTDTimer == -1) EditSizeTDTimer = SetTimer("ReSizeTextDrawEDITOR", 50, 0);
 				case VK_OEM_PLUS, VK_ADD:
			 	{
			 	    if(EditSizeSpeed == 0.05)
				 	{
				 		EditSizeSpeed = 0.1;
				 		new SpeedSTR[24];
				 		format(SpeedSTR, 24, "%.1f", EditSizeSpeed);
				 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
				 		EditSizeSpeedT = SetTimerEx("EditSizeSpeedCallback", 500, 0, "d", 0);
				 		return 1;
					}
			 		EditSizeSpeed += 0.1;
			 		new SpeedSTR[24];
			 		format(SpeedSTR, 24, "%.1f", EditSizeSpeed);
			 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
			 		EditSizeSpeedT = SetTimerEx("EditSizeSpeedCallback", 500, 0, "d", 0);
				}
				case VK_OEM_MINUS, VK_SUBTRACT:
				{
					if(EditSizeSpeed <= 0.1)
					{
						EditSizeSpeed = 0.05;
						new SpeedSTR[24];
				 		format(SpeedSTR, 24, "~r~%.2f", EditSizeSpeed);
				 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
				 		EditSizeSpeedT = SetTimerEx("EditSizeSpeedCallback", 500, 0, "d", 1);
				 		return 1;
					}
					EditSizeSpeed -= 0.1;
					new SpeedSTR[24];
			 		format(SpeedSTR, 24, "%.1f", EditSizeSpeed);
			 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
			 		EditSizeSpeedT = SetTimerEx("EditSizeSpeedCallback", 500, 0, "d", 1);
				}
            }
        }
        case EDITMODE_COLOR, EDITMODE_BGCOLOR, EDITMODE_BOXCOLOR, EDITMODE_MODELS:
        {
			if(key == VK_LBUTTON)
			{
		        if(!CursorX && (0 < CursorY < (ScreenHeight - 1)) && ColorMode != COLORMODE_RED) ColorMode = COLORMODE_RED;
		        if(CursorX == (ScreenWidth - 1) && (0 < CursorY < (ScreenHeight - 1)) && ColorMode != COLORMODE_BLUE) ColorMode = COLORMODE_BLUE;
		        if(!CursorY && (0 < CursorX < (ScreenWidth - 1)) && ColorMode != COLORMODE_GREEN) ColorMode = COLORMODE_GREEN;
		        if(CursorY == (ScreenHeight - 1) && (0 < CursorX < (ScreenWidth - 1)) && ColorMode != COLORMODE_ALPHA) ColorMode = COLORMODE_ALPHA;
			}
        }
        case EDITMODE_OUTLINE:
        {
            switch(key)
            {
                case VK_OEM_PLUS, VK_ADD, VK_UP, VK_RIGHT:
			 	{
			 	    ProjectTD[EditIndex][ETextDrawOutline] += 1;
					TextDrawSetOutline(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawOutline]);
					TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
					new SpeedSTR[32];
			 		format(SpeedSTR, 24, "OUTLINE: %d", ProjectTD[EditIndex][ETextDrawOutline]);
			 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
			 		
			 		OutlineTimer = SetTimerEx("EditOutline", 500, 0, "d", 0);
			 	}
			 	case VK_OEM_MINUS, VK_SUBTRACT, VK_DOWN, VK_LEFT:
			 	{
			 	    ProjectTD[EditIndex][ETextDrawOutline] -= 1;
					TextDrawSetOutline(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawOutline]);
					TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
					new SpeedSTR[32];
			 		format(SpeedSTR, 24, "OUTLINE: %d", ProjectTD[EditIndex][ETextDrawOutline]);
			 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
			 		
			 		OutlineTimer = SetTimerEx("EditOutline", 500, 0, "d", 1);
			 	}
            }
        }
        case EDITMODE_SHADOW:
        {
            switch(key)
            {
                case VK_OEM_PLUS, VK_ADD, VK_UP, VK_RIGHT:
			 	{
			 	    ProjectTD[EditIndex][ETextDrawShadow] += 1;
					TextDrawSetShadow(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawShadow]);
					TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
					new SpeedSTR[32];
			 		format(SpeedSTR, 24, "SHADOW: %d", ProjectTD[EditIndex][ETextDrawShadow]);
			 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
			 		
			 		ShadowTimer = SetTimerEx("EditShadow", 500, 0, "d", 0);
			 	}
			 	case VK_OEM_MINUS, VK_SUBTRACT, VK_DOWN, VK_LEFT:
			 	{
			 	    ProjectTD[EditIndex][ETextDrawShadow] -= 1;
					TextDrawSetShadow(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawShadow]);
					TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
					new Speed[32];
			 		format(Speed, 24, "SHADOW: %d", ProjectTD[EditIndex][ETextDrawShadow]);
			 		GameTextForPlayer(ProjectEditor, Speed, 1000, 5);
			 		
			 		ShadowTimer = SetTimerEx("EditShadow", 500, 0, "d", 1);
			 	}
            }
        }
        case EDITMODE_LETTERSIZE:
        {
            switch(key)
            {
                case VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT: if(LetterSizeTimer == -1) LetterSizeTimer = SetTimer("LetterSizeTextDrawEDITOR", 50, 0);
 				case VK_OEM_PLUS, VK_ADD:
			 	{
			 	    if(EditLetterSizeSpeed == 0.005)
				 	{
				 		EditLetterSizeSpeed = 0.01;
				 		new Speed[24];
				 		format(Speed, 24, "%.3f", EditLetterSizeSpeed);
				 		GameTextForPlayer(ProjectEditor, Speed, 1000, 5);
				 		LetterTimer = SetTimerEx("TEditLetterSizeSpeed", 500, 0, "d", 0);
				 		return 1;
					}
			 		EditLetterSizeSpeed += 0.01;
			 		new Speed[24];
			 		format(Speed, 24, "%.3f", EditLetterSizeSpeed);
			 		GameTextForPlayer(ProjectEditor, Speed, 1000, 5);
			 		LetterTimer = SetTimerEx("TEditLetterSizeSpeed", 500, 0, "d", 0);
				}
				case VK_OEM_MINUS, VK_SUBTRACT:
				{
					if(EditLetterSizeSpeed <= 0.01)
					{
						EditLetterSizeSpeed = 0.005;
						new Speed[24];
				 		format(Speed, 24, "~r~%.4f", EditLetterSizeSpeed);
				 		GameTextForPlayer(ProjectEditor, Speed, 1000, 5);
				 		LetterTimer = SetTimerEx("TEditLetterSizeSpeed", 500, 0, "d", 1);
				 		return 1;
					}
					EditLetterSizeSpeed -= 0.01;
					new Speed[24];
			 		format(Speed, 24, "%.3f", EditLetterSizeSpeed);
			 		GameTextForPlayer(ProjectEditor, Speed, 1000, 5);
			 		LetterTimer = SetTimerEx("TEditLetterSizeSpeed", 500, 0, "d", 1);
				}
            }
        }
    }
	return true;
}

TDE_CALLBACK:EditOutline(key)
{
    if(EditMode != EDITMODE_OUTLINE) return 1;
    if(key == 0)
    {
        if(VirtualKeys[81][KEY_PRESSED] || VirtualKeys[76][KEY_PRESSED] || VirtualKeys[31][KEY_PRESSED] || VirtualKeys[30][KEY_PRESSED])
		{
		    ProjectTD[EditIndex][ETextDrawOutline] += 1;
			TextDrawSetOutline(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawOutline]);
			TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
			new Speed[32];
	 		format(Speed, 24, "OUTLINE: %d", ProjectTD[EditIndex][ETextDrawOutline]);
	 		GameTextForPlayer(ProjectEditor, Speed, 1000, 5);
	 		OutlineTimer = SetTimerEx("EditOutline", 25, 0, "d", 0);
		}
    }
    else if(key == 1)
    {
        if(VirtualKeys[83][KEY_PRESSED] || VirtualKeys[78][KEY_PRESSED] || VirtualKeys[32][KEY_PRESSED] || VirtualKeys[29][KEY_PRESSED])
		{
		    ProjectTD[EditIndex][ETextDrawOutline] -= 1;
			TextDrawSetOutline(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawOutline]);
			TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
			new Speed[32];
	 		format(Speed, 24, "OUTLINE: %d", ProjectTD[EditIndex][ETextDrawOutline]);
	 		GameTextForPlayer(ProjectEditor, Speed, 1000, 5);
	 		OutlineTimer = SetTimerEx("EditOutline", 25, 0, "d", 1);
		}
    }
	return 1;
}

TDE_CALLBACK:EditShadow(key)
{
    if(EditMode != EDITMODE_SHADOW) return 1;
    if(key == 0)
    {
        if(VirtualKeys[81][KEY_PRESSED] || VirtualKeys[76][KEY_PRESSED] || VirtualKeys[31][KEY_PRESSED] || VirtualKeys[30][KEY_PRESSED])
		{
		    ProjectTD[EditIndex][ETextDrawShadow] += 1;
			TextDrawSetShadow(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawShadow]);
			TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
			new Speed[32];
	 		format(Speed, 24, "SHADOW: %d", ProjectTD[EditIndex][ETextDrawShadow]);
	 		GameTextForPlayer(ProjectEditor, Speed, 1000, 5);
	 		ShadowTimer = SetTimerEx("EditShadow", 25, 0, "d", 0);
		}
    }
    else if(key == 1)
    {
        if(VirtualKeys[83][KEY_PRESSED] || VirtualKeys[78][KEY_PRESSED] || VirtualKeys[32][KEY_PRESSED] || VirtualKeys[29][KEY_PRESSED])
		{
	 		ProjectTD[EditIndex][ETextDrawShadow] -= 1;
			TextDrawSetShadow(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawShadow]);
			TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
			new Speed[32];
	 		format(Speed, 24, "SHADOW: %d", ProjectTD[EditIndex][ETextDrawShadow]);
	 		GameTextForPlayer(ProjectEditor, Speed, 1000, 5);
	 		ShadowTimer = SetTimerEx("EditShadow", 25, 0, "d", 1);
		}
    }
	return 1;
}

TDE_CALLBACK:EditSizeSpeedCallback(key)
{
    if(EditMode != EDITMODE_SIZE) return 1;
	if(key == 0)
	{
	    if(VirtualKeys[81][KEY_PRESSED] || VirtualKeys[76][KEY_PRESSED])
		{
	 		if(EditSizeSpeed == 0.05)
		 	{
		 		EditSizeSpeed = 0.1;
		 		new SpeedSTR[24];
		 		format(SpeedSTR, 24, "%.1f", EditSizeSpeed);
		 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
		 		EditSizeSpeedT = SetTimerEx("EditSizeSpeedCallback", 25, 0, "d", 0);
		 		return 1;
			}
	 		EditSizeSpeed += 0.1;
	 		new SpeedSTR[24];
	 		format(SpeedSTR, 24, "%.1f", EditSizeSpeed);
	 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
	 		EditSizeSpeedT = SetTimerEx("EditSizeSpeedCallback", 25, 0, "d", 0);
		}
	}
	else if(key == 1)
	{
	    if(VirtualKeys[83][KEY_PRESSED] || VirtualKeys[78][KEY_PRESSED])
		{
		    if(EditSizeSpeed <= 0.1)
			{
				EditSizeSpeed = 0.05;
				new SpeedSTR[24];
		 		format(SpeedSTR, 24, "~r~%.2f", EditSizeSpeed);
		 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
		 		EditSizeSpeedT = SetTimerEx("EditSizeSpeedCallback", 25, 0, "d", 1);
		 		return 1;
			}
			EditSizeSpeed -= 0.1;
			new SpeedSTR[24];
	 		format(SpeedSTR, 24, "%.1f", EditSizeSpeed);
	 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
	 		EditSizeSpeedT = SetTimerEx("EditSizeSpeedCallback", 25, 0, "d", 1);
		}
	}
	return 1;
}

TDE_CALLBACK:EditMovementSpeed(key)
{
    if(EditMode != EDITMODE_POSITION) return 1;
	if(key == 0)
	{
	    if(VirtualKeys[81][KEY_PRESSED] || VirtualKeys[76][KEY_PRESSED])
		{
		    if(EditMoveSpeed == 0.05)
		 	{
		 		EditMoveSpeed = 0.1;
		 		new Speed[24];
		 		format(Speed, 24, "%.1f", EditMoveSpeed);
		 		GameTextForPlayer(ProjectEditor, Speed, 1000, 5);
		 		SpeedTimer = SetTimerEx("EditMovementSpeed", 25, 0, "d", 0);
		 		return 1;
			}
	 		EditMoveSpeed += 0.1;
	 		new Speed[24];
	 		format(Speed, 24, "%.1f", EditMoveSpeed);
	 		GameTextForPlayer(ProjectEditor, Speed, 1000, 5);
	 		SpeedTimer = SetTimerEx("EditMovementSpeed", 25, 0, "d", 0);
		}
	}
	else if(key == 1)
	{
	    if(VirtualKeys[83][KEY_PRESSED] || VirtualKeys[78][KEY_PRESSED])
		{
		    if(EditMoveSpeed <= 0.1)
			{
				EditMoveSpeed = 0.05;
				new Speed[24];
		 		format(Speed, 24, "~r~%.2f", EditMoveSpeed);
		 		GameTextForPlayer(ProjectEditor, Speed, 1000, 5);
		 		SpeedTimer = SetTimerEx("EditMovementSpeed", 25, 0, "d", 1);
		 		return 1;
			}
			EditMoveSpeed -= 0.1;
			new Speed[24];
	 		format(Speed, 24, "%.1f", EditMoveSpeed);
	 		GameTextForPlayer(ProjectEditor, Speed, 1000, 5);
	 		SpeedTimer = SetTimerEx("EditMovementSpeed", 25, 0, "d", 1);
		}
	}
	return 1;
}

TDE_CALLBACK:TEditLetterSizeSpeed(key)
{
    if(EditMode != EDITMODE_LETTERSIZE) return 1;
	if(key == 0)
	{
	    if(VirtualKeys[81][KEY_PRESSED] || VirtualKeys[76][KEY_PRESSED])
		{
		    if(EditLetterSizeSpeed == 0.005)
		 	{
		 		EditLetterSizeSpeed = 0.01;
		 		new Speed[24];
		 		format(Speed, 24, "%.3f", EditLetterSizeSpeed);
		 		GameTextForPlayer(ProjectEditor, Speed, 1000, 5);
		 		LetterTimer = SetTimerEx("TEditLetterSizeSpeed", 500, 0, "d", 0);
		 		return 1;
			}
	 		EditLetterSizeSpeed += 0.01;
	 		new Speed[24];
	 		format(Speed, 24, "%.3f", EditLetterSizeSpeed);
	 		GameTextForPlayer(ProjectEditor, Speed, 1000, 5);
	 		LetterTimer = SetTimerEx("TEditLetterSizeSpeed", 25, 0, "d", 0);
		}
	}
	else if(key == 1)
	{
	    if(VirtualKeys[83][KEY_PRESSED] || VirtualKeys[78][KEY_PRESSED])
		{
		    if(EditLetterSizeSpeed <= 0.01)
			{
				EditLetterSizeSpeed = 0.005;
				new Speed[24];
		 		format(Speed, 24, "~r~%.4f", EditLetterSizeSpeed);
		 		GameTextForPlayer(ProjectEditor, Speed, 1000, 5);
		 		LetterTimer = SetTimerEx("TEditLetterSizeSpeed", 500, 0, "d", 1);
		 		return 1;
			}
			EditLetterSizeSpeed -= 0.01;
			new Speed[24];
	 		format(Speed, 24, "%.3f", EditLetterSizeSpeed);
	 		GameTextForPlayer(ProjectEditor, Speed, 1000, 5);
	 		LetterTimer = SetTimerEx("TEditLetterSizeSpeed", 25, 0, "d", 1);
		}
	}
	return 1;
}

TDE_CALLBACK:DeleteTextDrawLetter()
{
    if(EditMode != EDITMODE_TEXT) return 1;
    if(VirtualKeys[52][KEY_PRESSED] || VirtualKeys[37][KEY_PRESSED]) //Delete
	{
    	new len = strlen(ProjectTD[EditIndex][ETextDrawText]);
        if(len == 0) return 1;
        if(ProjectTD[EditIndex][ETextDrawText][len-1] == '~' && ProjectTD[EditIndex][ETextDrawText][len-2] == 'n' && ProjectTD[EditIndex][ETextDrawText][len-3] == '~')
		{
			strdel(ProjectTD[EditIndex][ETextDrawText], len-3, len);
		}
		else strdel(ProjectTD[EditIndex][ETextDrawText], len-1, len);
 		TextDrawSetString(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawText]);
 		DeleteTimer = SetTimer("DeleteTextDrawLetter", 25, 0);
	}
	return 1;
}

TDE_CALLBACK:LetterSizeTextDrawEDITOR()
{
	if(EditMode != EDITMODE_LETTERSIZE) return 1;
    if(VirtualKeys[31][KEY_PRESSED]) //UP
	{
	    ProjectTD[EditIndex][ETextDrawLetterY] -= EditLetterSizeSpeed;
	    TextDrawLetterSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);
	    TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
	    
	    new SpeedSTR[64];
 		format(SpeedSTR, 64, "%.4f, %.4f", ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);
 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
	    LetterSizeTimer = SetTimer("LetterSizeTextDrawEDITOR", 25, 0);
	    return 1;
	}
	if(VirtualKeys[32][KEY_PRESSED]) //DOWN
	{
	    ProjectTD[EditIndex][ETextDrawLetterY] += EditLetterSizeSpeed;
	    TextDrawLetterSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);
	    TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
	    
	    new SpeedSTR[64];
 		format(SpeedSTR, 64, "%.4f, %.4f", ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);
 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
	    LetterSizeTimer = SetTimer("LetterSizeTextDrawEDITOR", 25, 0);
	    return 1;
	}
    if(VirtualKeys[29][KEY_PRESSED]) //LEFT
	{
     	ProjectTD[EditIndex][ETextDrawLetterX] -= floatdiv(EditLetterSizeSpeed, 10);
	    TextDrawLetterSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);
	    TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
	    
	    new SpeedSTR[64];
 		format(SpeedSTR, 64, "%.4f, %.4f", ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);
 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
	    LetterSizeTimer = SetTimer("LetterSizeTextDrawEDITOR", 25, 0);
	    return 1;
	}
	if(VirtualKeys[30][KEY_PRESSED]) //RIGHT
	{
	    ProjectTD[EditIndex][ETextDrawLetterX] += floatdiv(EditLetterSizeSpeed, 10);
	    TextDrawLetterSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);
	    TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
	    
	    new SpeedSTR[64];
 		format(SpeedSTR, 64, "%.4f, %.4f", ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);
 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
	    LetterSizeTimer = SetTimer("LetterSizeTextDrawEDITOR", 25, 0);
	    return 1;
	}
	KillTimer(LetterSizeTimer);
	LetterSizeTimer = -1;
	return 1;
}

TDE_CALLBACK:ReSizeTextDrawEDITOR()
{
	if(EditMode != EDITMODE_SIZE) return 1;
    if(VirtualKeys[31][KEY_PRESSED]) //UP
	{
	    
	    if( (TextDrawIsBox(ProjectTD[EditIndex][ETextDrawID]) && ProjectTD[EditIndex][ETextDrawLetterX] == 0.0)  )
		{
            ProjectTD[EditIndex][ETextDrawLetterY] -= EditSizeSpeed/10;
            TextDrawLetterSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);
            
            TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
		    new SpeedSTR[64];
	 		format(SpeedSTR, 64, "%.4f, %.4f", ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawLetterY]);
	 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
		    EditSizeTDTimer = SetTimer("ReSizeTextDrawEDITOR", 25, 0);
		    return 1;
		}
		ProjectTD[EditIndex][ETextDrawTextY] -= EditSizeSpeed;
	    new alignment = TextDrawGetAlignment(ProjectTD[EditIndex][ETextDrawID]);
	    switch(alignment)
	    {
	    	case 1, 3: TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
	    	case 2: TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextY], ProjectTD[EditIndex][ETextDrawTextX]);
		}
	    TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);

	    new SpeedSTR[64];
 		format(SpeedSTR, 64, "%.4f, %.4f", ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
	    EditSizeTDTimer = SetTimer("ReSizeTextDrawEDITOR", 25, 0);
	    return 1;
	}
	if(VirtualKeys[32][KEY_PRESSED]) //DOWN
	{
	    if( (TextDrawIsBox(ProjectTD[EditIndex][ETextDrawID]) && ProjectTD[EditIndex][ETextDrawLetterX] == 0.0)  )
		{
            ProjectTD[EditIndex][ETextDrawLetterY] += EditSizeSpeed/10;
            TextDrawLetterSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawLetterX], ProjectTD[EditIndex][ETextDrawLetterY]);

            TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
		    new SpeedSTR[64];
	 		format(SpeedSTR, 64, "%.4f, %.4f", ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawLetterY]);
	 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
		    EditSizeTDTimer = SetTimer("ReSizeTextDrawEDITOR", 25, 0);
		    return 1;
		}
	    ProjectTD[EditIndex][ETextDrawTextY] += EditSizeSpeed;
	    new alignment = TextDrawGetAlignment(ProjectTD[EditIndex][ETextDrawID]);
	    switch(alignment)
	    {
	    	case 1, 3: TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
	    	case 2: TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextY], ProjectTD[EditIndex][ETextDrawTextX]);
		}
	    TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);

	    new SpeedSTR[64];
 		format(SpeedSTR, 64, "%.4f, %.4f", ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
	    EditSizeTDTimer = SetTimer("ReSizeTextDrawEDITOR", 25, 0);
	    return 1;
	}
    if(VirtualKeys[29][KEY_PRESSED]) //LEFT
	{
	    ProjectTD[EditIndex][ETextDrawTextX] -= EditSizeSpeed;
	    new alignment = TextDrawGetAlignment(ProjectTD[EditIndex][ETextDrawID]);
	    switch(alignment)
	    {
	    	case 1, 3: TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
	    	case 2: TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextY], ProjectTD[EditIndex][ETextDrawTextX]);
		}
	    TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);

	    new SpeedSTR[64];
 		format(SpeedSTR, 64, "%.4f, %.4f", ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
 		if( (TextDrawIsBox(ProjectTD[EditIndex][ETextDrawID]) && ProjectTD[EditIndex][ETextDrawLetterX] == 0.0)  ) format(SpeedSTR, 64, "%.4f, %.4f", ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawLetterY]);
 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
	    EditSizeTDTimer = SetTimer("ReSizeTextDrawEDITOR", 25, 0);
	    return 1;
	}
	if(VirtualKeys[30][KEY_PRESSED]) //RIGHT
	{
	    ProjectTD[EditIndex][ETextDrawTextX] += EditSizeSpeed;
	    new alignment = TextDrawGetAlignment(ProjectTD[EditIndex][ETextDrawID]);
	    switch(alignment)
	    {
	    	case 1, 3: TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
	    	case 2: TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextY], ProjectTD[EditIndex][ETextDrawTextX]);
		}
	    TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);

	    new SpeedSTR[64];
 		format(SpeedSTR, 64, "%.4f, %.4f", ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
 		if( (TextDrawIsBox(ProjectTD[EditIndex][ETextDrawID]) && ProjectTD[EditIndex][ETextDrawLetterX] == 0.0)  ) format(SpeedSTR, 64, "%.4f, %.4f", ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawLetterY]);
        GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
		EditSizeTDTimer = SetTimer("ReSizeTextDrawEDITOR", 25, 0);
	    return 1;
	}
	KillTimer(EditSizeTDTimer);
	EditSizeTDTimer = -1;
	return 1;
}

TDE_CALLBACK:MoveTextDrawEDITOR()
{
	if(EditMode != EDITMODE_POSITION) return 1;
    if(VirtualKeys[31][KEY_PRESSED]) //UP
	{
	    ProjectTD[EditIndex][ETextDrawPosY] -= EditMoveSpeed;
	    TextDrawSetPos(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawPosX], ProjectTD[EditIndex][ETextDrawPosY]);
	    TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
	    
	    new SpeedSTR[64];
 		format(SpeedSTR, 64, "%.4f, %.4f", ProjectTD[EditIndex][ETextDrawPosX], ProjectTD[EditIndex][ETextDrawPosY]);
 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
	    MoveTDTimer = SetTimer("MoveTextDrawEDITOR", 25, 0);
	    return 1;
	}
	if(VirtualKeys[32][KEY_PRESSED]) //DOWN
	{
	    ProjectTD[EditIndex][ETextDrawPosY] += EditMoveSpeed;
	    TextDrawSetPos(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawPosX], ProjectTD[EditIndex][ETextDrawPosY]);
	    TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
	    
	    new SpeedSTR[64];
 		format(SpeedSTR, 64, "%.4f, %.4f", ProjectTD[EditIndex][ETextDrawPosX], ProjectTD[EditIndex][ETextDrawPosY]);
 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
	    MoveTDTimer = SetTimer("MoveTextDrawEDITOR", 25, 0);
	    return 1;
	}
    if(VirtualKeys[29][KEY_PRESSED]) //LEFT
	{
	    ProjectTD[EditIndex][ETextDrawPosX] -= EditMoveSpeed;
	    TextDrawSetPos(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawPosX], ProjectTD[EditIndex][ETextDrawPosY]);
	    
	    if(TextDrawIsBox(ProjectTD[EditIndex][ETextDrawID]))
		{
		    if(TextDrawGetAlignment(ProjectTD[EditIndex][ETextDrawID]) != 2)
			{
				ProjectTD[EditIndex][ETextDrawTextX] -= EditMoveSpeed;
		    	TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
			}
		}
	    
	    TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
	    
	    new SpeedSTR[64];
 		format(SpeedSTR, 64, "%.4f, %.4f", ProjectTD[EditIndex][ETextDrawPosX], ProjectTD[EditIndex][ETextDrawPosY]);
 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
	    MoveTDTimer = SetTimer("MoveTextDrawEDITOR", 25, 0);
	    return 1;
	}
	if(VirtualKeys[30][KEY_PRESSED]) //RIGHT
	{
	    ProjectTD[EditIndex][ETextDrawPosX] += EditMoveSpeed;
	    TextDrawSetPos(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawPosX], ProjectTD[EditIndex][ETextDrawPosY]);
	    
	    if(TextDrawIsBox(ProjectTD[EditIndex][ETextDrawID]))
		{
		    if(TextDrawGetAlignment(ProjectTD[EditIndex][ETextDrawID]) != 2)
			{
				ProjectTD[EditIndex][ETextDrawTextX] += EditMoveSpeed;
		    	TextDrawTextSize(ProjectTD[EditIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawTextX], ProjectTD[EditIndex][ETextDrawTextY]);
			}
		}
		
	    TextDrawShowForPlayer(ProjectEditor, ProjectTD[EditIndex][ETextDrawID]);
	    
	    new SpeedSTR[64];
 		format(SpeedSTR, 64, "%.4f, %.4f", ProjectTD[EditIndex][ETextDrawPosX], ProjectTD[EditIndex][ETextDrawPosY]);
 		GameTextForPlayer(ProjectEditor, SpeedSTR, 1000, 5);
	    MoveTDTimer = SetTimer("MoveTextDrawEDITOR", 25, 0);
	    return 1;
	}
	KillTimer(MoveTDTimer);
	MoveTDTimer = -1;
	return 1;
}

stock ShowEditor()
{
	TogglePlayerControllable(ProjectEditor, false);
    
    Loop(0, sizeof(TDE_Menu))
    {
        switch(c)
        {
            case 0:
			{
                TextDrawColor(TDE_Menu[c], 0x000000FF);
        		TextDrawSetSelectable(TDE_Menu[c], false);
            }
            case 2:
            {
        		TextDrawColor(TDE_Menu[c], 0xDDDDDDFF);
        		TextDrawSetSelectable(TDE_Menu[c], true);
			}
			default:
			{
				TextDrawColor(TDE_Menu[c], 0x888888FF);
 				TextDrawSetSelectable(TDE_Menu[c], false);
			}
		}
        TextDrawShowForPlayer(ProjectEditor, TDE_Menu[c]);
    }
    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[20]);
    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[29]);
    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[33]);
    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[35]);
    TextDrawShowForPlayer(ProjectEditor, TD_Status);
	SelectTextDraw(ProjectEditor, -1);
	return true;
}

stock ShowEditorEx()
{
  

    Loop(0, sizeof(TDE_Menu))
    {
        switch(c)
        {
            case 0:
			{
                TextDrawColor(TDE_Menu[c], 0x000000FF);
        		TextDrawSetSelectable(TDE_Menu[c], false);
            }
			default:
			{
				TextDrawColor(TDE_Menu[c], 0x888888FF);
 				TextDrawSetSelectable(TDE_Menu[c], false);
			}
		}
        TextDrawShowForPlayer(ProjectEditor, TDE_Menu[c]);
    }
    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[20]);
    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[29]);
    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[33]);
    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[35]);
    TextDrawShowForPlayer(ProjectEditor, TD_Status);
	SelectTextDraw(ProjectEditor, -1);
	return true;
}

stock CreateMenuTextDraws()
{
    TDE_Menu[0] = TextDrawCreate(0.0, OffsetZ - 2.0, "LD_SPAC:white");
	TextdrawSettings(TDE_Menu[0], Float:{0.5, 1.0, 640.0, 37.0}, {0,0x000000FF,0,0,0,0,255,4,1,0});

	new Float:OffsetX = 0.01;
	TDE_Menu[1] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_manage"); OffsetX += 32.0;
	TDE_Menu[4] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_export"); OffsetX += 32.0;
	TDE_Menu[2] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_new"); OffsetX += 32.0;
	TDE_Menu[3] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_delete"); OffsetX += 32.0;
    TDE_Menu[8] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_duplicate"); OffsetX += 32.0;
    TDE_Menu[24] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_font0");
    TDE_Menu[25] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_font1");
    TDE_Menu[26] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_font2");
    TDE_Menu[27] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_font3");
    TDE_Menu[12] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_image");
    TDE_Menu[13] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_previews"); OffsetX += 32.0;
	TDE_Menu[9] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_pos"); OffsetX += 32.0;
    TDE_Menu[10] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_size"); OffsetX += 32.0;
    TDE_Menu[11] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_text");
	TDE_Menu[35] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_modelid"); OffsetX += 32.0;
    TDE_Menu[14] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_color"); OffsetX += 32.0;
    TDE_Menu[15] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_bgcolor"); OffsetX += 32.0;
    TDE_Menu[32] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_boxcolor"); OffsetX += 32.0;
    TDE_Menu[16] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_lettersize"); OffsetX += 32.0;
    TDE_Menu[17] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_outline"); OffsetX += 32.0;
    TDE_Menu[18] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_shadow"); OffsetX += 32.0;
    TDE_Menu[19] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_useboxno");
    TDE_Menu[20] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_useboxyes");
	TDE_Menu[34] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_modeloptions"); OffsetX += 32.0;
    TDE_Menu[21] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_alignmentleft");
    TDE_Menu[22] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_alignmentcenter");
    TDE_Menu[23] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_alignmentright"); OffsetX += 32.0;
    TDE_Menu[5] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_global");
	TDE_Menu[33] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_player"); OffsetX += 32.0;
    TDE_Menu[28] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_selectableno");
    TDE_Menu[29] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_selectableyes"); OffsetX += 32.0;
    TDE_Menu[30] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_proportionno");
    TDE_Menu[31] = TextDrawCreate(OffsetX, OffsetZ, "TDE:btn_proportionyes"); OffsetX += 32.0;
    Loop(1, sizeof TDE_Menu) TextdrawSettings(TDE_Menu[c], Float:{0.5, 1.0, 32.0, 32.0}, {0,0xDDDDDDFF,0,0,0,0,0,4,1,0});
    
	TD_Status = TextDrawCreate(2.0, 404.86, "EditMode: EDITMODE_NONE");
	TextDrawLetterSize(TD_Status, 0.179665, 0.857481);
	TextDrawAlignment(TD_Status, 1);
	TextDrawColor(TD_Status, -186);
	TextDrawSetShadow(TD_Status, 0);
	TextDrawSetOutline(TD_Status, 0);
	TextDrawBackgroundColor(TD_Status, 255);
	TextDrawFont(TD_Status, 1);
	TextDrawSetProportional(TD_Status, 1);
	
	TDEditor_Helper[0] = TextDrawCreate(322.000000, -6.000000, "_");
	TextDrawAlignment(TDEditor_Helper[0], 2);
	TextDrawBackgroundColor(TDEditor_Helper[0], 255);
	TextDrawFont(TDEditor_Helper[0], 1);
	TextDrawLetterSize(TDEditor_Helper[0], 0.000000, 24.000003);
	TextDrawColor(TDEditor_Helper[0], -1);
	TextDrawSetOutline(TDEditor_Helper[0], 0);
	TextDrawSetProportional(TDEditor_Helper[0], 1);
	TextDrawSetShadow(TDEditor_Helper[0], 1);
	TextDrawUseBox(TDEditor_Helper[0], 1);
	TextDrawBoxColor(TDEditor_Helper[0], -16776961);
	TextDrawTextSize(TDEditor_Helper[0], 0.000000, -2.000000);
	TextDrawSetSelectable(TDEditor_Helper[0], 0);

	TDEditor_Helper[1] = TextDrawCreate(324.000000, 150.000000, "_");
	TextDrawBackgroundColor(TDEditor_Helper[1], 255);
	TextDrawFont(TDEditor_Helper[1], 1);
	TextDrawLetterSize(TDEditor_Helper[1], 0.00000, -0.321204);
	TextDrawColor(TDEditor_Helper[1], -1);
	TextDrawSetOutline(TDEditor_Helper[1], 0);
	TextDrawSetProportional(TDEditor_Helper[1], 1);
	TextDrawSetShadow(TDEditor_Helper[1], 1);
	TextDrawUseBox(TDEditor_Helper[1], 1);
	TextDrawBoxColor(TDEditor_Helper[1], -16776961);
	TextDrawTextSize(TDEditor_Helper[1], -30.000000, 0.000000);
	TextDrawSetSelectable(TDEditor_Helper[1], 0);
	
	TDELOGO = TextDrawCreate(215.000091, 182.933395, "TDE:TDELogo");
	TextDrawLetterSize(TDELOGO, 0.000000, 0.000000);
	TextDrawTextSize(TDELOGO, 190.0, 50.0);
	TextDrawAlignment(TDELOGO, 1);
	TextDrawColor(TDELOGO, -1);
	TextDrawSetShadow(TDELOGO, 0);
	TextDrawSetOutline(TDELOGO, 0);
	TextDrawFont(TDELOGO, 4);
	TextDrawSetSelectable(TDELOGO, 1);
    return 1;
}

stock DestroyMenuTextDraws()
{
    Loop(0, sizeof TDE_Menu)
	{
		TextDrawDestroy(TDE_Menu[c]);
		TDE_Menu[c] = Text:INVALID_TEXT_DRAW;
	}
	TextDrawDestroy(TD_Status);
	TD_Status = Text:INVALID_TEXT_DRAW;
	TextDrawDestroy(TDEditor_Helper[0]);
	TDEditor_Helper[0] = Text:INVALID_TEXT_DRAW;
	TextDrawDestroy(TDEditor_Helper[1]);
	TDEditor_Helper[1] = Text:INVALID_TEXT_DRAW;
	TextDrawDestroy(TDELOGO);
	TDELOGO = Text:INVALID_TEXT_DRAW;
	return 1;
}

stock TextdrawSettings(Text:textid, Float:Sizes[4], Options[10]) //By iPleomax
{
	TextDrawLetterSize		(textid, Sizes[0], Sizes[1]);
	TextDrawTextSize    	(textid, Sizes[2], Sizes[3]);
	TextDrawAlignment   	(textid, Options[0] ? Options[0] : 1);
	TextDrawColor   		(textid, Options[1]);
	TextDrawUseBox   		(textid, Options[2]);
	TextDrawBoxColor   		(textid, Options[3]);
	TextDrawSetShadow   	(textid, Options[4]);
	TextDrawSetOutline  	(textid, Options[5]);
	TextDrawBackgroundColor (textid, Options[6]);
	TextDrawFont   			(textid, Options[7]);
	TextDrawSetProportional	(textid, Options[8]);
	TextDrawSetSelectable   (textid, Options[9]);
}

stock GetAvailableIndex()
{
	for (new i = 0; i < MAX_PROJECT_TEXTDRAWS; i++)
	{
	    if(ProjectTD[i][ItsFromTDE] == -1)
	    {
			if(ProjectTD[i][ETextDrawID] == Text:INVALID_TEXT_DRAW)
			{
				return i;
			}
		}
	}
	return INVALID_INDEX_ID;
}

stock KeyToString(key)
{
	new LETTER[4] = "";
	if((GetKeyState(VK_CAPSLOCK) & 0x0001) != 0)
	{
	    if(VirtualKeys[41][KEY_PRESSED]) //Shift
	    {
	        switch(key)
	        {
	        	case VK_KEY_A: LETTER = "a";//41
				case VK_KEY_B: LETTER = "b";//42
				case VK_KEY_C: LETTER = "c";//43
				case VK_KEY_D: LETTER = "d";//44
				case VK_KEY_E: LETTER = "e";//45
				case VK_KEY_F: LETTER = "f";//46
				case VK_KEY_G: LETTER = "g";//47
				case VK_KEY_H: LETTER = "h";//48
				case VK_KEY_I: LETTER = "i";//49
				case VK_KEY_J: LETTER = "j";//4A
				case VK_KEY_K: LETTER = "k";//4B
				case VK_KEY_L: LETTER = "l";//4C
				case VK_KEY_M: LETTER = "m";//4D
				case VK_KEY_N: LETTER = "n";//4E
				case VK_KEY_O: LETTER = "o";//4F
				case VK_KEY_P: LETTER = "p";//50
				case VK_KEY_Q: LETTER = "q";//51
				case VK_KEY_R: LETTER = "r";//52
				case VK_KEY_S: LETTER = "s";//53
				case VK_KEY_T: LETTER = "t";//54
				case VK_KEY_U: LETTER = "u";//55
				case VK_KEY_V: LETTER = "v";//56
				case VK_KEY_W: LETTER = "w";//57
				case VK_KEY_X: LETTER = "x";//58
				case VK_KEY_Y: LETTER = "y";//59
				case VK_KEY_Z: LETTER = "z";//5A
				case VK_SPACE: LETTER = "_";
				case VK_ENTER: LETTER = "~n~";
				case VK_KEYB0: LETTER = "=";//30
				case VK_KEYB1: LETTER = "!";//!
				case VK_KEYB2: LETTER = "\"";//32
				//case VK_KEYB3: LETTER = "·";//33
				case VK_KEYB4: LETTER = "$";//34
				case VK_KEYB5: LETTER = "%";//35
				case VK_KEYB6: LETTER = "&";//36
				case VK_KEYB7: LETTER = "/";//37
				case VK_KEYB8: LETTER = "(";//38
				case VK_KEYB9: LETTER = ")";//39
				case VK_OEM_PLUS: LETTER = "*";
				case VK_OEM_COMMA: LETTER = ";";
				case VK_OEM_MINUS: LETTER = "_";
				case VK_OEM_PERIOD: LETTER = ":";
				case VK_OEM_2: LETTER = "?";
				case VK_OEM_4: LETTER = "?";
				//case VK_OEM_5: LETTER = "ª";
				case VK_OEM_6: LETTER = "[";
				case VK_OEM_102: LETTER = ">";
				case VK_NUMPAD0: LETTER = "0";
				case VK_NUMPAD1: LETTER = "1";
				case VK_NUMPAD2: LETTER = "2";
				case VK_NUMPAD3: LETTER = "3";
				case VK_NUMPAD4: LETTER = "4";
				case VK_NUMPAD5: LETTER = "5";
				case VK_NUMPAD6: LETTER = "6";
				case VK_NUMPAD7: LETTER = "7";
				case VK_NUMPAD8: LETTER = "8";
				case VK_NUMPAD9: LETTER = "9";
				case VK_MULTIPLY: LETTER = "*";
				case VK_ADD: LETTER = "+";
				//case VK_SEPARATOR: LETTER = "?";
				case VK_SUBTRACT: LETTER = "-";
				case VK_DECIMAL: LETTER = ".";
				case VK_DIVIDE: LETTER = "/";
	        }
	    }
	    else
	    {
	        switch(key)
	        {
		        case VK_KEY_A: LETTER = "A";//41
				case VK_KEY_B: LETTER = "B";//42
				case VK_KEY_C: LETTER = "C";//43
				case VK_KEY_D: LETTER = "D";//44
				case VK_KEY_E: LETTER = "E";//45
				case VK_KEY_F: LETTER = "F";//46
				case VK_KEY_G: LETTER = "G";//47
				case VK_KEY_H: LETTER = "H";//48
				case VK_KEY_I: LETTER = "I";//49
				case VK_KEY_J: LETTER = "J";//4A
				case VK_KEY_K: LETTER = "K";//4B
				case VK_KEY_L: LETTER = "L";//4C
				case VK_KEY_M: LETTER = "M";//4D
				case VK_KEY_N: LETTER = "N";//4E
				case VK_KEY_O: LETTER = "O";//4F
				case VK_KEY_P: LETTER = "P";//50
				case VK_KEY_Q: LETTER = "Q";//51
				case VK_KEY_R: LETTER = "R";//52
				case VK_KEY_S: LETTER = "S";//53
				case VK_KEY_T: LETTER = "T";//54
				case VK_KEY_U: LETTER = "U";//55
				case VK_KEY_V: LETTER = "V";//56
				case VK_KEY_W: LETTER = "W";//57
				case VK_KEY_X: LETTER = "X";//58
				case VK_KEY_Y: LETTER = "Y";//59
				case VK_KEY_Z: LETTER = "Z";//5A
				case VK_SPACE: LETTER = "_";
				case VK_ENTER: LETTER = "~n~";
				case VK_KEYB0: LETTER = "0";//30
				case VK_KEYB1: LETTER = "1";//31
				case VK_KEYB2: LETTER = "2";//32
				case VK_KEYB3: LETTER = "3";//33
				case VK_KEYB4: LETTER = "4";//34
				case VK_KEYB5: LETTER = "5";//35
				case VK_KEYB6: LETTER = "6";//36
				case VK_KEYB7: LETTER = "7";//37
				case VK_KEYB8: LETTER = "8";//38
				case VK_KEYB9: LETTER = "9";//39
				case VK_OEM_PLUS: LETTER = "+";
				case VK_OEM_COMMA: LETTER = ",";
				case VK_OEM_MINUS: LETTER = "-";
				case VK_OEM_PERIOD: LETTER = ".";
				case VK_OEM_2: LETTER = "]";
				case VK_OEM_4: LETTER = "'";
				case VK_OEM_5: LETTER = "|";
				case VK_OEM_6: LETTER = "¡";
				case VK_OEM_102: LETTER = "<";
				case VK_NUMPAD0: LETTER = "0";
				case VK_NUMPAD1: LETTER = "1";
				case VK_NUMPAD2: LETTER = "2";
				case VK_NUMPAD3: LETTER = "3";
				case VK_NUMPAD4: LETTER = "4";
				case VK_NUMPAD5: LETTER = "5";
				case VK_NUMPAD6: LETTER = "6";
				case VK_NUMPAD7: LETTER = "7";
				case VK_NUMPAD8: LETTER = "8";
				case VK_NUMPAD9: LETTER = "9";
				case VK_MULTIPLY: LETTER = "*";
				case VK_ADD: LETTER = "+";
				//case VK_SEPARATOR: LETTER = "?";
				case VK_SUBTRACT: LETTER = "-";
				case VK_DECIMAL: LETTER = ".";
				case VK_DIVIDE: LETTER = "/";


			}
	    }
	}
	else
	{
 		if(VirtualKeys[41][KEY_PRESSED]) //Shift
	    {
	        switch(key)
	        {
				case VK_KEY_A: LETTER = "A";//41
				case VK_KEY_B: LETTER = "B";//42
				case VK_KEY_C: LETTER = "C";//43
				case VK_KEY_D: LETTER = "D";//44
				case VK_KEY_E: LETTER = "E";//45
				case VK_KEY_F: LETTER = "F";//46
				case VK_KEY_G: LETTER = "G";//47
				case VK_KEY_H: LETTER = "H";//48
				case VK_KEY_I: LETTER = "I";//49
				case VK_KEY_J: LETTER = "J";//4A
				case VK_KEY_K: LETTER = "K";//4B
				case VK_KEY_L: LETTER = "L";//4C
				case VK_KEY_M: LETTER = "M";//4D
				case VK_KEY_N: LETTER = "N";//4E
				case VK_KEY_O: LETTER = "O";//4F
				case VK_KEY_P: LETTER = "P";//50
				case VK_KEY_Q: LETTER = "Q";//51
				case VK_KEY_R: LETTER = "R";//52
				case VK_KEY_S: LETTER = "S";//53
				case VK_KEY_T: LETTER = "T";//54
				case VK_KEY_U: LETTER = "U";//55
				case VK_KEY_V: LETTER = "V";//56
				case VK_KEY_W: LETTER = "W";//57
				case VK_KEY_X: LETTER = "X";//58
				case VK_KEY_Y: LETTER = "Y";//59
				case VK_KEY_Z: LETTER = "Z";//5A
				case VK_SPACE: LETTER = "_";
				case VK_ENTER: LETTER = "~n~";
				case VK_KEYB0: LETTER = "=";//30
				case VK_KEYB1: LETTER = "!";//!
				case VK_KEYB2: LETTER = "\"";//32
				//case VK_KEYB3: LETTER = "·";//33
				case VK_KEYB4: LETTER = "$";//34
				case VK_KEYB5: LETTER = "%";//35
				case VK_KEYB6: LETTER = "&";//36
				case VK_KEYB7: LETTER = "/";//37
				case VK_KEYB8: LETTER = "(";//38
				case VK_KEYB9: LETTER = ")";//39
				case VK_OEM_PLUS: LETTER = "*";
				case VK_OEM_COMMA: LETTER = ";";
				case VK_OEM_MINUS: LETTER = "_";
				case VK_OEM_PERIOD: LETTER = ":";
				case VK_OEM_2: LETTER = "?";
				case VK_OEM_4: LETTER = "?";
				//case VK_OEM_5: LETTER = "ª";
				case VK_OEM_6: LETTER = "[";
				case VK_OEM_102: LETTER = ">";
				case VK_NUMPAD0: LETTER = "0";
				case VK_NUMPAD1: LETTER = "1";
				case VK_NUMPAD2: LETTER = "2";
				case VK_NUMPAD3: LETTER = "3";
				case VK_NUMPAD4: LETTER = "4";
				case VK_NUMPAD5: LETTER = "5";
				case VK_NUMPAD6: LETTER = "6";
				case VK_NUMPAD7: LETTER = "7";
				case VK_NUMPAD8: LETTER = "8";
				case VK_NUMPAD9: LETTER = "9";
				case VK_MULTIPLY: LETTER = "*";
				case VK_ADD: LETTER = "+";
				//case VK_SEPARATOR: LETTER = "?";
				case VK_SUBTRACT: LETTER = "-";
				case VK_DECIMAL: LETTER = ".";
				case VK_DIVIDE: LETTER = "/";
	        }
	    }
	    else
	    {
	        switch(key)
	        {
		        case VK_KEY_A: LETTER = "a";//41
				case VK_KEY_B: LETTER = "b";//42
				case VK_KEY_C: LETTER = "c";//43
				case VK_KEY_D: LETTER = "d";//44
				case VK_KEY_E: LETTER = "e";//45
				case VK_KEY_F: LETTER = "f";//46
				case VK_KEY_G: LETTER = "g";//47
				case VK_KEY_H: LETTER = "h";//48
				case VK_KEY_I: LETTER = "i";//49
				case VK_KEY_J: LETTER = "j";//4A
				case VK_KEY_K: LETTER = "k";//4B
				case VK_KEY_L: LETTER = "l";//4C
				case VK_KEY_M: LETTER = "m";//4D
				case VK_KEY_N: LETTER = "n";//4E
				case VK_KEY_O: LETTER = "o";//4F
				case VK_KEY_P: LETTER = "p";//50
				case VK_KEY_Q: LETTER = "q";//51
				case VK_KEY_R: LETTER = "r";//52
				case VK_KEY_S: LETTER = "s";//53
				case VK_KEY_T: LETTER = "t";//54
				case VK_KEY_U: LETTER = "u";//55
				case VK_KEY_V: LETTER = "v";//56
				case VK_KEY_W: LETTER = "w";//57
				case VK_KEY_X: LETTER = "x";//58
				case VK_KEY_Y: LETTER = "y";//59
				case VK_KEY_Z: LETTER = "z";//5A
				case VK_SPACE: LETTER = "_";
				case VK_ENTER: LETTER = "~n~";
				case VK_KEYB0: LETTER = "0";//30
				case VK_KEYB1: LETTER = "1";//31
				case VK_KEYB2: LETTER = "2";//32
				case VK_KEYB3: LETTER = "3";//33
				case VK_KEYB4: LETTER = "4";//34
				case VK_KEYB5: LETTER = "5";//35
				case VK_KEYB6: LETTER = "6";//36
				case VK_KEYB7: LETTER = "7";//37
				case VK_KEYB8: LETTER = "8";//38
				case VK_KEYB9: LETTER = "9";//39
				case VK_OEM_PLUS: LETTER = "+";
				case VK_OEM_COMMA: LETTER = ",";
				case VK_OEM_MINUS: LETTER = "-";
				case VK_OEM_PERIOD: LETTER = ".";
				case VK_OEM_2: LETTER = "]";
				case VK_OEM_4: LETTER = "'";
				case VK_OEM_5: LETTER = "|";
				case VK_OEM_6: LETTER = "¡";
				case VK_OEM_102: LETTER = "<";
				case VK_NUMPAD0: LETTER = "0";
				case VK_NUMPAD1: LETTER = "1";
				case VK_NUMPAD2: LETTER = "2";
				case VK_NUMPAD3: LETTER = "3";
				case VK_NUMPAD4: LETTER = "4";
				case VK_NUMPAD5: LETTER = "5";
				case VK_NUMPAD6: LETTER = "6";
				case VK_NUMPAD7: LETTER = "7";
				case VK_NUMPAD8: LETTER = "8";
				case VK_NUMPAD9: LETTER = "9";
				case VK_MULTIPLY: LETTER = "*";
				case VK_ADD: LETTER = "+";
				//case VK_SEPARATOR: LETTER = "?";
				case VK_SUBTRACT: LETTER = "-";
				case VK_DECIMAL: LETTER = ".";
				case VK_DIVIDE: LETTER = "/";


			}
	    }
	}
	return LETTER;
}

stock HexToRGBA(colour, &r, &g, &b, &a) //By Betamaster
{
    r = (colour >> 24) & 0xFF;
    g = (colour >> 16) & 0xFF;
    b = (colour >> 8) & 0xFF;
    a = colour & 0xFF;
}

stock RGBAToHex(r, g, b, a) //By Betamaster
{
    return (r<<24 | g<<16 | b<<8 | a);
}

stock RemoveTextDrawTDE(Index)
{
	format(ProjectTD[Index][ETextDrawText], 800, "");
	ProjectTD[Index][ETextDrawPosX] = 0.0;
	ProjectTD[Index][ETextDrawPosY] = 0.0;
	ProjectTD[Index][ETextDrawLetterX] = 0.0;
	ProjectTD[Index][ETextDrawLetterY] = 0.0;
	ProjectTD[Index][ETextDrawTextX] = 0.0;
	ProjectTD[Index][ETextDrawTextY] = 0.0;
	ProjectTD[Index][ETextDrawOutline] = 0;
	ProjectTD[Index][ETextDrawShadow] = 0;
	ProjectTD[Index][ETextDrawModelid] = 0;
	ProjectTD[Index][ETextDrawRotX] = 0.0;
	ProjectTD[Index][ETextDrawRotY] = 0.0;
	ProjectTD[Index][ETextDrawRotZ] = 0.0;
	ProjectTD[Index][ETextDrawZoom] = 0.0;
	ProjectTD[Index][ETextDrawType] = 0;
	ProjectTD[Index][ETextDrawSelectable] = 0;
	ProjectTD[Index][ETextDrawColor] = 0;
	ProjectTD[Index][ETextDrawBGColor] = 0;
	ProjectTD[Index][ETextDrawBoxColor] = 0;
	ProjectTD[Index][ETextDrawVehCol1] = 0;
	ProjectTD[Index][ETextDrawVehCol2] = 0;
	TextDrawDestroy(ProjectTD[Index][ETextDrawID]);
	ProjectTD[Index][ItsFromTDE] = -1;
	ProjectTD[Index][ETextDrawID] = Text:INVALID_TEXT_DRAW;
	
	new NewIndex = GetAvailableIndexBack(EditIndex);
	EditIndex = NewIndex;
	if(EditIndex == -1)
	{
	    Loop(1, sizeof(TDE_Menu))
	    {
			TextDrawColor(TDE_Menu[c], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[c], false);
	        TextDrawShowForPlayer(ProjectEditor, TDE_Menu[c]);
	    }
	    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
	    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
	    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[20]);
	    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
	    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
	    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
	    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
	    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
	    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[29]);
	    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[33]);
	    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[35]);
	    TextDrawColor(TDE_Menu[2], 0xDDDDDDFF);
	    TextDrawSetSelectable(TDE_Menu[2], true);
	    TextDrawShowForPlayer(ProjectEditor, TDE_Menu[2]);
	    TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
   		EditMode = EDITMODE_NONE;
	}
	else
	{
	    new string[128];
        format(string, sizeof(string), "{e2b960}TDEditor: {FFFFFF}Now you are editing TextDraw {e2b960}#%d.", EditIndex);
        SendClientMessage(ProjectEditor, -1, string);
        UpdateIcons(EditIndex);
        
        if(EditMode == EDITMODE_MODELS)
        {
            TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
	    	EditMode = EDITMODE_NONE;
        }
	}
	return 1;
}

stock RemoveTextDrawTDEOnly(Index)
{
	format(ProjectTD[Index][ETextDrawText], 800, "");
	ProjectTD[Index][ETextDrawPosX] = 0.0;
	ProjectTD[Index][ETextDrawPosY] = 0.0;
	ProjectTD[Index][ETextDrawLetterX] = 0.0;
	ProjectTD[Index][ETextDrawLetterY] = 0.0;
	ProjectTD[Index][ETextDrawTextX] = 0.0;
	ProjectTD[Index][ETextDrawTextY] = 0.0;
	ProjectTD[Index][ETextDrawOutline] = 0;
	ProjectTD[Index][ETextDrawShadow] = 0;
	ProjectTD[Index][ETextDrawModelid] = 0;
	ProjectTD[Index][ETextDrawRotX] = 0.0;
	ProjectTD[Index][ETextDrawRotY] = 0.0;
	ProjectTD[Index][ETextDrawRotZ] = 0.0;
	ProjectTD[Index][ETextDrawZoom] = 0.0;
	ProjectTD[Index][ETextDrawType] = 0;
	ProjectTD[Index][ETextDrawSelectable] = 0;
	ProjectTD[Index][ETextDrawColor] = 0;
	ProjectTD[Index][ETextDrawBGColor] = 0;
	ProjectTD[Index][ETextDrawBoxColor] = 0;
	ProjectTD[Index][ETextDrawVehCol1] = 0;
	ProjectTD[Index][ETextDrawVehCol2] = 0;
	TextDrawDestroy(ProjectTD[Index][ETextDrawID]);
	ProjectTD[Index][ItsFromTDE] = -1;
	ProjectTD[Index][ETextDrawID] = Text:INVALID_TEXT_DRAW;
	return 1;
}

stock GetAvailableIndexBack(start)
{
	for (new i = start; i != -1; i--)
	{
	    if(ProjectTD[i][ItsFromTDE] == 1)
	    {
			if(ProjectTD[i][ETextDrawID] != Text:INVALID_TEXT_DRAW)
			{
				return i;
			}
		}
	}
	
	for (new i = 0; i < MAX_PROJECT_TEXTDRAWS; i++)
	{
	    if(ProjectTD[i][ItsFromTDE] == 1)
	    {
			if(ProjectTD[i][ETextDrawID] != Text:INVALID_TEXT_DRAW)
			{
				return i;
			}
		}
	}
	return INVALID_INDEX_ID;
}

stock HexToInt(string[])//DracoBlue
{
   if (string[0] == 0) return 0;
   new i, cur=1, res = 0;
   for (i=strlen(string);i>0;i--) {
     if (string[i-1]<58) res=res+cur*(string[i-1]-48); else res=res+cur*(string[i-1]-65+10);
     cur=cur*16;
   }
   return res;
}

stock RGB( red, green, blue, alpha )
{
	return (red * 16777216) + (green * 65536) + (blue * 256) + alpha;
}

stock ShowManage(playerid)
{
	new d, c, dialog[310], str[31];
    for (d = PageStart; d < MAX_PROJECT_TEXTDRAWS; d++)
	{
	    if(ProjectTD[d][ItsFromTDE] == 1)
	    {
			BackManageDialog[c] = 0;
			c ++;
			if(c == 11)
			{
				if(PageStart >= 10)
			    {
					format(str, 30, ">>\n");
					strcat(dialog, str);
				}
				else
				{
				    format(str, 30, ">>");
				    strcat(dialog, str);
				}
				break;
			}
			if(TextDrawGetFont(ProjectTD[d][ETextDrawID]) == 5) format(str, 31, "%s(%i)ModelPreview: %d\n", EditIndex == d ? ("{FFCC00}"):("{CCCCCC}"), d, ProjectTD[d][ETextDrawModelid]);
			else format(str, 31, "%s(%i)%s\n", EditIndex == d ? ("{FFCC00}"):("{CCCCCC}"), d, ProjectTD[d][ETextDrawText]);
			
			if(strlen(str) >= 30)
			{
				strdel(str, 28, 30);
				strcat(str, "\n");
			}
			strcat(dialog, str);
		}
	}
	if(PageStart >= 10)
	{
	    BackManageDialog[c] = 1;
		format(str, 30, "<<");
		strcat(dialog, str);
	}
	ShowPlayerDialog(playerid, DIALOG_MANAGE, DIALOG_STYLE_LIST, "TDEditor - Manage", dialog, ">>", "X");
	IsPSel = false;
	return 1;
}

stock DuplicateTextDraw(Index, ToIndex)
{
	format(ProjectTD[ToIndex][ETextDrawText], 800, "%s", ProjectTD[Index][ETextDrawText]);
	ProjectTD[ToIndex][ETextDrawPosX] = ProjectTD[Index][ETextDrawPosX];
	ProjectTD[ToIndex][ETextDrawPosY] = ProjectTD[Index][ETextDrawPosY];
	ProjectTD[ToIndex][ETextDrawLetterX] = ProjectTD[Index][ETextDrawLetterX];
	ProjectTD[ToIndex][ETextDrawLetterY] = ProjectTD[Index][ETextDrawLetterY];
	ProjectTD[ToIndex][ETextDrawTextX] = ProjectTD[Index][ETextDrawTextX];
	ProjectTD[ToIndex][ETextDrawTextY] = ProjectTD[Index][ETextDrawTextY];
	ProjectTD[ToIndex][ETextDrawOutline] = ProjectTD[Index][ETextDrawOutline];
	ProjectTD[ToIndex][ETextDrawShadow] = ProjectTD[Index][ETextDrawShadow];
	ProjectTD[ToIndex][ETextDrawModelid] = ProjectTD[Index][ETextDrawModelid];
	ProjectTD[ToIndex][ETextDrawRotX] = ProjectTD[Index][ETextDrawRotX];
	ProjectTD[ToIndex][ETextDrawRotY] = ProjectTD[Index][ETextDrawRotY];
	ProjectTD[ToIndex][ETextDrawRotZ] = ProjectTD[Index][ETextDrawRotZ];
	ProjectTD[ToIndex][ETextDrawZoom] = ProjectTD[Index][ETextDrawZoom];
	ProjectTD[ToIndex][ETextDrawType] = ProjectTD[Index][ETextDrawType];
	ProjectTD[ToIndex][ETextDrawSelectable] = ProjectTD[Index][ETextDrawSelectable];
	ProjectTD[ToIndex][ETextDrawColor] = ProjectTD[Index][ETextDrawColor];
	ProjectTD[ToIndex][ETextDrawBGColor] = ProjectTD[Index][ETextDrawBGColor];
	ProjectTD[ToIndex][ETextDrawBoxColor] = ProjectTD[Index][ETextDrawBoxColor];
	ProjectTD[ToIndex][ETextDrawVehCol1] = ProjectTD[Index][ETextDrawVehCol1];
	ProjectTD[ToIndex][ETextDrawVehCol2] = ProjectTD[Index][ETextDrawVehCol2];
	
	new Float:p[2];
	TextDrawGetFontSize(ProjectTD[Index][ETextDrawID], p[0], p[1]);
	ProjectTD[ToIndex][ETextDrawID] = TextDrawCreate(ProjectTD[ToIndex][ETextDrawPosX], ProjectTD[ToIndex][ETextDrawPosY], ProjectTD[ToIndex][ETextDrawText]);
	TextDrawLetterSize(ProjectTD[ToIndex][ETextDrawID], ProjectTD[ToIndex][ETextDrawLetterX], ProjectTD[ToIndex][ETextDrawLetterY]);
	TextDrawAlignment(ProjectTD[ToIndex][ETextDrawID], TextDrawGetAlignment(ProjectTD[Index][ETextDrawID]));
	TextDrawColor(ProjectTD[ToIndex][ETextDrawID], ProjectTD[ToIndex][ETextDrawColor]);
	TextDrawUseBox(ProjectTD[ToIndex][ETextDrawID], TextDrawIsBox(ProjectTD[Index][ETextDrawID]));
	TextDrawTextSize(ProjectTD[ToIndex][ETextDrawID], p[0], p[1]);
	TextDrawBoxColor(ProjectTD[ToIndex][ETextDrawID], ProjectTD[ToIndex][ETextDrawBoxColor]);
	TextDrawSetShadow(ProjectTD[ToIndex][ETextDrawID], ProjectTD[ToIndex][ETextDrawShadow]);
	TextDrawSetOutline(ProjectTD[ToIndex][ETextDrawID], ProjectTD[ToIndex][ETextDrawOutline]);
	TextDrawBackgroundColor(ProjectTD[ToIndex][ETextDrawID], ProjectTD[ToIndex][ETextDrawBGColor]);
	TextDrawFont(ProjectTD[ToIndex][ETextDrawID], TextDrawGetFont(ProjectTD[Index][ETextDrawID]));
	TextDrawSetProportional(ProjectTD[ToIndex][ETextDrawID], TextDrawIsProportional(ProjectTD[Index][ETextDrawID]));
	
	if(TextDrawGetFont(ProjectTD[Index][ETextDrawID]) == 5)
 	{
 	    TextDrawSetPreviewModel(ProjectTD[ToIndex][ETextDrawID], ProjectTD[ToIndex][ETextDrawModelid]);
		TextDrawSetPreviewRot(ProjectTD[ToIndex][ETextDrawID], ProjectTD[ToIndex][ETextDrawRotX], ProjectTD[ToIndex][ETextDrawRotY], ProjectTD[ToIndex][ETextDrawRotZ], ProjectTD[ToIndex][ETextDrawZoom]);
		if(IsVehicle(ProjectTD[ToIndex][ETextDrawModelid])) TextDrawSetPreviewVehCol(ProjectTD[ToIndex][ETextDrawID], ProjectTD[EditIndex][ETextDrawVehCol1], ProjectTD[EditIndex][ETextDrawVehCol2]);
 	}
 	else
 	{
 	    if(EditMode == EDITMODE_MODELS)
        {
            TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
	    	EditMode = EDITMODE_NONE;
        }
  	}
	TextDrawShowForPlayer(ProjectEditor, ProjectTD[ToIndex][ETextDrawID]);
	ProjectTD[ToIndex][ItsFromTDE] = ProjectTD[Index][ItsFromTDE];
	return 1;
}

stock UpdateIcons(Index)
{
    switch(TextDrawGetFont(ProjectTD[Index][ETextDrawID]))
    {
        case 0:
        {
            TextDrawColor(TDE_Menu[12], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[12], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[12]);
			TextDrawColor(TDE_Menu[15], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[15], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[15]);
			TextDrawColor(TDE_Menu[32], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[32], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[32]);
			TextDrawColor(TDE_Menu[16], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[16], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[16]);
			TextDrawColor(TDE_Menu[17], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[17], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[17]);
			TextDrawColor(TDE_Menu[18], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[18], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[18]);
			TextDrawColor(TDE_Menu[19], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[19], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[19]);
			TextDrawColor(TDE_Menu[20], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[20], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[20]);
			TextDrawColor(TDE_Menu[34], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[34], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[34]);
			TextDrawColor(TDE_Menu[21], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[21], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[21]);
			TextDrawColor(TDE_Menu[22], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[22], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[22]);
			TextDrawColor(TDE_Menu[23], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[23], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[23]);
			TextDrawColor(TDE_Menu[30], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[30], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[30]);
			TextDrawColor(TDE_Menu[31], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[31], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[31]);
			
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[25]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[35]);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[11]);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[24]);
        }
        case 1:
        {
            TextDrawColor(TDE_Menu[12], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[12], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[12]);
			TextDrawColor(TDE_Menu[15], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[15], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[15]);
			TextDrawColor(TDE_Menu[32], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[32], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[32]);
			TextDrawColor(TDE_Menu[16], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[16], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[16]);
			TextDrawColor(TDE_Menu[17], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[17], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[17]);
			TextDrawColor(TDE_Menu[18], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[18], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[18]);
			TextDrawColor(TDE_Menu[19], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[19], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[19]);
			TextDrawColor(TDE_Menu[20], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[20], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[20]);
			TextDrawColor(TDE_Menu[34], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[34], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[34]);
			TextDrawColor(TDE_Menu[21], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[21], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[21]);
			TextDrawColor(TDE_Menu[22], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[22], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[22]);
			TextDrawColor(TDE_Menu[23], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[23], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[23]);
			TextDrawColor(TDE_Menu[30], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[30], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[30]);
			TextDrawColor(TDE_Menu[31], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[31], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[31]);
			
            TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[25]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[35]);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[11]);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[25]);
        }
        case 2:
        {
            TextDrawColor(TDE_Menu[12], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[12], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[12]);
			TextDrawColor(TDE_Menu[15], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[15], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[15]);
			TextDrawColor(TDE_Menu[32], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[32], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[32]);
			TextDrawColor(TDE_Menu[16], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[16], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[16]);
			TextDrawColor(TDE_Menu[17], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[17], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[17]);
			TextDrawColor(TDE_Menu[18], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[18], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[18]);
			TextDrawColor(TDE_Menu[19], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[19], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[19]);
			TextDrawColor(TDE_Menu[20], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[20], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[20]);
			TextDrawColor(TDE_Menu[34], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[34], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[34]);
			TextDrawColor(TDE_Menu[21], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[21], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[21]);
			TextDrawColor(TDE_Menu[22], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[22], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[22]);
			TextDrawColor(TDE_Menu[23], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[23], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[23]);
			TextDrawColor(TDE_Menu[30], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[30], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[30]);
			TextDrawColor(TDE_Menu[31], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[31], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[31]);
			
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[25]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[35]);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[11]);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[26]);
        }
        case 3:
        {
			TextDrawColor(TDE_Menu[12], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[12], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[12]);
			TextDrawColor(TDE_Menu[15], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[15], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[15]);
			TextDrawColor(TDE_Menu[32], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[32], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[32]);
			TextDrawColor(TDE_Menu[16], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[16], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[16]);
			TextDrawColor(TDE_Menu[17], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[17], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[17]);
			TextDrawColor(TDE_Menu[18], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[18], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[18]);
			TextDrawColor(TDE_Menu[19], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[19], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[19]);
			TextDrawColor(TDE_Menu[20], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[20], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[20]);
			TextDrawColor(TDE_Menu[34], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[34], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[34]);
			TextDrawColor(TDE_Menu[21], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[21], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[21]);
			TextDrawColor(TDE_Menu[22], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[22], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[22]);
			TextDrawColor(TDE_Menu[23], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[23], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[23]);
			TextDrawColor(TDE_Menu[30], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[30], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[30]);
			TextDrawColor(TDE_Menu[31], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[31], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[31]);
			
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[25]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[35]);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[11]);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[27]);
        }
        case 4:
        {
			TextDrawColor(TDE_Menu[12], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[12], false);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[12]);
			TextDrawColor(TDE_Menu[15], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[15], false);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[15]);
			TextDrawColor(TDE_Menu[32], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[32], false);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[32]);
			TextDrawColor(TDE_Menu[16], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[16], false);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[16]);
			TextDrawColor(TDE_Menu[17], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[17], false);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[17]);
			TextDrawColor(TDE_Menu[18], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[18], false);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[18]);
			TextDrawColor(TDE_Menu[19], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[19], false);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[19]);
			TextDrawColor(TDE_Menu[20], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[20], false);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[20]);
			TextDrawColor(TDE_Menu[34], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[34], false);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[34]);
			TextDrawColor(TDE_Menu[21], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[21], false);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[21]);
			TextDrawColor(TDE_Menu[22], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[22], false);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[22]);
			TextDrawColor(TDE_Menu[23], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[23], false);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[23]);
			TextDrawColor(TDE_Menu[30], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[30], false);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[30]);
			TextDrawColor(TDE_Menu[31], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[31], false);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[31]);
			
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[25]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[35]);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[11]);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[12]);
			
        }
        case 5:
        {
            TextDrawColor(TDE_Menu[12], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[12], false);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[12]);
			TextDrawColor(TDE_Menu[15], 0xDDDDDDFF);
			TextDrawSetSelectable(TDE_Menu[15], true);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[15]);
			TextDrawColor(TDE_Menu[32], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[32], false);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[32]);
			TextDrawColor(TDE_Menu[16], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[16], false);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[16]);
			TextDrawColor(TDE_Menu[17], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[17], false);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[17]);
			TextDrawColor(TDE_Menu[18], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[18], false);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[18]);
			TextDrawColor(TDE_Menu[19], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[19], false);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[19]);
			TextDrawColor(TDE_Menu[20], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[20], false);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[20]);
			TextDrawColor(TDE_Menu[34], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[34], false);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[34]);
			TextDrawColor(TDE_Menu[21], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[21], false);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[21]);
			TextDrawColor(TDE_Menu[22], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[22], false);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[22]);
			TextDrawColor(TDE_Menu[23], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[23], false);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[23]);
			TextDrawColor(TDE_Menu[30], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[30], false);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[30]);
			TextDrawColor(TDE_Menu[31], 0x888888FF);
			TextDrawSetSelectable(TDE_Menu[31], false);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[31]);
			
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[24]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[25]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[26]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[27]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[12]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[13]);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[13]);
			TextDrawHideForPlayer(ProjectEditor, TDE_Menu[11]);
			TextDrawShowForPlayer(ProjectEditor, TDE_Menu[35]);
        }
    }
    
    if(TextDrawIsBox(ProjectTD[Index][ETextDrawID]))
	{
	    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[19]);
	    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[20]);
	    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[34]);
	    TextDrawShowForPlayer(ProjectEditor, TDE_Menu[20]);
	}
	else
	{
	    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[19]);
	    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[20]);
	    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[34]);
	    TextDrawShowForPlayer(ProjectEditor, TDE_Menu[19]);
	}



    switch(TextDrawGetAlignment(ProjectTD[Index][ETextDrawID]))
    {
    	case 1:
		{
		    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[21]);
		    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
		    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
		    TextDrawShowForPlayer(ProjectEditor, TDE_Menu[21]);
		}
    	case 2:
    	{
    	    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[21]);
		    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
		    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
		    TextDrawShowForPlayer(ProjectEditor, TDE_Menu[22]);
    	}
    	case 3: 
    	{
    	    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[21]);
		    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[22]);
		    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[23]);
		    TextDrawShowForPlayer(ProjectEditor, TDE_Menu[23]);
    	}
	}
	
	switch(ProjectTD[Index][ETextDrawType])
	{
	    case 0:
	    {
	        TextDrawHideForPlayer(ProjectEditor, TDE_Menu[5]);
		    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[33]);
		    TextDrawShowForPlayer(ProjectEditor, TDE_Menu[5]);
	    }
	    case 1:
	    {
	        TextDrawHideForPlayer(ProjectEditor, TDE_Menu[5]);
		    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[33]);
		    TextDrawShowForPlayer(ProjectEditor, TDE_Menu[33]);
	    }
	}
	
	switch(ProjectTD[Index][ETextDrawSelectable])
	{
	    case 0:
	    {
	        TextDrawHideForPlayer(ProjectEditor, TDE_Menu[28]);
		    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[29]);
		    TextDrawShowForPlayer(ProjectEditor, TDE_Menu[28]);
	    }
	    case 1:
	    {
	        TextDrawHideForPlayer(ProjectEditor, TDE_Menu[28]);
		    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[29]);
		    TextDrawShowForPlayer(ProjectEditor, TDE_Menu[29]);
	    }
	}
	
	switch(TextDrawIsProportional(ProjectTD[Index][ETextDrawID]))
	{
	    case 0:
	    {
	        TextDrawHideForPlayer(ProjectEditor, TDE_Menu[30]);
		    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[31]);
		    TextDrawShowForPlayer(ProjectEditor, TDE_Menu[30]);
	    }
	    case 1:
	    {
	        TextDrawHideForPlayer(ProjectEditor, TDE_Menu[30]);
		    TextDrawHideForPlayer(ProjectEditor, TDE_Menu[31]);
		    TextDrawShowForPlayer(ProjectEditor, TDE_Menu[31]);
	    }
	}
    return 1;
}

stock IsVehicle(modelid)
{
	if(modelid >= 400 && modelid <= 611) return true;
	return false;
}


stock SaveProject()
{
	if(!strlen(ProjectFile)) return SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}Load the project first.");
    if(fexist(ProjectFile)) fremove(ProjectFile);
	Handler = fopen(ProjectFile, io_append);
    if(!Handler) return SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}Couldn't save the project.");

	new alignment, usebox, font, proportional;
    for (new i = 0; i < MAX_PROJECT_TEXTDRAWS; i++)
	{
	    if(ProjectTD[i][ItsFromTDE] == 1)
	    {

            alignment = TextDrawGetAlignment(ProjectTD[i][ETextDrawID]);
            usebox = TextDrawIsBox(ProjectTD[i][ETextDrawID]);
            font = TextDrawGetFont(ProjectTD[i][ETextDrawID]);
            proportional = TextDrawIsProportional(ProjectTD[i][ETextDrawID]);
		    format(Pro_Str, sizeof(Pro_Str),
			"%f|%f|%f|%f|%f|%f|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%s|%d|%f|%f|%f|%f|%d|%d\r\n",
		    ProjectTD[i][ETextDrawPosX], 				ProjectTD[i][ETextDrawPosY],
			ProjectTD[i][ETextDrawLetterX], 			ProjectTD[i][ETextDrawLetterY],
			ProjectTD[i][ETextDrawTextX], 				ProjectTD[i][ETextDrawTextY],
			alignment, 									ProjectTD[i][ETextDrawColor],
			usebox, 									ProjectTD[i][ETextDrawBoxColor],
			ProjectTD[i][ETextDrawShadow], 				ProjectTD[i][ETextDrawOutline],
			ProjectTD[i][ETextDrawBGColor], 			font,
			proportional, 								ProjectTD[i][ETextDrawSelectable],
			ProjectTD[i][ETextDrawType], 				ProjectTD[i][ETextDrawText],
			ProjectTD[i][ETextDrawModelid],
			ProjectTD[i][ETextDrawRotX],				ProjectTD[i][ETextDrawRotY],				ProjectTD[i][ETextDrawRotZ], ProjectTD[i][ETextDrawZoom],
			ProjectTD[i][ETextDrawVehCol1], 			ProjectTD[i][ETextDrawVehCol2]);
			fwrite(Handler, Pro_Str);
		}
	}
    fclose(Handler);
	return true;
}

stock LoadProject()
{
    if(!strlen(ProjectFile)) return SendClientMessage(ProjectEditor, -1, "{e2b960}TDEditor: {FFFFFF}Couldnt load the project.");
    Handler = fopen(ProjectFile, io_read);
	if(!Handler) return false;
    new i, alignment, usebox, font, proportional;
    while(fread(Handler, Pro_Str))
    {
        StripNewLine(Pro_Str);
		if(!sscanf(Pro_Str, "p<|>ffffffiiiiiiiiiiis[128]dffffdd",
		ProjectTD[i][ETextDrawPosX], 				ProjectTD[i][ETextDrawPosY],
		ProjectTD[i][ETextDrawLetterX], 			ProjectTD[i][ETextDrawLetterY],
		ProjectTD[i][ETextDrawTextX], 				ProjectTD[i][ETextDrawTextY],
		alignment, 									ProjectTD[i][ETextDrawColor],
		usebox, 									ProjectTD[i][ETextDrawBoxColor],
		ProjectTD[i][ETextDrawShadow], 				ProjectTD[i][ETextDrawOutline],
		ProjectTD[i][ETextDrawBGColor], 			font,
		proportional, 								ProjectTD[i][ETextDrawSelectable],
		ProjectTD[i][ETextDrawType], 				ProjectTD[i][ETextDrawText],
		ProjectTD[i][ETextDrawModelid],
		ProjectTD[i][ETextDrawRotX],				ProjectTD[i][ETextDrawRotY],				ProjectTD[i][ETextDrawRotZ], ProjectTD[i][ETextDrawZoom],
		ProjectTD[i][ETextDrawVehCol1], 			ProjectTD[i][ETextDrawVehCol2]))
		{
		    EditIndex = i;
		    
		    ProjectTD[i][ETextDrawID] = TextDrawCreate(ProjectTD[i][ETextDrawPosX], ProjectTD[i][ETextDrawPosY], ProjectTD[i][ETextDrawText]);
			TextDrawLetterSize(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawLetterX], ProjectTD[i][ETextDrawLetterY]);
			TextDrawAlignment(ProjectTD[i][ETextDrawID], alignment);
			TextDrawColor(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawColor]);
			TextDrawUseBox(ProjectTD[i][ETextDrawID], usebox);
			TextDrawSetShadow(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawShadow]);
			TextDrawSetOutline(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawOutline]);
			TextDrawBackgroundColor(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawBGColor]);
			TextDrawFont(ProjectTD[i][ETextDrawID], font);
			TextDrawSetProportional(ProjectTD[i][ETextDrawID], proportional);
			TextDrawTextSize(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawTextX], ProjectTD[i][ETextDrawTextY]);
			TextDrawBoxColor(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawBoxColor]);
			if(font == 5)
		    {
		        TextDrawSetPreviewModel(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawModelid]);
				TextDrawSetPreviewRot(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawRotX], ProjectTD[i][ETextDrawRotY], ProjectTD[i][ETextDrawRotZ], ProjectTD[i][ETextDrawZoom]);
				if(IsVehicle(ProjectTD[i][ETextDrawModelid])) TextDrawSetPreviewVehCol(ProjectTD[i][ETextDrawID], ProjectTD[i][ETextDrawVehCol1], ProjectTD[i][ETextDrawVehCol2]);
		    }
		    ProjectTD[i][ItsFromTDE] = 1;
		    TextDrawShowForPlayer(ProjectEditor, ProjectTD[i][ETextDrawID]);
		    i++;
		}
    }

    fclose(Handler);
    PageStart = 0;
//	UpdateIcons(EditIndex);
	return true;
}

stock StripNewLine(string[]) //DracoBlue (bugfix idea by Y_Less)
{
	new len = strlen(string);
	if (string[0]==0) return ;
	if ((string[len - 1] == '\n') || (string[len - 1] == '\r')) {
		string[len - 1] = 0;
		if (string[0]==0) return ;
		if ((string[len - 2] == '\n') || (string[len - 2] == '\r')) string[len - 2] = 0;
	}
}

stock CheckProject(name[])
{
    if(!fexist("tdelist.txt")) return false;

    Handler = fopen("tdelist.txt", io_read);
    if(!Handler) return -1;

	while(fread(Handler, Pro_Str))
	{
		if(!strcmp(Pro_Str, name, true, strlen(name)))
		{
		    fclose(Handler);
		    return true;
		}
	}
	fclose(Handler);
	return false;
}

stock AddProject(name[])
{
    Handler = fopen("tdelist.txt", io_append);
    if(!Handler) return false;

    fwrite(Handler, name);
    fwrite(Handler, "\r\n");
    fclose(Handler);
    return true;
}

stock CloseProject()
{
    if(!strlen(ProjectFile)) return false;

    SaveProject();
    for (new i = 0; i < MAX_PROJECT_TEXTDRAWS; i++) RemoveTextDrawTDEOnly(i);

	EditIndex = INVALID_INDEX_ID;
	TextDrawSetString(TD_Status, "EditMode: EDITMODE_NONE");
	EditMode = EDITMODE_NONE;
	ColorMode = COLORMODE_NONE;
	EmptyString(ProjectFile);
	ShowEditorEx();
	IsPSel = false;
	KillTimer(EditorUpdateTimer);
	EmptyString(ProjectFile);
    return true;
}

stock IsValidProjectName(name[])
{
	Loop(0, strlen(name))
	{
	    switch(name[c])
	    {
	        case 'A' .. 'Z', 'a' .. 'z', '0' .. '9', '-', '_', '(', ')': continue;
	        default: return false;
	    }
	}
	return true;
}

stock ExportProject()
{
	if(!strlen(ProjectFile)) return false;

    new ExportFile[64];
    format(ExportFile, sizeof(ExportFile), "%s", ProjectFile);
    strins(ExportFile, "TDE_", 0);
    new len = strlen(ExportFile);
	strdel(ExportFile, len - 3, len);
	strcat(ExportFile, "txt");

    if(fexist(ExportFile)) fremove(ExportFile);
    
	new File:ExportIO = fopen(ExportFile, io_append);
	if(!ExportIO) return false;

	new Index, global, player;
    for (new i = 0; i < MAX_PROJECT_TEXTDRAWS; i++)
	{
	    if(ProjectTD[i][ItsFromTDE] == 1)
	    {
			if(ProjectTD[i][ETextDrawID] != Text:INVALID_TEXT_DRAW)
			{
			    if(ProjectTD[i][ETextDrawType] == 0)
			    {
			    	Index++;
			    	global++;
				}
			}
		}
	}
	
	if(Index != 0)
	{
	    fwrite(ExportIO, "//Global TextDraws: \r\n\r\n\r\n");
	    format(line, sizeof(line), "new Text:TDEditor_TD[%i];\r\n", Index); fwrite(ExportIO, line);
	    Index = 0;
	    new alignment, font, proportion;
	    fwrite(ExportIO, "\r\n");
	    for (new i = 0; i < MAX_PROJECT_TEXTDRAWS; i++)
		{
		    if(ProjectTD[i][ItsFromTDE] == 1)
		    {
				if(ProjectTD[i][ETextDrawID] != Text:INVALID_TEXT_DRAW)
				{
				    if(ProjectTD[i][ETextDrawType] == 0)
				    {
				        alignment = TextDrawGetAlignment(ProjectTD[i][ETextDrawID]);
				        font = TextDrawGetFont(ProjectTD[i][ETextDrawID]);
				        proportion = TextDrawIsProportional(ProjectTD[i][ETextDrawID]);
				        format(line, sizeof(line), "TDEditor_TD[%i] = TextDrawCreate(%f, %f, \"%s\");\r\n", Index, ProjectTD[i][ETextDrawPosX], ProjectTD[i][ETextDrawPosY], ProjectTD[i][ETextDrawText]); fwrite(ExportIO, line);
                        format(line, sizeof(line), "TextDrawLetterSize(TDEditor_TD[%i], %f, %f);\r\n", Index, ProjectTD[i][ETextDrawLetterX], ProjectTD[i][ETextDrawLetterY]); fwrite(ExportIO, line);
	                    if(TextDrawIsBox(ProjectTD[i][ETextDrawID]) || font == 4 || font == 5)
	                    {
	                    	if(alignment == 2)
							{
								format(line, sizeof(line), "TextDrawTextSize(TDEditor_TD[%i], %f, %f);\r\n", Index, ProjectTD[i][ETextDrawTextY], ProjectTD[i][ETextDrawTextX]);
								fwrite(ExportIO, line);
							}
							else
							{
								format(line, sizeof(line), "TextDrawTextSize(TDEditor_TD[%i], %f, %f);\r\n", Index, ProjectTD[i][ETextDrawTextX], ProjectTD[i][ETextDrawTextY]);
								fwrite(ExportIO, line);
							}
						}
						format(line, sizeof(line), "TextDrawAlignment(TDEditor_TD[%i], %d);\r\n", Index, alignment); fwrite(ExportIO, line);
						format(line, sizeof(line), "TextDrawColor(TDEditor_TD[%i], %i);\r\n", Index, ProjectTD[i][ETextDrawColor]); fwrite(ExportIO, line);
						if(TextDrawIsBox(ProjectTD[i][ETextDrawID]))
	                    {
							format(line, sizeof(line), "TextDrawUseBox(TDEditor_TD[%i], 1);\r\n", Index); fwrite(ExportIO, line);
                            format(line, sizeof(line), "TextDrawBoxColor(TDEditor_TD[%i], %i);\r\n", Index, ProjectTD[i][ETextDrawBoxColor]); fwrite(ExportIO, line);
						}
						format(line, sizeof(line), "TextDrawSetShadow(TDEditor_TD[%i], %d);\r\n", Index, ProjectTD[i][ETextDrawShadow]); fwrite(ExportIO, line);
						format(line, sizeof(line), "TextDrawSetOutline(TDEditor_TD[%i], %d);\r\n", Index, ProjectTD[i][ETextDrawOutline]); fwrite(ExportIO, line);
						format(line, sizeof(line), "TextDrawBackgroundColor(TDEditor_TD[%i], %d);\r\n", Index, ProjectTD[i][ETextDrawBGColor]); fwrite(ExportIO, line);
						format(line, sizeof(line), "TextDrawFont(TDEditor_TD[%i], %d);\r\n", Index, font); fwrite(ExportIO, line);
						format(line, sizeof(line), "TextDrawSetProportional(TDEditor_TD[%i], %d);\r\n", Index, proportion); fwrite(ExportIO, line);
						format(line, sizeof(line), "TextDrawSetShadow(TDEditor_TD[%i], %d);\r\n", Index, ProjectTD[i][ETextDrawShadow]); fwrite(ExportIO, line);
						
                        if(ProjectTD[i][ETextDrawSelectable])
						{
						    format(line, sizeof(line), "TextDrawSetSelectable(TDEditor_TD[%i], true);\r\n", Index); fwrite(ExportIO, line);
						}
						
						if(font == 5)
						{
						    format(line, sizeof(line), "TextDrawSetPreviewModel(TDEditor_TD[%i], %d);\r\n", Index, ProjectTD[i][ETextDrawModelid]); fwrite(ExportIO, line);
						    format(line, sizeof(line), "TextDrawSetPreviewRot(TDEditor_TD[%i], %f, %f, %f, %f);\r\n", Index, ProjectTD[i][ETextDrawRotX], ProjectTD[i][ETextDrawRotY], ProjectTD[i][ETextDrawRotZ], ProjectTD[i][ETextDrawZoom]); fwrite(ExportIO, line);
							if(IsVehicle(ProjectTD[i][ETextDrawModelid]))
							{
							    format(line, sizeof(line), "TextDrawSetPreviewVehCol(TDEditor_TD[%i], %d, %d);\r\n", Index, ProjectTD[i][ETextDrawVehCol1], ProjectTD[i][ETextDrawVehCol2]); fwrite(ExportIO, line);
							}
						}
						format(line, sizeof(line), "\r\n"); fwrite(ExportIO, line);
						Index ++;
				    }
				}
			}
		}
	}

    Index = 0;
    
    for (new i = 0; i < MAX_PROJECT_TEXTDRAWS; i++)
	{
	    if(ProjectTD[i][ItsFromTDE] == 1)
	    {
			if(ProjectTD[i][ETextDrawID] != Text:INVALID_TEXT_DRAW)
			{
			    if(ProjectTD[i][ETextDrawType] == 1)
			    {
			    	Index++;
			    	player++;
				}
			}
		}
	}
	
	if(Index != 0)
	{
	    if(global > 0) fwrite(ExportIO, "\r\n\r\n");
		fwrite(ExportIO, "//Player TextDraws: \r\n\r\n\r\n");
	    format(line, sizeof(line), "new Text:TDEditor_PTD[MAX_PLAYERS][%i];\r\n", Index); fwrite(ExportIO, line);
	    Index = 0;
	    new alignment, font, proportion;
	    fwrite(ExportIO, "\r\n");
	    for (new i = 0; i < MAX_PROJECT_TEXTDRAWS; i++)
		{
		    if(ProjectTD[i][ItsFromTDE] == 1)
		    {
				if(ProjectTD[i][ETextDrawID] != Text:INVALID_TEXT_DRAW)
				{
				    if(ProjectTD[i][ETextDrawType] == 1)
				    {
				        alignment = TextDrawGetAlignment(ProjectTD[i][ETextDrawID]);
				        font = TextDrawGetFont(ProjectTD[i][ETextDrawID]);
				        proportion = TextDrawIsProportional(ProjectTD[i][ETextDrawID]);
				        format(line, sizeof(line), "TDEditor_PTD[playerid][%i] = CreatePlayerTextDraw(playerid, %f, %f, \"%s\");\r\n", Index, ProjectTD[i][ETextDrawPosX], ProjectTD[i][ETextDrawPosY], ProjectTD[i][ETextDrawText]); fwrite(ExportIO, line);
	                    format(line, sizeof(line), "PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][%i], %f, %f);\r\n", Index, ProjectTD[i][ETextDrawLetterX], ProjectTD[i][ETextDrawLetterY]); fwrite(ExportIO, line);
	                    if(TextDrawIsBox(ProjectTD[i][ETextDrawID]) || font == 4 || font == 5)
	                    {
	                    	if(alignment == 2)
							{
								format(line, sizeof(line), "PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][%i], %f, %f);\r\n", Index, ProjectTD[i][ETextDrawTextY], ProjectTD[i][ETextDrawTextX]);
								fwrite(ExportIO, line);
							}
							else
							{
								format(line, sizeof(line), "PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][%i], %f, %f);\r\n", Index, ProjectTD[i][ETextDrawTextX], ProjectTD[i][ETextDrawTextY]);
								fwrite(ExportIO, line);
							}
						}
						format(line, sizeof(line), "PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][%i], %d);\r\n", Index, alignment); fwrite(ExportIO, line);
						format(line, sizeof(line), "PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][%i], %i);\r\n", Index, ProjectTD[i][ETextDrawColor]); fwrite(ExportIO, line);
						if(TextDrawIsBox(ProjectTD[i][ETextDrawID]))
	                    {
							format(line, sizeof(line), "PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][%i], 1);\r\n", Index); fwrite(ExportIO, line);
	                        format(line, sizeof(line), "PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][%i], %i);\r\n", Index, ProjectTD[i][ETextDrawBoxColor]); fwrite(ExportIO, line);
						}
						format(line, sizeof(line), "PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][%i], %d);\r\n", Index, ProjectTD[i][ETextDrawShadow]); fwrite(ExportIO, line);
						format(line, sizeof(line), "PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][%i], %d);\r\n", Index, ProjectTD[i][ETextDrawOutline]); fwrite(ExportIO, line);
						format(line, sizeof(line), "PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][%i], %d);\r\n", Index, ProjectTD[i][ETextDrawBGColor]); fwrite(ExportIO, line);
						format(line, sizeof(line), "PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][%i], %d);\r\n", Index, font); fwrite(ExportIO, line);
						format(line, sizeof(line), "PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][%i], %d);\r\n", Index, proportion); fwrite(ExportIO, line);
						format(line, sizeof(line), "PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][%i], %d);\r\n", Index, ProjectTD[i][ETextDrawShadow]); fwrite(ExportIO, line);

	                    if(ProjectTD[i][ETextDrawSelectable])
						{
						    format(line, sizeof(line), "PlayerTextDrawSetSelectable(playerid, TDEditor_PTD[playerid][%i], true);\r\n", Index); fwrite(ExportIO, line);
						}

						if(font == 5)
						{
						    format(line, sizeof(line), "PlayerTextDrawSetPreviewModel(playerid, TDEditor_PTD[playerid][%i], %d);\r\n", Index, ProjectTD[i][ETextDrawModelid]); fwrite(ExportIO, line);
						    format(line, sizeof(line), "PlayerTextDrawSetPreviewRot(playerid, TDEditor_PTD[playerid][%i], %f, %f, %f, %f);\r\n", Index, ProjectTD[i][ETextDrawRotX], ProjectTD[i][ETextDrawRotY], ProjectTD[i][ETextDrawRotZ], ProjectTD[i][ETextDrawZoom]); fwrite(ExportIO, line);
							if(IsVehicle(ProjectTD[i][ETextDrawModelid]))
							{
							    format(line, sizeof(line), "PlayerTextDrawSetPreviewVehCol(playerid, TDEditor_PTD[playerid][%i], %d, %d);\r\n", Index, ProjectTD[i][ETextDrawVehCol1], ProjectTD[i][ETextDrawVehCol2]); fwrite(ExportIO, line);
							}
						}
						format(line, sizeof(line), "\r\n"); fwrite(ExportIO, line);
						Index ++;
				    }
				}
			}
		}
	}
	
	new Hour, Minute, Second;
	gettime(Hour, Minute, Second);
	new Year, Month, Day;
	getdate(Year, Month, Day);

	format(line, sizeof(line), "\r\n\r\n\r\n//Total textdraws exported: %d (%d global textdraws / %d player textdraws) ~ %d/%d/%d ~ %d:%d:%d", (global+player), global, player, Day, Month, Year, Hour, Minute, Second); fwrite(ExportIO, line);
	format(line, sizeof(line), "\r\nTDEditor V1.12 by adri1"); fwrite(ExportIO, line);
	fclose(ExportIO);
	
	new str[128];
	format(str, 128, "{e2b960}TDEditor: {FFFFFF}Proyecto exportado (%s, %d global textdraws, %d player textdraws).", ExportFile, global, player);
	SendClientMessage(ProjectEditor, -1, str);
	return 1;
}

/*

	___ __  __
	 | |  \|_  _|.|_ _  _
	 | |__/|__(_|||_(_)|

	TDEditor 1.12 by adri1

*/
