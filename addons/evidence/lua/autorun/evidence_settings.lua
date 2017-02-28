--  _      _____  ___   _   __ ___________  ________   __
-- | |    |  ___|/ _ \ | | / /|  ___|  _  \ | ___ \ \ / /
-- | |    | |__ / /_\ \| |/ / | |__ | | | | | |_/ /\ V / 
-- | |    |  __||  _  ||    \ |  __|| | | | | ___ \ \ /  
-- | |____| |___| | | || |\  \| |___| |/ /  | |_/ / | |  
-- \_____/\____/\_| |_/\_| \_/\____/|___/   \____/  \_/                                                                                                            
--      ___      .__   __.   ______   .__   __. ____    ____ .___  ___.   ______    __    __       _______.    __       _______     ___       __  ___ .______      
--     /   \     |  \ |  |  /  __  \  |  \ |  | \   \  /   / |   \/   |  /  __  \  |  |  |  |     /       |   |  |     |   ____|   /   \     |  |/  / |   _  \     
--    /  ^  \    |   \|  | |  |  |  | |   \|  |  \   \/   /  |  \  /  | |  |  |  | |  |  |  |    |   (----`   |  |     |  |__     /  ^  \    |  '  /  |  |_)  |    
--   /  /_\  \   |  . `  | |  |  |  | |  . `  |   \_    _/   |  |\/|  | |  |  |  | |  |  |  |     \   \       |  |     |   __|   /  /_\  \   |    <   |      /     
--  /  _____  \  |  |\   | |  `--'  | |  |\   |     |  |     |  |  |  | |  `--'  | |  `--'  | .----)   |      |  `----.|  |____ /  _____  \  |  .  \  |  |\  \----.
-- /__/     \__\ |__| \__|  \______/  |__| \__|     |__|     |__|  |__|  \______/   \______/  |_______/       |_______||_______/__/     \__\ |__|\__\ | _| `._____|

Evidence = {}
Evidence.Settings = {}

-- Evidence.Settings.InstantTake -- Is there a timer when pressing E on evidence untill the killer gets wanted or does the killer get wanted as soon as you press E on the Evidence(as a valid job).
Evidence.Settings.InstantTake 			= false

-- Evidence.Settings.InvestigationTime -- How long does it take to investigate the evidence before the killer becomes wanted. ( in Seconds )
Evidence.Settings.InvestigationTime		= 30

-- Evidence.Settings.DoWantedPlayersDrop -- Do wanted players drop evidence too?
Evidence.Settings.DoWantedPlayersDrop	= false
	
-- Evidence.Settings.EntityHalo 		-- Halo / Light around the evidence, slightly decreases players fps. ( if there are +10 evidences rendered in ur screen this effect can drop ur fps by 10%, else it should be fine. )
-- http://i.gyazo.com/27d8f918a9353c6a05902ced3617df58.png -- it's the red glow around the Evidence.Settings.
Evidence.Settings.EntityHalo 			= false

-- Evidence.Settings.EntityHaloColor -- the color of the Halo
Evidence.Settings.EntityHaloColor 		= Color(255,0,0)

-- Evidence.Settings.RemovesAfter 	-- How many seconds until the evidence disappears after it was spawned. 180 = 3 minutes ( 3x60 = 180 )
Evidence.Settings.RemovesAfter			= 120

-- Evidence.Settings.ShowDistance 	-- From how far away does the on-screen-display show?  ( Don't make this too high, will slightly decrease fps if it's too far away and there are many evidences rendering for you. )
Evidence.Settings.ShowDistance			= 750

-- Evidence.Settings.AlphaDistance 	-- Does the transparency of the on-screen-display change with the distance to the evidence ( Doesn't have any performance effect, just visual. )
Evidence.Settings.AlphaDistance			= true

-- Evidence.Settings.TheModel 		-- The model of the evidence entity
/* Some I recommend using: 
"models/Gibs/HGIBS.mdl"					-- a Skull
"models/props_junk/Shoe001a.mdl"		-- a Shoe
"models/props_lab/jar01a.mdl"			-- a big Jar
"models/props_lab/jar01b.mdl"			-- a tiny Jar
"models/props_junk/TrafficCone001a.mdl"	-- a traffic cone
"models/props_lab/huladoll.mdl"			-- a Hula Hula Doll */
Evidence.Settings.TheModel				= "models/Gibs/HGIBS.mdl"

-- Evidence.Settings.ShowToAll -- does the on-screen-display show who was the victim
Evidence.Settings.ShowVictim			= false

-- Evidence.Settings.ShowKiller -- does the on-screen-display show who was the killer
Evidence.Settings.ShowKiller 			= false

-- Evidence.Settings.ShowToAllPlayers -- if set to true all players can see the evidence, 
-- if set to false only government jobs can see it ( talking about the whole entity and the on-screen-display. )
-- If set to false can also cause misunderstanding to players who don't know the evidence system (out of the blue getting wanted) could lead to false demotes of the cops.
Evidence.Settings.ShowToAllPlayers		= true

-- Evidence.Settings.AllowCP --		-- Are all cops allowed to investigate evidences? Uses isCP() check, so you need to set the CP job's into darkrp's job.lua to be in CivilProtection
-- http://i.gyazo.com/ca453db731163ff363551f8b60426c3c.png -- Example, all those jobs can investigate the evidence if this is set to true.
-- Enabling this will overwrite Evidence.Settings.AllowJobName
Evidence.Settings.AllowCP				= true
 
-- if Evidence.Settings.AllowCP is set to false Evidence.Settings.AllowJobName defines what job can investigate Evidence.Settings. This uses the job's name, not the uniqname(not TEAM_POLICE, but uses DarkRP.createJob("Detective"...)
-- http://i.gyazo.com/85a7a36da00281627e8d65366b5ee348.png -- the selected & green part 
-- Some think that /job CUSTOM JOB NAME HERE (example /job Detective - when being citizen ) in-game would work with this, it doesn't, only the job set to that name and selected from F4 works.
Evidence.Settings.AllowJobName			= "Детектив"

-- Evidence.Settings.EnableCustomWantedText -- if enabled uses the text line below it as the reason when player gets wanted from evidence.
-- ( if set to false it uses the default one: "Murderer of " .. victim_name .. "!" )
Evidence.Settings.EnableCustomWantedText = false
Evidence.Settings.CustomWantedText		= "Assassinato comprovado!" -- only a string works here.

-- the color of the on-screen-display's background.
Evidence.Settings.BGColor				= Color(0,255,255)

-- http://i.gyazo.com/e330fdb95c76951da3a42ca280ada109.png -- The color of the title
Evidence.Settings.TitleColor			= Color(0,255,255)

-- http://i.gyazo.com/61618b393fc19c00948d0efd5034a56b.png -- The color of the victim text
Evidence.Settings.VictimColor			= Color(240,240,240)

-- Evidence.Settings.KillerColor -- The color of the killer text
Evidence.Settings.KillerColor			= Color(255,0,0)

-- http://i.gyazo.com/2c1abfc694f69638157f105460055c74.png -- The color of not being allowed to investigate
Evidence.Settings.NotAllowed			= Color(255,0,0)
Evidence.Settings.Allowed				= Color(0,255,0)

-- Evidence.Settings.WaterMark --		-- whether or not there is a 'Love to Anonymous Leakr' on the On-Screen-Display when you are looking at an evidence. ( I hope you would leave this to true :< )
Evidence.Settings.WaterMark				= false

--  _      _____  ___   _   __ ___________  ________   __
-- | |    |  ___|/ _ \ | | / /|  ___|  _  \ | ___ \ \ / /
-- | |    | |__ / /_\ \| |/ / | |__ | | | | | |_/ /\ V / 
-- | |    |  __||  _  ||    \ |  __|| | | | | ___ \ \ /  
-- | |____| |___| | | || |\  \| |___| |/ /  | |_/ / | |  
-- \_____/\____/\_| |_/\_| \_/\____/|___/   \____/  \_/                                                                                                            
--      ___      .__   __.   ______   .__   __. ____    ____ .___  ___.   ______    __    __       _______.    __       _______     ___       __  ___ .______      
--     /   \     |  \ |  |  /  __  \  |  \ |  | \   \  /   / |   \/   |  /  __  \  |  |  |  |     /       |   |  |     |   ____|   /   \     |  |/  / |   _  \     
--    /  ^  \    |   \|  | |  |  |  | |   \|  |  \   \/   /  |  \  /  | |  |  |  | |  |  |  |    |   (----`   |  |     |  |__     /  ^  \    |  '  /  |  |_)  |    
--   /  /_\  \   |  . `  | |  |  |  | |  . `  |   \_    _/   |  |\/|  | |  |  |  | |  |  |  |     \   \       |  |     |   __|   /  /_\  \   |    <   |      /     
--  /  _____  \  |  |\   | |  `--'  | |  |\   |     |  |     |  |  |  | |  `--'  | |  `--'  | .----)   |      |  `----.|  |____ /  _____  \  |  .  \  |  |\  \----.
-- /__/     \__\ |__| \__|  \______/  |__| \__|     |__|     |__|  |__|  \______/   \______/  |_______/       |_______||_______/__/     \__\ |__|\__\ | _| `._____|