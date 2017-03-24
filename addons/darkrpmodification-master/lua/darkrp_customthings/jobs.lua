--[[---------------------------------------------------------------------------
DarkRP custom jobs
---------------------------------------------------------------------------

This file contains your custom jobs.
This file should also contain jobs from DarkRP that you edited.

Note: If you want to edit a default DarkRP job, first disable it in darkrp_config/disabled_defaults.lua
	Once you've done that, copy and paste the job to this file and edit it.

The default jobs can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/jobrelated.lua

For examples and explanation please visit this wiki page:
http://wiki.darkrp.com/index.php/DarkRP:CustomJobFields


Add jobs under the following line:
---------------------------------------------------------------------------]]

/*


customCheck = isDonator,
    isDonator = true,
    CustomCheckFailMsg = "Извините, только для донаторов",



*/

--#NoSimplerr#

function isArchitector(ply)
    return ply:GetUserGroup() == "architector"
end
function isSuperAdmin(ply)
    return ply:GetUserGroup() == "superadmin" or isArchitector(ply)
end
function isAdmin(ply)
    return ply:GetUserGroup() == "admin" or isSuperAdmin(ply)
end
function isDonator(ply)
    return ply:GetUserGroup() == "premium" or isAdmin(ply)
end

TEAM_CITIZEN = DarkRP.createJob("Безработный", {
    color = Color(20, 150, 20, 255),
    model = {
        "models/player/Group01/Male_05.mdl",
        "models/player/Group01/Female_01.mdl",
        "models/player/Group01/Female_02.mdl",
        "models/player/Group01/Female_03.mdl",
        "models/player/Group01/Female_04.mdl",
        "models/player/Group01/Female_06.mdl",
        "models/player/group01/male_01.mdl",
        "models/player/Group01/Male_02.mdl",
        "models/player/Group01/male_03.mdl",
        "models/player/Group01/Male_04.mdl",
        "models/player/Group01/Male_06.mdl",
        "models/player/Group01/Male_07.mdl",
        "models/player/Group01/Male_08.mdl",
        "models/player/Group01/Male_09.mdl"
    },
    description = [[Тот, кто не приносит пользы обществу.]],
    weapons = {},
    command = "citizen",
    max = 0,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Citizens",
})

TEAM_ADMINONDUTY = DarkRP.createJob("Администратор", {
    color = Color(255, 10, 10, 255),
    model = "models/player/combine_super_soldier.mdl",
    description = [[Тот, кто должен работать.]],
    weapons = {},
    command = "adminonduty",
    max = 10,
    salary = GAMEMODE.Config.normalsalary*0,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Citizens",
    customCheck = isAdmin,
    CustomCheckFailMsg = "Только для администрации" 
})

TEAM_POLICE = DarkRP.createJob("Офицер полиции", {
    color = Color(34, 130, 220, 255),
    model = {
		"models/humans/nypd1940/male_02.mdl",
		"models/humans/nypd1940/male_03.mdl",
		"models/humans/nypd1940/male_04.mdl",
		"models/humans/nypd1940/male_05.mdl",
		"models/humans/nypd1940/male_06.mdl",
        "models/humans/nypd1940/male_01.mdl",
		"models/humans/nypd1940/male_07.mdl",
		"models/humans/nypd1940/male_08.mdl",
		"models/humans/nypd1940/male_09.mdl"},
	description = [[Тот, кто сохраняет порядок в городе.]],
    weapons = {"weapon_policebaton", "cw_m1911", "door_ram", "weaponchecker"},
    command = "cp",
    max = 13,
    salary = GAMEMODE.Config.normalsalary * 1.45,
    admin = 0,
    vote = true,
    hasLicense = true,
    ammo = {
        ["pistol"] = 30,
    },
    category = "Civil Protection",
})

TEAM_DETECTIVE = DarkRP.createJob("Детектив", {
    color = Color(206,141,83,255),
    model = "models/sirgibs/ragdolls/detective_magnusson_player.mdl",
    description = [[Тот, кто ведет расследования.]],
    weapons = {"weapon_policebaton", "weaponchecker", "cw_mr96"},
    command = "detective",
    max = 2,
    salary = GAMEMODE.Config.normalsalary * 2,
    admin = 0,
    vote = false,
    hasLicense = true,
    ammo = {
        ["357"] = 18,
    },
    category = "Civil Protection",
    customCheck = isDonator,
    isDonator = true,
    CustomCheckFailMsg = "Извините, только для Премиум игроков",
})

TEAM_CHIEF = DarkRP.createJob("Шериф полиции", {
    color = Color(36, 100, 233, 255),
    model = {
        "models/portal2/patrol_02.mdl",
        "models/portal2/patrol_04.mdl",
        "models/portal2/patrol_06.mdl",
        "models/portal2/patrol_07.mdl",
        "models/portal2/patrol_08.mdl",
        "models/portal2/patrol_09.mdl",},
    description = [[Тот, кто руководит полицией.]],
    weapons = {"cw_mr96", "weapon_policebaton", "door_ram", "weaponchecker"},
    command = "chief",
    max = 1,
    salary = GAMEMODE.Config.normalsalary * 1.67,
    admin = 0,
    vote = false,
    hasLicense = true,
    chief = true,
    NeedToChangeFrom = TEAM_POLICE,
    ammo = {
        ["357"] = 18,
    },
    category = "Civil Protection",
})

TEAM_GUN = DarkRP.createJob("Торговец оружием", {
    color = Color(255, 140, 0, 255),
    model = "models/player/monk.mdl",
    description = [[Тот, кто продает гражданам оружие.]],
    weapons = {},
    command = "gundealer",
    max = 4,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Citizens",
})

TEAM_ILLEGALDEALER = DarkRP.createJob("Торговец нелегалом", {
    color = Color(255, 190, 0, 255),
    model = "models/player/eli.mdl",
    description = [[Тот, кто продает нелегальные вещи.]],
    weapons = {},
    command = "illegaldealer",
    max = 3,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Citizens",
})

TEAM_HEAVYDEALER = DarkRP.createJob("Торговец тяж оружием", {
    color = Color(255, 190, 0, 255),
    model = "models/player/guerilla.mdl",
    description = [[Тот, кто продает нелегальные вещи.]],
    weapons = {},
    command = "heavydealer",
    max = 3,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Citizens",
})


TEAM_SWAT = DarkRP.createJob("SWAT Штурмовик", {
    color = Color(133, 73, 238, 255),
    model ="models/player/bfh_enforcer.mdl",
    description = [[Тот, кто вооружен и опасен.]],
    weapons = {"weapon_policebaton", "cw_ump45", "cw_p99", "cw_flash_grenade", "cw_smoke_grenade", "door_ram", "weaponchecker", "weapon_policeshield"},
    command = "swat",
    max = 4,
    salary = GAMEMODE.Config.normalsalary * 1.8,
    admin = 0,
    vote = true,
    hasLicense = true,
    ammo = {
        ["smg"] = 60,
    },
    category = "Civil Protection",
})

TEAM_SWATLEADER = DarkRP.createJob("SWAT Лидер", {
    color = Color(133, 73, 238, 255),
    model ="models/player/bfh_mechanic.mdl",
    description = [[Тот, кто командует SWAT.]],
    weapons = {"weapon_policebaton", "cw_p99", "cw_g36c", "door_ram", "cw_flash_grenade", "cw_smoke_grenade", "weaponchecker", "weapon_policeshield"},
    command = "swatleader",
    max = 1,
    salary = GAMEMODE.Config.normalsalary * 2,
    admin = 0,
    vote = false,
    hasLicense = true,
    ammo = {
        ["buckshot"] = 30,
    },
    category = "Civil Protection",
    customCheck = isDonator,
    isDonator = true,
    CustomCheckFailMsg = "Извините, только для Премиум игроков",
})

TEAM_SWATMEDIC = DarkRP.createJob("SWAT Медик", {
    color = Color(133, 73, 238, 255),
    model ="models/player/bfh_operator.mdl",
    description = [[Тот, лечит союзников.]],
    weapons = {"weapon_policebaton", "cw_m3super90", "cw_p99", "cw_flash_grenade", "cw_smoke_grenade", "door_ram", "weaponchecker", "med_kit"},
    command = "swatmedic",
    max = 2,
    salary = GAMEMODE.Config.normalsalary * 1.8,
    admin = 0,
    vote = true,
    hasLicense = true,
    ammo = {
        ["pistol"] = 30,
    },
    category = "Civil Protection",
})

TEAM_SWATSNIPER = DarkRP.createJob("SWAT Снайпер", {
    color = Color(133, 73, 238, 255),
    model = "models/player/bfh_pro.mdl",
    description = [[Тот, кто следит за тобой.]],
    weapons = {"weapon_policebaton", "cw_p99", "cw_l115", "cw_flash_grenade", "cw_smoke_grenade", "door_ram", "weaponchecker"},
    command = "swatsniper",
    max = 1,
    salary = GAMEMODE.Config.normalsalary * 2,
    admin = 0,
    vote = false,
    hasLicense = true,
    ammo = {
        ["sniper_rounds"] = 20,
    },
    category = "Civil Protection",
    customCheck = isDonator,
    isDonator = true,
    CustomCheckFailMsg = "Извините, только для Премиум игроков",
})

TEAM_GANG = DarkRP.createJob("Бандит", {
    color = Color(130, 130, 130, 255),
    model = {
        "models/humans/mafia/male_02.mdl",
        "models/humans/mafia/male_04.mdl",
        "models/humans/mafia/male_06.mdl",
        "models/humans/mafia/male_07.mdl",
        "models/humans/mafia/male_08.mdl",
        "models/humans/mafia/male_09.mdl"},
    description = [[Тот, кто грабит и убивает.]],
    weapons = {},
    command = "gangster",
    max = 10,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Gangsters",
    

})

TEAM_THIEF = DarkRP.createJob("Вор", {
    color = Color(130, 130, 130, 255),
    model = "models/player/group01/cookies114.mdl",
    description = [[Тот, кто обворовывает людей.]],
    weapons = {"lockpick","keypad_cracker"},
    command = "thief",
    max = 5,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Gangsters",
})

TEAM_MOB = DarkRP.createJob("Босс мафии", {
    color = Color(40, 40, 40, 255),
    model = "models/vito.mdl",
    description = [[Тот, кто руководит бандитами.]],
    weapons = {"lockpick", "unarrest_stick"},
    command = "mobboss",
    max = 1,
    salary = GAMEMODE.Config.normalsalary * 1.34,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Gangsters",
})

TEAM_MEDIC = DarkRP.createJob("Доктор", {
    color = Color(47, 79, 79, 255),
    model = {
        "models/player/hostage/hostage_04.mdl",
        "models/player/hostage/hostage_03.mdl",
        "models/player/hostage/hostage_02.mdl",
        "models/player/hostage/hostage_01.mdl",
        "models/player/kleiner.mdl"},
    description = [[Тот, кто лечит граждан.]],
    weapons = {"med_kit"},
    command = "medic",
    max = 4,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    medic = true,
    category = "Citizens",
})

TEAM_MAYOR = DarkRP.createJob("Мэр", {
    color = Color(150, 20, 20, 255),
    model = "models/player/breen.mdl",
    description = [[Тот, кто управляет городом.]],
    weapons = {},
    command = "mayor",
    max = 1,
    salary = GAMEMODE.Config.normalsalary * 1.89,
    admin = 0,
    vote = true,
    hasLicense = false,
    mayor = true,
    category = "Civil Protection",
})

TEAM_HOBO = DarkRP.createJob("Бомж", {
    color = Color(80, 45, 0, 255),
    model = "models/player/corpse1.mdl",
    description = [[Тот, кому негде жить.]],
    weapons = {"weapon_bugbait"},
    command = "hobo",
    max = 0,
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    hobo = true,
    category = "Citizens",
})

TEAM_GUARD = DarkRP.createJob("Охранник", {
    color = Color(25, 25, 200, 255),
    model = "models/player/odessa.mdl",
    description = [[Тот, кто вас охраняет.]],
    weapons = {"stunstick"},
    command = "guard",
    max = 6,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Citizens",
})

TEAM_HITMAN = DarkRP.createJob("Наемный убийца", {
    color = Color(94, 0, 24, 255),
    model = "models/player/lanoire_detective.mdl",
    description = [[Тот, кто убивает на заказ.]],
    weapons = {""},
    command = "hitman",
    max = 3,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Citizens",
    customCheck = isDonator,
    isDonator = true,
    CustomCheckFailMsg = "Извините, только для Премиум игроков",
})

TEAM_RADIOHOST = DarkRP.createJob("Ведущий радио", {
    color = Color(108, 156, 92, 255),
    model = {
        "models/player/Group01/Male_05.mdl",
        "models/player/Group01/Female_01.mdl",
        "models/player/Group01/Female_02.mdl",
        "models/player/Group01/Female_03.mdl",
        "models/player/Group01/Female_04.mdl",
        "models/player/Group01/Female_06.mdl",
        "models/player/group01/male_01.mdl",
        "models/player/Group01/Male_02.mdl",
        "models/player/Group01/male_03.mdl",
        "models/player/Group01/Male_04.mdl",
        "models/player/Group01/Male_06.mdl",
        "models/player/Group01/Male_07.mdl",
        "models/player/Group01/Male_08.mdl",
        "models/player/Group01/Male_09.mdl"
    },
    description = [[Тот, кто не ставит ваши песни.]],
    weapons = {},
    command = "radiohost",
    max = 1,
    salary = GAMEMODE.Config.normalsalary*2,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Citizens",
    customCheck = isDonator,
    isDonator = true,
    CustomCheckFailMsg = "Извините, только для Премиум игроков",
})

TEAM_DOG = DarkRP.createJob("Собака", {
    color = Color(238, 166, 80, 255),
    model = "models/doge_player/doge_player.mdl",
    description = [[Тот, кто постоянно лает.]],
    weapons = {},
    command = "dog",
    max = 10,
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    PlayerLoadout = function(ply) return true end
})

TEAM_WHORE = DarkRP.createJob("Проститука", {
    color = Color(238, 99, 140, 255),
    model = "models/player/alyx.mdl",
    description = [[Тот, кто торгует телом.]],
    weapons = {"weapon_hooker"},
    command = "whore",
    max = 4,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    cook = true,
})

if not DarkRP.disabledDefaults["modules"]["hungermod"] then
    TEAM_COOK = DarkRP.createJob("Повар", {
        color = Color(238, 99, 99, 255),
        model = "models/player/mossman.mdl",
        description = [[Тот, кто продает еду гражданам.]],
        weapons = {},
        command = "cook",
        max = 4,
        salary = 45,
        admin = 0,
        vote = false,
        hasLicense = false,
        cook = true
    })


end

--[[---------------------------------------------------------------------------
Define which team joining players spawn into and what team you change to if demoted
---------------------------------------------------------------------------]]
GAMEMODE.DefaultTeam = TEAM_CITIZEN


--[[---------------------------------------------------------------------------
Define which teams belong to civil protection
Civil protection can set warrants, make people wanted and do some other police related things
---------------------------------------------------------------------------]]
GAMEMODE.CivilProtection = {
	[TEAM_POLICE] = true,
	[TEAM_CHIEF] = true,
	[TEAM_MAYOR] = true,
    [TEAM_DETECTIVE] = true,
    [TEAM_SWAT] = true,
    [TEAM_SWATLEADER] = true,
    [TEAM_SWATSNIPER] = true,
    [TEAM_ADMINONDUTY] = true,
}

--[[---------------------------------------------------------------------------
Jobs that are hitmen (enables the hitman menu)
---------------------------------------------------------------------------]]
DarkRP.addHitmanTeam(TEAM_HITMAN)
