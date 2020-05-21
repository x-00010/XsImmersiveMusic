// This script is executed on either the player host (non-dedicated) or a dedicated server


// Below is the creation of arrays, that contain classnames of music tracks defined in config.cpp, randomized to make it fresh each time;
aCombatMusicClassnames = "'intense' in getArray (_x >> 'moods') " configClasses (configFile >> "CfgMusic") apply {configName _x} call BIS_fnc_arrayShuffle;
aDarkMusicClassnames = "'dark' in getArray (_x >> 'moods') " configClasses (configFile >> "CfgMusic") apply {configName _x} call BIS_fnc_arrayShuffle;
aCalmMusicClassnames = "'calm' in getArray (_x >> 'moods') " configClasses (configFile >> "CfgMusic") apply {configName _x} call BIS_fnc_arrayShuffle;

["initialize",[aDarkMusicClassnames,aCombatMusicClassnames,aCalmMusicClassnames]] remoteExecCall ["BIS_fnc_jukebox",-2,true]; //Init jukebox on clients + JIP



fncXIM_MusicRemote = {
	params ["_ximgroup", "_ximcombat"]; //Defining params
	private _groupOwnerIDs = [];
	(units _ximgroup) apply {_groupOwnerIDs pushBackUnique (owner _x)}; //Retrieving ID's for players in group

	if (_ximcombat) then {
		
		missionNameSpace setVariable ["ace_hearing_disableVolumeUpdate",true,_groupOwnerIDs];
		["forceBehaviour",["combat"]] remoteExecCall ["BIS_fnc_jukebox",_ximgroup]; //Change music type to intense ("combat")
		[{missionNameSpace setVariable ["ace_hearing_disableVolumeUpdate",false,_groupOwnerIDs];},[], 5] call CBA_fnc_waitAndExecute;
			
	} else {
		private _sunrisesunset = date call BIS_fnc_sunriseSunsetTime;
		private _sunrise = _sunrisesunset select 0;
		private _sunset = _sunrisesunset select 1;

		if ((rain > 0.2) or (fog > 0.2) or ((daytime > _sunset) and (daytime < _sunrise))) then {

  			missionNameSpace setVariable ["ace_hearing_disableVolumeUpdate",true,_groupOwnerIDs];
			["forceBehaviour",["stealth"]] remoteExecCall ["BIS_fnc_jukebox",_ximgroup]; //Change music type to dark ("stealth")
			[{missionNameSpace setVariable ["ace_hearing_disableVolumeUpdate",false,_groupOwnerIDs];},[], 5] call CBA_fnc_waitAndExecute;

		} else {

  			missionNameSpace setVariable ["ace_hearing_disableVolumeUpdate",true,_groupOwnerIDs];
			["forceBehaviour",["safe"]] remoteExecCall ["BIS_fnc_jukebox",_ximgroup]; //Change music type to calm ("safe")
			[{missionNameSpace setVariable ["ace_hearing_disableVolumeUpdate",false,_groupOwnerIDs];},[], 5] call CBA_fnc_waitAndExecute;

		};

	};	
};






  "XIM_aStateChange" addPublicVariableEventHandler {
  		private _aXIMstatechange = _this select 1; //Store array in variable
  		private _ximgroup = _aXIMstatechange select 0; //Retrieve group object
  		private _ximcombat = _aXIMstatechange select 1; //Retrieve combat state

  		if (_ximcombat) then {
  		  result = [_ximgroup,_ximcombat] call fncXIM_MusicRemote;

  		};

  	};

