You can change settings in: garrysmod/addons/evidence/lua/autorun/evidence_settings.lua
|||||||||||||||||||||||||||||||||
|||| Fast and Basic Install |||||
1. This addon goes to addons folder like any other normal addon.
		- the file bath should be something like this: garrysmod/addons/evidence and inside evidence there should be lua folder and this readme.txt
2. Done, now go and investigate murders!
|||||||||||||||||||||||||||||||||

|||||||||||||||||||||||||||||||||||||||
|||| Advanced Setup (recommended) |||||
1. This addon goes to addons folder like any other normal addon.
		- the file bath should be something like this: garrysmod/addons/evidence and inside evidence there should be lua folder and this readme.txt
2. Go to garrysmod/addons/darkrpmodification/lua/darkrp_customthings/jobs.lua, 
in here you need to make sure you have set all the government jobs to be in CivilProtection in order for them to be able to investigate the evidences.
Scroll all the way to the bottom of the lua file and you will find a 'table' called 'GAMEMODE.CivilProtection' You need to have all the jobs in this table.
Example:
GAMEMODE.CivilProtection = {
	[TEAM_POLICE] = true,
	[TEAM_CHIEF] = true,
	[TEAM_MAYOR] = true,
	[TEAM_BASIC_SWAT] = true,
	[TEAM_ATTACK_SWAT] = true,
	[TEAM_SNIPER_SWAT] = true,
	[TEAM_SWAT_LEADER] = true,
	[TEAM_DETECTIVE] = true,
}
3. OPTIONAL | Also I recommend checking the group chat and doorgroups to be same as this, else it would be weird.
4. OPTIONAL | I my self would recommend using this evidence addon so that only one job called Detective can investigate the evidences. Here is what I would add:
TEAM_DETECTIVE = DarkRP.createJob("Detective", {
	color = Color(25, 25, 170, 255),
	model = {
	"models/player/barney.mdl"
	},
	description = [[The protector of every citizen that lives in the city.
		You have the power to arrest criminals and protect innocents.
		Hit a player with your arrest baton to put them in jail.
		Bash a player with a stunstick and they may learn to obey the law.
		The Battering Ram can break down the door of a criminal, with a warrant for their arrest.
		Type /wanted <name>  to make a player wanted.
		Type /warrant <name>  to warrant a player.]],
	weapons = { 
		"arrest_stick",
		"unarrest_stick",
		"stunstick",
		"door_ram",
		"weaponchecker"
	},
	command = "detective",
	max = 3,
	salary = 150,
	admin = 0,
	vote = true,
	PlayerLoadout = function(ply) ply:setDarkRPVar("HasGunlicense", true) end,
	help = {
		"Type /warrant [Nick|SteamID|Status ID] to set a search warrant for a player.",
		"Type /wanted [Nick|SteamID|Status ID] to alert everyone to a wanted suspect",
		"Type /unwanted [Nick|SteamID|Status ID] to clear the suspect",
	}
})

if you do this you need to go to garrysmod/addons/evidence/lua/autorun/evidence_settings.lua and make
Evidence.Settings.AllowCP = false
Evidence.Settings.AllowJobName = "detective"
That should be it.
|||||||||||||||||||||||||||||||||||||||	