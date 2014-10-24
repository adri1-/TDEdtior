#include <a_samp>
#include <core>
#include <float>

#pragma tabsize 0

main()
{
	print("\n----------------------------------");
	print("  Bare Script\n");
	print("----------------------------------\n");
}

public OnPlayerConnect(playerid)
{
	GameTextForPlayer(playerid,"~w~SA-MP: ~r~Bare Script",5000,5);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new idx;
	new cmd[256];
	
	cmd = strtok(cmdtext, idx);

	if(strcmp(cmd, "/a", true) == 0) {
	
	RemoveBuildingForPlayer(playerid, 4064, 1571.6016, -1675.7500, 35.6797, 0.25);
RemoveBuildingForPlayer(playerid, 3976, 1571.6016, -1675.7500, 35.6797, 0.25);
new Cartel1 = CreateObject(2885, 1554.99, -1675.62, 27.03,   0.00, 0.00, 89.46);
SetObjectMaterialText(Cartel1, "\nDepartamento\nPolicial", 0,OBJECT_MATERIAL_SIZE_256x128,\
"Arial", 25, 1, 0xFFFF0000, 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);


new myobject3 = CreateObject(3976, 1571.60, -1675.75, 35.64,   360.04, 0.00, 0.08);
SetObjectMaterial(myobject3, 1, 3967,"cj_airprt","Slabs");
SetObjectMaterial(myobject3, 2, 3967,"cj_airprt","Slabs");
SetObjectMaterial(myobject3, 3, 3967,"cj_airprt","Slabs");
SetObjectMaterial(myobject3, 4, 3967,"cj_airprt","ws_stationfloor");
SetObjectMaterial(myobject3, 5, 3922,"bistro","DinerFloor");
SetObjectMaterial(myobject3, 6, 19400,"all_walls","ab_clubloungewall");
SetObjectMaterial(myobject3, 7, 19400,"all_walls","ab_clubloungewall");
SetObjectMaterial(myobject3, 8, 19400,"all_walls","ab_clubloungewall");
SetObjectMaterial(myobject3, 9, 3922,"bistro","DinerFloor");
SetObjectMaterial(myobject3, 12, 3925,"weemap","sw_shedwindow1");
SetObjectMaterial(myobject3, 11, 19400,"all_walls","desgreengrass");
SetObjectMaterial(myobject3, 13, 3967,"cj_airprt","Slabs");
    	return 1;
	}
	
	if(strcmp(cmd, "/b", true) == 0) return SetPlayerPos(playerid, 1554.99, -1675.62, 30.03);

	return 0;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerInterior(playerid,0);
	TogglePlayerClock(playerid,0);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
   	return 1;
}

SetupPlayerForClassSelection(playerid)
{
 	SetPlayerInterior(playerid,14);
	SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
	SetPlayerFacingAngle(playerid, 270.0);
	SetPlayerCameraPos(playerid,256.0815,-43.0475,1004.0234);
	SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
}

public OnPlayerRequestClass(playerid, classid)
{
	SetupPlayerForClassSelection(playerid);
	return 1;
}

public OnGameModeInit()
{
	SetGameModeText("Bare Script");
	ShowPlayerMarkers(1);
	ShowNameTags(1);
	AllowAdminTeleport(1);

	AddPlayerClass(265,1958.3783,1343.1572,15.3746,270.1425,0,0,0,0,-1,-1);

	return 1;
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
