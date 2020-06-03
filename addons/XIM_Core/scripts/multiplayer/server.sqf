// This script is executed on either the player host (non-dedicated) or a dedicated server


// Below is the creation of arrays, that contain classnames of music tracks defined in config.cpp, randomized to make it fresh each time;
aCombatMusicClassnames = "'intense' in getArray (_x >> 'moods') " configClasses (configFile >> "CfgMusic") apply {configName _x} call BIS_fnc_arrayShuffle;
aDarkMusicClassnames = "'dark' in getArray (_x >> 'moods') " configClasses (configFile >> "CfgMusic") apply {configName _x} call BIS_fnc_arrayShuffle;
aCalmMusicClassnames = "'calm' in getArray (_x >> 'moods') " configClasses (configFile >> "CfgMusic") apply {configName _x} call BIS_fnc_arrayShuffle;



/*if (isDedicated) then {
  ["initialize",[aDarkMusicClassnames,aCombatMusicClassnames,aCalmMusicClassnames]] remoteExecCall ["BIS_fnc_jukebox",-2,true]; //Init jukebox on clients + JIP
} else {
  ["initialize",[aDarkMusicClassnames,aCombatMusicClassnames,aCalmMusicClassnames]] remoteExecCall ["BIS_fnc_jukebox",0,true]; //Init jukebox globally + JIP
};*/

// ======================================== LOGIC FUNCTIONS ========================================

XIM_fncMain = // this function calls XIM_fncIteratePlayerCombat every time a shot is fired for every single player on the server
{
	{
		private _bCombatMasterExists = false;
		params["_oFiringAI"]; // defines the parameter of _oFiringAI in argument position zero
		{
			if (_x getVariable ["XIM_bCombatMaster", false]) then
			{
				_bCombatMasterExists = true;
			};
		} forEach (units (group _x)); // for every player in the player's group

		if ((!(_bCombatMasterExists)) or (_x getVariable ["XIM_bCombatMaster", false])) then
		{
			[_oFiringAI, _x] call XIM_fncIteratePlayerCombat; // call XIM_fncIteratePlayerCombat, with _oFiringAI and currently iterated player as arguments
		};
	} forEach (allPlayers - entities "HeadlessClient_F"); // for every player, except headless clients
};

XIM_fncSendGroup = // submits the provided unit's group to the server plus the unit's combat state, which triggers the publicVariable event handler
{
	params["_oPlayer"]; // defines the parameter _aPlayerMachineIDs in position zero
	XIM_aStateChange = []; // defines XIM_aStateChange, which is an empty array
	XIM_aStateChange pushBack [group _oPlayer]; // adds the player's group to XIM_aStateChange at position zero
	XIM_aStateChange pushBack (_oPlayer getVariable "XIM_bCombat"); // adds the value of XIM_bCombat to the XIM_aStateChange array at position one
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
			private _bTimedOut = false;
			if (_oPlayer getVariable "XIM_bCombatMaster") then
			{
				_oPlayer setVariable ["XIM_bRecentCombat", false];
				if (!(_oPlayer getVariable "XIM_bRecentCombat")) then
				{
					sleep 300; // sleep for 5 minutes
					_bTimedOut = true;
				};

				if (_bTimedOut) then
				{
					_oPlayer setVariable ["XIM_bCombatMaster", false];
					_oPlayer setVariable ["XIM_bCombat", false]; // sets the player's XIM_bCombat to false
					[_oPlayer] call XIM_fncSendGroup;
				};
			};
			false;
		};
	};
};

XIM_fncIteratePlayerCombat = // defines the XIM_fncIteratePlayers function, which iterates through each player and determines if they are in combat
{
	params ["_oFiringAI", "_oPlayer"]; // defines _oFiringAI, which is the object of the AI who fired

	if (alive _oPlayer) then // if the player is not dead
	{
		if (_oPlayer distance _oFiringAI <= 500) then // if the distance to the AI who is firing is less than or equal to 500 metres
		{
			if (!(_oPlayer getVariable "XIM_bCombat")) then // if the player is not already in combat
			{
				_oPlayer setVariable ["XIM_bCombat", true]; // set the player's combat variable to true
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
	params ["_aXIMPlayers","_musictype"];
	XIM_aPlayers = _aXIMPlayers; //Global for use in CBA function

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
	params ["_gXIMGroup","_musictype"];
	private _groupOwnerIDs = [];

	(units _gXIMGroup) apply {_groupOwnerIDs pushBackUnique (owner _x)}; //Retrieving ID's for players in group
	XIM_groupOwnerIDs = _groupOwnerIDs;

	_trackname = [_musictype] call fncXIM_TrackSelect;
	[0,0] remoteExecCall ["fadeMusic",_groupOwnerIDs,false];
	[_trackname] remoteExecCall ["playMusic", _groupOwnerIDs, false];
	[5,1] remoteExecCall ["fadeMusic",_groupOwnerIDs,false];
	[{missionNameSpace setVariable ["ace_hearing_disableVolumeUpdate",false,XIM_groupOwnerIDs];},[], 10] call CBA_fnc_waitAndExecute; //Wait 10 seconds, then enable ACE Volume Update again (earplugs, deafened,...)
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

// ======================================== LOOP ========================================

waitUntil
{
	{
		if (_x == leader group _x) then
		{
			{
				
			} forEach ((units group _x) - _x)
		};
	} forEach (allPlayers - entities "HeadlessClient_F");
	false;
};

// ======================================== EVENT HANDLERS ========================================
addMissionEventHandler ["PlayerConnected", // when a player connects
{
	player setVariable ["XIM_bCombat", false]; // set the XIM_bCombat variable on the client, with the default value of false
	player setVariable ["XIM_bCombatMaster", false]; // set the XIM_bCombatMaster variable on the client, with the default value of false
	[player] call XIM_fncCombatTimeout; // calls the XIM_fncCombatTimeout function with the argument player
}];

["ace_firedNonPlayer", XIM_fncMain] call CBA_fnc_addEventHandler; // adds event handler for when an AI fires

"XIM_aStateChange" addPublicVariableEventHandler 
{
	private _aXIMstatechange = _this select 1; //Store array in variable
	private _gXIMGroup = _aXIMstatechange select 0; //Retrieve network ID's
	private _bXIMCombatState = _aXIMstatechange select 1; //Retrieve combat state for those network ID's
	[_gXIMGroup,_bXIMCombatState,"statechange"] call fncXIM_MusicRemote;
};

"XIM_aPlayNext" addPublicVariableEventHandler {
//Detects broadcast from group leader that tells server to play next track for his group
	private _aXIMPlayNext = _this select 1;
	private _gXIMGroup = _aXIMPlayNext select 0;
	private _bXIMCombatState = _aXIMPlayNext select 1;
	
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