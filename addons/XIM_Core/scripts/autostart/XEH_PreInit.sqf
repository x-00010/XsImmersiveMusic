// put cba debug setting stuff here

if (isMultiplayer) then
{
	if (hasInterface) then // runs on all player clients, including host (if there is one)
	{
		execVM "\XIM_Core\scripts\client.sqf"; // executes main.sqf
	};

	if (isServer) then // runs on the dedicated server, or player host, either way it runs on machine id 2
	{
		execVM "\XIM_Core\scripts\server.sqf"; // executes server.sqf
	};
};

else
{
	hint "singleplayer not done yet"
};