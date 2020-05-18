private _combat = false; // declares _combat
private _self = name player; // declares _self, which is the player
private _selfFiredNear = false; // declares _selfFiredNear, for later use in an event handler
private _selfHit = false; // declares _selfHit, for later use in an event handler


if (_combat = false) then
{
	_self addEventHandler // create firednear event handler
	[
		"FiredNear"
		{
			_selfFiredNear = true;
		};
	];
	_selfHit = _self addEventHandler // create hit event handler
	[
		"Hit"
		{
			_selfHit = true;
		};
	];

	if (_selfFiredNear = true or _selfHit = true) then // if someone fires near the player, they themselves fire or are shot
	{
		_enemy = _self findNearestEnemy _self;
		_enemyKnowledge = _enemy knowsAbout _self;
		if (_enemyKnowledge > 0) then // and the closest enemy is alerted to their presence
		{
			_combat = true;
			hint "Warning! Entering combat!"
		};
	};
};
