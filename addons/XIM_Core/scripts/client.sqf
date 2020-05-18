private _self = player; // declares _self, which is the player
private _combat = false; // declare _combat, which is a bool for combat state
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
		_selfHit = true;
	}
];

[_combat, _self, _selfFiredNear, _selfHit] spawn // add following code to scheduler
{
	_combat = _this select 0; // _combat is first argument
	_self = _this select 1; // _self is second argument
	_selfFiredNear = _this select 2; // _selfFiredNear is third argument
	_selfHit = _this select 3; // _selfHit is fourth argument
	while {!_combat} do // while not in combat
	{
		if ((_selfFiredNear) or (_selfHit)) then // if someone fires near the player or they themselves fire or they are shot
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
};

