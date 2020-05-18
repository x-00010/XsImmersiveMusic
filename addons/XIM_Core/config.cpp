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
        moods[] = 
        {
            "intense"
        };
        //This is war
    };
    class LeadTrack01a_F
    {
        moods[] = 
        {
            "intense"
        };
        //This is war a
    };
    class LeadTrack01b_F
    {
        moods[] = 
        {
            "intense"
        };
        //This is war b
    };
    class LeadTrack01c_F
    {
        moods[] = 
        {
            "intense"
        };
        //Main menu
    };
    class LeadTrack02_F
    {
        moods[] = 
        {
            "dark",
            "intense"
        };
        //Proteus
    };
    class LeadTrack03_F
    {
        moods[] = 
        {
            "intense"
        };
        //Combined Arms
    };
    class LeadTrack04_F
    {
        moods[] = 
        {
            "intense",
            "dark"
        };
        //Action Dark 2
    };
    class LeadTrack04a_F
    {
        moods[] = 
        {
            "intense",
            "dark"
        };
        //Action Dark
    };
    class LeadTrack05_F
    {
        moods[] = 
        {
            "intense"
        };
        //Taking Kavala
    };
    class LeadTrack06_F
    {
        moods[] = 
        {
            "intense",
            "dark"
        };
        //Down at the Garina bay
    };
    class AmbientTrack01_F
    {
        moods[] = 
        {
            "calm",
            "dark"
        };
        //East Wind Alternative 1
    };
    class AmbientTrack01a_F
    {
        moods[] = 
        {
            "calm",
            "dark"
        };
        //East Wind
    };
    class AmbientTrack01b_F
    {
        moods[] = 
        {
            "calm",
            "dark"
        };
        //East Wind Alternative 2
    };
    class AmbientTrack03_F
    {
        moods[] = 
        {
            "calm"
        };
        //Solar Power
    };
     class AmbientTrack04a_F
    {
        moods[] = 
        {
            "dark"
        };
        //Night percussions
    };
    class AmbientTrack04_F
    {
        moods[] = 
        {
            "dark"
        };
        //Night ambient
    };
    class BackgroundTrack01_F
    {
    	moods[] = 
        {
            "calm"
        };
    	//Underwater 2
    };
    class BackgroundTrack01a_F
    {
    	moods[] = 
        {
            "calm"
        };
    	//Underwater
    };
    class BackgroundTrack02_F
    {
    	moods[] = 
        {
            "calm",
            "dark"
        };
    	//On the road
    };
    class LeadTrack01_F_EPA
    {
    	moods[] = 
        {
            "calm"
        };
    	//Stage A: Lead Track 01 (Conquistador)
    };
    class LeadTrack02_F_EPA
    {
    	moods[] = 
        {
            "calm",
            "dark"
        };
    	//Stage A: Lead Track 02 (Aegis Blues)
    };
    class LeadTrack02a_F_EPA
    {
    	moods[] = 
        {
            "calm",
            "dark"
        };
    	//Stage A: Lead Track 02 (Aegis Blues - Alternative 1)
    };
    class LeadTrack02b_F_EPA
    {
    	moods[] = 
        {
            "calm",
            "dark"
        };
    	//Stage A: Lead Track 02 (Aegis Blues - Alternative 2)
    };
    class LeadTrack03_F_EPA
    {
    	moods[] = 
        {
            "dark",
            "intense"
        };
    	//Stage A: Lead Track 03 (Survive the Hard Part)
    };

    class LeadTrack01_F_EPB
    {
    	moods[] = 
        {
            "calm"
        };
    	//Stage B: Lead Track 01 (Adapt)
    };

    class LeadTrack01a_F_EPB
    {
    	moods[] = 
        {
            "calm"
        };
    	//Stage B: Lead Track 01 (Adapt - Alternative)
    };
    class LeadTrack02_F_EPB
    {
    	moods[] = 
        {
            "dark",
            "intense"
        };
    	//Stage B: Lead Track 02 (Exit Strategy)
    };
    class LeadTrack02a_F_EPB
    {
    	moods[] = 
        {
            "dark"
        };
    	//Stage B: Lead Track 02 (Exit Strategy - Alternative 1)
    };
    class LeadTrack02b_F_EPB
    {
    	moods[] = 
        {
            "dark",
            "intense"
        };
    	//Stage B: Lead Track 02 (Exit Strategy - Alternative 2)
    };
    class LeadTrack03_F_EPB
    {
    	moods[] = 
        {
            "dark"
        };
    	//Stage B: Lead Track 03 (Beyond Recognition)
    };

    class LeadTrack03a_F_EPB
    {
    	moods[] = 
        {
            "dark"
        };
    	//Stage B: Lead Track 03 (Beyond Recognition - Alternative 1)
    };


    class LeadTrack04_F_EPB
    {
        moods[] = 
        {
            "dark"
        };
        //Stage B: Lead Track 04 (Canton Protocol)

    };

    class AmbientTrack01_F_EPB
    {
        moods[] = 
        {
            "dark","calm"
        };
        //Stage B: Ambient Track 01 (Signal Lost)
    };
    class BackgroundTrack01_F_EPB
    {
        moods[] = 
        {
            "dark"
        };
        //Stage B: Background Track 01 (The Hunt)
    };
    class LeadTrack01_F_EPC
    {
        moods[] = 
        {
            "calm"
        };
        //Stage C: Lead Track 01 (Back on Stratis)

    };
    class LeadTrack02_F_EPC
    {
        moods[] = 
        {
            "intense"
        };
        //Stage C: Lead Track 02 (LZ hot)
    };

    class LeadTrack03_F_EPC
    {
        moods[] = 
        {
            "calm","dark"
        };
        //Stage C: Lead Track 03 (The Trap)
    };

    class LeadTrack04_F_EPC
    {
        moods[] = 
        {
            "calm"
        };
        //Stage C: Lead Track 04 (In the Open)
    };

    class LeadTrack05_F_EPC
    {
        moods[] = 
        {
            "intense"
        };
        //Stage C: Lead Track 05 (Revenge)
    };

    class LeadTrack06_F_EPC
    {
        moods[] = 
        {
            "intense"
        };
        //Stage C: Lead Track 06 (Win)
    };

    class LeadTrack06b_F_EPC
    {
        moods[] = 
        {
            "calm","dark"
        };
        //Stage C: Lead Track 06 (Win - Alternative 1)
    };

    class EventTrack03_F_EPC
    {
        moods[] = 
        {
            "calm","dark"
        };
        //Stage C: Event Track 03 (Unforeseen Perdition)
    };

    class BackgroundTrack01_F_EPC
    {
        moods[] = 
        {
            "intense"
        };
        //Stage C: Background Track 01 (Alone)
    };

    class BackgroundTrack02_F_EPC
    {
        moods[] = 
        {
            "calm","dark"
        };
        //Stage C: Background Track 02 (Just Another Day)
    };

    class BackgroundTrack03_F_EPC
    {
        moods[] = 
        {
            "calm"
        };
        //Stage C: Background Track 03 (Altis Requiem)
    };

    class BackgroundTrack04_F_EPC
    {
        moods[] = 
        {
            "calm","dark"
        };
        //Stage C: Background Track 04 (Assembly)
    };

    class Fallout
    {
        moods[] = 
        {
            "calm","dark"
        };
        //Fallout
    };

    class Defcon
    {
        moods[] = 
        {
            "dark"
        };
        //Defcon
    };

    class Wasteland
    {
        moods[] = 
        {
            "dark"
        };
        //Wasteland
    };

    class SkyNet
    {
        moods[] = 
        {
            "dark","calm"
        };
        //SkyNet
    };

    class MAD
    {
        moods[] = 
        {
            "dark","calm"
        };
        //Wasteland
    };

    class LeadTrack01_F_Curator
    {
        moods[] = 
        {
            "calm"
        };
        //Zeus Theme
    };

    class LeadTrack01_F_Bootcamp
    {
        moods[] = 
        {
            "intense"
        };
        //This is War (VR Remix)
    };

    class LeadTrack02_F_Bootcamp
    {
        moods[] = 
        {
            "calm"
        };
        //Evolution
    };

    class LeadTrack03_F_Bootcamp
    {
        moods[] = 
        {
            "calm"
        };
        //Epic Split
    };

    class LeadTrack01_F_Heli
    {
        moods[] = 
        {
            "intense"
        };
        //This is War (Heli Remix)
    };

    class LeadTrack01_F_Mark
    {
        moods[] = 
        {
            "intense"
        };
        //This is War (Marksmen Remix)
    };

    class LeadTrack02_F_Mark
    {
        moods[] = 
        {
            "intense"
        };
        //Marksmen DLC: Lead Track 02 (Into the Sun)
    };

    class LeadTrack03_F_Mark
    {
        moods[] = 
        {
            "calm","dark"
        };
        //Marksmen DLC: Lead Track 03 (Marksmen)
    };

    class LeadTrack01_F_EXP
    {
        moods[] = 
        {
            "calm"
        };
        //This Is War (Apex Remix)
    };

    class LeadTrack02_F_EXP
    {
        moods[] = 
        {
            "calm"
        };
        //An Unknown Enemy
    };

    class LeadTrack03_F_EXP
    {
        moods[] = 
        {
            "intense"
        };
        //No Time For Questions
    };

    class LeadTrack04_F_EXP
    {
        moods[] = 
        {
            "calm"
        };
        //This Is War (Apex Remix - Alternative 1)
    };

    class AmbientTrack01_F_EXP
    {
        moods[] = 
        {
            "calm","dark"
        };
        //Through The Jungle
    };

    class AmbientTrack02_F_EXP
    {
        moods[] = 
        {
            "calm"
        };
        //Welcome To Tanoa
    };



    class LeadTrack01_F_Jets
    {
        moods[] = 
        {
            "calm"
        };
        //Fighter Jets
    };

    class LeadTrack02_F_Jets
    {
        moods[] = 
        {
            "calm"
        };
        //Air Power
    };

    class LeadTrack01_F_Malden
    {
        moods[] = 
        {
            "calm"
        };
        //Flashpoint
    };

    class LeadTrack02_F_Malden
    {
        moods[] = 
        {
            "calm"
        };
        //Malden
    };

    class LeadTrack01_F_Orange
    {
        moods[] = 
        {
            "intense"
        };
        //This Is War (Laws of War Remix)
    };

    class AmbientTrack02_F_Orange
    {
        moods[] = 
        {
            "dark"
        };
        //Laws of War DLC: Remnants of War
    };

    class AmbientTrack01_F_Orange
    {
        moods[] = 
        {
            "calm"
        };
        //Laws of War DLC: Ambient
    };


    class LeadTrack01_F_Tacops
    {
        moods[] = 
        {
            "intense"
        };
        //Tac-Ops DLC: Opening 1
    };


    class LeadTrack02_F_Tacops
    {
        moods[] = 
        {
            "intense"
        };
        //Tac-Ops DLC: Opening 2
    };


    class LeadTrack03_F_Tacops
    {
        moods[] = 
        {
            "intense"
        };
        //Tac-Ops DLC: Opening 3
    };


    class AmbientTrack01a_F_Tacops
    {
        moods[] = 
        {
            "dark"
        };
        //Tac-Ops DLC: Ambient 1a
    };


    class AmbientTrack01b_F_Tacops
    {
        moods[] = 
        {
            "dark"
        };
        //Tac-Ops DLC: Ambient 1b
    };


    class AmbientTrack02a_F_Tacops
    {
        moods[] = 
        {
            "dark","calm"
        };
        //Tac-Ops DLC: Ambient 2a
    };

    class AmbientTrack03a_F_Tacops
    {
        moods[] = 
        {
            "dark","calm"
        };
        //Tac-Ops DLC: Ambient 3a
    };

    class AmbientTrack03b_F_Tacops
    {
        moods[] = 
        {
            "dark","calm"
        };
        //Tac-Ops DLC: Ambient 3b
    };

    class AmbientTrack04a_F_Tacops
    {
        moods[] = 
        {
            "dark"
        };
        //Tac-Ops DLC: Ambient 4a
    };

    class AmbientTrack04b_F_Tacops
    {
        moods[] = 
        {
            "dark"
        };
        //Tac-Ops DLC: Ambient 4b
    };

    class MainTheme_F_Tank
    {
        moods[] = 
        {
            "intense"
        };
        //Tanks DLC: This is War (Tanks DLC version)
    };

    class LeadTrack01_F_Tank
    {
        moods[] = 
        {
            "intense"
        };
        //Tanks DLC: Fight for the City
    };

    class LeadTrack02_F_Tank
    {
        moods[] = 
        {
            "calm"
        };
        //Tanks DLC: Last Stand
    };

    class LeadTrack03_F_Tank
    {
        moods[] = 
        {
            "dark","calm"
        };
        //Tanks DLC: Way Back
    };

    class LeadTrack05_F_Tank
    {
        moods[] = 
        {
            "intense"
        };
        //Tanks DLC: Wrath of the Giants
    };

    class LeadTrack05_F_Tank
    {
        moods[] = 
        {
            "intense"
        };
        //Tanks DLC: Wrath of the Giants
    };

    class LeadTrack06_F_Tank
    {
        moods[] = 
        {
            "calm"
        };
        //Tanks DLC: Iron Gods
    };

    class AmbientTrack01_F_Tank
    {
        moods[] = 
        {
            "calm","dark"
        };
        //Tanks DLC: Hidden Enemy
    };

    class Music_Theme_Contact
    {
        moods[] = 
        {
            "dark"
        };
        //Contact: Transilience (Main Theme)
    };

    class Music_Credits_Contact
    {
        moods[] = 
        {
            "dark"
        };
        //Contact: Transilience (Credits)
    };

    class Music_Arrival
    {
        moods[] = 
        {
            "dark"
        };
        //Contact: Wavering Base
    };

    class Music_Roaming_Night
    {
        moods[] = 
        {
            "dark"
        };
        //Contact: Night Eyes Zero-One
    };

    class Music_Roaming_Night_02
    {
        moods[] = 
        {
            "dark"
        };
        //Contact: Night Eyes Zero-Two
    };

    class Music_Roaming_Day
    {
        moods[] = 
        {
            "dark"
        };
        //Contact: Sunrise Zero-One
    };

    class Music_Roaming_Day_02
    {
        moods[] = 
        {
            "dark"
        };
        //Contact: Sunrise Zero-One
    };

    class Music_Hostile_Drone_Close_01
    {
        moods[] = 
        {
            "dark"
        };
        //Contact: Hostile
    };

    class Music_Battle_Alien
    {
        moods[] = 
        {
            "intense"
        };
        //Contact: Contact
    };

    class Music_Battle_Human
    {
        moods[] = 
        {
            "intense"
        };
        //Contact: Infighting
    };

    class Music_Russian_Theme
    {
        moods[] = 
        {
            "intense"
        };
        //Contact: Sharper Claws
    };

    class Music_Suspended_Loop_01
    {
        moods[] = 
        {
            "dark"
        };
        //Contact: Suspense
    };

    class Music_Tension_Loop_01
    {
        moods[] = 
        {
            "dark"
        };
        //Contact: Tension
    };

    class Music_Roaming_Day_02
    {
        moods[] = 
        {
            "dark"
        };
        //Contact: Sunrise Zero-One
    };

    class Music_Roaming_Day_02
    {
        moods[] = 
        {
            "dark"
        };
        //Contact: Sunrise Zero-One
    };

    class Music_Roaming_Day_02
    {
        moods[] = 
        {
            "dark"
        };
        //Contact: Sunrise Zero-One
    };

    class Music_Roaming_Day_02
    {
        moods[] = 
        {
            "dark"
        };
        //Contact: Sunrise Zero-One
    };

    class Music_Roaming_Day_02
    {
        moods[] = 
        {
            "dark"
        };
        //Contact: Sunrise Zero-One
    };

    class Music_Roaming_Day_02
    {
        moods[] = 
        {
            "dark"
        };
        //Contact: Sunrise Zero-One
    };





};