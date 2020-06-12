// put cba debug setting stuff here

if (isMultiplayer) then // if client is in multiplayer
{
	if (hasInterface) then
	{
		execVM "\XIM_Core\scripts\multiplayer\client.sqf"; // displays currently playing song
	};
	
	if (isServer) then // runs on the dedicated server, or player host, either way it runs on machine id 2
	{
		execVM "\XIM_Core\scripts\multiplayer\server.sqf"; // executes server.sqf
	};
} 
else // if client is in singleplayer
{
	execVM "\XIM_Core\scripts\singleplayer\client.sqf"; // executes client.sqf
};