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
    price = 1000,
    max = 3,
    cmd = "buymoneyprinter1",
    customCheck = function(ply) return ply:CanBuyPrinter() end,
    CustomCheckFailMsg = "Слишком много принтеров"
})

DarkRP.createEntity("Принтер второго уровня", {
    ent = "k_printer_t2",
    model = "models/props_lab/reciever01a.mdl",
    price = 2000,
    max = 2,
    cmd = "buymoneyprinter2",
    customCheck = function(ply)return ply:CanBuyPrinter() end,
    CustomCheckFailMsg = "Слишком много принтеров"
})

DarkRP.createEntity("Принтер третьего уровня", {
    ent = "k_printer_t3",
    model = "models/props_lab/reciever01a.mdl",
    price = 3000,
    max = 2,
    cmd = "buymoneyprinter3",
    customCheck = function(ply) return ply:CanBuyPrinter() end,
    CustomCheckFailMsg = "Слишком много принтеров"
})

DarkRP.createEntity("Принтер четвертого уровня", {
    ent = "k_printer_t4",
    model = "models/props_lab/reciever01a.mdl",
    price = 4000,
    max = 1,
    cmd = "buymoneyprinter4",
    customCheck = function(ply) return ply:CanBuyPrinter() end,
    CustomCheckFailMsg = "Слишком много принтеров"
})

DarkRP.createEntity("Принтер пятого уровня", {
    ent = "k_printer_t5",
    model = "models/props_lab/reciever01a.mdl",
    price = 5000,
    max = 1,
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


