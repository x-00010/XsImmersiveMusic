bCombat = false; // declares bCombat, which is the player's combat state
uSelf = player; // declares uSelf, which is the player
bEvaluated = false; // declares bEvaluating, which is a flag to prevent event handler spam

fncEvaluateCombat = // defines subEvaluateCombat, which evaluates if the player is in combat or not
{
	private _uEnemy = uSelf findNearestEnemy uSelf; // find the closest enemy to the player and store them in uEnemy
	private _iEnemyKnowledge = _uEnemy knowsAbout uSelf; // find out how much the enemy knows about the player from a scale of 1 to 4
	if (_iEnemyKnowledge > 0) then // if the closest enemy is alerted to the player's presence
	{
		hint "Warning! Entering combat!";
		private _combat = true;
	}
	else
	{
		private _combat = false;
	}
};

uSelf addEventHandler 
["FiredNear", // creates firednear event handler
	{
		if (!bCombat) then // if not currently in combat, then
		{
			if (bEvaluated) then // if the combat state is not already being evaluated, then
			{
				bEvaluated = [] spawn // once fncEvaluateCombat has run, set bEvaluated to true
				{
					bCombat = [uSelf] call {fncEvaluateCombat}; // call fncEvaluateCombat with _bCombat and _uSelf within the scheduler
				};
			};
		};
	}
];

uSelf addEventHandler 
["Hit", // creates hit event handler
	{
		if (!bCombat) then // if not currently in combat, then
		{
			if (bEvaluated) then // if the combat state is not already being evaluated, then
			{
				bEvaluated = [] spawn // once fncEvaluateCombat has run, set bEvaluated to true
				{
					bCombat = [uSelf] call {fncEvaluateCombat}; // call fncEvaluateCombat with _bCombat and _uSelf within the scheduler
				};
			};
		};
	}
];