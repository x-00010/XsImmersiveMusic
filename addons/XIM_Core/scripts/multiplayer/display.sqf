addMusicEventHandler ["MusicStart", {
_nowplaying = "Now playing";
_trackname = getText (configFile >> "CfgMusic" >> _this select 0 >> "trackname");
_artistname = "by" + getText (configFile >> "CfgMusic" >> _this select 0 >> "artist");
 [_nowplaying, 2, 5, 2],[_trackname, 2, 5, 2],[_artistname, 2, 5, 2] spawn BIS_fnc_EXP_camp_SITREP}];
