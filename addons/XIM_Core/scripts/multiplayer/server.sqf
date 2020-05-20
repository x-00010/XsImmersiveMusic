// This script is executed on either the player host (non-dedicated) or a dedicated server

["ace_hearing_disableVolumeUpdate",true] remoteExec ["setVariable",-2,true]; //Disable ace interference

// Below is the creation of arrays, that contain classnames of music tracks defined in config.cpp, randomized to make it fresh each time;
aCombatMusicClassnames = "'intense' in getArray (_x >> 'moods') " configClasses (configFile >> "CfgMusic") apply {configName _x} call BIS_fnc_arrayShuffle;
aDarkMusicClassnames = "'dark' in getArray (_x >> 'moods') " configClasses (configFile >> "CfgMusic") apply {configName _x} call BIS_fnc_arrayShuffle;
aCalmMusicClassnames = "'calm' in getArray (_x >> 'moods') " configClasses (configFile >> "CfgMusic") apply {configName _x} call BIS_fnc_arrayShuffle;

["initialize",[aDarkMusicClassnames,aCombatMusicClassnames,aCalmMusicClassnames]] remoteExecCall ["BIS_fnc_jukebox",-2,true]; //Init jukebox on clients + JIP


fncXIM_MusicRemote = {
	params ["_ximgroup", "_ximcombat"]; //Defining params

	if (_ximcombat) then {
		
	["forceBehaviour",["combat"]] remoteExecCall ["BIS_fnc_jukebox",_ximgroup]; //Change music type to combat
			
	}
	else {
		
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
