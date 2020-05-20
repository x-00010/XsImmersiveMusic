XIM_bCombat = false; // declares XIM_bCombat, which is the flag for the player's combat state
XIM_uSelf = player; // declares XIM_uSelf, which is the player's unit
XIM_bEvaluated = true; // declares XIM_bEvaluated, which is a flag to prevent event handler spam
XIM_bToggled = true; // declares XIM_bToggled, which is a flag to prevent event handler spam

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
		_uEnemy = XIM_uSelf findNearestEnemy XIM_uSelf; // find the closest enemy to the player and store them in uEnemy
	};

	if (!isNull _uEnemy) then // if there is an enemy that has been detected
	{
		if (XIM_bToggled) then // if the combat state is not already being toggled
		{
			XIM_hToggleCombat = [] spawn
			{
				call XIM_fncToggleCombat; // call XIM_fncToggleCombat within the scheduler
			};
		};
		XIM_bToggled = scriptDone XIM_hToggleCombat; // if XIM_fncToggleCombat has been executed, set XIM_bToggled to true, else set it to false
	};
};

if (leader group XIM_uSelf == XIM_uSelf) then // if the client is the leader of their group, or are not in one
{
	if (!XIM_bCombat) then // if the client is in combat
	{
		XIM_uSelf addEventHandler 
		["FiredNear", // creates firednear event handler
			{
				if (XIM_bEvaluated) then // if the combat state is not already being evaluated, then
				{
					XIM_hEvaluateCombat = [] spawn
					{
						call XIM_fncEvaluateCombat; // call XIM_fncEvaluateCombat with within the scheduler
					};
				};
			XIM_bEvaluated = scriptDone XIM_hEvaluateCombat; // if XIM_fncEvaluateCombat has been executed, set XIM_bEvaluated to true, else set it to false
			}
		];

		XIM_uSelf addEventHandler 
		["Hit", // creates hit event handler
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
			XIM_bEvaluated = scriptDone XIM_hEvaluateCombat; // if fncEvaluateCombat has been executed, set XIM_bEvaluated to true, else set it to false
			}
		];
	};
};

while {leader group XIM_uSelf == XIM_uSelf} do // while the client is the leader of their group, or are not in one
{
	if (XIM_bCombat) then // if the client is in combat
	{
		private _gSelfGroup = group XIM_uSelf; // gets the client's group and assigns it to _gSelfGroup
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
			sleep 5; // wait 5 seconds before executing again
		};
	};
};