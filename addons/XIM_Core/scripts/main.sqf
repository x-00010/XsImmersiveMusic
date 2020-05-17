private _combat = false; // declares _combat
private _self = name player; // declares _self, which is the player

if (_combat = false) then;
{
	_self addEventHandler 
	["FiredNear", // create firednear event handler
		{
			_enemy = _self findNearestEnemy _self
			
			
		};
	];
};
