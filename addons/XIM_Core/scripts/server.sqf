// This script is executed on either the player host (non-dedicated) or a dedicated server

fncXIMCombat = {

private _group = _this select 0;

[15,0] remoteExec ["fadeMusic", _group];

["someTrack"] remoteExec [];

	
};






  "XIM_aStateChange" addPublicVariableEventHandler {
  		private _aXIMstatechange = _this select 1;
  		private _ximgroup = _aXIMstatechange select 0;
  		private _ximcombat = _aXIMstatechange select 1;

  		if (_ximcombat) then {
  		  result = [_ximgroup] call {fncXIMCombat};

  		};

  	};
