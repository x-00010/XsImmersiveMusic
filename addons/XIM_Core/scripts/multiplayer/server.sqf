// This script is executed on either the player host (non-dedicated) or a dedicated server

#define XIM_const_CALM "calm"
#define XIM_const_COMBAT "combat"
#define XIM_const_DARK "dark"
// Below is the creation of arrays, that contain classnames of music tracks defined in config.cpp, randomized to make it fresh each time;
XIM_aCombatMusicClassnames = "'intense' in getArray (_x >> 'moods') " configClasses (configFile >> "CfgMusic") apply {configName _x} call BIS_fnc_arrayShuffle;
XIM_aDarkMusicClassnames = "'dark' in getArray (_x >> 'moods') " configClasses (configFile >> "CfgMusic") apply {configName _x} call BIS_fnc_arrayShuffle;
XIM_aCalmMusicClassnames = "'calm' in getArray (_x >> 'moods') " configClasses (configFile >> "CfgMusic") apply {configName _x} call BIS_fnc_arrayShuffle;

XIM_aMusicClassnames = [XIM_aCombatMusicClassnames,XIM_aDarkMusicClassnames,XIM_aCalmMusicClassnames];

XIM_aCombatMusicClassnames = nil;
XIM_aDarkMusicClassnames = nil;
XIM_aCalmMusicClassnames = nil;



[{missionNameSpace setVariable ["ace_common_allowFadeMusic",false,true];}, [], 5] call CBA_fnc_waitAndExecute; // disabled allowFadeMusic in ace options, fixes lots
																											   // of problems with fadeMusic and ACE

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
	XIM_aStateChange = []; // defines XIM_aStateChange, which is an empty array
	XIM_aStateChange pushBack group _oPlayer; // adds the player's group to XIM_aStateChange at position zero
	XIM_aStateChange pushBack (_oPlayer getVariable ["XIM_bCombat", false]); // adds the value of XIM_bCombat to the XIM_aStateChange array at position one
	publicVariableServer "XIM_aStateChange"; // sends the XIM_aStateChange variable to the server via its namespace
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
			sleep 1;
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

fncXIM_MusicHandler = { // defines the fncXIM_MusicHandler function, which plays a certain type of music based on the parameter
	params ["_groupOwnerIDs","_musictype"];
	_trackname = [_musictype] call fncXIM_TrackSelect; // select a random track from the given music type

	
	[10,0] remoteExecCall ["fadeMusic",_groupOwnerIDs,false]; //Fades currently playing music
	[{params["_trackname", "_groupOwnerIDs"]; [_trackname] remoteExecCall ["playMusic", _groupOwnerIDs, false];[10,1] remoteExecCall ["fadeMusic",_groupOwnerIDs,false];},[_trackname, _groupOwnerIDs], 10] call CBA_fnc_waitAndExecute; //After fade-out, fade-in next track
};

fncXIM_TrackSelect = {
	params ["_musictype"];
	private _trackclassname = ""; // declare the empty string _trackclassname



	switch (_musictype) do { 
		case XIM_const_COMBAT : { _trackclassname = selectRandom XIM_aMusicClassnames[0]; }; // select a random track from the XIM_aCombatMusicClassnames array
		case XIM_const_DARK : { _trackclassname = selectRandom XIM_aMusicClassnames[1]; }; // select a random track from the XIM_aDarkMusicClassnames array
		case XIM_const_CALM : { _trackclassname = selectRandom XIM_aMusicClassnames[2]; };  // select a random track from the XIM_aCalmMusicClassnames array
	};
	
	_trackclassname; //Return classname

};

fncXIM_Shuffler = {
	params ["_groupOwnerIDs","_musictype","_bXIMCombatState","_gXIMGroup"];
	_trackname = [_musictype] call fncXIM_TrackSelect; // select a random track from the given music type
	[0,0] remoteExecCall ["fadeMusic",_groupOwnerIDs,false]; // set music volume to zero for fading back in later

	if (XIM_bMusicDelayEnabled) then // if the music delay is enabled
	{
		_iRandomDelay = random 1 * (XIM_iMaxMusicDelay - XIM_iMinMusicDelay) + XIM_iMinMusicDelay; // calculates a random delay value using the specified min and max values
																								   // specified by the server from the CBA settings and the calculated mean
		_oGroupLeader = leader _gXIMGroup; // finds the leader of the _gXIMGroup group

		[{params["_trackname","_oGroupLeader", "_bXIMCombatState", "_groupOwnerIDs"]; if (_bXIMCombatState == _oGroupLeader getVariable ["XIM_bCombat", false]) then {[_trackname] remoteExecCall ["playMusic", _groupOwnerIDs, false]; [10,1] remoteExecCall ["fadeMusic",_groupOwnerIDs,false];};},[_trackname, _oGroupLeader, _bXIMCombatState, _groupOwnerIDs], _iRandomDelay] call CBA_fnc_waitAndExecute;
		// if the combat state after the random delay is still the same, then play the next song. this is to prevent an edge case where a group leader requests a
		// new song and then goes into combat soon after, effectively being in combat with a calm category song.
	}
	else // if the music delay is disabled
	{
		[_trackname] remoteExecCall ["playMusic", _groupOwnerIDs, false]; // plays the selected song on all clients in the group
		[10,1] remoteExecCall ["fadeMusic",_groupOwnerIDs,false]; // fade in next track
	};
};

fncXIM_MusicRemote = {
	params ["_gXIMGroup", "_bXIMCombatState","_XIMMusicRemoteFunction"]; //Defining params
	private _groupOwnerIDs = []; // declare the empty array _groupOwnerIDs

	if (!(_gXIMGroup getVariable ["XIM_bMusicStopped", false])) then // if XIM_bMusicStopped is false
	{
		(units _gXIMGroup) apply {_groupOwnerIDs pushBackUnique (owner _x)}; //Retrieving ID's for players in group
		private _sXIM_MusicType = ""; // declare the empty string _sXIM_MusicType

		if (_bXIMCombatState) then { // if _bXIMCombatState is true

			if (XIM_bCombatMusicEnabled) then // if combat music is enabled in the cba settings
			{
				_sXIM_MusicType = COMBAT; // then set the music type to combat
			};
					
		} else {
			private _sunrisesunset = date call BIS_fnc_sunriseSunsetTime;
			private _sunrise = _sunrisesunset select 0;
			private _sunset = _sunrisesunset select 1;

			if ((rain > 0.2) or (fog > 0.2) or ((daytime > _sunset) and (daytime < _sunrise))) then { // if it is foggy, raining or night time

				if (XIM_bStealthMusicEnabled) then // if stealth music is enabled in the cba settings
				{
					_sXIM_MusicType = DARK; // set the music to dark
				};
			} else {

				if (XIM_bCalmMusicEnabled) then // if calm music is enabled in the cba settings
				{
					_sXIM_MusicType = CALM; // otherwise set it to calm
				};
			};

		};	

		if (!(_sXIM_MusicType == "")) then // if _sXIM_MusicType is not an empty string
		{
			switch (_XIMMusicRemoteFunction) do { 
				case "next" : {  [_groupOwnerIDs,_sXIM_MusicType,_bXIMCombatState,_gXIMGroup] call fncXIM_Shuffler; }; // if the function was called with next, then
																													   // execute fncXIM_Shuffler
				case "statechange" : { [_groupOwnerIDs,_sXIM_MusicType] call fncXIM_MusicHandler; }; // if the function was called with statechange, then execute
																									 // fncXIM_MusicHandler
			};
		};
	};
};

// ======================================== EVENT HANDLERS ========================================
addMissionEventHandler ["PlayerConnected", // when a player connects
{
	params ["_id", "_uid", "_name", "_jip", "_owner"]; // declares params
	[_owner] spawn
	{
		params ["_owner"];
		private _oPlayer = objNull; // declares _oPlayer, which is objNull by default
		waitUntil
		{
			sleep 1; // sleep for one second
			{
				if ((owner _x) == _owner) then // if the currently iterated player's owner has the same machine id as the player who just connected
				{
					_oPlayer = _x; // _oPlayer is equal to the currently iterated player
				};
			} forEach (allPlayers - entities "HeadlessClient_F"); // for every player, except headless clients

			if (!isNull _oPlayer) then // if the _oPlayer object is not set to null
			{
				_oPlayer setVariable ["XIM_bCombat", false]; // set the XIM_bCombat variable on the client, with the default value of false
				_oPlayer setVariable ["XIM_bCombatMaster", false]; // set the XIM_bCombatMaster variable on the client, with the default value of false
				[_oPlayer] call XIM_fncSendGroup; // calls the XIM_fncSendGroup function with the argument player
				[_oPlayer] call XIM_fncCombatTimeout; // calls the XIM_fncCombatTimeout function with the argument player
			};
			if (!isNull _oPlayer) exitWith {true}; // if the _oPlayer object is not set to null, exit and return true
			false; // else exit and return false
		};	
	};
}];

["ace_firedNonPlayer", XIM_fncMain] call CBA_fnc_addEventHandler; // adds event handler for when an AI fires

["ace_firedNonPlayerVehicle", XIM_fncMain] call CBA_fnc_addEventHandler; // adds event handler for when an AI fires inside a vehicle

"XIM_aStateChange" addPublicVariableEventHandler  // detects a broadcast from the combat master, which contains the group and its combat state 
{
	private _aXIMstatechange = _this select 1; //Store array in variable
	private _gXIMGroup = _aXIMstatechange select 0; //Retrieve group
	private _bXIMCombatState = _aXIMstatechange select 1; //Retrieve combat state for those network ID's
	[_gXIMGroup,_bXIMCombatState,"statechange"] call fncXIM_MusicRemote;
};

"XIM_aPlayNext" addPublicVariableEventHandler { // detects broadcast from group leader that tells server to play next track for his group
	private _aXIMPlayNext = _this select 1; // retrieve array
	private _gXIMGroup = _aXIMPlayNext select 0; // retrieve group
	private _oXIMGroupLeader = _aXIMPlayNext select 1; // retrieve leader
	private _bXIMCombatState = _oXIMGroupLeader getVariable ["XIM_bCombat", false]; // retrieve XIM_bCombat variable from _oXIMGroupLeader
	
	[_gXIMGroup,_bXIMCombatState,"next"] call fncXIM_MusicRemote; // call fncXIM_MusicRemote with _gXIMGroup, _bXIMCombatState and "next" as arguments
};