class CfgPatches
{
	class XIMCore
	{
		name = "X's Immersive Music";
		author = "x00010";
		requiredVersion = 1.98;
		requiredAddons[] = {  
			"cba_settings"
		};
	};
};

class Extended_PreInit_EventHandlers 
{
    class XIMCoreStart // preinit event handler
	{
        init = "call compile preprocessFileLineNumbers '\XIM_Core\scripts\autostart\XEH_PreInit.sqf'";
    };
};