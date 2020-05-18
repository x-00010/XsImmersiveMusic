private _combat = false; // declares _combat
private _self = player; // declares _self, which is the player
private _selfFiredNear = false; // declares _selfFiredNear, for later use in an event handler
private _selfHit = false; // declares _selfHit, for later use in an event handler

_self addEventHandler 
["FiredNear", // creates firednear event handler
	{
		_selfFiredNear = true;
	}
];

_self addEventHandler 
["Hit", // creates hit event handler
	{
		_selfHit = true
	}
];

while {combat = false} do
{
	if ((_selfFiredNear == true) or (_selfHit == true)) then // if someone fires near the player, they themselves fire or are shot
	{
		_enemy = _self findNearestEnemy _self;
		_enemyKnowledge = _enemy knowsAbout _self;
		if (_enemyKnowledge > 0) then // and the closest enemy is alerted to their presence
		{
			_combat = true;
			hint "Warning! Entering combat!"
		};
	};
	sleep 0.5; // wait half a second before executing once more
};
