class CfgPatches
{
	class XIMCore
	{
		name = "X's Immersive Music";
		author = "x00010";
		requiredVersion = 1.98;

		requiredAddons[] = 
		{  
			"cba_settings"
		};

		units[] = {};
		weapons[] = {};
	};
};

class Extended_PreInit_EventHandlers 
{
    class XIMCoreStart // preinit event handler
	{
        init = "call compile preprocessFileLineNumbers '\XIM_Core\scripts\autostart\XEH_PreInit.sqf'";
    };
};


class CfgMusic
{
    class LeadTrack01_F
    {
        moods = {"intense"}
        //This is war
    };
    class LeadTrack01a_F
    {
        moods = {"intense"}
        //This is war a
    };
    class LeadTrack01b_F
    {
        moods = {"intense"}
        //This is war b
    };
    class LeadTrack01c_F
    {
        moods = {"intense"}
        //Main menu
    };
    class LeadTrack02_F
    {
        moods = {"dark","intense"}
        //Proteus
    };
    class LeadTrack03_F
    {
        moods = {"intense"}
        //Combined Arms
    };
    class LeadTrack04_F
    {
        moods = {"intense","dark"}
        //Action Dark 2
    };
    class LeadTrack04a_F
    {
        moods = {"intense","dark"}
        //Action Dark
    };
    class LeadTrack05_F
    {
        moods = {"intense"}
        //Taking Kavala
    };
    class LeadTrack06_F
    {
        moods = {"intense","dark"}
        //Down at the Garina bay
    };
    class AmbientTrack01_F
    {
        moods = {"calm","dark"}
        //East Wind Alternative 1
    };
    class AmbientTrack01a_F
    {
        moods = {"calm","dark"}
        //East Wind
    };
    class AmbientTrack01b_F
    {
        moods = {"calm","dark"}
        //East Wind Alternative 2
    };
    class AmbientTrack03_F
    {
        moods = {"calm"}
        //Solar Power
    };
     class AmbientTrack04a_F
    {
        moods = {"dark"}
        //Night percussions
    };
    class AmbientTrack04_F
    {
        moods = {"dark"}
        //Night ambient
    };
    class BackgroundTrack01_F
    {
    	moods = {"calm"}
    	//Underwater 2
    };
    class BackgroundTrack01a_F
    {
    	moods = {"calm"}
    	//Underwater
    };
    class BackgroundTrack02_F
    {
    	moods = {"calm","dark"}
    	//On the road
    };
    class LeadTrack01_F_EPA
    {
    	moods = {"calm"}
    	//Stage A: Lead Track 01 (Conquistador)
    };
    class LeadTrack02_F_EPA
    {
    	moods = {"calm","dark"}
    	//Stage A: Lead Track 02 (Aegis Blues)
    };
    class LeadTrack02a_F_EPA
    {
    	moods = {"calm","dark"}
    	//Stage A: Lead Track 02 (Aegis Blues - Alternative 1)
    };
    class LeadTrack02b_F_EPA
    {
    	moods = {"calm","dark"}
    	//Stage A: Lead Track 02 (Aegis Blues - Alternative 2)
    };
    class LeadTrack03_F_EPA
    {
    	moods = {"dark","intense"}
    	//Stage A: Lead Track 03 (Survive the Hard Part)
    };

    class LeadTrack01_F_EPB
    {
    	moods = {"calm"}
    	//Stage B: Lead Track 01 (Adapt)
    };

    class LeadTrack01a_F_EPB
    {
    	moods = {"calm"}
    	//Stage B: Lead Track 01 (Adapt - Alternative)
    };
    class LeadTrack02_F_EPB
    {
    	moods = {"dark","intense"}
    	//Stage B: Lead Track 02 (Exit Strategy)
    };
    class LeadTrack02a_F_EPB
    {
    	moods = {"dark"}
    	//Stage B: Lead Track 02 (Exit Strategy - Alternative 1)
    };
    class LeadTrack02b_F_EPB
    {
    	moods = {"dark","intense"}
    	//Stage B: Lead Track 02 (Exit Strategy - Alternative 2)
    };
    class LeadTrack03_F_EPB
    {
    	moods = {"dark"}
    	//Stage B: Lead Track 03 (Beyond Recognition - Alternative 1)
    };

    class LeadTrack03a_F_EPB
    {
    	moods = {"dark"}
    	//Stage B: Lead Track 03 (Beyond Recognition - Alternative 1)
    };

};


