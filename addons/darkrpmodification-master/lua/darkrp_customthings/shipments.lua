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
    pricesep = 2600,
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
    pricesep = 3500,
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
    pricesep = 3400,
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
    pricesep = 4500,
    noship = true,
    allowed = {TEAM_GUN},
    category = "Pistols",
})

DarkRP.createShipment("S&W Model 627", {
    model = "models/weapons/w_sw_model_627.mdl",
    entity = "m9k_model627",
    price = 2450,
    amount = 10,
    separate = true,
    pricesep = 4600,
    noship = true,
    allowed = {TEAM_GUN},
    category = "Pistols",
})

DarkRP.createShipment("Thommy Gun", {
    model = "models/weapons/w_tommy_gun.mdl",
    entity = "m9k_thompson",
    price = 2450,
    amount = 10,
    separate = true,
    pricesep = 8900,
    noship = true,
    allowed = {TEAM_GUN},
    category = "Rifles",
})

DarkRP.createShipment("Отмычка", {
    model = "models/weapons/w_crowbar.mdl",
    entity = "lockpick",
    price = 1000,
    amount = 10,
    separate = true,
    pricesep = 800,
    noship = true,
    allowed = {TEAM_ILLEGALDEALER},
})

DarkRP.createShipment("Устройство для взлома", {
    model = "models/weapons/w_c4.mdl",
    entity = "keypad_cracker",
    price = 1000,
    amount = 10,
    separate = true,
    pricesep = 1200,
    noship = true,
    allowed = {TEAM_ILLEGALDEALER},
})




