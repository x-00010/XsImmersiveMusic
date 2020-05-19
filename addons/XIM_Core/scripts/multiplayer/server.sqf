// This script is executed on either the player host (non-dedicated) or a dedicated server
private _moodarray = ["intense","calm","dark"];

aCombatMusicClassnames = "'intense' in getArray (_x >> 'moods') " configClasses (configFile >> "CfgMusic") apply {configName _x};
aDarkMusicClassnames = "'dark' in getArray (_x >> 'moods') " configClasses (configFile >> "CfgMusic") apply {configName _x};
aCalmMusicClassnames = "'calm' in getArray (_x >> 'moods') " configClasses (configFile >> "CfgMusic") apply {configName _x};


fncXIM_MusicRemote = {
	params ["_ximgroup", "_ximcombat"]; //Defining params

	if (_ximcombat) then {
		_randomTrack = selectRandom aCombatMusicClassnames; //Select random track
		["ace_hearing_disableVolumeUpdate",true] remoteExec {"setVariable",[_ximgroup,2]}; //Disable ace interference
		[20,0] remoteExec ["fadeMusic", [_ximgroup,2]]; //Start fade to 0 of currently playing music

		/*waitUntil {
		  musicVolume == 0;
		};*/

		15 fadeMusic 1;
		playMusic "LeadTrack04_F_EPB";};



		playMusic _randomTrack;


		["someTrack"] remoteExec [];
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
