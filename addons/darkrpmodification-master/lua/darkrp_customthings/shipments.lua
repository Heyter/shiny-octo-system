--[[---------------------------------------------------------------------------
DarkRP custom shipments and guns
---------------------------------------------------------------------------

This file contains your custom shipments and guns.
This file should also contain shipments and guns from DarkRP that you edited.

Note: If you want to edit a default DarkRP shipment, first disable it in darkrp_config/disabled_defaults.lua
	Once you've done that, copy and paste the shipment to this file and edit it.

The default shipments and guns can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/addentities.lua

For examples and explanation please visit this wiki page:
http://wiki.darkrp.com/index.php/DarkRP:CustomShipmentFields


Add shipments and guns under the following line:
---------------------------------------------------------------------------]]
DarkRP.createShipment("Colt 1911", {
    model = "models/weapons/s_dmgf_co1911.mdl",
    entity = "m9k_colt1911",
    price = 850,
    amount = 10,
    separate = true,
    pricesep = 650,
    noship = true,
    allowed = {TEAM_GUN},
    category = "Pistols",
})

DarkRP.createShipment("HK USP", {
    model = "models/weapons/w_pist_fokkususp.mdl",
    entity = "m9k_usp",
    price = 0,
    amount = 10,
    separate = true,
    pricesep = 875,
    noship = true,
    allowed = {TEAM_GUN},
    category = "Pistols",
})

DarkRP.createShipment("M92 Beretta", {
    model = "models/weapons/w_beretta_m92.mdl",
    entity = "m9k_m92beretta",
    price = 0,
    amount = 10,
    separate = true,
    pricesep = 850,
    noship = true,
    allowed = {TEAM_GUN},
    category = "Pistols",
})

DarkRP.createShipment("Desert Eagle", {
    model = "models/weapons/w_tcom_deagle.mdl",
    entity = "m9k_deagle",
    price = 0,
    amount = 10,
    separate = true,
    pricesep = 1125,
    noship = true,
    allowed = {TEAM_GUN},
    category = "Pistols",
})

DarkRP.createShipment("S&W Model 627", {
    model = "models/weapons/w_sw_model_627.mdl",
    entity = "m9k_model627",
    price = 1150,
    amount = 10,
    separate = true,
    pricesep = 11150,
    noship = true,
    allowed = {TEAM_GUN},
    category = "Pistols",
})

DarkRP.createShipment("Uzi", {
        model = "models/weapons/w_uzi_imi.mdl",
        entity = "m9k_uzi",
        price = 2000,
        amount = 1,
        seperate = true,
        pricesep = 2000,
        noship = true,
        allowed = {TEAM_GUN}
})

DarkRP.createShipment("Thommy Gun", {
    model = "models/weapons/w_tommy_gun.mdl",
    entity = "m9k_thompson",
    price = 2450,
    amount = 10,
    separate = true,
    pricesep = 5000,
    noship = true,
    allowed = {TEAM_GUN},
    category = "Rifles",
})

DarkRP.createShipment("Double Barrel Shotgun", {
        model = "models/weapons/w_double_barrel_shotgun.mdl",
        entity = "m9k_dbarrel",
        price = 2375,
        amount = 1,
        seperate = true,
        pricesep = 9500,
        noship = true,
        allowed = {TEAM_GUN}
})

DarkRP.createShipment("AK-47", {
        model = "models/weapons/w_ak47_m9k.mdl",
        entity = "m9k_ak47",
        price = 2500,
        amount = 1,
        seperate = true,
        pricesep = 10000,
        noship = true,
        allowed = {TEAM_GUN}
})

DarkRP.createShipment("M16A4", {
        model = "models/weapons/w_dmg_m16ag.mdl",
        entity = "m9k_m16a4_acog",
        price = 1000,
        amount = 1,
        seperate = true,
        pricesep = 2750,
        noship = true,
        allowed = {TEAM_GUN}
})

DarkRP.createShipment("Winchester-73", {
        model = "models/weapons/w_winchester_1873.mdl",
        entity = "m9k_winchester73",
        price = 1000,
        amount = 1,
        seperate = true,
        pricesep = 3000,
        noship = true,
        allowed = {TEAM_GUN}
})

DarkRP.createShipment("SVT 40", {
        model = "models/weapons/w_svt_40.mdl",
        entity = "m9k_svt40",
        price = 1000,
        amount = 1,
        seperate = true,
        pricesep = 3500,
        noship = true,
        allowed = {TEAM_GUN}
})

DarkRP.createShipment("Отмычка", {
    model = "models/weapons/w_crowbar.mdl",
    entity = "lockpick",
    price = 1000,
    amount = 10,
    separate = true,
    pricesep = 500,
    noship = true,
    allowed = {TEAM_ILLEGALDEALER},
})

DarkRP.createShipment("Устройство для взлома", {
    model = "models/weapons/w_c4.mdl",
    entity = "keypad_cracker",
    price = 1000,
    amount = 10,
    separate = true,
    pricesep = 800,
    noship = true,
    allowed = {TEAM_ILLEGALDEALER},
})




