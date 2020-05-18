private bCombat = false; // declares bCombat, which is the player's combat state
private uSelf = player; // declares uSelf, which is the player

fncEvaluateCombat = // defines subEvaluateCombat, which evaluates if the player is in combat or not
{
	private bCombat = _this select 0; 
	private uSelf = _this select 1;

	while {!bCombat} do
	{
		private uEnemy = uSelf findNearestEnemy uSelf; // declares bCombat, which is the player's combat state and the first argument
		private iEnemyKnowledge = uEnemy knowsAbout uSelf; // declares uSelf, which is the player and the second argument
		if (iEnemyKnowledge > 0) then // if the closest enemy is alerted to the player's presence
		{
			hint "Warning! Entering combat!";
			combat = true;
		};
	};
};

uSelf addEventHandler 
["FiredNear", // creates firednear event handler
	{
		[bCombat, uSelf] spawn
		{
			[_this select 0, _this select 1] call fncEvaluateCombat; // call fncEvaluateCombat with bCombat and uSelf
		};
	} 
];

uSelf addEventHandler 
["Hit", // creates hit event handler
	{
		[bCombat, uSelf] spawn
		{
			[_this select 0, _this select 1] call fncEvaluateCombat; // call fncEvaluateCombat with bCombat and uSelf
		};
		
	}
];