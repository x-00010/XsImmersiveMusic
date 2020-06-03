
// ======================================== FUNCTIONS ========================================

XIM_fncSendGroup = // submits the provided unit's group to the server plus the unit's combat state, which triggers the publicVariable event handler
{
	params["_oPlayer"]; // defines the parameter _aPlayerMachineIDs in position zero
	XIM_aStateChange = []; // defines XIM_aStateChange, which is an empty array
	XIM_aStateChange pushBack [group _oPlayer]; // adds the player's group to XIM_aStateChange at position zero
	XIM_aStateChange pushBack (_oPlayer getVariable "XIM_bCombat"); // adds the value of XIM_bCombat to the XIM_aStateChange array at position one
	publicVariableServer "XIM_aStateChange"; // sends the XIM_aStateChange variable to the server via its namespace
};

// ======================================== EVENT HANDLERS ========================================

addMusicEventHandler ["MusicStart", {
private _trackname = getText (configFile >> "CfgMusic" >> _this select 0 >> "name");
private _artistname = getText (configFile >> "CfgMusic" >> _this select 0 >> "artist");
[parseText format["Now playing<br/><t font='PuristaBold' size='1.6'>%1</t><br/><t font='PuristaBold' size='0.8'>%2</t>", _trackname,_artistname], true, nil, 5, 1, 0] spawn BIS_fnc_textTiles;}];

addMusicEventHandler ["MusicStop", // once the currently playing track has finished playing
{
	if (leader (group player)) then
	{
		[player] call XIM_fncSendGroup;
	};
}];