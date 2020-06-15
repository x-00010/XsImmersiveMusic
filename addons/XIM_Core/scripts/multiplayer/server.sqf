// This script is executed on either the player host (non-dedicated) or a dedicated server


// Below is the creation of arrays, that contain classnames of music tracks defined in config.cpp, randomized to make it fresh each time;
aCombatMusicClassnames = "'intense' in getArray (_x >> 'moods') " configClasses (configFile >> "CfgMusic") apply {configName _x} call BIS_fnc_arrayShuffle;
aDarkMusicClassnames = "'dark' in getArray (_x >> 'moods') " configClasses (configFile >> "CfgMusic") apply {configName _x} call BIS_fnc_arrayShuffle;
aCalmMusicClassnames = "'calm' in getArray (_x >> 'moods') " configClasses (configFile >> "CfgMusic") apply {configName _x} call BIS_fnc_arrayShuffle;


// ======================================== LOGIC FUNCTIONS ========================================

XIM_fncMain = // this function calls XIM_fncIteratePlayerCombat every time a shot is fired for the combat master in that group
{
	{
		private _bCombatMasterExists = false; // defines _bCombatMasterExists, which is false by default
		params["_oFiringAI"]; // defines the parameter of _oFiringAI in argument position zero
		{
			if (_x getVariable ["XIM_bCombatMaster", false]) then // if the iterated unit is a combat master
			{
				_bCombatMasterExists = true; // set _bCombatMasterExists to true
			};
		} forEach (units (group _x)); // for every player in the player's group

		if ((!(_bCombatMasterExists)) or (_x getVariable ["XIM_bCombatMaster", false])) then // if the combat master does not exist, or the currently selected player
																							 // is a combat master then
		{
			[_oFiringAI, _x] call XIM_fncIteratePlayerCombat; // call XIM_fncIteratePlayerCombat, with _oFiringAI and currently iterated player as arguments
		};
	} forEach (allPlayers - entities "HeadlessClient_F"); // for every player, except headless clients
};

XIM_fncSendGroup = // submits the provided unit's group to the server plus the unit's combat state, which triggers the publicVariable event handler
{
	params["_oPlayer"]; // defines the parameter _aPlayerMachineIDs in position zero
	diag_log ("XIM: SendGroup called");
	XIM_aStateChange = []; // defines XIM_aStateChange, which is an empty array
	XIM_aStateChange pushBack group _oPlayer; // adds the player's group to XIM_aStateChange at position zero
	XIM_aStateChange pushBack (_oPlayer getVariable "XIM_bCombat"); // adds the value of XIM_bCombat to the XIM_aStateChange array at position one
	publicVariableServer "XIM_aStateChange"; // sends the XIM_aStateChange variable to the server via its namespace
	diag_log ("XIM: StateChange sent");
};

XIM_fncCombatTimeout = // this function determines whether the player has not had an AI fire near them in the past 5 mins, and if they have not, sets XIM_bCombat to
					   // false
{
	params["_oPlayer"]; // defines the parameter _oPlayer
	[_oPlayer] spawn // adds the following code to the scheduler
	{
		params["_oPlayer"]; // defines the parameter _oPlayer
		waitUntil // repeats the following code once every frame (ish)
		{
			private _bTimedOut = false; // declares _bTimedOut, which is false by default
			if (_oPlayer getVariable "XIM_bCombatMaster") then // if the player is the combat master for that group
			{
				_oPlayer setVariable ["XIM_bRecentCombat", false]; // set the player's recent combat variable to false
				sleep XIM_iCombatRefreshTime; // sleep for the value of XIM_iCombatRefreshTime, which is 120 seconds by default
				if (!(_oPlayer getVariable "XIM_bRecentCombat")) then // if XIM_bRecentCombat is still false after 2 minutes
				{
					_bTimedOut = true; // then set _bTimedOut to true
				};
			};
			if (_bTimedOut) then // if _bTimedOut is true
			{
				_oPlayer setVariable ["XIM_bCombatMaster", false]; // sets the player's combat master variable to false
				_oPlayer setVariable ["XIM_bCombat", false]; // sets the player's combat state to false
				[_oPlayer] call XIM_fncSendGroup; // calls the XIM_fncSendGroup function with the argument of _oPlayer
			};
			false; // makes the loop start all over again
		};
	};
};

XIM_fncIteratePlayerCombat = // defines the XIM_fncIteratePlayers function, which iterates through each player and determines if they are in combat
{
	params ["_oFiringAI", "_oPlayer"]; // defines _oFiringAI, which is the object of the AI who fired

	if (alive _oPlayer) then // if the player is not dead
	{
		if (_oPlayer distance _oFiringAI <= XIM_iCombatRange) then // if the distance to the AI who is firing is less than or equal to the value of XIM_iCombatRange,
																   // which is 500 metres by default
		{
			if (!(_oPlayer getVariable "XIM_bCombat")) then // if the player is not already in combat
			{
				_oPlayer setVariable ["XIM_bCombat", true]; // set the player's combat variable to true
				_oPlayer setVariable ["XIM_bCombatMaster", true]; // set the player's combat master variable to true
				[_oPlayer] call XIM_fncSendGroup; // call XIM_fncSendGroup with the argument _oPlayer
			}
			else // if the player is in combat
			{
				_oPlayer setVariable ["XIM_bRecentCombat", true]; // set the player's recent combat variable to true
			};
		};
	};
};

// ====================================== MUSIC FUNCTIONS ================================================

fncXIM_MusicHandler = { // defines the fncXIM_MusicHandler function, which disables ace's volume interference for the group, plays a certain type of music based on the parameter, and then reenables ace's volume interference for that same group
	params ["_groupOwnerIDs","_musictype"];
	diag_log ("XIM: MusicHandler called");
	XIM_groupOwnerIDs = _groupOwnerIDs; //Global for use in CBA function
	missionNameSpace setVariable ["ace_hearing_disableVolumeUpdate",true,XIM_groupOwnerIDs]; //Disable ACE interference
	XIM_trackname = [_musictype] call fncXIM_TrackSelect; // select a random track from the given music type

	
	[5,0] remoteExecCall ["fadeMusic",XIM_groupOwnerIDs,false]; //Fades currently playing music, if there is a track playing
	[{[XIM_trackname] remoteExecCall ["playMusic", XIM_groupOwnerIDs, false];},[], 5] call CBA_fnc_waitAndExecute;
	[5,1] remoteExecCall ["fadeMusic",XIM_groupOwnerIDs,false];

	[{missionNameSpace setVariable ["ace_hearing_disableVolumeUpdate",false,XIM_groupOwnerIDs];},[], 15] call CBA_fnc_waitAndExecute; //Wait 15 seconds, then enable ACE Volume Update again (earplugs, deafened,...)
};

fncXIM_TrackSelect = {
	params ["_musictype"];
	diag_log ("XIM: TrackSelect called");
	private _trackclassname = "";

	switch (_musictype) do { 
		case "combat" : { _trackclassname = selectRandom aCombatMusicClassnames; }; // select a random track from the aCombatMusicClassnames array
		case "dark" : { _trackclassname = selectRandom aDarkMusicClassnames;}; // select a random track from the aDarkMusicClassnames array
		case "calm" : { _trackclassname = selectRandom aCalmMusicClassnames; };  // select a random track from the aCalmMusicClassnames array
	};
	
	_trackclassname; //Return classname

};

fncXIM_Shuffler = {
	params ["_groupOwnerIDs","_musictype"];
	diag_log ("XIM: Shuffler called");
	XIM_groupOwnerIDs = _groupOwnerIDs;
	missionNameSpace setVariable ["ace_hearing_disableVolumeUpdate",true,XIM_groupOwnerIDs]; //Disable ACE interference
	_trackname = [_musictype] call fncXIM_TrackSelect; // select a random track from the given music type
	if (_trackname == "") then
	{
		diag_log ("XIM: Track name is empty!");
	};
	[0,0] remoteExecCall ["fadeMusic",XIM_groupOwnerIDs,false];
	[_trackname] remoteExecCall ["playMusic", XIM_groupOwnerIDs, false]; // plays the selected song on all clients in the group
	[5,1] remoteExecCall ["fadeMusic",XIM_groupOwnerIDs,false];
	[{missionNameSpace setVariable ["ace_hearing_disableVolumeUpdate",false,XIM_groupOwnerIDs];},[], 10] call CBA_fnc_waitAndExecute; //Wait 10 seconds, then enable ACE Volume Update again (earplugs, deafened,...)
};


fncXIM_MusicRemote = {
	params ["_gXIMGroup", "_bXIMCombatState","_XIMMusicRemoteFunction"]; //Defining params
	diag_log ("XIM: MusicRemote called");
	private _groupOwnerIDs = [];
	(units _gXIMGroup) apply {_groupOwnerIDs pushBackUnique (owner _x)}; //Retrieving ID's for players in group
	private _sXIM_MusicType = "";

	if (_bXIMCombatState) then { // if _bXIMCombatState is true

		_sXIM_MusicType = "combat"; // then set the music type to combat
				
	} else {
		private _sunrisesunset = date call BIS_fnc_sunriseSunsetTime;
		private _sunrise = _sunrisesunset select 0;
		private _sunset = _sunrisesunset select 1;

		if ((rain > 0.2) or (fog > 0.2) or ((daytime > _sunset) and (daytime < _sunrise))) then { // if it is foggy, raining or night time

			_sXIM_MusicType = "dark"; // set the music to dark
	  	} else {

	  		_sXIM_MusicType = "calm"; // otherwise set it to calm
		};

	};	

	switch (_XIMMusicRemoteFunction) do { 
		case "next" : {  [_groupOwnerIDs,_sXIM_MusicType] call fncXIM_Shuffler; }; 
		case "statechange" : { [_groupOwnerIDs,_sXIM_MusicType] call fncXIM_MusicHandler; }; 
	};

};

// ======================================== EVENT HANDLERS ========================================
addMissionEventHandler ["PlayerConnected", // when a player connects
{
	params ["_id", "_uid", "_name", "_jip", "_owner"]; // declares params
	diag_log ("XIM: Player has connected");
	private _oPlayer = objNull; // declares _oPlayer, which is objNull by default
	{
		if ((owner _x) == _owner) then // if the currently iterated player's owner has the same machine id as the player who just connected
		{
			_oPlayer = _x; // _oPlayer is equal to the currently iterated player
		};
	} forEach ((allPlayers - entities "HeadlessClient_F")); // for every player, except headless clients

	if (_oPlayer != objNull) then
	{
		_oPlayer setVariable ["XIM_bCombat", false]; // set the XIM_bCombat variable on the client, with the default value of false
		_oPlayer setVariable ["XIM_bCombatMaster", false]; // set the XIM_bCombatMaster variable on the client, with the default value of false
		diag_log ("XIM: Player variables have been set");
		sleep 1; // 
		if (leader (group _oPlayer) == _oPlayer) then // if the player is the leader of their group
		{
			diag_log ("XIM: Player is the leader of the group");
			[_oPlayer] call XIM_fncSendGroup; // calls the XIM_fncSendGroup function with the argument player
		};
		[_oPlayer] call XIM_fncCombatTimeout; // calls the XIM_fncCombatTimeout function with the argument player
	}
	else
	{
		diag_log("XIM - Error, could not determine player object from machine ID");
	};
}];

["ace_firedNonPlayer", XIM_fncMain] call CBA_fnc_addEventHandler; // adds event handler for when an AI fires

"XIM_aStateChange" addPublicVariableEventHandler  // detects a broadcast from the combat master, which contains the group and its combat state 
{
	diag_log ("XIM: StateChange recieved");
	private _aXIMstatechange = _this select 1; //Store array in variable
	private _gXIMGroup = _aXIMstatechange select 0; //Retrieve group
	private _bXIMCombatState = _aXIMstatechange select 1; //Retrieve combat state for those network ID's
	[_gXIMGroup,_bXIMCombatState,"statechange"] call fncXIM_MusicRemote;
};

"XIM_aPlayNext" addPublicVariableEventHandler { // detects broadcast from group leader that tells server to play next track for his group
	diag_log ("XIM: PlayNext recieved");
	private _aXIMPlayNext = _this select 1; //Retrieve array
	private _gXIMGroup = _aXIMPlayNext select 0; //Retrieve group
	private _bXIMCombatState = _aXIMPlayNext select 1; //Retrieve state
	
	[_gXIMGroup,_bXIMCombatState,"next"] call fncXIM_MusicRemote;
};