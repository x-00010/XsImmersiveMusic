// This executes on the client when they are playing singleplayer

// Below is the creation of arrays, that contain classnames of music tracks defined in config.cpp, randomized to make it fresh each time;
aCombatMusicClassnames = "'intense' in getArray (_x >> 'moods') " configClasses (configFile >> "CfgMusic") apply {configName _x} call BIS_fnc_arrayShuffle;
aDarkMusicClassnames = "'dark' in getArray (_x >> 'moods') " configClasses (configFile >> "CfgMusic") apply {configName _x} call BIS_fnc_arrayShuffle;
aCalmMusicClassnames = "'calm' in getArray (_x >> 'moods') " configClasses (configFile >> "CfgMusic") apply {configName _x} call BIS_fnc_arrayShuffle;

[{missionNameSpace setVariable ["ace_common_allowFadeMusic",false,true];}, [], 5] call CBA_fnc_waitAndExecute;

// ======================================== FUNCTIONS ========================================

XIM_fncMain = 
{
	params["_oFiringAI"];
	[_oFiringAI, player] call XIM_fncIteratePlayerCombat;
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

XIM_fncSendGroup = // submits the provided unit's group to the server plus the unit's combat state, which triggers the publicVariable event handler
{
	params["_oPlayer"]; // defines the parameter _aPlayerMachineIDs in position zero
	[group _oPlayer,_oPlayer getVariable ["XIM_bCombat", false],"statechange"] call fncXIM_MusicRemote;
};

XIM_fncPlayNext = // submits the provided unit's group to the server plus the unit's combat state, which triggers the publicVariable event handler
{
	params["_oPlayer"]; // defines the parameter _aPlayerMachineIDs in position zero
	[group _oPlayer,_oPlayer getVariable ["XIM_bCombat", false],"next"] call fncXIM_MusicRemote;
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

// ======================================== MUSIC FUNCTIONS ========================================

fncXIM_MusicHandler = { // defines the fncXIM_MusicHandler function, which disables ace's volume interference for the group, plays a certain type of music based on the parameter, and then reenables ace's volume interference for that same group
	params ["_groupOwnerIDs","_musictype"];
	XIM_groupOwnerIDs = _groupOwnerIDs; //Global for use in CBA function
	missionNameSpace setVariable ["ace_hearing_disableVolumeUpdate",true,XIM_groupOwnerIDs]; //Disable ACE interference
	XIM_trackname = [_musictype] call fncXIM_TrackSelect; // select a random track from the given music type

	
	[10,0] remoteExecCall ["fadeMusic",XIM_groupOwnerIDs,false]; //Fades currently playing music
	[{[XIM_trackname] remoteExecCall ["playMusic", XIM_groupOwnerIDs, false];[10,1] remoteExecCall ["fadeMusic",XIM_groupOwnerIDs,false];},[], 10] call CBA_fnc_waitAndExecute;
	[{missionNameSpace setVariable ["ace_hearing_disableVolumeUpdate",false,XIM_groupOwnerIDs];},[], 30] call CBA_fnc_waitAndExecute; //Wait 30 seconds, then enable ACE Volume Update again (earplugs, deafened,...)

	
};

fncXIM_TrackSelect = {
	params ["_musictype"];
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
	XIM_groupOwnerIDs = _groupOwnerIDs;
	_trackname = [_musictype] call fncXIM_TrackSelect; // select a random track from the given music type
	[0,0] remoteExecCall ["fadeMusic",XIM_groupOwnerIDs,false];
	[_trackname] remoteExecCall ["playMusic", XIM_groupOwnerIDs, false]; // plays the selected song on all clients in the group
	[10,1] remoteExecCall ["fadeMusic",XIM_groupOwnerIDs,false];
};


fncXIM_MusicRemote = {
	params ["_gXIMGroup", "_bXIMCombatState","_XIMMusicRemoteFunction"]; //Defining params
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

// ======================================== INIT ========================================

player setVariable ["XIM_bCombat", false]; // set the XIM_bCombat variable on the client, with the default value of false
player setVariable ["XIM_bCombatMaster", false]; // set the XIM_bCombatMaster variable on the client, with the default value of false
[player] call XIM_fncSendGroup; // calls the XIM_fncSendGroup function with the argument player
[player] call XIM_fncCombatTimeout; // calls the XIM_fncCombatTimeout function with the argument player

// ======================================== EVENT HANDLERS ========================================

["ace_firedNonPlayer", XIM_fncMain] call CBA_fnc_addEventHandler; // adds event handler for when an AI fires

["ace_firedNonPlayerVehicle", XIM_fncMain] call CBA_fnc_addEventHandler; // adds event handler for when an AI fires inside a vehicle

addMusicEventHandler ["MusicStart", {
	if (XIM_bNowPlayingEnabled) then
	{
		private _trackname = getText (configFile >> "CfgMusic" >> _this select 0 >> "name");
		private _artistname = getText (configFile >> "CfgMusic" >> _this select 0 >> "artist");
		[parseText format["Now playing<br/><t font='PuristaBold' size='1.6'>%1</t><br/><t font='PuristaBold' size='0.8'>%2</t>", _trackname,_artistname], true, nil, 5, 1, 0] spawn BIS_fnc_textTiles;
	};
}];

addMusicEventHandler ["MusicStop", // once the currently playing track has finished playing
{
	[player] call XIM_fncPlayNext;
}];