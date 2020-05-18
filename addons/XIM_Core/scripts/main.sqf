private _combat = false; // declares _combat
private _self = name player; // declares _self, which is the player
private _selfFiredNear = false;


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

	if (_selfFiredNear = true or _selfHit = true) then
	{
		_enemy = _self findNearestEnemy _self;
		_enemyKnowledge = _enemy knowsAbout _self;
		if (_enemyKnowledge > 0) then
		{
			_combat = true;
		};
	};
	
};
