// This script is executed on either the player host (non-dedicated) or a dedicated server


// Below is the creation of arrays, that contain classnames of music tracks defined in config.cpp, randomized to make it fresh each time;
aCombatMusicClassnames = "'intense' in getArray (_x >> 'moods') " configClasses (configFile >> "CfgMusic") apply {configName _x} call BIS_fnc_arrayShuffle;
aDarkMusicClassnames = "'dark' in getArray (_x >> 'moods') " configClasses (configFile >> "CfgMusic") apply {configName _x} call BIS_fnc_arrayShuffle;
aCalmMusicClassnames = "'calm' in getArray (_x >> 'moods') " configClasses (configFile >> "CfgMusic") apply {configName _x} call BIS_fnc_arrayShuffle;



if (isDedicated) then {
  ["initialize",[aDarkMusicClassnames,aCombatMusicClassnames,aCalmMusicClassnames]] remoteExecCall ["BIS_fnc_jukebox",-2,true]; //Init jukebox on clients + JIP
} else {
  ["initialize",[aDarkMusicClassnames,aCombatMusicClassnames,aCalmMusicClassnames]] remoteExecCall ["BIS_fnc_jukebox",0,true]; //Init jukebox globally + JIP
};

// ======================================== FUNCTIONS ========================================

XIM_fncMonitorPlayers = 
{
	params[["_aPlayerMachineIDs", objNull], "_oPlayer"];

	if (isNull _aPlayerMachineIDs) then // if no argument in position zero was provided
	{
		private _aPlayerMachineIDs = [];
		{
			if (_oPlayer distance _x <= 500) then // if the distance between the player currently being iterated in the outermost loop and the player currently being iterated in the innermost loop is less than or equal to 500
			{
				private _iPlayerID = owner _x;
				_aPlayerMachineIDs pushBack _iPlayerID;
			};
		} forEach allPlayers - entities "HeadlessClient_F"; // for every player, except headless clients
	}
	else // if an argument in position zero was provided
	{
		[_aPlayerMachineIDs, _oPlayer] spawn
		{
			params ["_aPlayerMachineIDs", "_oPlayer"];
			{
				if (_oPlayer distance _x <= 500) then // if the distance between the player currently being iterated in the outermost loop and the player currently being iterated in the innermost loop is less than or equal to 500
				{
					private _iPlayerID = owner _x;
					_aPlayerMachineIDs pushBack _iPlayerID;
				};
			} forEach allPlayers - entities "HeadlessClient_F"; // for every player, except headless clients
		};
	};
};

XIM_fncIteratePlayer = // defines the XIM_fncIteratePlayers function, which iterates through each player
{
	params ["_oFiringAI", "_oPlayer"]; // defines _oFiringAI, which is the object of the AI who fired
	private _aPlayerMachineIDs = []; // defines _aPlayerMachineIDs, which is an empty array

	if (_oPlayer getVariable ["XIM_bCombat"] == false) then // if the client is not already in combat
	{
		if (alive _oPlayer) then // if the player is not dead
		{
			if (_oPlayer distance _oFiringAI <= 500) then // if the distance to the AI who is firing is less than or equal to 500 metres
			{
				private _iPlayerID = owner _oPlayer; // finds the player's machine ID, and assigns the value to _iPlayerID
				_iPlayerID publicVariableClient ["XIM_bCombat", true]; // set the player's combat variable to true
			};
		};

		if (_oPlayer getVariable ["XIM_bCombat"] == true) then // if the player entered combat after previously not being in combat
		{
			private _oPlayer = _x;
		};
	};
	_aPlayerMachineIDs sort true; // sort the array in ascending order, and return the array
};

fncXIM_MusicHandler = { // defines the fncXIM_MusicHandler function, which disables ace's volume interference for the group, plays a certain type of music based on the parameter, and then reenables ace's volume interference for that same group
	params ["_aXIMPlayers","_musictype"];

	missionNameSpace setVariable ["ace_hearing_disableVolumeUpdate",true,_aXIMPlayers]; //Disable ACE interference
	["forceBehaviour",[_musictype]] remoteExecCall ["BIS_fnc_jukebox",_aXIMPlayers]; //Changes music type based on passed parameter
	[{missionNameSpace setVariable ["ace_hearing_disableVolumeUpdate",false,_aXIMPlayers];},[], 15] call CBA_fnc_waitAndExecute; //Wait 15 seconds, then enable ACE Volume Update again (earplugs, deafened,...)
};


fncXIM_MusicRemote = {
	params ["_aXIMPlayers", "_bXIMCombatState"]; //Defining params
	if (_bXIMCombatState) then {

		[_aXIMPlayers,"combat"] spawn fncXIM_MusicHandler; //Set music to type combat
			
	} else {
		private _sunrisesunset = date call BIS_fnc_sunriseSunsetTime;
		private _sunrise = _sunrisesunset select 0;
		private _sunset = _sunrisesunset select 1;

		if ((rain > 0.2) or (fog > 0.2) or ((daytime > _sunset) and (daytime < _sunrise))) then {

			[_aXIMPlayers,"stealth"] spawn fncXIM_MusicHandler; //Set music to type stealth (dark)
  			
		} else {

  			[_aXIMPlayers,"safe"] spawn fncXIM_MusicHandler; //Set music to type safe

		};

	};	
};

// ======================================== EVENT HANDLERS ========================================
onPlayerConnected // when a player connects
{
	XIM_bCombat = false; // declare XIM_bCombat, which is a variable to determine if the player is in combat or not
	_owner publicVariableClient "XIM_bCombat"; // broadcast the XIM_bCombat variable, with the default value of false
	XIM_bCombat = nil; // destroy the XIM_bCombat variable, as it is no longer needed
};

["ace_firedNonPlayer", [this select 0] call XIM_fncIteratePlayer] call CBA_fnc_addEventHandler; // adds event handler for when an AI fires

"XIM_aStateChange" addPublicVariableEventHandler 
{
	private _aXIMstatechange = _this select 1; //Store array in variable
	private _aXIMPlayers = _aXIMstatechange select 0; //Retrieve network ID's
	private _bXIMCombatState = _aXIMstatechange select 1; //Retrieve combat state for those network ID's
	
	[_aXIMPlayers,_bXIMCombatState] call fncXIM_MusicRemote;
};


"XIM_oSender" addPublicVariableEventHandler 
{
	private _oXIMSender = _this select 1; //Store array in variable
	private _senderID = owner _oXIMSender;
	ximnearestenemy = _oXIMSender findNearestEnemy _oXIMSender;


	XIM_oEnemy = ximnearestenemy; //Assign to missionNamespace var
	_senderID publicVariableClient "XIM_oEnemy";
};