bCombat = false; // declares _bCombat, which is the player's combat state
uSelf = player; // declares _uSelf, which is the player

fncEvaluateCombat = // defines subEvaluateCombat, which evaluates if the player is in combat or not
{
	private _bCombat = _this select 0; // declares _bCombat, which is the player's combat state and the first argument
	private _uSelf = _this select 1; // declares _uSelf, which is the player and the second argument
	private _uEnemy = _uSelf findNearestEnemy _uSelf; // find the closest enemy to the player and store them in uEnemy
	private _iEnemyKnowledge = _uEnemy knowsAbout _uSelf; // find out how much the enemy knows about the player from a scale of 1 to 4
	if (_iEnemyKnowledge > 0) then // if the closest enemy is alerted to the player's presence
	{
		hint "Warning! Entering combat!";
		combat = true;
	};
};

uSelf addEventHandler 
["FiredNear", // creates firednear event handler
	{
		while {!bCombat} do // while not in combat
		{
			[bCombat, uSelf] spawn
			{
				[_this select 0, _this select 1] call fncEvaluateCombat; // call fncEvaluateCombat with _bCombat and _uSelf within the scheduler
			};
		};
	}
];

uSelf addEventHandler 
["Hit", // creates hit event handler
	{
		while {!bCombat} do // while not in combat
		{
			[bCombat, uSelf] spawn
			{
				[_this select 0, _this select 1] call fncEvaluateCombat; // call fncEvaluateCombat with _bCombat and _uSelf within the scheduler
			};
		};	
	}
];