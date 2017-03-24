--[[---------------------------------------------------------------------------
DarkRP custom entities
---------------------------------------------------------------------------

This file contains your custom entities.
This file should also contain entities from DarkRP that you edited.

Note: If you want to edit a default DarkRP entity, first disable it in darkrp_config/disabled_defaults.lua
	Once you've done that, copy and paste the entity to this file and edit it.

The default entities can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/addentities.lua#L111

For examples and explanation please visit this wiki page:
http://wiki.darkrp.com/index.php/DarkRP:CustomEntityFields

Add entities under the following line:
---------------------------------------------------------------------------]]


DarkRP.createEntity("Бронежилет", {
    ent = "armor",
    model = "models/weapons/w_defuser.mdl",
    price = 500,
    max = 10,
    cmd = "buyarmor",
    allowed = {TEAM_ILLEGALDEALER},
})

DarkRP.createEntity("Аптечка", {
    ent = "health_pack",
    model = "models/healthvial.mdl",
    price = 250,
    max = 10,
    cmd = "buyhealthpack",
    allowed = {TEAM_MEDIC},
})

DarkRP.createEntity("Радио", {
    ent = "re_radio",
    model = "models/props_lab/citizenradio.mdl",
    price = 50,
    max = 2,
    cmd = "buyradio",
})

DarkRP.createEntity("Микрофон", {
    ent = "re_microphone",
    model = "models/roleplay/microphone_full.mdl",
    price = 200,
    max = 1,
    cmd = "buymicrophone",
    allowed = {TEAM_RADIOHOST},
})


DarkRP.createEntity("Принтер первого уровня", {
    ent = "k_printer_t1",
    model = "models/props_lab/reciever01a.mdl",
    price = 500,
    max = 3,
    cmd = "buymoneyprinter1",
    customCheck = function(ply) return ply:CanBuyPrinter() end,
    CustomCheckFailMsg = "Слишком много принтеров"
})

DarkRP.createEntity("Принтер второго уровня", {
    ent = "k_printer_t2",
    model = "models/props_lab/reciever01a.mdl",
    price = 1000,
    max = 3,
    cmd = "buymoneyprinter2",
    customCheck = function(ply)return ply:CanBuyPrinter() end,
    CustomCheckFailMsg = "Слишком много принтеров"
})

DarkRP.createEntity("Принтер третьего уровня", {
    ent = "k_printer_t3",
    model = "models/props_lab/reciever01a.mdl",
    price = 1500,
    max = 3,
    cmd = "buymoneyprinter3",
    customCheck = function(ply) return ply:CanBuyPrinter() end,
    CustomCheckFailMsg = "Слишком много принтеров"
})

DarkRP.createEntity("Принтер четвертого уровня", {
    ent = "k_printer_t4",
    model = "models/props_lab/reciever01a.mdl",
    price = 2000,
    max = 3,
    cmd = "buymoneyprinter4",
    customCheck = function(ply) return ply:CanBuyPrinter() end,
    CustomCheckFailMsg = "Слишком много принтеров"
})

DarkRP.createEntity("Принтер пятого уровня", {
    ent = "k_printer_t5",
    model = "models/props_lab/reciever01a.mdl",
    price = 2500,
    max = 3,
    cmd = "f4091876df6a5d39e6690b7395a95399",
    customCheck = function(ply)  return ply:CanBuyPrinter() and isDonator(ply) end
})

DarkRP.createEntity("Улучшение принтера", {
    ent = "k_printer_upgrade",
    model = "models/props_lab/box01a.mdl",
    price = 500,
    max = 1,
    cmd = "buyprinterupgrade"
})

DarkRP.createEntity("Охладитель", {
    ent = "k_coolant_cell",
    model = "models/Items/battery.mdl",
    price = 200,
    max = 5,
    cmd = "buycoolantcell"
})


DarkRP.createEntity("CQC Прицелы", {
    ent = "cw_attpack_sights_cqb",
    model = "models/Items/BoxMRounds.mdl",
    price = 300,
    max = 10,
    cmd = "buycqcsights",
    allowed = {TEAM_GUN},
})

DarkRP.createEntity("MP5 Разное", {
    ent = "cw_attpack_mp5_misc",
    model = "models/Items/BoxMRounds.mdl",
    price = 150,
    max = 10,
    cmd = "buymp5sights",
    allowed = {TEAM_GUN},
})

DarkRP.createEntity("MP5 Приклады", {
    ent = "cw_attpack_mp5_stocks",
    model = "models/Items/BoxMRounds.mdl",
    price = 100,
    max = 10,
    cmd = "buymp5stocks",
    allowed = {TEAM_GUN},
})

DarkRP.createEntity("Разные патроны для дробовика", {
    ent = "cw_attpack_ammotypes_shotguns",
    model = "models/Items/BoxMRounds.mdl",
    price = 200,
    max = 10,
    cmd = "buyshotgunammotypes",
    allowed = {TEAM_GUN},
})

DarkRP.createEntity("Вариации боеприпаса", {
    ent = "cw_attpack_ammotypes_rifles",
    model = "models/Items/BoxMRounds.mdl",
    price = 200,
    max = 10,
    cmd = "buyrifleammotypes",
    allowed = {TEAM_GUN},
})



DarkRP.createEntity("Стволы MR96", {
    ent = "cw_attpack_mr96_barrels",
    model = "models/Items/BoxMRounds.mdl",
    price = 300,
    max = 10,
    cmd = "buymr96barrels",
    allowed = {TEAM_ILLEGALDEALER},
})

DarkRP.createEntity("АК74 Разное", {
    ent = "cw_attpack_ak74_misc",
    model = "models/Items/BoxMRounds.mdl",
    price = 350,
    max = 10,
    cmd = "buyak74misc",
    allowed = {TEAM_ILLEGALDEALER},
})

DarkRP.createEntity("АК74 Стволы", {
    ent = "cw_attpack_ak74_barrels",
    model = "models/Items/BoxMRounds.mdl",
    price = 400,
    max = 10,
    cmd = "buyak74barrels",
    allowed = {TEAM_ILLEGALDEALER},
})

DarkRP.createEntity("АК74 Приклады", {
    ent = "cw_attpack_ak74_stocks",
    model = "models/Items/BoxMRounds.mdl",
    price = 250,
    max = 10,
    cmd = "buyak74stocks",
    allowed = {TEAM_ILLEGALDEALER},
})

DarkRP.createEntity("Нелегальные обвесы", {
    ent = "cw_attpack_various",
    model = "models/Items/BoxMRounds.mdl",
    price = 800,
    max = 10,
    cmd = "buyvarious",
    allowed = {TEAM_ILLEGALDEALER},
})






DarkRP.createEntity("Прицелы средней дальности", {
    ent = "cw_attpack_sights_midrange",
    model = "models/Items/BoxMRounds.mdl",
    price = 450,
    max = 10,
    cmd = "buymidrangesights",
    allowed = {TEAM_HEAVYDEALER},
})

DarkRP.createEntity("Прицелы большой дальности", {
    ent = "cw_attpack_sights_longrange",
    model = "models/Items/BoxMRounds.mdl",
    price = 600,
    max = 10,
    cmd = "buylongrangesights",
    allowed = {TEAM_HEAVYDEALER},
})

DarkRP.createEntity("AR15 Приклады", {
    ent = "cw_attpack_ar15_stocks",
    model = "models/Items/BoxMRounds.mdl",
    price = 200,
    max = 10,
    cmd = "buyar15stocks",
    allowed = {TEAM_HEAVYDEALER},
})

DarkRP.createEntity("AR15 Стволы (большие)", {
    ent = "cw_attpack_ar15_barrels_large",
    model = "models/Items/BoxMRounds.mdl",
    price = 250,
    max = 10,
    cmd = "buyar15barrelslarge",
    allowed = {TEAM_HEAVYDEALER},
})

DarkRP.createEntity("AR15 Стволы", {
    ent = "cw_attpack_ar15_barrels",
    model = "models/Items/BoxMRounds.mdl",
    price = 250,
    max = 10,
    cmd = "buyar15barrels",
    allowed = {TEAM_HEAVYDEALER},
})

DarkRP.createEntity("Разные патроны для винтовки", {
    ent = "cw_attpack_ammotypes_rifles",
    model = "models/Items/BoxMRounds.mdl",
    price = 200,
    max = 10,
    cmd = "buyar15ammotypesrifles",
    allowed = {TEAM_HEAVYDEALER},
})

DarkRP.createEntity("G3A3 Обвесы", {
    ent = "cw_attpack_g3_sg1package",
    model = "models/Items/BoxMRounds.mdl",
    price = 250,
    max = 10,
    cmd = "buyg3sg1package",
    allowed = {TEAM_HEAVYDEALER},
})




