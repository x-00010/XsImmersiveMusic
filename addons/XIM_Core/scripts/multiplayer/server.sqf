// This script is executed on either the player host (non-dedicated) or a dedicated server


// Below is the creation of arrays, that contain classnames of music tracks defined in config.cpp, randomized to make it fresh each time;
aCombatMusicClassnames = "'intense' in getArray (_x >> 'moods') " configClasses (configFile >> "CfgMusic") apply {configName _x} call BIS_fnc_arrayShuffle;
aDarkMusicClassnames = "'dark' in getArray (_x >> 'moods') " configClasses (configFile >> "CfgMusic") apply {configName _x} call BIS_fnc_arrayShuffle;
aCalmMusicClassnames = "'calm' in getArray (_x >> 'moods') " configClasses (configFile >> "CfgMusic") apply {configName _x} call BIS_fnc_arrayShuffle;

["initialize",[aDarkMusicClassnames,aCombatMusicClassnames,aCalmMusicClassnames]] remoteExecCall ["BIS_fnc_jukebox",-2,true]; //Init jukebox on clients + JIP





fncXIM_MusicHandler = {
	params ["_groupOwnerIDs","_musictype"];

	missionNameSpace setVariable ["ace_hearing_disableVolumeUpdate",true,_groupOwnerIDs]; //Disable ACE interference
	["forceBehaviour",[_musictype]] remoteExecCall ["BIS_fnc_jukebox",_groupOwnerIDs]; //Changes music type based on passed parameter
	[{missionNameSpace setVariable ["ace_hearing_disableVolumeUpdate",false,_groupOwnerIDs];},[], 5] call CBA_fnc_waitAndExecute; //Re-enable ACE function after 5 sec
};


fncXIM_MusicRemote = {
	params ["_ximgroup", "_ximcombat"]; //Defining params
	private _groupOwnerIDs = [];
	(units _ximgroup) apply {_groupOwnerIDs pushBackUnique (owner _x)}; //Retrieving ID's for players in group
	format ["%1",_groupOwnerIDs] remoteExec ["hint", 0];
	if (_ximcombat) then {

		[_groupOwnerIDs,"combat"] call fncXIM_MusicHandler; //Set music to type combat
			
	} else {
		private _sunrisesunset = date call BIS_fnc_sunriseSunsetTime;
		private _sunrise = _sunrisesunset select 0;
		private _sunset = _sunrisesunset select 1;

		if ((rain > 0.2) or (fog > 0.2) or ((daytime > _sunset) and (daytime < _sunrise))) then {

			[_groupOwnerIDs,"stealth"] call fncXIM_MusicHandler; //Set music to type stealth (dark)
  			
		} else {

  			[_groupOwnerIDs,"safe"] call fncXIM_MusicHandler; //Set music to type safe

		};

	};	
};

  "XIM_aStateChange" addPublicVariableEventHandler {
  		private _aXIMstatechange = _this select 1; //Store array in variable
  		private _ximgroup = _aXIMstatechange select 0; //Retrieve group object
  		private _ximcombat = _aXIMstatechange select 1; //Retrieve combat state

  		if (_ximcombat) then {
  			[_ximgroup,_ximcombat] call fncXIM_MusicRemote;

  		};

  	};


"XIM_oSender" addPublicVariableEventHandler {
  		private _oXIMSender = _this select 1; //Store array in variable
  		private _senderID = owner _oXIMSender;
		ximnearestenemy = _oXIMSender findNearestEnemy _oXIMSender;

		if (ximnearestenemy != objNull) then {
			XIM_oEnemy = ximnearestenemy; //Assign to missionNamespace var
			_senderID publicVariableClient "XIM_oEnemy";
		};



  		
  	};