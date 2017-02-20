-- Scoreboard configuration
-- Coded by AC² 

-- Fonts
surface.CreateFont("scoreboard.title", {font = "DermaLarge", size = 32, weight = 800})
surface.CreateFont("scoreboard.info", {font = "DermaLarge", size = 16, weight = 200})
surface.CreateFont("scoreboard.player.big", {font = "DermaLarge", size = 20, weight = 800})
surface.CreateFont("scoreboard.player", {font = "DermaLarge", size = 16, weight = 800})

-- Change colors here 
local config = {}

-- Enable background blur ?
config.bEnableBlur = true 

-- Background color
config.cBackground = Color(85,58,35,255)

-- Border around the entire scoreboard color
config.cBackgroundOutline = Color(0, 0, 0, 255)

-- Server title color
config.cServerName = TCB_Settings.BlackColor 

-- 'Rounded' box color
config.cHeader = Color(227, 210, 161, 255)

-- Line under server title
config.cLine = Color(10, 6, 4, 255)

-- Player outline color
config.cPlayerOutline = Color(0, 0, 0, 100)

-- Icons for usergroups
config.mIconGroups = {}
config.mIconGroups["premium"] = Material("icon16/star.png")
config.mIconGroups["architector"] = Material("icon16/key.png")
config.mIconGroups["superadmin"] = Material("icon16/shield_add.png")
config.mIconGroups["admin"] = Material("icon16/shield.png")
config.mIconGroups["guest"] = Material("icon16/user.png")
-- I made the scoreboard and released it for free
-- So don't you tell me I don't deserve a little icon :/
config.mIconGroups["STEAM_0:0:16134549"] = Material("icon16/tux.png")

-- Return the config table 
function GetScoreboardConfig()
	-- Return this 
	return config
end 