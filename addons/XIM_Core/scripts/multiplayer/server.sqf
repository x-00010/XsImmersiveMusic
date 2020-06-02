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

// ======================================== LOGIC FUNCTIONS ========================================

XIM_fncMain = 
{
	{
		params["_oFiringAI"]; // defines the parameter of _oFiringAI in argument position zero
		[_oFiringAI, _x] call XIM_fncIteratePlayerCombat; // call XIM_fncIteratePlayerCombat, with _oFiringAI and currently iterated player as arguments
	} forEach (allPlayers - entities "HeadlessClient_F"); // for every player, except headless clients
};

XIM_fncSendIDs = // submits the provided array of machine IDs to the server plus a true for the combat state, which triggers the publicVariable event handler
{
	params["_aPlayerMachineIDs", "_oPlayer"]; // defines the parameter _aPlayerMachineIDs in position zero
	XIM_aStateChange = []; // defines XIM_aStateChange, which is an empty array
	XIM_aStateChange append [_aPlayerMachineIDs]; // adds the _aPlayerMachineIDs array to XIM_aStateChange at position zero
	XIM_aStateChange pushBack (_oPlayer getVariable "XIM_bCombat"); // adds the value of XIM_bCombat to the XIM_aStateChange array at position one
	publicVariableServer "XIM_aStateChange"; // sends the XIM_aStateChange variable to the server via its namespace
};

XIM_fncWatchPlayers = // this function gets the machine IDs of all players within a 500m radius of the argument, calls XIM_fncSendIDs with the array of the players
						// as the argument and then checks all of the players within 500m of the argument again every 5 seconds. 
						// if a new player has entered the 500m radius, then XIM_fncSendIDs is called, with the array containing the latest player machine IDs as the
						// argument.
{
	params["_oPlayer"]; // defines the parameter _oPlayer in position zero
	private _bUpdateCombat = false; // defines the _bUpdateCombat variable, which is false by default
	private _aPlayerMachineIDs = []; // defines the array _aPlayerMachineIDs, which is empty
	if (isNil{_oPlayer getVariable "XIM_bIterating"}) then // if XIM_bIterating is not defined on that player
	{
		{
			if (_oPlayer distance _x <= 500) then // if the distance between the player currently being iterated in the outermost loop and the player currently being iterated in the innermost loop is less than or equal to 500
			{
				private _iPlayerID = owner _x; // assign _iPlayerID to the machine ID of the player who is selected
				_aPlayerMachineIDs pushBack _iPlayerID; // add the player's machine ID to the _aPlayerMachineIDs array
			};
		} forEach (allPlayers - entities "HeadlessClient_F"); // for every player, except headless clients
		_aPlayerMachineIDs sort true; // sort _aPlayerMachineIDs in ascending order
		[_aPlayerMachineIDs, _oPlayer] call XIM_fncSendIDs; // call XIM_fncSendIDs with the argument _aPlayerMachineIDs
		_oPlayer setVariable ["XIM_bIterating", true]; // define the variable XIM_bIterating on the player, and set it to true
	};
	[_aPlayerMachineIDs, _oPlayer] spawn // adds the following code to the scheduler, with the arguments _aPlayerMachineIDs and _oPlayer
	{
		params ["_aPlayerMachineIDs", "_oPlayer"]; // defines the variables _aPlayerMachineIDs and _oPlayer
		waitUntil // loop forever
		{
			private _aRecentPlayerMachineIDs = []; // declares _aRecentPlayerMachineIDs, which is an empty array
			private _bUpdateCombat = false;
			sleep 5; // wait 5 seconds
			{
				if (_oPlayer distance _x <= 500) then // if the distance between the player currently being iterated in the outermost loop and the player currently being iterated in the innermost loop is less than or equal to 500
				{
					private _iPlayerID = owner _x; // assign _iPlayerID to the machine ID of the player who is selected
					_aRecentPlayerMachineIDs pushBack _iPlayerID; // add the player's machine ID to the _aPlayerMachineIDs array
				};
			} forEach (allPlayers - entities "HeadlessClient_F"); // for every player, except headless clients
			_aRecentPlayerMachineIDs sort true; // sort _aRecentPlayerMachineIDs in ascending order
			if (!(_aPlayerMachineIDs isEqualTo _aRecentPlayerMachineIDs)) then // if the arrays are not completely identical
			{
				{
					_iRecentMachineID = _x; // assign the currently selected machine ID to _iRecentMachineID, so it can be used in a findIf
					if (_aPlayerMachineIDs findIf {_x  = _iRecentMachineID} == -1) then // if the selected ID from the _aRecentPlayerMachineIDs array is not in _aPlayerMachineIDs
					{
						_bUpdateCombat = true; // then change _bUpdateCombat to true
					};
				} forEach _aRecentPlayerMachineIDs // for every entry in the _aRecentPlayerMachineIDs array
			};
			if (_bUpdateCombat) then // if _bUpdateCombat is true
			{
				[_aRecentPlayerMachineIDs, _oPlayer] call XIM_fncSendIDs; // call the XIM_fncSendIDs function with the argument _aRecentPlayerMachineIDs
			};
			_aPlayerMachineIDs = _aRecentPlayerMachineIDs; // set the value of _aPlayerMachineIDs to _aRecentPlayerMachineIDs
			XIM_aPlayerMachineIDs = _aPlayerMachineIDs;
			false;
		};
	};
};

XIM_fncIteratePlayerCombat = // defines the XIM_fncIteratePlayers function, which iterates through each player and determines if they are in combat
{
	params ["_oFiringAI", "_oPlayer"]; // defines _oFiringAI, which is the object of the AI who fired

	if (!(_oPlayer getVariable "XIM_bCombat")) then // if the client is not already in combat
	{
		if (alive _oPlayer) then // if the player is not dead
		{
			if (_oPlayer distance _oFiringAI <= 500) then // if the distance to the AI who is firing is less than or equal to 500 metres
			{
				_oPlayer setVariable ["XIM_bCombat", true]; // set the player's combat variable to true
				[XIM_aPlayerMachineIDs, _oPlayer] call XIM_fncSendIDs; // call XIM_fncSendIDs with the argument _aPlayerMachineIDs
			};
		};
	};
};

// ======================================MUSIC FUNCTIONS================================================

fncXIM_MusicHandler = { // defines the fncXIM_MusicHandler function, which disables ace's volume interference for the group, plays a certain type of music based on the parameter, and then reenables ace's volume interference for that same group
	params ["_aXIMPlayers","_musictype"];
	XIM_aPlayers = _aXIMPlayers;

	missionNameSpace setVariable ["ace_hearing_disableVolumeUpdate",true,XIM_aPlayers]; //Disable ACE interference
	XIM_trackname = [_musictype] call fncXIM_TrackSelect;

	
	[5,0] remoteExecCall ["fadeMusic",XIM_aPlayers,false]; //Fades currently playing music, if there is a track playing
	[{[XIM_trackname] remoteExecCall ["playMusic", XIM_aPlayers, false];},[], 5] call CBA_fnc_waitAndExecute;
	[5,1] remoteExecCall ["fadeMusic",XIM_aPlayers,false];

	[{missionNameSpace setVariable ["ace_hearing_disableVolumeUpdate",false,XIM_aPlayers];},[], 15] call CBA_fnc_waitAndExecute; //Wait 15 seconds, then enable ACE Volume Update again (earplugs, deafened,...)
};

fncXIM_TrackSelect = {
	params ["_musictype"];
	private _trackclassname = "";

	switch (_musictype) do { 
		case "combat" : { _trackclassname = selectRandom aCombatMusicClassnames; }; 
		case "dark" : { _trackclassname = selectRandom aDarkMusicClassnames;}; 
		case "calm" : { _trackclassname = selectRandom aCalmMusicClassnames; }; 
	};
	
	_trackclassname; //Return classname

};

fncXIM_Shuffler = {
	params ["_aXIMPlayers","_musictype"];
	private _groupOwnerIDs = [];
	(units _gXIMPlayNextForGroup) apply {_groupOwnerIDs pushBackUnique (owner _x)}; //Retrieving ID's for players in group
 
	_trackname = [_musictype] call fncXIM_TrackSelect;

	[_trackname] remoteExecCall ["playMusic", _groupOwnerIDs, false];
	[5,1] remoteExecCall ["fadeMusic",_groupOwnerIDs,false];
	[{missionNameSpace setVariable ["ace_hearing_disableVolumeUpdate",false,_groupOwnerIDs];},[], 10] call CBA_fnc_waitAndExecute; //Wait 10 seconds, then enable ACE Volume Update again (earplugs, deafened,...)
};


fncXIM_MusicRemote = {
	params ["_gXIMGroup", "_bXIMCombatState","_XIMMusicRemoteFunction"]; //Defining params
	private _groupOwnerIDs = [];
	(units _gXIMGroup) apply {_groupOwnerIDs pushBackUnique (owner _x)}; //Retrieving ID's for players in group
	private _sXIM_MusicType = "";

	if (_bXIMCombatState) then {

		_sXIM_MusicType = "combat";
				
	} else {
		private _sunrisesunset = date call BIS_fnc_sunriseSunsetTime;
		private _sunrise = _sunrisesunset select 0;
		private _sunset = _sunrisesunset select 1;

		if ((rain > 0.2) or (fog > 0.2) or ((daytime > _sunset) and (daytime < _sunrise))) then {

			_sXIM_MusicType = "dark";
	  	} else {

	  		_sXIM_MusicType = "calm";
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
	player setVariable ["XIM_bCombat", false]; // broadcast the XIM_bCombat variable, with the default value of false
	[player] call XIM_fncWatchPlayers; // calls the XIM_fncWatchPlayers function with the argument _owner
}];

["ace_firedNonPlayer", XIM_fncMain] call CBA_fnc_addEventHandler; // adds event handler for when an AI fires

"XIM_aStateChange" addPublicVariableEventHandler 
{
	private _aXIMstatechange = _this select 1; //Store array in variable
	private _gXIMPlayers = _aXIMstatechange select 0; //Retrieve network ID's
	private _bXIMCombatState = _aXIMstatechange select 1; //Retrieve combat state for those network ID's
	[_gXIMPlayers,_bXIMCombatState,"statechange"] call fncXIM_MusicRemote;
};

"XIM_aPlayNext" addPublicVariableEventHandler {
//Detects broadcast from group leader that tells server to play next track for his group
	private _aXIMPlayNext = _this select 1;
	private _gXIMGroup = _aXIMPlayNextForGroup select 0;
	private _bXIMCombatState = _aXIMPlayNextForGroup select 1;
	
	[_gXIMGroup,_bXIMCombatState,"next"] call fncXIM_MusicRemote;
};
"XIM_oSender" addPublicVariableEventHandler 
{
	private _oXIMSender = _this select 1; //Store array in variable
	private _senderID = owner _oXIMSender;
	ximnearestenemy = _oXIMSender findNearestEnemy _oXIMSender;


	XIM_oEnemy = ximnearestenemy; //Assign to missionNamespace var
	_senderID publicVariableClient "XIM_oEnemy";
};