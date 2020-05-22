// ======================================== LOCAL VARIABLES ========================================

XIM_bCombat = false; // declares XIM_bCombat, which is the flag for the player's combat state
XIM_oSelf = player; // declares XIM_oSelf, which is the player's unit
XIM_hEvaluateCombat = [] spawn {}; // sets the the handler for XIM_fncEvaluateCombat to return true when scriptDone is used before the script is run for the first time
XIM_bEventHandlersRemoved = true; // declares XIM_bEventHandlersRemoved, which is a flag to easily determine if the event handlers have already been removed
XIM_bCalm = false;

// ======================================== FUNCTIONS ========================================

XIM_fncCallCalmCombat =
{
	XIM_hEvaluateCombat = [] spawn
	{
		XIM_bCalm =  call XIM_fncEvaluateCombat; // call XIM_fncEvaluateCombat with within the scheduler
		XIM_bCalm = !XIM_bCalm; // inverts the value of XIM_bCalm as the function was designed to return true the opposite of what the variable means
	};
};

XIM_fncObtainGroupUnits = // defines XIM_fncObtainGroupUnits, which returns an array with all the units in the client's group, minus the client themselves
{
	private _gSelfGroup = group XIM_oSelf; // gets the client's group and assigns it to _gSelfGroup
	private _aSelfGroupUnits = units _gSelfGroup - [XIM_oSelf]; // gets all of the units within the _gSelfGroup group and puts them in an array, minus the client so the others may sync
	_aSelfGroupUnits; // return _aSelfGroupUnits when the function is called
};

XIM_fncNotifyServer = // defines XIM_fncNotifyServer, which notifies the server of the group's current combat state
{
	private _gSelfGroup = group XIM_oSelf; // obtain the group the player is in
	XIM_aStateChange = [_gSelfGroup, XIM_bCombat]; // put the player's group in the state-change variable, along with the combat state
	publicVariableServer "XIM_aStateChange"; // sends the XIM_aStateChange array to the server
};


XIM_fncToggleCombat = // defines XIM_fncToggleCombat, which toggles the current combat status
{
	XIM_bCombat = !XIM_bCombat; // inverts the current value of XIM_bCombat
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
	params [["_oEnemy", objNull]]; // defines the optional parameter, XIM_oEnemy
	if (!isNull _oEnemy) then // if there is an argument in position zero
	{
		XIM_oEnemy = _this select 0; // assign the first argument to XIM_oEnemy, which is most likely the same as _uInstigator from before
	}
	else // if there isn't an argument in position zero
	{
		XIM_oSender = XIM_oSelf;
		XIM_oEnemy = objNull;
		owner XIM_oSelf publicVariableClient "XIM_oEnemy";
		publicVariableServer "XIM_oSender"; // send a variable called XIM_oSender to server which contains the name of the object currently being controlled
		waitUntil{sleep 0.4; !isNull(missionNamespace getVariable "XIM_oEnemy")}; // wait until the server sends a variable back, called XIM_oEnemy
		XIM_oEnemy = missionNamespace getVariable "XIM_oEnemy"; // assign the recieved variable to XIM_oEnemy
	};

	if (!isNull XIM_oEnemy) then // if there is an enemy that has been detected
	{
		XIM_bCombat = true; // set XIM_bCombat to true
		hint "Entering combat!";
	}
	else // if no enemy has been detected
	{
		XIM_bCombat = false; // set XIM_bCombat to false
		hint "Exiting combat!";
	};
	XIM_bCombat; // return the current value of XIM_bCombat
};

// ======================================== MAIN ========================================
while {leader group XIM_oSelf == XIM_oSelf} do  // while the client is the leader of their group
{
	waitUntil {sleep 2; scriptDone XIM_hEvaluateCombat}; // wait 2 seconds plus until the combat state has finished being evaluated  
	if (!XIM_bEventHandlersRemoved) then // if the event handlers have not been removed
	{
		// ======================================== REMOVE EVENT HANDLERS ========================================
		XIM_oSelf removeEventHandler ["FiredNear", XIM_iFiredNearEHIndex]; // removes the created FiredNear event handler
		XIM_oSelf removeEventHandler ["Hit", XIM_iHitEHIndex]; // removes the created Hit event handler
		XIM_bEventHandlersRemoved = true; // set XIM_bEventHandlersRemoved to true, as the event handlers have been deleted
	};

	if (XIM_bCombat) then // if the client is in combat
	{
		// ======================================== EVALUATE IF STILL IN COMBAT ========================================

		private _aSelfGroupUnits = call XIM_fncObtainGroupUnits; // obtain the units in the client's group without the client themselves by calling XIM_fncObtainGroupUnits and assigning the returned value to _aSelfGroupUnits
		remoteExec["XIM_fncToggleCombat", _aSelfGroupUnits]; // sets everyone in the _aSelfGroupUnits group to be in combat

		[] spawn 
		{
			call XIM_fncNotifyServer; // call XIM_fncNotifyServer, which notifies the server that the group's combat state has changed
		};

		XIM_hCallCalmCombat = [] spawn 
		{
			call XIM_fncCallCalmCombat; // call XIM_fncCallCalmCombat in the scheduler, which in turn calls XIM_fncEvaluateCombat with the return value assigned to XIM_bCalm
		};
		waitUntil {scriptDone XIM_hCallCalmCombat}; // wait until XIM_fncEvaluateCombat has finished executing

		waitUntil // wait until XIM_fncEvaluateCombat returns false
		{
			sleep 5; // wait ten seconds
			if (!XIM_bCalm) then // if XIM_bCalm = false
			{
				XIM_hCallCalmCombat = [] spawn 
				{
					call XIM_fncCallCalmCombat; // call XIM_fncCallCalmCombat in the scheduler, which in turn calls XIM_fncEvaluateCombat with the return value assigned to XIM_bCalm
				};
				waitUntil {scriptDone XIM_hCallCalmCombat}; // wait until XIM_fncEvaluateCombat has finished executing
			};
			if (XIM_bCalm) exitWith {true}; // if XIM_bCalm = true then exit with true
			false; // else return false
		};
		remoteExec["XIM_fncToggleCombat", _aSelfGroupUnits]; // sets everyone in the _gSelfGroup group to no longer be in combat
		private _gSelfGroup = group XIM_oSelf; // obtain the group the player is in
		XIM_bCalm = !XIM_bCalm;
		XIM_aStateChange = [_gSelfGroup, XIM_bCalm]; // put the player's group in the state-change variable, along with the combat state
		publicVariableServer "XIM_aStateChange"; // sends the XIM_aStateChange array to the server
		XIM_bCombat = false; // takes the client out of combat, and thus the cycle continues...
	}

	else // if the client is not in combat
	{
		[] spawn 
		{
			call XIM_fncNotifyServer; // call XIM_fncNotifyServer, which notifies the server that the group's combat state has changed
		};
		// ======================================== ADD EVENT HANDLERS ========================================
		XIM_bEventHandlersRemoved = false; // set XIM_bEventHandlersRemoved to false, as the event handlers are about to be created
		XIM_iFiredNearEHIndex = XIM_oSelf addEventHandler 
		["FiredNear", // creates firednear event handler
			{
				[] spawn
				{
					XIM_bCombat = call XIM_fncEvaluateCombat; // call XIM_fncEvaluateCombat with within the scheduler
				};
			}
		];

		XIM_iHitEHIndex = XIM_oSelf addEventHandler  
		["Hit", // creates hit event handler
			{
				private _uInstigator = _this select 3; // assign the unit who shot the player to _uInstigator
				private _iInstigatorRelation = ((side XIM_oSelf) getFriend (side _uInstigator)); // check if the unit is friend or foe
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
};