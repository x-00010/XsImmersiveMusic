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

// finch your code looks fucking gross mate ~jake
XIM_fncIteratePlayers = // defines the XIM_fncIteratePlayers function, which iterates through each player
{
	{
		params["_oFiringAI"]; // defines _oFiringAI, which is the object of the AI who fired
		[_oFiringAI, _x] call XIM_fncEvaluateCombat; // calls the XIM_fncEvaluateCombat function, with _oFiringAI as the first argument, and the player's object as the second

		if (_x getVariable ["XIM_bCombat", true] == true) then // if XIM_fncEvaluateCombat returned true
		{
			private _oPlayer = _x;
			private _aPlayerNetIds = [];
			{
				if (_oPlayer distance _x <= 500) then // if the distance between the player currently being iterated in the outermost loop and the player currently being iterated in the innermost loop is less than or equal to 500
				{
					_sPlayerID = NetId _x;
					_aPlayerNetIds pushBack _sPlayerID;
				};
			} forEach allPlayers - entities "HeadlessClient_F";
		};
	} forEach allPlayers - entities "HeadlessClient_F"; // for every single player, excluding headless clients
};

XIM_fncEvaluateCombat = // defines XIM_fncEvaluateCombat, which checks if the player can move, before checking if they are within 500m of the argument, and returning true if they are, else returning false
{
	params ["_oFiringAI", "_oPlayer"]; // defines _oFiringAI, which is the object of the AI who fired

	if (alive _oPlayer) then // if the player is not dead
	{
		if (_oPlayer distance _oFiringAI <= 500) then // if the distance to the AI who is firing is less than or equal to 500 metres
		{
			_oPlayer setVariable ["XIM_bCombat", true];
		};
	};
};

fncXIM_MusicHandler = { // defines the fncXIM_MusicHandler function, which disables ace's volume interference for the group, plays a certain type of music based on the parameter, and then reenables ace's volume interference for that same group
	params ["_groupOwnerIDs","_musictype"];

	missionNameSpace setVariable ["ace_hearing_disableVolumeUpdate",true,_groupOwnerIDs]; //Disable ACE interference
	["forceBehaviour",[_musictype]] remoteExecCall ["BIS_fnc_jukebox",_groupOwnerIDs]; //Changes music type based on passed parameter
	XIM_GroupOwnerIDs = _groupOwnerIDs;
	[{missionNameSpace setVariable ["ace_hearing_disableVolumeUpdate",false,XIM_GroupOwnerIDs];},[], 15] call CBA_fnc_waitAndExecute;
};


fncXIM_MusicRemote = {
	params ["_ximgroup", "_ximcombat"]; //Defining params
	private _groupOwnerIDs = [];
	(units _ximgroup) apply {_groupOwnerIDs pushBackUnique (owner _x)}; //Retrieving ID's for players in group
	if (_ximcombat) then {

		[_groupOwnerIDs,"combat"] spawn fncXIM_MusicHandler; //Set music to type combat
			
	} else {
		private _sunrisesunset = date call BIS_fnc_sunriseSunsetTime;
		private _sunrise = _sunrisesunset select 0;
		private _sunset = _sunrisesunset select 1;

		if ((rain > 0.2) or (fog > 0.2) or ((daytime > _sunset) and (daytime < _sunrise))) then {

			[_groupOwnerIDs,"stealth"] spawn fncXIM_MusicHandler; //Set music to type stealth (dark)
  			
		} else {

  			[_groupOwnerIDs,"safe"] spawn fncXIM_MusicHandler; //Set music to type safe

		};

	};	
};

// ======================================== EVENT HANDLERS ========================================
onPlayerConnected
{
	
};

["ace_firedNonPlayer", [this select 0] call XIM_fncIteratePlayers] call CBA_fnc_addEventHandler; // adds event handler for when an AI fires

"XIM_aStateChange" addPublicVariableEventHandler 
{
	private _aXIMstatechange = _this select 1; //Store array in variable
	private _ximgroup = _aXIMstatechange select 0; //Retrieve group object
	private _ximcombat = _aXIMstatechange select 1; //Retrieve combat state
	
	[_ximgroup,_ximcombat] call fncXIM_MusicRemote;
};


"XIM_oSender" addPublicVariableEventHandler 
{
	private _oXIMSender = _this select 1; //Store array in variable
	private _senderID = owner _oXIMSender;
	ximnearestenemy = _oXIMSender findNearestEnemy _oXIMSender;


	XIM_oEnemy = ximnearestenemy; //Assign to missionNamespace var
	_senderID publicVariableClient "XIM_oEnemy";
};