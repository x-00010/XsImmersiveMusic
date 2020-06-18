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

class CfgVehicles 
{
    class Man;
    class CAManBase: Man 
    {
        class ACE_SelfActions 
        {
            class skipSong
            {
                displayName = "Skip song";
                condition = "((leader (group player) == player) or !isMultiplayer) and (!(group player getVariable ['XIM_bMusicStopped', false]))";
                exceptions[] = {};
                statement = "[player] call XIM_fncPlayNext";
            };
            class stopMusic
            {
                displayName = "Stop music";
                condition = "(leader (group player) == player) or !isMultiplayer and (!(group player getVariable ['XIM_bMusicStopped', false]))";
                exceptions[] = {};
                statement = "[] call XIM_fncStopMusic";
            };
            class startMusic
            {
                displayName = "Start music";
                condition = "((leader (group player) == player) or !isMultiplayer) and (group player getVariable ['XIM_bMusicStopped', false])";
                exceptions[] = {};
                statement = "[] call XIM_fncStartMusic";
            };
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

class CfgMusic
{
    class LeadTrack01_F
    {
        name = "This Is War";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\music_f\Music\LeadTrack01_F.ogg", db + 0, 1.0 }; 
        //This is war
    };
    class LeadTrack01a_F
    {
        name = "This Is War";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\music_f\Music\LeadTrack01a_F.ogg", db + 0, 1.0 };
        //This is war a
    };
    class LeadTrack01b_F
    {
        name = "This Is War";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\music_f\Music\LeadTrack01b_F.ogg", db + 0, 1.0 };
        //This is war b
    };
    class LeadTrack01c_F
    {
        name = "This Is War";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\music_f\Music\LeadTrack01c_F.ogg", db + 0, 1.0 };
        //Main menu
    };
    class LeadTrack02_F
    {
        name = "Proteus";
        artist = "Bohemia Interactive";
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
        name = "Combined Arms";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\music_f\Music\LeadTrack03_F.ogg", db + 0, 1.0 };
        //Combined Arms
    };
    class LeadTrack04_F
    {
        name = "Action Dark 2";
        artist = "Bohemia Interactive";
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
        name = "Action Dark";
        artist = "Bohemia Interactive";
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
        name = "Taking Kavala";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\music_f\Music\LeadTrack05_F.ogg", db + 0, 1.0 };
        //Taking Kavala
    };
    class LeadTrack06_F
    {
        name = "Down at the Garina bay";
        artist = "Bohemia Interactive";
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
        name = "East Wind - Alternative";
        artist = "Bohemia Interactive";
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
        name = "East Wind";
        artist = "Bohemia Interactive";
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
        name = "East Wind - Alternative 2";
        artist = "Bohemia Interactive";
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
        name = "Solar Power";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f\Music\AmbientTrack03_F.ogg", db + 0, 1.0 };
        //Solar Power
    };
     class AmbientTrack04a_F
    {
        name = "Night percussions";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\music_f\Music\AmbientTrack04a_F.ogg", db + 0, 1.0 };
        //Night percussions
    };
    class AmbientTrack04_F
    {
        name = "Night ambient";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\music_f\Music\AmbientTrack04_F.ogg", db + 0, 1.0 };
        //Night ambient
    };
    class BackgroundTrack01_F
    {
        name = "Underwater 2";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f\Music\BackgroundTrack01_F.ogg", db + 0, 1.0 };
        //Underwater 2
    };
    class BackgroundTrack01a_F
    {
        name = "Underwater";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f\Music\BackgroundTrack01a_F.ogg", db + 0, 1.0 };
    	  //Underwater
    };
    class BackgroundTrack02_F
    {
        name = "On the road";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f\Music\BackgroundTrack02_F.ogg", db + 0, 1.0 };
        //On the road
    };
    class LeadTrack01_F_EPA
    {
        name = "Conquistador";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f_epa\Music\LeadTrack01_F_EPA.ogg", db + 0, 1.0 };
        //Stage A: Lead Track 01 (Conquistador)
    };
    class LeadTrack02_F_EPA
    {
        name = "Aegis Blues";
        artist = "Bohemia Interactive";
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
        name = "Aegis Blues - Alternative";
        artist = "Bohemia Interactive";
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
        name = "Aegis Blues - Alternative 2";
        artist = "Bohemia Interactive";
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
        name = "Survive the Hard Part";
        artist = "Bohemia Interactive";
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
        name = "Adapt";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f_epb\Music\LeadTrack01_F_EPB.ogg", db + 0, 1.0 };
        //Stage B: Lead Track 01 (Adapt)
    };

    class LeadTrack01a_F_EPB
    {
        name = "Adapt - Alternative";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f_epb\Music\LeadTrack01a_F_EPB.ogg", db + 0, 1.0 };
        //Stage B: Lead Track 01 (Adapt - Alternative)
    };
    class LeadTrack02_F_EPB
    {
        name = "Exit Strategy";
        artist = "Bohemia Interactive";
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
        name = "Exit Strategy - Alternative";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\music_f_epb\Music\LeadTrack02a_F_EPB.ogg", db + 0, 1.0 };
        //Stage B: Lead Track 02 (Exit Strategy - Alternative 1)
    };
    class LeadTrack02b_F_EPB
    {
        name = "Exit Strategy - Alternative 2";
        artist = "Bohemia Interactive";
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
        name = "Beyond Recognition";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\music_f_epb\Music\LeadTrack03_F_EPB.ogg", db + 0, 1.0 };
        //Stage B: Lead Track 03 (Beyond Recognition)
    };

    class LeadTrack03a_F_EPB
    {
        name = "Beyond Recognition - Alternative 1";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\music_f_epb\Music\LeadTrack03a_F_EPB.ogg", db + 0, 1.0 };
        //Stage B: Lead Track 03 (Beyond Recognition - Alternative 1)
    };


    class LeadTrack04_F_EPB
    {
        name = "Canton Protocol";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\music_f_epb\Music\LeadTrack04_F_EPB.ogg", db + 0, 1.0 };
        //Stage B: Lead Track 04 (Canton Protocol)

    };

    class AmbientTrack01_F_EPB
    {
        name = "Signal Lost";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark",
            "calm"
        };
        sound[] = { "\A3\music_f_epb\Music\AmbientTrack01_F_EPB.ogg", db + 0, 1.0 };
        //Stage B: Ambient Track 01 (Signal Lost)
    };
    class BackgroundTrack01_F_EPB
    {
        name = "The Hunt";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\music_f_epb\Music\BackgroundTrack01_F_EPB.ogg", db + 0, 1.0 };
        //Stage B: Background Track 01 (The Hunt)
    };
    class LeadTrack01_F_EPC
    {
        name = "Back on Stratis";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f_EPC\Music\LeadTrack01_F_EPC.ogg", db + 0, 1.0 };
        //Stage C: Lead Track 01 (Back on Stratis)

    };
    class LeadTrack02_F_EPC
    {
        name = "LZ hot";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\music_f_EPC\Music\LeadTrack02_F_EPC.ogg", db + 0, 1.0 };
        //Stage C: Lead Track 02 (LZ hot)
    };

    class LeadTrack03_F_EPC
    {
        name = "The Trap";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm","dark"
        };
        sound[] = { "\A3\music_f_EPC\Music\LeadTrack03_F_EPC.ogg", db + 0, 1.0 };
        //Stage C: Lead Track 03 (The Trap)
    };

    class LeadTrack04_F_EPC
    {
        name = "In the Open";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f_EPC\Music\LeadTrack04_F_EPC.ogg", db + 0, 1.0 };
        //Stage C: Lead Track 04 (In the Open)
    };

    class LeadTrack05_F_EPC
    {
        name = "Revenge";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\music_f_EPC\Music\LeadTrack05_F_EPC.ogg", db + 0, 1.0 };
        //Stage C: Lead Track 05 (Revenge)
    };

    class LeadTrack06_F_EPC
    {
        name = "Win";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\music_f_EPC\Music\LeadTrack06_F_EPC.ogg", db + 0, 1.0 };
        //Stage C: Lead Track 06 (Win)
    };

    class LeadTrack06b_F_EPC
    {
        name = "Win - Alternative 1";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f_EPC\Music\LeadTrack06b_F_EPC.ogg", db + 0, 1.0 };
        //Stage C: Lead Track 06 (Win - Alternative 1)
    };

    class EventTrack03_F_EPC
    {
        name = "Unforeseen Perdition";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\music_f_EPC\Music\EventTrack03_F_EPC.ogg", db + 0, 1.0 };
        //Stage C: Event Track 03 (Unforeseen Perdition)
    };

    class BackgroundTrack01_F_EPC
    {
        name = "Alone";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\music_f_EPC\Music\BackgroundTrack01_F_EPC.ogg", db + 0, 1.0 };
        //Stage C: Background Track 01 (Alone)
    };

    class BackgroundTrack02_F_EPC
    {
        name = "Just Another Day";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f_EPC\Music\BackgroundTrack02_F_EPC.ogg", db + 0, 1.0 };
        //Stage C: Background Track 02 (Just Another Day)
    };

    class BackgroundTrack03_F_EPC
    {
        name = "Altis Reqiuem";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f_EPC\Music\BackgroundTrack03_F_EPC.ogg", db + 0, 1.0 };
        //Stage C: Background Track 03 (Altis Requiem)
    };

    class BackgroundTrack04_F_EPC
    {
        name = "Assembly";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm",
            "dark"
        };
        sound[] = { "\A3\music_f_EPC\Music\BackgroundTrack04_F_EPC.ogg", db + 0, 1.0 };
        //Stage C: Background Track 04 (Assembly)
    };

    class Fallout
    {
        name = "Fallout";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm",
            "dark"
        };
        sound[] = { "A3\Missions_F_EPA\data\music\fallout.ogg", db + 0, 1.0 };
        //Fallout
    };

    class Defcon
    {
        name = "Defcon";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "A3\Missions_F_EPA\data\music\defcon.ogg", db + 0, 1.0 };
        //Defcon
    };

    class Wasteland
    {
        name = "Wasteland";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "A3\Missions_F_EPA\data\music\wasteland.ogg", db + 0, 1.0 };
        //Wasteland
    };

    class SkyNet
    {
        name = "SkyNet";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark","calm"
        };
        sound[] = { "A3\Missions_F_EPA\data\music\skynet.ogg", db + 0, 1.0 };
        //SkyNet
    };

    class MAD
    {
        name = "Wasteland";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark","calm"
        };
        sound[] = { "A3\Missions_F_EPA\data\music\mad.ogg", db + 0, 1.0 };
        //Wasteland
    };

    class LeadTrack01_F_Curator
    {
        name = "Zeus DLC: Zeus";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\Data_F_Curator\Music\LeadTrack01_F_Curator.ogg", db + 0, 1.0 };
        //Zeus Theme
    };

    class LeadTrack01_F_Bootcamp
    {
        name = "This Is War (VR Remix)";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\music_f_Bootcamp\Music\LeadTrack01_F_Bootcamp.ogg", db + 0, 1.0 };
        //This is War (VR Remix)
    };

    class LeadTrack02_F_Bootcamp
    {
        name = "Evolution";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f_Bootcamp\Music\LeadTrack02_F_Bootcamp.ogg", db + 0, 1.0 };
        //Evolution
    };

    class LeadTrack03_F_Bootcamp
    {
        name = "Epic Split";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f_Bootcamp\Music\LeadTrack03_F_Bootcamp.ogg", db + 0, 1.0 };
        //Epic Split
    };

    class LeadTrack01_F_Heli
    {
        name = "This Is War (Helicopters Remix)";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\music_f_Heli\Music\LeadTrack01_F_Heli.ogg", db + 0, 1.0 };
        //This is War (Heli Remix)
    };

    class LeadTrack01_F_Mark
    {
        name = "This Is War (Marksmen Remix)";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\Music_f_Mark\Music\LeadTrack01_F_Mark.ogg", db + 0, 1.0 };
        //This is War (Marksmen Remix)
    };

    class LeadTrack02_F_Mark
    {
        name = "Marksmen DLC: Into the Sun";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\Music_f_Mark\Music\LeadTrack02_F_Mark.ogg", db + 0, 1.0 };
        //Marksmen DLC: Lead Track 02 (Into the Sun)
    };

    class LeadTrack03_F_Mark
    {
        name = "Marksmen DLC: Marksmen";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm","dark"
        };
        sound[] = { "\A3\Music_f_Mark\Music\LeadTrack03_F_Mark.ogg", db + 0, 1.0 };
        //Marksmen DLC: Lead Track 03 (Marksmen)
    };

    class LeadTrack01_F_EXP
    {
        name = "This Is War (Apex Remix)";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f_exp\Music\LeadTrack01_F_EXP.ogg", db + 0, 1.0 };
        //This Is War (Apex Remix)
    };

    class LeadTrack02_F_EXP
    {
        name = "Apex DLC: An Unknown Enemy";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\music_f_exp\Music\LeadTrack02_F_EXP.ogg", db + 0, 1.0 };
        //An Unknown Enemy
    };

    class LeadTrack03_F_EXP
    {
        name = "Apex DLC: No Time For Questions";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\music_f_exp\Music\LeadTrack03_F_EXP.ogg", db + 0, 1.0 };
        //No Time For Questions
    };

    class LeadTrack04_F_EXP
    {
        name = "This Is War (Apex Remix - Alternative)";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f_exp\Music\LeadTrack04_F_EXP.ogg", db + 0, 1.0 };
        //This Is War (Apex Remix - Alternative 1)
    };

    class AmbientTrack01_F_EXP
    {
        name = "Apex DLC: Through The Jungle";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm","dark"
        };
        sound[] = { "\A3\music_f_exp\Music\AmbientTrack01_F_EXP.ogg", db + 0, 1.0 };
        //Through The Jungle
    };

    class AmbientTrack02_F_EXP
    {
        name = "Apex DLC: Welcome To Tanoa";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\music_f_exp\Music\AmbientTrack02_F_EXP.ogg", db + 0, 1.0 };
        //Welcome To Tanoa
    };



    class LeadTrack01_F_Jets
    {
        name = "Jets DLC: Fighter Jets";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\Music_F_Jets\Music\LeadTrack01_F_Jets.ogg", db + 0, 1.0 };
        //Fighter Jets
    };

    class LeadTrack02_F_Jets
    {
        name = "Jets DLC: Air Power";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\Music_F_Jets\Music\LeadTrack02_F_Jets.ogg", db + 0, 1.0 };
        //Air Power
    };

    class LeadTrack01_F_Malden
    {
        name = "Malden DLC: Flashpoint";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\Music_F_Argo\Music\LeadTrack01_F_Malden.ogg", db + 0, 1.0 };
        //Flashpoint
    };

    class LeadTrack02_F_Malden
    {
        name = "Malden DLC: Malden";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\Music_F_Argo\Music\LeadTrack02_F_Malden.ogg", db + 0, 1.0 };
        //Malden
    };

    class LeadTrack01_F_Orange
    {
        name = "This Is War (Laws of War Remix)";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\Music_F_Orange\Music\LeadTrack01_F_Orange.ogg", db + 0, 1.0 };
        //This Is War (Laws of War Remix)
    };

    class AmbientTrack02_F_Orange
    {
        name = "Laws of War DLC: Remnants of War";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\Music_F_Orange\Music\AmbientTrack02_F_Orange.ogg", db + 0, 1.0 };
        //Laws of War DLC: Remnants of War
    };

    class AmbientTrack01_F_Orange
    {
        name = "Laws of War DLC: Ambient";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\Music_F_Orange\Music\AmbientTrack01_F_Orange.ogg", db + 0, 1.0 };
        //Laws of War DLC: Ambient
    };


    class LeadTrack01_F_Tacops
    {
        name = "Tac-Ops DLC: Opening";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\Music_F_Tacops\Music\LeadTrack01_F_Tacops.ogg", db + 0, 1.0 };
        //Tac-Ops DLC: Opening 1
    };


    class LeadTrack02_F_Tacops
    {
        name = "Tac-Ops DLC: Opening";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\Music_F_Tacops\Music\LeadTrack02_F_Tacops.ogg", db + 0, 1.0 };
        //Tac-Ops DLC: Opening 2
    };


    class LeadTrack03_F_Tacops
    {
        name = "Tac-Ops DLC: Opening";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\Music_F_Tacops\Music\LeadTrack03_F_Tacops.ogg", db + 0, 1.0 };
        //Tac-Ops DLC: Opening 3
    };


    class AmbientTrack01a_F_Tacops
    {
        name = "Tac-Ops DLC: Ambient";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\Music_F_Tacops\Music\AmbientTrack01a_F_Tacops.ogg", db + 0, 1.0 };
        //Tac-Ops DLC: Ambient 1a
    };


    class AmbientTrack01b_F_Tacops
    {
        name = "Tac-Ops DLC: Ambient 1";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\Music_F_Tacops\Music\AmbientTrack01b_F_Tacops.ogg", db + 0, 1.0 };
        //Tac-Ops DLC: Ambient 1b
    };


    class AmbientTrack02a_F_Tacops
    {
        name = "Tac-Ops DLC: Ambient 2";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark",
            "calm"
        };
        sound[] = { "\A3\Music_F_Tacops\Music\AmbientTrack02a_F_Tacops.ogg", db + 0, 1.0 };
        //Tac-Ops DLC: Ambient 2a
    };

    class AmbientTrack02b_F_Tacops
    {
        name = "Tac-Ops DLC: Ambient 2";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark","calm"
        };
        sound[] = { "\A3\Music_F_Tacops\Music\AmbientTrack02b_F_Tacops.ogg", db + 0, 1.0 };
        //Tac-Ops DLC: Ambient 2b
    };

    class AmbientTrack03a_F_Tacops
    {
        name = "Tac-Ops DLC: Ambient 3";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\Music_F_Tacops\Music\AmbientTrack03a_F_Tacops.ogg", db + 0, 1.0 };
        //Tac-Ops DLC: Ambient 3a
    };

    class AmbientTrack03b_F_Tacops
    {
        name = "Tac-Ops DLC: Ambient 3";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\Music_F_Tacops\Music\AmbientTrack03b_F_Tacops.ogg", db + 0, 1.0 };
        //Tac-Ops DLC: Ambient 3b
    };

    class AmbientTrack04a_F_Tacops
    {
        name = "Tac-Ops DLC: Ambient 4";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\Music_F_Tacops\Music\AmbientTrack04a_F_Tacops.ogg", db + 0, 1.0 };
        //Tac-Ops DLC: Ambient 4a
    };

    class AmbientTrack04b_F_Tacops
    {
        name = "Tac-Ops DLC: Ambient 4";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\Music_F_Tacops\Music\AmbientTrack04b_F_Tacops.ogg", db + 0, 1.0 };
        //Tac-Ops DLC: Ambient 4b
    };

    class MainTheme_F_Tank
    {
        name = "This Is War (Tanks DLC Remix)";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\Music_F_Tank\MainTheme_F_Tank.ogg", db + 0, 1.0 };
        //Tanks DLC: This is War (Tanks DLC version)
    };

    class LeadTrack01_F_Tank
    {
        name = "Tanks DLC: Fight for the City";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\Music_F_Tank\LeadTrack01_F_Tank.ogg", db + 0, 1.0 };
        //Tanks DLC: Fight for the City
    };

    class LeadTrack02_F_Tank
    {
        name = "Tanks DLC: Last Stand";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\Music_F_Tank\LeadTrack02_F_Tank.ogg", db + 0, 1.0 };
        //Tanks DLC: Last Stand
    };

    class LeadTrack03_F_Tank
    {
        name = "Tanks DLC: Way Back";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark","calm"
        };
        sound[] = { "\A3\Music_F_Tank\LeadTrack03_F_Tank.ogg", db + 0, 1.0 };
        //Tanks DLC: Way Back
    };

    class LeadTrack05_F_Tank
    {
        name = "Tanks DLC: Wrath of the Giants";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\Music_F_Tank\LeadTrack05_F_Tank.ogg", db + 0, 1.0 };
        //Tanks DLC: Wrath of the Giants
    };

    class LeadTrack06_F_Tank
    {
        name = "Tanks DLC: Iron Gods";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\A3\Music_F_Tank\LeadTrack06_F_Tank.ogg", db + 0, 1.0 };
        //Tanks DLC: Iron Gods
    };

    class AmbientTrack01_F_Tank
    {
        name = "Tanks DLC: Hidden Enemy";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm",
            "dark"
        };
        sound[] = { "\A3\Music_F_Tank\AmbientTrack01_F_Tank.ogg", db + 0, 1.0 };
        //Tanks DLC: Hidden Enemy
    };

    // FIREDNEAR HAS A MAX RANGE OF ~69M WTF ILLUMINATI CONFIRMED
    // lmaoxd

    class Music_Theme_Contact
    {
        name = "Contact DLC: Transilience";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\Music_F_Enoch\Music\Transilience.ogg", db + 0, 1.0 };
        //Contact: Transilience (Main Theme)
    };

    class Music_Credits_Contact
    {
        name = "Contact DLC: Transilience";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\Music_F_Enoch\Music\Music_Credits_Contact.ogg", db + 0, 1.0 };
        //Contact: Transilience (Credits)
    };

    class Music_Arrival
    {
        name = "Contact DLC: Wavering Base";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\Music_F_Enoch\Music\Wavering_Base.ogg", db + 0, 1.0 };
        //Contact: Wavering Base
    };

    class Music_Roaming_Night
    {
        name = "Contact DLC: Night Eyes Zero-One";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\Music_F_Enoch\Music\Night_Eyes_Zero_One.ogg", db + 0, 1.0 };
        //Contact: Night Eyes Zero-One
    };

    class Music_Roaming_Night_02
    {
        name = "Contact DLC: Night Eyes Zero-Two";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\Music_F_Enoch\Music\Night_Eyes_Zero_Two.ogg", db + 0, 1.0 };
        //Contact: Night Eyes Zero-Two
    };

    class Music_Roaming_Day
    {
        name = "Contact DLC: Sunrise Zero-One";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\Music_F_Enoch\Music\Sunrise_Zero_One.ogg", db + 0, 1.0 };
        //Contact: Sunrise Zero-One
    };

    class Music_Roaming_Day_02
    {
        name = "Contact DLC: Sunrise Zero-Two";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\Music_F_Enoch\Music\Sunrise_Zero_Two.ogg", db + 0, 1.0 };
        //Contact: Sunrise Zero-Two
    };

    class Music_Hostile_Drone_Close_01
    {
        name = "Contact DLC: Hostile";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\Music_F_Enoch\Music\Music_Hostile_Drone_Close_01.ogg", db + 0, 1.0 };
        //Contact: Hostile
    };

    class Music_Battle_Alien
    {
        name = "Contact DLC: Contact";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\Music_F_Enoch\Music\Contact.ogg", db + 0, 1.0 };
        //Contact: Contact
    };

    class Music_Battle_Human
    {
        name = "Contact DLC: Infighting";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\Music_F_Enoch\Music\Infighting.ogg", db + 0, 1.0 };
        //Contact: Infighting
    };

    class Music_Russian_Theme
    {
        name = "Contact DLC: Sharper Claws";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\A3\Music_F_Enoch\Music\Sharper_Claws.ogg", db + 0, 1.0 };
        //Contact: Sharper Claws
    };

    class Music_Suspended_Loop_01
    {
        name = "Contact DLC: Suspense";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\Music_F_Enoch\Music\Music_Suspended_Loop_01.ogg", db + 0, 1.0 };
        //Contact: Suspense
    };

    class Music_Tension_Loop_01
    {
        name = "Contact DLC: Tension";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\Music_F_Enoch\Music\Music_Tension_Loop_01.ogg", db + 0, 1.0 };
        //Contact: Tension
    };



    class Track_C_01
    {
        name = "Old Man: Chillout 1";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\chillout\Track_C_01.ogg", db + 0, 1.0 };
        //Old Man: Chillout 01
    };

    class Track_C_02
    {
        name = "Old Man: Chillout 2";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark","calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\chillout\Track_C_02.ogg", db + 0, 1.0 };
        //Old Man: Chillout 02
    };

    class Track_C_03
    {
        name = "Old Man: Chillout 3";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\chillout\Track_C_03.ogg", db + 0, 1.0 };
        //Old Man: Chillout 03
    };

    class Track_C_04
    {
        name = "Old Man: Chillout 4";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\chillout\Track_C_04.ogg", db + 0, 1.0 };
        //Old Man: Chillout 04
    };

    class Track_C_05
    {
        name = "Old Man: Chillout 5";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\chillout\Track_C_05.ogg", db + 0, 1.0 };
        //Old Man: Chillout 05
    };

    class Track_C_06
    {
        name = "Old Man: Chillout 6";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\chillout\Track_C_06.ogg", db + 0, 1.0 };
        //Old Man: Chillout 06
    };

    class Track_C_07
    {
        name = "Old Man: Chillout 7";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\chillout\Track_C_07.ogg", db + 0, 1.0 };
        //Old Man: Chillout 07
    };

    class Track_C_08
    {
        name = "Old Man: Chillout 8";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\chillout\Track_C_08.ogg", db + 0, 1.0 };
        //Old Man: Chillout 08
    };

    class Track_C_09
    {
        name = "Old Man: Chillout 9";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\chillout\Track_C_09.ogg", db + 0, 1.0 };
        //Old Man: Chillout 09
    };

    class Track_C_10
    {
        name = "Old Man: Chillout 10";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\chillout\Track_C_10.ogg", db + 0, 1.0 };
        //Old Man: Chillout 10
    };

    class Track_C_11
    {
        name = "Old Man: Chillout 11";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\chillout\Track_C_11.ogg", db + 0, 1.0 };
        //Old Man: Chillout 11
    };

    class Track_C_12
    {
        name = "Old Man: Chillout 12";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\chillout\Track_C_12.ogg", db + 0, 1.0 };
        //Old Man: Chillout 12
    };

    class Track_C_13
    {
        name = "Old Man: Chillout 13";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\chillout\Track_C_13.ogg", db + 0, 1.0 };
        //Old Man: Chillout 13
    };

    class Track_C_14
    {
        name = "Old Man: Chillout 14";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\chillout\Track_C_14.ogg", db + 0, 1.0 };
        //Old Man: Chillout 14
    };

    class Track_C_15
    {
        name = "Old Man: Chillout 15";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\chillout\Track_C_15.ogg", db + 0, 1.0 };
        //Old Man: Chillout 15
    };

    class Track_C_16
    {
        name = "Old Man: Chillout 16";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\chillout\Track_C_16.ogg", db + 0, 1.0 };
        //Old Man: Chillout 16
    };

    class Track_C_17
    {
        name = "Old Man: Chillout 17";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\chillout\Track_C_17.ogg", db + 0, 1.0 };
        //Old Man: Chillout 17
    };

    class Track_C_18
    {
        name = "Old Man: Chillout 18";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\chillout\Track_C_18.ogg", db + 0, 1.0 };
        //Old Man: Chillout 18
    };

    class Track_C_19
    {
        name = "Old Man: Chillout 19";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\chillout\Track_C_19.ogg", db + 0, 1.0 };
        //Old Man: Chillout 19
    };

    class Track_C_20
    {
        name = "Old Man: Chillout 20";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\chillout\Track_C_20.ogg", db + 0, 1.0 };
        //Old Man: Chillout 20
    };

    class Track_D_01
    {
        name = "Old Man: Dance 1";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\dance\Track_D_01.ogg", db + 0, 1.0 };
        //Old Man: Dance 01
    };

    class Track_D_02
    {
        name = "Old Man: Dance 2";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\dance\Track_D_02.ogg", db + 0, 1.0 };
        //Old Man : Dance 02
    };

    class Track_D_03
    {
        name = "Old Man: Dance 3";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\dance\Track_D_03.ogg", db + 0, 1.0 };
        //Old Man : Dance 03
    };

    class Track_M_01
    {
        name = "Old Man: Metal 1";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\metal\Track_M_01.ogg", db + 0, 1.0 };
        //Old Man : Metal 01
    };

    class Track_M_02
    {
        name = "Old Man: Metal 2";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm",
            "intense"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\metal\Track_M_02.ogg", db + 0, 1.0 };
        //Old Man : Metal 02
    };

    class Track_M_03
    {
        name = "Old Man: Metal 3";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\metal\Track_M_03.ogg", db + 0, 1.0 };
        //Old Man : Metal 03
    };

    class Track_O_01
    {
        name = "Old Man: OST 1";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\ost\Track_O_01.ogg", db + 0, 1.0 };
        //Old Man OST 01
    };

    class Track_O_02
    {
        name = "Old Man: OST 2";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\ost\Track_O_02.ogg", db + 0, 1.0 };
        //Old Man OST 02
    };

    class Track_O_03
    {
        name = "Old Man: OST 3";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\ost\Track_O_03.ogg", db + 0, 1.0 };
        //Old Man OST 03
    };

    class Track_O_04
    {
        name = "Old Man: OST 4";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\ost\Track_O_04.ogg", db + 0, 1.0 };
        //Old Man OST 04
    };

    class Track_O_05
    {
        name = "Old Man: OST 5";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark","calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\ost\Track_O_05.ogg", db + 0, 1.0 };
        //Old Man OST 05
    };

    class Track_O_06
    {
        name = "Old Man: OST 6";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\ost\Track_O_06.ogg", db + 0, 1.0 };
        //Old Man OST 06
    };

    class Track_O_07
    {
        name = "Old Man: OST 7";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\ost\Track_O_07.ogg", db + 0, 1.0 };
        //Old Man OST 07
    };

    class Track_O_08
    {
        name = "Old Man: OST 8";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\ost\Track_O_08.ogg", db + 0, 1.0 };
        //Old Man OST 08
    };

    class Track_O_09
    {
        name = "Old Man: OST 9";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\ost\Track_O_09.ogg", db + 0, 1.0 };
        //Old Man OST 09
    };

    class Track_O_10
    {
        name = "Old Man: OST 10";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\ost\Track_O_10.ogg", db + 0, 1.0 };
        //Old Man OST 10
    };

    class Track_O_12
    {
        name = "Old Man: OST 12";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\ost\Track_O_12.ogg", db + 0, 1.0 };
        //Old Man OST 12
    };

    class Track_O_14
    {
        name = "Old Man: OST 14";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\ost\Track_O_14.ogg", db + 0, 1.0 };
        //Old Man OST 14
    };

    class Track_O_15
    {
        name = "Old Man: OST 15";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\ost\Track_O_15.ogg", db + 0, 1.0 };
        //Old Man OST 15
    };

    class Track_O_16
    {
        name = "Old Man: OST 16";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\ost\Track_O_16.ogg", db + 0, 1.0 };
        //Old Man OST 16
    };

    class Track_P_05
    {
        name = "Old Man: Pop 5";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\pop\Track_P_05.ogg", db + 0, 1.0 };
        //Old Man Pop 05
    };

    class Track_P_11
    {
        name = "Old Man: Pop 11";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\pop\Track_P_11.ogg", db + 0, 1.0 };
        //Old Man Pop 11
    };

    class Track_P_12
    {
        name = "Old Man: Pop 12";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark","intense"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\pop\Track_P_12.ogg", db + 0, 1.0 };
        //Old Man: Pop 12
    };

    class Track_P_13
    {
        name = "Old Man: Pop 13";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\pop\Track_P_13.ogg", db + 0, 1.0 };
        //Old Man: Pop 13
    };

    class Track_P_14
    {
        name = "Old Man: Pop 14";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\pop\Track_P_14.ogg", db + 0, 1.0 };
        //Old Man: Pop 14
    };

    class Track_P_15
    {
        name = "Old Man: Pop 15";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\pop\Track_P_15.ogg", db + 0, 1.0 };
        //Old Man: Pop 15
    };

    class Track_P_16
    {
        name = "Old Man: Pop 16";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\pop\Track_P_16.ogg", db + 0, 1.0 };
        //Old Man: Pop 16
    };

    class Track_P_17
    {
        name = "Old Man: Pop 17";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\pop\Track_P_17.ogg", db + 0, 1.0 };
        //Old Man: Pop 17
    };

    class Track_R_01
    {
        name = "Old Man: Rock 1";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\rock\Track_R_01.ogg", db + 0, 1.0 };
        //Old Man: Rock 01
    };

    class Track_R_02
    {
        name = "Old Man: Rock 2";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark","intense"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\rock\Track_R_02.ogg", db + 0, 1.0 };
        //Old Man: Rock 02
    };

    class Track_R_03
    {
        name = "Old Man: Rock 3";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\rock\Track_R_03.ogg", db + 0, 1.0 };
        //Old Man: Rock 03
    };

    class Track_R_04
    {
        name = "Old Man: Rock 4";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\rock\Track_R_04.ogg", db + 0, 1.0 };
        //Old Man: Rock 04
    };

    class Track_R_05
    {
        name = "Old Man: Rock 5";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\rock\Track_R_05.ogg", db + 0, 1.0 };
        //Old Man: Rock 05
    };

    class Track_R_06
    {
        name = "Old Man: Rock 6";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\rock\Track_R_06.ogg", db + 0, 1.0 };
        //Old Man: Rock 06
    };

    class Track_R_07
    {
        name = "Old Man: Rock 7";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\rock\Track_R_07.ogg", db + 0, 1.0 };
        //Old Man: Rock 07
    };

    class Track_R_08
    {
        name = "Old Man: Rock 8";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\rock\Track_R_08.ogg", db + 0, 1.0 };
        //Old Man: Rock 08
    };

    class Track_R_09
    {
        name = "Old Man: Rock 9";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\rock\Track_R_09.ogg", db + 0, 1.0 };
        //Old Man: Rock 09
    };

    class Track_R_10
    {
        name = "Old Man: Rock 10";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\rock\Track_R_10.ogg", db + 0, 1.0 };
        //Old Man: Rock 10
    };

    class Track_R_11
    {
        name = "Old Man: Rock 11";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\rock\Track_R_11.ogg", db + 0, 1.0 };
        //Old Man: Rock 11
    };

    class Track_R_13
    {
        name = "Old Man: Rock 13";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\rock\Track_R_13.ogg", db + 0, 1.0 };
        //Old Man: Rock 13
    };

    class Track_R_14
    {
        name = "Old Man: Rock 14";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\rock\Track_R_14.ogg", db + 0, 1.0 };
        //Old Man: Rock 14
    };

    class Track_R_15
    {
        name = "Old Man: Rock 15";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\rock\Track_R_15.ogg", db + 0, 1.0 };
        //Old Man: Rock 15
    };

    class Track_R_16
    {
        name = "Old Man: Rock 16";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\rock\Track_R_16.ogg", db + 0, 1.0 };
        //Old Man: Rock 16
    };

    class Track_R_17
    {
        name = "Old Man: Rock 17";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\rock\Track_R_17.ogg", db + 0, 1.0 };
        //Old Man: Rock 17
    };

    class Track_R_18
    {
        name = "Old Man: Rock 18";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\rock\Track_R_18.ogg", db + 0, 1.0 };
        //Old Man: Rock 18
    };

    class Track_R_19
    {
        name = "Old Man: Rock 19";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\rock\Track_R_19.ogg", db + 0, 1.0 };
        //Old Man: Rock 19
    };

    class Track_R_20
    {
        name = "Old Man: Rock 20";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\rock\Track_R_20.ogg", db + 0, 1.0 };
        //Old Man: Rock 20
    };

    class Track_R_21
    {
        name = "Old Man: Rock 21";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\rock\Track_R_21.ogg", db + 0, 1.0 };
        //Old Man: Rock 21
    };

    class Track_R_22
    {
        name = "Old Man: Rock 22";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\rock\Track_R_22.ogg", db + 0, 1.0 };
        //Old Man: Rock 22
    };

    class Track_R_23
    {
        name = "Old Man: Rock 23";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "intense"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\rock\Track_R_23.ogg", db + 0, 1.0 };
        //Old Man: Rock 23
    };

    class Track_R_24
    {
        name = "Old Man: Rock 24";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "calm"
        };
        sound[] = { "\a3\Music_F_Oldman\music\radio\rock\Track_R_24.ogg", db + 0, 1.0 };
        //Old Man: Rock 24
    };

    class OM_Music02
    {
        name = "Old Man: Ambient 1";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\Missions_F_Oldman\Music\ProbeDiscovered01.ogg", db + 0, 1.0 };
        //Old Man: Ambient Music 01
    };

    class OM_Music03
    {
        name = "Old Man: Ambient 2";
        artist = "Bohemia Interactive";
        moods[] = 
        {
            "dark"
        };
        sound[] = { "\A3\Missions_F_Oldman\Music\ProbeDiscovered02.ogg", db + 0, 1.0 };
        //Old Man: Ambient Music 02
    };





};