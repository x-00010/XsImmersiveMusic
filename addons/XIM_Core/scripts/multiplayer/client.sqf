// ======================================== LOCAL VARIABLES ========================================

XIM_bCombat = false; // declares XIM_bCombat, which is the flag for the player's combat state
XIM_uSelf = player; // declares XIM_uSelf, which is the player's unit
XIM_bEvaluated = true; // declares XIM_bEvaluated, which is a flag to prevent event handler spam
XIM_bToggled = true; // declares XIM_bToggled, which is a flag to prevent event handler spam
XIM_bOngoingEvent = false; // declares XIM_bOngoingEvent, which is a flag to prevent event handler spam
XIM_hEvaluateCombat = [] spawn {}; //sets the waituntil for XIM_fncEvaluateCombat to be true the first time it is run
XIM_hToggleCombat = [] spawn {}; //sets the waituntil for XIM_fncToggleCombat to be true the first time it is run

// ======================================== FUNCTIONS ========================================

XIM_fncToggleCombat = // defines fncToggleCombat, which inverts the current value of XIM_bCombat
{
	XIM_bCombat = !XIM_bCombat; // invert the current value of XIM_bCombat
	//hint str XIM_bOngoingEvent;

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
		waitUntil {scriptDone XIM_hToggleCombat}; // wait until the combat state has finished being toggled
		XIM_hToggleCombat = [] spawn
		{
			call XIM_fncToggleCombat; // call XIM_fncToggleCombat within the scheduler
		};
	}
	else // if no enemy has been detected
	{
		waitUntil {scriptDone XIM_hToggleCombat}; // wait until the combat state has finished being toggled
		XIM_hToggleCombat = [] spawn
		{
			call XIM_fncToggleCombat; // call XIM_fncToggleCombat within the scheduler
		};
	};
};

// ======================================== MAIN ========================================

while {leader group XIM_uSelf == XIM_uSelf} do // while the client is the leader of their group, or are not in one
{
	// ======================================== EVENT HANDLERS ========================================
	waitUntil {sleep 0.5; scriptDone XIM_hEvaluateCombat}; // wait until the combat state has finished being evaluated
	waitUntil {sleep 0.5; scriptDone XIM_hToggleCombat}; // wait until the combat state has finished being toggled
	if (!XIM_bCombat) then // if the client is not in combat
	{
		XIM_uSelf addEventHandler 
		["FiredNear", // creates firednear event handler
			{
				waitUntil {sleep 0.5; scriptDone XIM_hEvaluateCombat}; // wait until the combat state has finished being evaluated
				XIM_hEvaluateCombat = [] spawn
				{
					call XIM_fncEvaluateCombat; // call XIM_fncEvaluateCombat with within the scheduler
				};
			}
		];

		XIM_uSelf addEventHandler  
		["Hit", // creates hit event handler
			{
				private _uInstigator = _this select 3; // assign the unit who shot the player to _uInstigator
				private _iInstigatorRelation = ((side XIM_uSelf) getFriend (side _uInstigator)); // check if the unit is friend or foe
				if (_iInstigatorRelation < 0.6) then // if the result is less than 0.6, then they are foe
				{
					waitUntil {scriptDone XIM_hEvaluateCombat}; // wait until the combat state has finished being evaluated
					XIM_hEvaluateCombat = [_uInstigator] spawn // once fncEvaluateCombat has run, set XIM_bEvaluated to true
					{
						[_this select 0] call XIM_fncEvaluateCombat; // call XIM_fncEvaluateCombat with _uInstigator within the scheduler
					};						
				};
			}
		];
	}

	// ======================================== EVALUATE IF STILL IN COMBAT ========================================
	else // if the client is in combat
	{
		private _gSelfGroup = group XIM_uSelf; // gets the client's group and assigns it to _gSelfGroup
		private _aSelfGroupUnits = units _gSelfGroup - [player]; // gets all of the units within the _gSelfGroup group, minus the player so the others may sync

		remoteExec["XIM_fncToggleCombat", _gSelfGroup]; // sets everyone in the _gSelfGroup group to be in combat

		while {XIM_bCombat} do // while the client is still in combat
		{
			waitUntil {scriptDone XIM_hEvaluateCombat}; // wait until the the combat state is no longer being evaluated
			XIM_hEvaluateCombat = [] spawn
			{
				call XIM_fncEvaluateCombat; // call fncEvaluateCombat with within the scheduler
			};
		};
		if (!XIM_bCombat) then // if the client is no longer in combat
		{
			remoteExec["XIM_fncToggleCombat", _gSelfGroup]; // sets everyone in the _gSelfGroup group to no longer be in combat comb
		};
	};
};