XIM_bCombat = false; // declares XIM_bCombat, which is the player's combat state
XIM_uSelf = player; // declares XIM_uSelf, which is the player
XIM_bEvaluated = true; // declares XIM_bEvaluated, which is a flag to prevent event handler spam

fncEvaluateCombat = // defines fncEvaluateCombat, which evaluates if the player is in combat or not
{
	if (!(isNil "_this select 0")) then // if there is an argument in position zero
	{
		private _uEnemy = _this select 0; // assign the first argument to _uEnemy, which is most likely the same as _uInstigator from before
		private _iEnemyKnowledge = _uEnemy knowsAbout XIM_uSelf; // find out how much the enemy knows about the player from a scale of 0 to 4
		private _iSelfKnowledge = XIM_uSelf knowsAbout _uEnemy; // find out how much the player knows about the enemy from a scale of 0 to 4
		if ((_iEnemyKnowledge > 0) and (_iSelfKnowledge > 0))  then // if the closest enemy is alerted to the player's presence, and the player is alerted to theirs
		{
			hint "Warning! Entering combat!";
			combat = true;
		}
		else
		{
			combat = false;
		};
	}
	else // if there isn't an argument in position zero
	{
		private _uEnemy = XIM_uSelf findNearestEnemy XIM_uSelf; // find the closest enemy to the player and store them in uEnemy
		private _iEnemyKnowledge = _uEnemy knowsAbout XIM_uSelf; // find out how much the enemy knows about the player from a scale of 0 to 4
		private _iSelfKnowledge = XIM_uSelf knowsAbout _uEnemy; // find out how much the player knows about the enemy from a scale of 0 to 4
		if ((_iEnemyKnowledge > 0) and (_iSelfKnowledge > 0))  then // if the closest enemy is alerted to the player's presence, and the player is alerted to theirs
		{
			hint "Warning! Entering combat!";
			combat = true;
		}
		else
		{
			hint "not going into combat";
			combat = false;
		};
	};
	combat;
};

XIM_uSelf addEventHandler 
["FiredNear", // creates firednear event handler
	{
		if (!XIM_bCombat) then // if not currently in combat, then
		{
			if (XIM_bEvaluated) then // if the combat state is not already being evaluated, then
			{
				XIM_hEvaluateCombat = [] spawn
				{
					XIM_bCombat = call fncEvaluateCombat; // call fncEvaluateCombat with within the scheduler

				};
			};
		};
		XIM_bEvaluated = scriptDone XIM_hEvaluateCombat; // if fncEvaluateCombat has been executed, set XIM_bEvaluated to true, else set it to false
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
						XIM_bCombat = [_this select 0] call fncEvaluateCombat; // call fncEvaluateCombat with _uInstigator within the scheduler
					};		
				};
			};
		};
		XIM_bEvaluated = scriptDone XIM_hEvaluateCombat; // if fncEvaluateCombat has been executed, set XIM_bEvaluated to true, else set it to false
	}
];