XIM_bCombat = false; // declares XIM_bCombat, which is the flag for the player's combat state
XIM_uSelf = player; // declares XIM_uSelf, which is the player's unit
XIM_bEvaluated = true; // declares XIM_bEvaluated, which is a flag to prevent event handler spam

XIM_fncToggleCombat = // defines fncToggleCombat, which inverts the current value of XIM_bCombat
{
		XIM_bCombat = !XIM_bCombat; // invert the current value of XIM_bCombat

	if (XIM_bCombat) then // if the client is in combat
	{
		hint "Warning! Entering combat!";
	}
	else // if the client is not in combat
	{
		hint "Warning! Exiting combat!";
	};
};

XIM_fncEvaluateCombat = // defines XIM_fncEvaluateCombat, which evaluates if the player is in combat or not
{
	params [["_uEnemy", objNull]]; // defines the optional parameter, _uEnemy
	if (!isNull _uEnemy) then // if there is an argument in position zero
	{
		_uEnemy = _this select 0; // assign the first argument to _uEnemy, which is most likely the same as _uInstigator from before
	}
	else // if there isn't an argument in position zero
	{
		_uEnemy = player findNearestEnemy player; // find the closest enemy to the player and store them in uEnemy
	};

	if (!isNull _uEnemy) then
	{
		_fEnemyKnowledge = _uEnemy knowsAbout XIM_uSelf; // find out how much the enemy knows about the player from a scale of 0 to 4
		_fSelfKnowledge = XIM_uSelf knowsAbout _uEnemy; // find out how much the player knows about the enemy from a scale of 0 to 4
		//hint str _iEnemyKnowledge;
		//sleep 3;
		//hint str _fSelfKnowledge;
		if ((_fEnemyKnowledge > 0) and (_fSelfKnowledge > 0)) then // if the closest enemy is alerted to the player's presence, and the player is alerted to theirs
		{
			call XIM_fncToggleCombat;
		}
		else
		{
			//hint "not going into combat";
		};
	}
	else
	{
		//hint "no enemies there forehead";
	};
};
if (leader group player == player) then
{
	if (!XIM_bCombat) then
	{
		XIM_uSelf addEventHandler 
		["FiredNear", // creates firednear event handler
			{
				if (!XIM_bCombat) then // if not currently in combat, then
				{
					if (XIM_bEvaluated) then // if the combat state is not already being evaluated, then
					{
						//hint "ping";
						XIM_hEvaluateCombat = [] spawn
						{
							call XIM_fncEvaluateCombat; // call XIM_fncEvaluateCombat with within the scheduler
						};
					};
				};
				XIM_bEvaluated = scriptDone XIM_hEvaluateCombat; // if XIM_fncEvaluateCombat has been executed, set XIM_bEvaluated to true, else set it to false
			}
		];

		XIM_uSelf addEventHandler 
		["Hit", // creates hit event handler
			{
				if (!XIM_bCombat) then // if not currently in combat, then
				{
					if (XIM_bEvaluated) then // if the combat state is not already being evaluated, then
					{
						private _uInstigator = _this select 3; // assign the unit who shot the player to _uInstigator
						private _iInstigatorRelation = ((side XIM_uSelf) getFriend (side _uInstigator)); // check if the unit is friend or foe
						if (_iInstigatorRelation < 0.6) then // if the result is less than 0.6, then they are foe
						{
							XIM_hEvaluateCombat = [_uInstigator] spawn // once fncEvaluateCombat has run, set XIM_bEvaluated to true
							{
								[_this select 0] call XIM_fncEvaluateCombat; // call XIM_fncEvaluateCombat with _uInstigator within the scheduler
							};		
						};
					};
				};
				XIM_bEvaluated = scriptDone XIM_hEvaluateCombat; // if fncEvaluateCombat has been executed, set XIM_bEvaluated to true, else set it to false
			}
		];
	};
};

while {leader group player == player} do
{
	if (XIM_bCombat) then // if this client is the first in the group to go into combat
	{
		private _gSelfGroup = group uSelf; // gets the client's group and assigns it to _gSelfGroup
		private _aSelfGroupUnits = units _gSelfGroup - [player]; // gets all of the units within the _gSelfGroup group, minus the player so the others may sync
		private _aGroupIDs = [];

		remoteExec["fncToggleCombat", _gSelfGroup]; // inverts the value of bCombat for every player in the group

		while {XIM_bCombat} do // while the client was the first in the group to go into combat
		{
			if (XIM_bEvaluated) then // if the combat state is not already being evaluated, then
			{
				XIM_hEvaluateCombat = [] spawn
				{
					call XIM_fncEvaluateCombat; // call fncEvaluateCombat with within the scheduler
				};
			};
			XIM_bEvaluated = scriptDone XIM_hEvaluateCombat; // if fncEvaluateCombat has been executed, set XIM_bEvaluated to true, else set it to false
			if (!XIM_bCombat) then // if the client is no longer in combat
			{
				remoteExec["fncToggleCombat", _gSelfGroup]; // inverts the value of bCombat for every player in the group
				XIM_bInstigator = false; // then set XIM_bInstigator to false, and the cycle continues...
			};
			sleep 5; // wait 0.5 seconds before executing again
		};
	};
};