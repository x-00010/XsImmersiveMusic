// ======================================== LOCAL VARIABLES ========================================

XIM_bCombat = false; // declares XIM_bCombat, which is the flag for the player's combat state
XIM_uSelf = player; // declares XIM_uSelf, which is the player's unit
XIM_hEvaluateCombat = [] spawn {}; // sets the the handler for XIM_fncEvaluateCombat to return true when scriptDone is used
XIM_bEventHandlersRemoved = true; // declares XIM_bEventHandlersRemoved, which is a flag to easily determine if the event handlers have already been removed

// ======================================== FUNCTIONS ========================================

XIM_fncToggleCombat =
{
	XIM_bCombat = !XIM_bCombat;
	if (XIM_bCombat) then
	{
		hint "Entering combat!";
	}
	else
	{
		hint "Exiting combat!";
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
		XIM_bCombat = true;
		hint "Entering combat!";
	}
	else // if no enemy has been detected
	{
		XIM_bCombat = false;
		hint "Exiting combat!";
	};
	XIM_bCombat;
};

// ======================================== MAIN ========================================
waitUntil {sleep 30; leader group XIM_uSelf == XIM_uSelf} // wait until the client is the leader of their group

waitUntil {sleep 0.5; scriptDone XIM_hEvaluateCombat}; // wait until the combat state has finished being evaluated
if (!XIM_bEventHandlersRemoved) then // if the event handlers have not been removed
{
	// ======================================== REMOVE EVENT HANDLERS ========================================
	XIM_uSelf removeEventHandler ["FiredNear", XIM_iFiredNearEHIndex]; // removes the created FiredNear event handler
	XIM_uSelf removeEventHandler ["Hit", XIM_iHitEHIndex]; // removes the created Hit event handler
	XIM_bEventHandlersRemoved = true;
};

if (XIM_bCombat) then // if the client is in combat
{
	// ======================================== EVALUATE IF STILL IN COMBAT ========================================
	private _gSelfGroup = group XIM_uSelf; // gets the client's group and assigns it to _gSelfGroup
	private _aSelfGroupUnits = units _gSelfGroup - [player]; // gets all of the units within the _gSelfGroup group and puts them in an array, minus the player so the others may sync

	remoteExec["XIM_fncToggleCombat", _aSelfGroupUnits]; // sets everyone in the _gSelfGroup group to be in combat

	waitUntil {scriptDone XIM_hEvaluateCombat}; // wait until XIM_fncEvaluateCombat has finished executing
	XIM_hEvaluateCombat = [] spawn
	{
		XIM_bCalm =  call XIM_fncEvaluateCombat; // call XIM_fncEvaluateCombat with within the scheduler
		XIM_bCalm = !XIM_bCalm; // inverts the value of XIM_bCalm as the function was designed to return true the opposite of what the variable means
	};
	waitUntil {scriptDone XIM_hEvaluateCombat}; // wait until XIM_fncEvaluateCombat has finished executing

	waitUntil // wait until XIM_fncEvaluateCombat returns false
	{
		sleep 10; // wait ten seconds
		if (!XIM_bCalm) then // if XIM_bCalm = false
		{
			waitUntil {scriptDone XIM_hEvaluateCombat}; // wait until XIM_fncEvaluateCombat has finished executing
			XIM_hEvaluateCombat = [] spawn
			{
				XIM_bCalm =  call XIM_fncEvaluateCombat; // call XIM_fncEvaluateCombat with within the scheduler
				XIM_bCalm = !XIM_bCalm; // inverts the value of XIM_bCalm as the function was designed to return true the opposite of what the variable means
			};
			waitUntil {scriptDone XIM_hEvaluateCombat}; // wait until XIM_fncEvaluateCombat has finished executing
		};
		
		if (XIM_bCalm) exitWith {true}; // if XIM_bCalm = true then exit with true
		false;
	};

	remoteExec["XIM_fncToggleCombat", _aSelfGroupUnits]; // sets everyone in the _gSelfGroup group to no longer be in combat
	XIM_bCombat = false; // takes the client out of combat, and thus the cycle continues...
}

else // if the client is not in combat
{
	// ======================================== ADD EVENT HANDLERS ========================================
	XIM_bEventHandlersRemoved = false; // set XIM_bEventHandlersRemoved to false, as the event handlers are about to be created
	XIM_iFiredNearEHIndex = XIM_uSelf addEventHandler 
	["FiredNear", // creates firednear event handler
		{
			[] spawn
			{
				XIM_bCombat = call XIM_fncEvaluateCombat; // call XIM_fncEvaluateCombat with within the scheduler
			};
		}
	];

	XIM_iHitEHIndex = XIM_uSelf addEventHandler  
	["Hit", // creates hit event handler
		{
			private _uInstigator = _this select 3; // assign the unit who shot the player to _uInstigator
			private _iInstigatorRelation = ((side XIM_uSelf) getFriend (side _uInstigator)); // check if the unit is friend or foe
			if (_iInstigatorRelation < 0.6) then // if the result is less than 0.6, then they are foe
			{
				[_uInstigator] spawn
				{
					XIM_bCombat = [_this select 0] call XIM_fncEvaluateCombat; // call XIM_fncEvaluateCombat with _uInstigator within the scheduler
				};						
			};
		}
	];
};