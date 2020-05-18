private _combat = false; // declares _combat
private playerFiredNear = false; // declares playerFiredNear, for later use in an event handler
private playerHit = false; // declares playerHit, for later use in an event handler

player addEventHandler 
["FiredNear", // creates firednear event handler
	{
		playerFiredNear = true;
	}
];

player addEventHandler 
["Hit", // creates hit event handler
	{
		playerHit = true
	}
];

while {combat = false} do
{
	if (playerFiredNear = true or playerHit = true) then // if someone fires near the player, they themselves fire or are shot
	{
		_enemy = player findNearestEnemy player;
		_enemyKnowledge = _enemy knowsAbout player;
		if (_enemyKnowledge > 0) then // and the closest enemy is alerted to their presence
		{
			_combat = true;
			hint "Warning! Entering combat!"
		};
	};
	sleep 0.5; // wait half a second before executing once more
};
