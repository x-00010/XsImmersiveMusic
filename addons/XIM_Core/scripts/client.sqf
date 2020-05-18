bCombat = false; // declares bCombat, which is the player's combat state
uSelf = player; // declares uSelf, which is the player
bEvaluated = true; // declares bEvaluated, which is a flag to prevent event handler spam

fncEvaluateCombat = // defines subEvaluateCombat, which evaluates if the player is in combat or not
{
	private _uEnemy = uSelf findNearestEnemy uSelf; // find the closest enemy to the player and store them in uEnemy
	private _iEnemyKnowledge = _uEnemy knowsAbout uSelf; // find out how much the enemy knows about the player from a scale of 1 to 4
	if (_iEnemyKnowledge > 0) then // if the closest enemy is alerted to the player's presence
	{
		hint "Warning! Entering combat!";
		combat = true;
	}
	else
	{
		combat = false;
	};
	combat;
};

uSelf addEventHandler 
["FiredNear", // creates firednear event handler
	{
		if (!bCombat) then // if not currently in combat, then
		{
			if (bEvaluated) then // if the combat state is not already being evaluated, then
			{
				hEvaluateCombat = [] spawn // once fncEvaluateCombat has run, set bEvaluated to true
				{
					bCombat = [uSelf] call fncEvaluateCombat; // call fncEvaluateCombat with uSelf within the scheduler

				};
			};
		};
		bEvaluated = scriptDone hEvaluateCombat; // if fncEvaluateCombat has been executed, set bEvaluated to true, else set it to false
	}
];

uSelf addEventHandler 
["Hit", // creates hit event handler
	{
		if (!bCombat) then // if not currently in combat, then
		{
			if (bEvaluated) then // if the combat state is not already being evaluated, then
			{
				hEvaluateCombat = [] spawn // once fncEvaluateCombat has run, set bEvaluated to true
				{
					hint {[uSelf] call {fncEvaluateCombat}}; // call fncEvaluateCombat with uSelf within the scheduler

				};
			};
		};
		bEvaluated = scriptDone hEvaluateCombat; // if fncEvaluateCombat has been executed, set bEvaluated to true, else set it to false
	}
];