addMusicEventHandler ["MusicStart", {
private _trackname = getText (configFile >> "CfgMusic" >> _this select 0 >> "name");
private _artistname = getText (configFile >> "CfgMusic" >> _this select 0 >> "artist");
[parseText format["Now playing<br/><t font='PuristaBold' size='1.6'>%1</t><br/><t font='PuristaBold' size='0.8'>%2</t>", _trackname,_artistname], true, nil, 5, 1, 0] spawn BIS_fnc_textTiles;}];
