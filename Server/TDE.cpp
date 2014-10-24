/*

Plugin Credits: Sasino97, adri1

native GetVirtualKeyState(key);
native GetScreenSize(&Width, &Height);
native GetMousePos(&X, &Y);
native PressKeyEnter(key);
native PressAnyKey(key);
native GetKeyState(key);
native GetDoubleClickTime();

*/

#include <Windows.h>
#include "../SDK/plugin.h"

typedef void  (*logprintf_t)(char* format, ...);
logprintf_t logprintf;
void **ppPluginData;
extern void *pAMXFunctions;


int comprobar;
cell* Buff;
POINT Cursor;
RECT Screen;

PLUGIN_EXPORT bool PLUGIN_CALL Load(void **ppData)
{
   pAMXFunctions = ppData[PLUGIN_DATA_AMX_EXPORTS];
   logprintf = (logprintf_t)ppData[PLUGIN_DATA_LOGPRINTF];
   logprintf("\nTDEditor Plugin loaded, thank you for using.\n");
   return 1;
}

PLUGIN_EXPORT void PLUGIN_CALL Unload()
{
}

cell AMX_NATIVE_CALL GetVirtualKeyState(AMX* amx, cell* params)
{
	return GetAsyncKeyState(params[1]);
}

cell AMX_NATIVE_CALL GetScreenSize(AMX* amx, cell* params)
{
	GetWindowRect(GetDesktopWindow(), &Screen);
	amx_GetAddr(amx, params[1], &Buff);
	*Buff = amx_ftoc(Screen.right);
	amx_GetAddr(amx, params[2], &Buff);
	*Buff = amx_ftoc(Screen.bottom);
	return true;
}

cell AMX_NATIVE_CALL GetMousePos(AMX* amx, cell* params)
{
	GetCursorPos(&Cursor);
	amx_GetAddr(amx, params[1], &Buff);
	*Buff = amx_ftoc(Cursor.x);
	amx_GetAddr(amx, params[2], &Buff);
	*Buff = amx_ftoc(Cursor.y);
    return true;
}

cell AMX_NATIVE_CALL PressKeyEnter(AMX *amx, cell *params)
{  
	INPUT ip;
    ip.type = INPUT_KEYBOARD;
    ip.ki.wScan = 0; 
    ip.ki.time = 0;
    ip.ki.dwExtraInfo = 0;
    ip.ki.wVk = params[1]; 
    ip.ki.dwFlags = KEYEVENTF_KEYUP;
	return SendInput(1, &ip, sizeof(INPUT));; 
}

cell AMX_NATIVE_CALL PressAnyKey(AMX *amx, cell *params)
{  
	INPUT ip;
    ip.type = INPUT_KEYBOARD;
    ip.ki.wScan = 0; 
    ip.ki.time = 0;
    ip.ki.dwExtraInfo = 0;
    ip.ki.wVk = params[1]; 
    ip.ki.dwFlags = 0;
	return SendInput(1, &ip, sizeof(INPUT));
}

cell AMX_NATIVE_CALL ActivateAnyKey(AMX* pAMX, cell* params)
{

	while (comprobar == 1)
	{
		for(int i = 8; i <= 190; i++)
		{
			if (GetAsyncKeyState(i) == -32767)
			{
				//char letter = static_cast<char>(i);				
				int idx;
				cell ret, amx_addr, *phys_addr;
				int amxerr = amx_FindPublic(pAMX, "OnAnyKeyDown", &idx);
				if(amxerr == AMX_ERR_NONE)
				{
					amx_Push(pAMX, i);
					//amx_PushString(pAMX,&amx_addr,&phys_addr,letter,0,0);
					amx_Exec(pAMX, &ret, idx);
				}
			}
		}
	}
	system ("PAUSE");
    return -1;
}

cell AMX_NATIVE_CALL ActivateAnyKeyVariable(AMX* amx, cell* params)
{
	comprobar = params[1];
	return 1;
}

cell AMX_NATIVE_CALL GetKeyState(AMX *amx, cell *params)
{  
	return GetKeyState(params[1]); 
}

cell AMX_NATIVE_CALL GetDoubleClickTime(AMX *amx, cell *params)
{  
	return GetDoubleClickTime(); 
}

AMX_NATIVE_INFO projectNatives[] =
{
	{"GetVirtualKeyState", GetVirtualKeyState},
	{"GetScreenSize", GetScreenSize},
    {"GetMousePos", GetMousePos},
	{"PressKeyEnter", PressKeyEnter},
	{"PressAnyKey", PressAnyKey},
	{"GetKeyState", GetKeyState},
	{"GetDoubleClickTime", GetDoubleClickTime},
	{"ActivateAnyKey", ActivateAnyKey},
	{"ActivateAnyKeyVariable", ActivateAnyKeyVariable},
	{ 0, 0 }
};


PLUGIN_EXPORT unsigned int PLUGIN_CALL Supports()
{
   return SUPPORTS_VERSION | SUPPORTS_AMX_NATIVES;
}

PLUGIN_EXPORT int PLUGIN_CALL AmxLoad(AMX *amx)
{
   return amx_Register(amx, projectNatives, -1);
}

PLUGIN_EXPORT int PLUGIN_CALL AmxUnload(AMX *amx)
{
   return AMX_ERR_NONE;
}