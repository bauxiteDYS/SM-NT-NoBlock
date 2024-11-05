#include <sourcemod>
#include <sdktools>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo = {
	name = "NT NoBlock",
	description = "Noblock for NT, requires SM >= 1.11.6939 probably",
	author = "bauxite, credits to sslice's NoBlock",
	version = "0.1.0",
	url = "https://forums.alliedmods.net/showthread.php?t=53721"
};

public void OnPluginStart()
{
	if (!HookEventEx("player_spawn", OnPlayerSpawnPost, EventHookMode_Post))
	{
		SetFailState("[NT NoBlock] Failed to hook event player_spawn");
	}
}

public void OnPlayerSpawnPost(Event event, const char[] name, bool dontBroadcast)
{
	int userid = event.GetInt("userid");
	
	RequestFrame(NoBlockClient, userid);
}

void NoBlockClient(int userid)
{
	int client = GetClientOfUserId(userid);
	
	if(client <= 0 || client > MaxClients || !IsClientInGame(client))
	{
		return;
	}
	
	SetEntityCollisionGroup(client, 2);
	EntityCollisionRulesChanged(client);
}
