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
        sound[] = { "\A3\music_f\Music\LeadTrack01_F.ogg", db + 0, 1.0 }; 
        //This is war
    };
    class LeadTrack01a_F
    {
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\music_f\Music\LeadTrack01a_F.ogg", db + 0, 1.0 };
        //This is war a
    };
    class LeadTrack01b_F
    {
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\music_f\Music\LeadTrack01b_F.ogg", db + 0, 1.0 };
        //This is war b
    };
    class LeadTrack01c_F
    {
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\music_f\Music\LeadTrack01c_F.ogg", db + 0, 1.0 };
        //Main menu
    };
    class LeadTrack02_F
    {
        moods[] = 
        {
            "dark",
            "intense"
        };
        sound[] = { "\A3\music_f\Music\LeadTrack02_F.ogg", db + 0, 1.0 };
        //Proteus
    };
    class LeadTrack03_F
    {
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\music_f\Music\LeadTrack03_F.ogg", db + 0, 1.0 };
        //Combined Arms
    };
    class LeadTrack04_F
    {
        moods[] = 
        {
            "intense",
            "dark"
        };
        sound[] = { "\A3\music_f\Music\LeadTrack04_F.ogg", db + 0, 1.0 };
        //Action Dark 2
    };
    class LeadTrack04a_F
    {
        moods[] = 
        {
            "intense",
            "dark"
        };
        sound[] = { "\A3\music_f\Music\LeadTrack04a_F.ogg", db + 0, 1.0 };
        //Action Dark
    };
    class LeadTrack05_F
    {
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\music_f\Music\LeadTrack05_F.ogg", db + 0, 1.0 };
        //Taking Kavala
    };
    class LeadTrack06_F
    {
        moods[] = 
        {
            "intense",
            "dark"
        };
        sound[] = { "\A3\music_f\Music\LeadTrack06_F.ogg", db + 0, 1.0 };
        //Down at the Garina bay
    };
    class AmbientTrack01_F
    {
        moods[] = 
        {
            "calm",
            "dark"
        };
        sound[] = { "\A3\music_f\Music\AmbientTrack01_F.ogg", db + 0, 1.0 };
        //East Wind Alternative 1
    };
    class AmbientTrack01a_F
    {
        moods[] = 
        {
            "calm",
            "dark"
        };
        sound[] = { "\A3\music_f\Music\AmbientTrack01a_F.ogg", db + 0, 1.0 };
        //East Wind
    };
    class AmbientTrack01b_F
    {
        moods[] = 
        {
            "calm",
            "dark"
        };
        sound[] = { "\A3\music_f\Music\AmbientTrack01b_F.ogg", db + 0, 1.0 };
        //East Wind Alternative 2
    };
    class AmbientTrack03_F
    {
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f\Music\AmbientTrack03_F.ogg", db + 0, 1.0 };
        //Solar Power
    };
     class AmbientTrack04a_F
    {
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\music_f\Music\AmbientTrack04a_F.ogg", db + 0, 1.0 };
        //Night percussions
    };
    class AmbientTrack04_F
    {
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\music_f\Music\AmbientTrack04_F.ogg", db + 0, 1.0 };
        //Night ambient
    };
    class BackgroundTrack01_F
    {
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f\Music\BackgroundTrack01_F.ogg", db + 0, 1.0 };
        //Underwater 2
    };
    class BackgroundTrack01a_F
    {
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f\Music\BackgroundTrack01a_F.ogg", db + 0, 1.0 };
    	  //Underwater
    };
    class BackgroundTrack02_F
    {
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f\Music\BackgroundTrack02_F.ogg", db + 0, 1.0 };
        //On the road
    };
    class LeadTrack01_F_EPA
    {
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f_epa\Music\LeadTrack01_F_EPA.ogg", db + 0, 1.0 };
        //Stage A: Lead Track 01 (Conquistador)
    };
    class LeadTrack02_F_EPA
    {
        moods[] = 
        {
            "calm",
            "dark"
        };
        sound[] = { "\A3\music_f_epa\Music\LeadTrack02_F_EPA.ogg", db + 0, 1.0 };
        //Stage A: Lead Track 02 (Aegis Blues)
    };
    class LeadTrack02a_F_EPA
    {
        moods[] = 
        {
            "calm",
            "dark"
        };
        sound[] = { "\A3\music_f_epa\Music\LeadTrack02a_F_EPA.ogg", db + 0, 1.0 };
        //Stage A: Lead Track 02 (Aegis Blues - Alternative 1)
    };
    class LeadTrack02b_F_EPA
    {
        moods[] = 
        {
            "calm",
            "dark"
        };
        sound[] = { "\A3\music_f_epa\Music\LeadTrack02b_F_EPA.ogg", db + 0, 1.0 };
        //Stage A: Lead Track 02 (Aegis Blues - Alternative 2)
    };
    class LeadTrack03_F_EPA
    {
        moods[] = 
        {
            "dark",
            "intense"
        };
        sound[] = { "\A3\music_f_epa\Music\LeadTrack03_F_EPA.ogg", db + 0, 1.0 };
        //Stage A: Lead Track 03 (Survive the Hard Part)
    };

    class LeadTrack01_F_EPB
    {
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f_epb\Music\LeadTrack01_F_EPB.ogg", db + 0, 1.0 };
        //Stage B: Lead Track 01 (Adapt)
    };

    class LeadTrack01a_F_EPB
    {
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f_epb\Music\LeadTrack01a_F_EPB.ogg", db + 0, 1.0 };
        //Stage B: Lead Track 01 (Adapt - Alternative)
    };
    class LeadTrack02_F_EPB
    {
        moods[] = 
        {
            "dark",
            "intense"
        };
        sound[] = { "\A3\music_f_epb\Music\LeadTrack02_F_EPB.ogg", db + 0, 1.0 };
        //Stage B: Lead Track 02 (Exit Strategy)
    };
    class LeadTrack02a_F_EPB
    {
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\music_f_epb\Music\LeadTrack02a_F_EPB.ogg", db + 0, 1.0 };
        //Stage B: Lead Track 02 (Exit Strategy - Alternative 1)
    };
    class LeadTrack02b_F_EPB
    {
        moods[] = 
        {
            "dark",
            "intense"
        };
        sound[] = { "\A3\music_f_epb\Music\LeadTrack02b_F_EPB.ogg", db + 0, 1.0 };
        //Stage B: Lead Track 02 (Exit Strategy - Alternative 2)
    };
    class LeadTrack03_F_EPB
    {
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\music_f_epb\Music\LeadTrack03_F_EPB.ogg", db + 0, 1.0 };
        //Stage B: Lead Track 03 (Beyond Recognition)
    };

    class LeadTrack03a_F_EPB
    {
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\music_f_epb\Music\LeadTrack03a_F_EPB.ogg", db + 0, 1.0 };
        //Stage B: Lead Track 03 (Beyond Recognition - Alternative 1)
    };


    class LeadTrack04_F_EPB
    {
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\music_f_epb\Music\LeadTrack04_F_EPB.ogg", db + 0, 1.0 };
        //Stage B: Lead Track 04 (Canton Protocol)

    };

    class AmbientTrack01_F_EPB
    {
        moods[] = 
        {
            "dark","calm"
        };
        sound[] = { "\A3\music_f_epb\Music\AmbientTrack01_F_EPB.ogg", db + 0, 1.0 };
        //Stage B: Ambient Track 01 (Signal Lost)
    };
    class BackgroundTrack01_F_EPB
    {
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\music_f_epb\Music\BackgroundTrack01_F_EPB.ogg", db + 0, 1.0 };
        //Stage B: Background Track 01 (The Hunt)
    };
    class LeadTrack01_F_EPC
    {
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f_EPC\Music\LeadTrack01_F_EPC.ogg", db + 0, 1.0 };
        //Stage C: Lead Track 01 (Back on Stratis)

    };
    class LeadTrack02_F_EPC
    {
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\music_f_EPC\Music\LeadTrack02_F_EPC.ogg", db + 0, 1.0 };
        //Stage C: Lead Track 02 (LZ hot)
    };

    class LeadTrack03_F_EPC
    {
        moods[] = 
        {
            "calm","dark"
        };
        sound[] = { "\A3\music_f_EPC\Music\LeadTrack03_F_EPC.ogg", db + 0, 1.0 };
        //Stage C: Lead Track 03 (The Trap)
    };

    class LeadTrack04_F_EPC
    {
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f_EPC\Music\LeadTrack04_F_EPC.ogg", db + 0, 1.0 };
        //Stage C: Lead Track 04 (In the Open)
    };

    class LeadTrack05_F_EPC
    {
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\music_f_EPC\Music\LeadTrack05_F_EPC.ogg", db + 0, 1.0 };
        //Stage C: Lead Track 05 (Revenge)
    };

    class LeadTrack06_F_EPC
    {
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\music_f_EPC\Music\LeadTrack06_F_EPC.ogg", db + 0, 1.0 };
        //Stage C: Lead Track 06 (Win)
    };

    class LeadTrack06b_F_EPC
    {
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f_EPC\Music\LeadTrack06b_F_EPC.ogg", db + 0, 1.0 };
        //Stage C: Lead Track 06 (Win - Alternative 1)
    };

    class EventTrack03_F_EPC
    {
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\music_f_EPC\Music\EventTrack03_F_EPC.ogg", db + 0, 1.0 };
        //Stage C: Event Track 03 (Unforeseen Perdition)
    };

    class BackgroundTrack01_F_EPC
    {
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\music_f_EPC\Music\BackgroundTrack01_F_EPC.ogg", db + 0, 1.0 };
        //Stage C: Background Track 01 (Alone)
    };

    class BackgroundTrack02_F_EPC
    {
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f_EPC\Music\BackgroundTrack02_F_EPC.ogg", db + 0, 1.0 };
        //Stage C: Background Track 02 (Just Another Day)
    };

    class BackgroundTrack03_F_EPC
    {
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f_EPC\Music\BackgroundTrack03_F_EPC.ogg", db + 0, 1.0 };
        //Stage C: Background Track 03 (Altis Requiem)
    };

    class BackgroundTrack04_F_EPC
    {
        moods[] = 
        {
            "calm","dark"
        };
        sound[] = { "\A3\music_f_EPC\Music\BackgroundTrack04_F_EPC.ogg", db + 0, 1.0 };
        //Stage C: Background Track 04 (Assembly)
    };

    class Fallout
    {
        moods[] = 
        {
            "calm","dark"
        };
        sound[] = { "A3\Missions_F_EPA\data\music\fallout.ogg", db + 0, 1.0 };
        //Fallout
    };

    class Defcon
    {
        moods[] = 
        {
            "dark"
        };
        sound[] = { "A3\Missions_F_EPA\data\music\defcon.ogg", db + 0, 1.0 };
        //Defcon
    };

    class Wasteland
    {
        moods[] = 
        {
            "dark"
        };
        sound[] = { "A3\Missions_F_EPA\data\music\wasteland.ogg", db + 0, 1.0 };
        //Wasteland
    };

    class SkyNet
    {
        moods[] = 
        {
            "dark","calm"
        };
        sound[] = { "A3\Missions_F_EPA\data\music\skynet.ogg", db + 0, 1.0 };
        //SkyNet
    };

    class MAD
    {
        moods[] = 
        {
            "dark","calm"
        };
        sound[] = { "A3\Missions_F_EPA\data\music\mad.ogg", db + 0, 1.0 };
        //Wasteland
    };

    class LeadTrack01_F_Curator
    {
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\Data_F_Curator\Music\LeadTrack01_F_Curator.ogg", db + 0, 1.0 };
        //Zeus Theme
    };

    class LeadTrack01_F_Bootcamp
    {
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\music_f_Bootcamp\Music\LeadTrack01_F_Bootcamp.ogg", db + 0, 1.0 };
        //This is War (VR Remix)
    };

    class LeadTrack02_F_Bootcamp
    {
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f_Bootcamp\Music\LeadTrack02_F_Bootcamp.ogg", db + 0, 1.0 };
        //Evolution
    };

    class LeadTrack03_F_Bootcamp
    {
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f_Bootcamp\Music\LeadTrack03_F_Bootcamp.ogg", db + 0, 1.0 };
        //Epic Split
    };

    class LeadTrack01_F_Heli
    {
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\music_f_Heli\Music\LeadTrack01_F_Heli.ogg", db + 0, 1.0 };
        //This is War (Heli Remix)
    };

    class LeadTrack01_F_Mark
    {
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\Music_f_Mark\Music\LeadTrack01_F_Mark.ogg", db + 0, 1.0 };
        //This is War (Marksmen Remix)
    };

    class LeadTrack02_F_Mark
    {
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\Music_f_Mark\Music\LeadTrack02_F_Mark.ogg", db + 0, 1.0 };
        //Marksmen DLC: Lead Track 02 (Into the Sun)
    };

    class LeadTrack03_F_Mark
    {
        moods[] = 
        {
            "calm","dark"
        };
        sound[] = { "\A3\Music_f_Mark\Music\LeadTrack03_F_Mark.ogg", db + 0, 1.0 };
        //Marksmen DLC: Lead Track 03 (Marksmen)
    };

    class LeadTrack01_F_EXP
    {
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f_exp\Music\LeadTrack01_F_EXP.ogg", db + 0, 1.0 };
        //This Is War (Apex Remix)
    };

    class LeadTrack02_F_EXP
    {
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\music_f_exp\Music\LeadTrack02_F_EXP.ogg", db + 0, 1.0 };
        //An Unknown Enemy
    };

    class LeadTrack03_F_EXP
    {
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\music_f_exp\Music\LeadTrack03_F_EXP.ogg", db + 0, 1.0 };
        //No Time For Questions
    };

    class LeadTrack04_F_EXP
    {
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f_exp\Music\LeadTrack04_F_EXP.ogg", db + 0, 1.0 };
        //This Is War (Apex Remix - Alternative 1)
    };

    class AmbientTrack01_F_EXP
    {
        moods[] = 
        {
            "calm","dark"
        };
        sound[] = { "\A3\music_f_exp\Music\AmbientTrack01_F_EXP.ogg", db + 0, 1.0 };
        //Through The Jungle
    };

    class AmbientTrack02_F_EXP
    {
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f_exp\Music\AmbientTrack02_F_EXP.ogg", db + 0, 1.0 };
        //Welcome To Tanoa
    };



    class LeadTrack01_F_Jets
    {
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\Music_F_Jets\Music\LeadTrack01_F_Jets.ogg", db + 0, 1.0 };
        //Fighter Jets
    };

    class LeadTrack02_F_Jets
    {
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\Music_F_Jets\Music\LeadTrack02_F_Jets.ogg", db + 0, 1.0 };
        //Air Power
    };

    class LeadTrack01_F_Malden
    {
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\Music_F_Argo\Music\LeadTrack01_F_Malden.ogg", db + 0, 1.0 };
        //Flashpoint
    };

    class LeadTrack02_F_Malden
    {
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\Music_F_Argo\Music\LeadTrack02_F_Malden.ogg", db + 0, 1.0 };
        //Malden
    };

    class LeadTrack01_F_Orange
    {
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\Music_F_Orange\Music\LeadTrack01_F_Orange.ogg", db + 0, 1.0 };
        //This Is War (Laws of War Remix)
    };

    class AmbientTrack02_F_Orange
    {
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\Music_F_Orange\Music\AmbientTrack02_F_Orange.ogg", db + 0, 1.0 };
        //Laws of War DLC: Remnants of War
    };

    class AmbientTrack01_F_Orange
    {
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\Music_F_Orange\Music\AmbientTrack01_F_Orange.ogg", db + 0, 1.0 };
        //Laws of War DLC: Ambient
    };


    class LeadTrack01_F_Tacops
    {
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\Music_F_Tacops\Music\LeadTrack01_F_Tacops.ogg", db + 0, 1.0 };
        //Tac-Ops DLC: Opening 1
    };


    class LeadTrack02_F_Tacops
    {
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\Music_F_Tacops\Music\LeadTrack02_F_Tacops.ogg", db + 0, 1.0 };
        //Tac-Ops DLC: Opening 2
    };


    class LeadTrack03_F_Tacops
    {
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\Music_F_Tacops\Music\LeadTrack03_F_Tacops.ogg", db + 0, 1.0 };
        //Tac-Ops DLC: Opening 3
    };


    class AmbientTrack01a_F_Tacops
    {
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\Music_F_Tacops\Music\AmbientTrack01a_F_Tacops.ogg", db + 0, 1.0 };
        //Tac-Ops DLC: Ambient 1a
    };


    class AmbientTrack01b_F_Tacops
    {
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\Music_F_Tacops\Music\AmbientTrack01b_F_Tacops.ogg", db + 0, 1.0 };
        //Tac-Ops DLC: Ambient 1b
    };


    class AmbientTrack02a_F_Tacops
    {
        moods[] = 
        {
            "dark","calm"
        };
        sound[] = { "\A3\Music_F_Tacops\Music\AmbientTrack02a_F_Tacops.ogg", db + 0, 1.0 };
        //Tac-Ops DLC: Ambient 2a
    };

    class AmbientTrack02b_F_Tacops
    {
        moods[] = 
        {
            "dark","calm"
        };
        sound[] = { "\A3\Music_F_Tacops\Music\AmbientTrack02b_F_Tacops.ogg", db + 0, 1.0 };
        //Tac-Ops DLC: Ambient 2b
    };

    class AmbientTrack03a_F_Tacops
    {
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\Music_F_Tacops\Music\AmbientTrack03a_F_Tacops.ogg", db + 0, 1.0 };
        //Tac-Ops DLC: Ambient 3a
    };

    class AmbientTrack03b_F_Tacops
    {
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\Music_F_Tacops\Music\AmbientTrack03b_F_Tacops.ogg", db + 0, 1.0 };
        //Tac-Ops DLC: Ambient 3b
    };

    class AmbientTrack04a_F_Tacops
    {
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\Music_F_Tacops\Music\AmbientTrack04a_F_Tacops.ogg", db + 0, 1.0 };
        //Tac-Ops DLC: Ambient 4a
    };

    class AmbientTrack04b_F_Tacops
    {
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\Music_F_Tacops\Music\AmbientTrack04b_F_Tacops.ogg", db + 0, 1.0 };
        //Tac-Ops DLC: Ambient 4b
    };

    class MainTheme_F_Tank
    {
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\Music_F_Tank\MainTheme_F_Tank.ogg", db + 0, 1.0 };
        //Tanks DLC: This is War (Tanks DLC version)
    };

    class LeadTrack01_F_Tank
    {
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\Music_F_Tank\LeadTrack01_F_Tank.ogg", db + 0, 1.0 };
        //Tanks DLC: Fight for the City
    };

    class LeadTrack02_F_Tank
    {
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\Music_F_Tank\LeadTrack02_F_Tank.ogg", db + 0, 1.0 };
        //Tanks DLC: Last Stand
    };

    class LeadTrack03_F_Tank
    {
        moods[] = 
        {
            "dark","calm"
        };
        sound[] = { "\A3\Music_F_Tank\LeadTrack03_F_Tank.ogg", db + 0, 1.0 };
        //Tanks DLC: Way Back
    };

    class LeadTrack05_F_Tank
    {
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\Music_F_Tank\LeadTrack05_F_Tank.ogg", db + 0, 1.0 };
        //Tanks DLC: Wrath of the Giants
    };

    class LeadTrack06_F_Tank
    {
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\Music_F_Tank\LeadTrack06_F_Tank.ogg", db + 0, 1.0 };
        //Tanks DLC: Iron Gods
    };

    class AmbientTrack01_F_Tank
    {
        moods[] = 
        {
            "calm","dark"
        };
        sound[] = { "\A3\Music_F_Tank\AmbientTrack01_F_Tank.ogg", db + 0, 1.0 };
        //Tanks DLC: Hidden Enemy
    };

    // FIREDNEAR HAS A MAX RANGE OF ~69M WTF ILLUMINATI CONFIRMED
    // lmaoxd

    /*
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
        //Contact: Sunrise Zero-Two
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
            "dark","intense"
        };
        //Contact: Tension
    };



    class Track_C_01
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man 01
    };

    class Track_C_02
    {
        moods[] = 
        {
            "dark","calm"
        };
        //Old Man 02
    };

    class Track_C_03
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man 03
    };

    class Track_C_04
    {
        moods[] = 
        {
            "dark"
        };
        //Old Man 04
    };

    class Track_C_05
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man 05
    };

    class Track_C_06
    {
        moods[] = 
        {
            "dark"
        };
        //Old Man 06
    };

    class Track_C_07
    {
        moods[] = 
        {
            "intense"
        };
        //Old Man 07
    };

    class Track_C_08
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man 08
    };

    class Track_C_09
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man 09
    };

    class Track_C_10
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man 10
    };

    class Track_C_11
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man 11
    };

    class Track_C_12
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man 12
    };

    class Track_C_13
    {
        moods[] = 
        {
            "dark"
        };
        //Old Man 13
    };

    class Track_C_14
    {
        moods[] = 
        {
            "dark"
        };
        //Old Man 14
    };

    class Track_C_15
    {
        moods[] = 
        {
            "dark"
        };
        //Old Man 15
    };

    class Track_C_16
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man 16
    };

    class Track_C_17
    {
        moods[] = 
        {
            "dark"
        };
        //Old Man 17
    };

    class Track_C_18
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man 18
    };

    class Track_C_19
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man 19
    };

    class Track_C_20
    {
        moods[] = 
        {
            "calm"
        };
        //Old man 20
    };

    class Track_D_01
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man: Dance 01
    };

    class Track_D_02
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man : Dance 02
    };

    class Track_D_03
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man : Dance 03
    };

    class Track_M_01
    {
        moods[] = 
        {
            "intense"
        };
        //Old Man : Metal 01
    };

    class Track_M_02
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man : Metal 02
    };

    class Track_M_03
    {
        moods[] = 
        {
            "intense"
        };
        //Old Man : Metal 03
    };

    class Track_O_01
    {
        moods[] = 
        {
            "intense"
        };
        //Old Man OST 01
    };

    class Track_O_02
    {
        moods[] = 
        {
            "intense"
        };
        //Old Man OST 02
    };

    class Track_O_03
    {
        moods[] = 
        {
            "intense"
        };
        //Old Man OST 03
    };

    class Track_O_04
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man OST 04
    };

    class Track_O_05
    {
        moods[] = 
        {
            "dark","calm"
        };
        //Old Man OST 05
    };

    class Track_O_06
    {
        moods[] = 
        {
            "intense"
        };
        //Old Man OST 06
    };

    class Track_O_07
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man OST 07
    };

    class Track_O_08
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man OST 08
    };

    class Track_O_09
    {
        moods[] = 
        {
            "intense"
        };
        //Old Man OST 09
    };

    class Track_O_10
    {
        moods[] = 
        {
            "intense"
        };
        //Old Man OST 10
    };

    class Track_O_12
    {
        moods[] = 
        {
            "intense"
        };
        //Old Man OST 12
    };

    class Track_O_14
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man OST 14
    };

    class Track_O_15
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man OST 15
    };

    class Track_O_16
    {
        moods[] = 
        {
            "intense"
        };
        //Old Man OST 16
    };

    class Track_P_05
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man Pop 05
    };

    class Track_P_11
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man Pop 11
    };

    class Track_P_12
    {
        moods[] = 
        {
            "dark","intense"
        };
        //Old Man Pop 12
    };

    class Track_P_13
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man Pop 13
    };

    class Track_P_14
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man Pop 14
    };

    class Track_P_15
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man Pop 15
    };

    class Track_P_16
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man Pop 16
    };

    class Track_P_17
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man Pop 17
    };

    class Track_R_01
    {
        moods[] = 
        {
            "intense"
        };
        //Old Man Rock 01
    };

    class Track_R_02
    {
        moods[] = 
        {
            "dark","intense"
        };
        //Old Man Rock 02
    };

    class Track_R_03
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man Rock 03
    };

    class Track_R_04
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man Rock 04
    };

    class Track_R_05
    {
        moods[] = 
        {
            "intense"
        };
        //Old Man Rock 05
    };

    class Track_R_06
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man Rock 06
    };

    class Track_R_07
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man Rock 07
    };

    class Track_R_08
    {
        moods[] = 
        {
            "intense"
        };
        //Old Man Rock 08
    };

    class Track_R_09
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man Rock 09
    };

    class Track_R_10
    {
        moods[] = 
        {
            "intense"
        };
        //Old Man Rock 10
    };

    class Track_R_11
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man Rock 11
    };

    class Track_R_13
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man Rock 13
    };

    class Track_R_14
    {
        moods[] = 
        {
            "intense"
        };
        //Old Man Rock 14
    };

    class Track_R_15
    {
        moods[] = 
        {
            "intense"
        };
        //Old Man Rock 15
    };

    class Track_R_16
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man Rock 16
    };

    class Track_R_17
    {
        moods[] = 
        {
            "intense"
        };
        //Old Man Rock 17
    };

    class Track_R_18
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man Rock 18
    };

    class Track_R_19
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man Rock 19
    };

    class Track_R_20
    {
        moods[] = 
        {
            "intense"
        };
        //Old Man Rock 20
    };

    class Track_R_21
    {
        moods[] = 
        {
            "intense"
        };
        //Old Man Rock 21
    };

    class Track_R_22
    {
        moods[] = 
        {
            "intense"
        };
        //Old Man Rock 22
    };

    class Track_R_23
    {
        moods[] = 
        {
            "intense"
        };
        //Old Man Rock 23
    };

    class Track_R_24
    {
        moods[] = 
        {
            "calm"
        };
        //Old Man Rock 24
    };

    class OM_Music02
    {
        moods[] = 
        {
            "dark"
        };
        //Old Man: Ambient Music 01
    };

    class OM_Music03
    {
        moods[] = 
        {
            "dark"
        };
        //Old Man: Ambient Music 02
    };*/





};