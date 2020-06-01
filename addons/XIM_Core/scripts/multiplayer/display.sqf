addMusicEventHandler ["MusicStart", {
private _nowplaying = "Now playing";
private _trackname = getText (configFile >> "CfgMusic" >> _this select 0 >> "name");
private _artistname = getText (configFile >> "CfgMusic" >> _this select 0 >> "artist");
[[_nowplaying, 2, 2, 2],[_trackname, 2, 1, 2],[_artistname, 2, 5, 2]] spawn BIS_fnc_EXP_camp_SITREP}];
