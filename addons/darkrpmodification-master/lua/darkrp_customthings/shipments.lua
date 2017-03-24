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

DarkRP.createShipment("Нож", {
    model = "models/weapons/wcw_ex_ra.mdl",
    entity = "cw_extrema_ratio_official",
    price = 850,
    amount = 10,
    separate = true,
    pricesep = 400,
    noship = true,
    allowed = {TEAM_GUN},
})

DarkRP.createShipment("Colt 1911", {
    model = "models/weapons/cw_pist_m1911.mdl",
    entity = "m9k_colt1911",
    price = 850,
    amount = 10,
    separate = true,
    pricesep = 500,
    noship = true,
    allowed = {TEAM_GUN},
})

DarkRP.createShipment("FN Five-seveN", {
    model = "models/weapons/w_pist_fiveseven.mdl",
    entity = "cw_fiveseven",
    price = 850,
    amount = 10,
    separate = true,
    pricesep = 650,
    noship = true,
    allowed = {TEAM_GUN},
})

DarkRP.createShipment("Walther P99", {
    model = "models/weapons/w_pist_p228.mdl",
    entity = "cw_p99",
    price = 850,
    amount = 10,
    separate = true,
    pricesep = 800,
    noship = true,
    allowed = {TEAM_GUN},
})

DarkRP.createShipment("MR99", {
    model = "models/weapons/w_357.mdl",
    entity = "cw_mr96",
    price = 850,
    amount = 10,
    separate = true,
    pricesep = 1100,
    noship = true,
    allowed = {TEAM_GUN},
})

DarkRP.createShipment("Mac-11", {
    model = "models/weapons/w_cst_mac11.mdl",
    entity = "cw_mac11",
    price = 850,
    amount = 10,
    separate = true,
    pricesep = 1300,
    noship = true,
    allowed = {TEAM_GUN},
})

DarkRP.createShipment("H&K MP5", {
    model = "models/weapons/w_smg_mp5.mdl",
    entity = "cw_mp5",
    price = 850,
    amount = 10,
    separate = true,
    pricesep = 1500,
    noship = true,
    allowed = {TEAM_GUN},
})

DarkRP.createShipment("Shorty", {
    model = "models/weapons/cw2_super_shorty.mdl",
    entity = "cw_shorty",
    price = 850,
    amount = 10,
    separate = true,
    pricesep = 1500,
    noship = true,
    allowed = {TEAM_GUN},
})





DarkRP.createShipment("ПМ", {
    model = "models/cw2/pistols/w_makarov.mdl",
    entity = "cw_makarov",
    price = 850,
    amount = 10,
    separate = true,
    pricesep = 450,
    noship = true,
    allowed = {TEAM_ILLEGALDEALER},
})

DarkRP.createShipment("АК 74", {
    model = "models/weapons/w_rif_ak47.mdl",
    entity = "cw_ak74",
    price = 850,
    amount = 10,
    separate = true,
    pricesep = 1800,
    noship = true,
    allowed = {TEAM_ILLEGALDEALER},
})

DarkRP.createShipment("VSS Винторез", {
    model = "models/cw2/rifles/w_vss.mdl",
    entity = "cw_vss",
    price = 850,
    amount = 10,
    separate = true,
    pricesep = 1800,
    noship = true,
    allowed = {TEAM_ILLEGALDEALER},
})

DarkRP.createShipment("Mosin-Nagant", {
    model = "models/weapons/ws mosin/w_ws_mosin.mdl",
    entity = "cw_ws_mosin",
    price = 850,
    amount = 10,
    separate = true,
    pricesep = 2500,
    noship = true,
    allowed = {TEAM_ILLEGALDEALER},
})

DarkRP.createShipment("Thompson 1928A1", {
    model = "models/weapons/w_thompsont.mdl",
    entity = "cw_thompsona1_s",
    price = 850,
    amount = 10,
    separate = true,
    pricesep = 1200,
    noship = true,
    allowed = {TEAM_ILLEGALDEALER},
})

DarkRP.createShipment("Дымовая граната", {
    model = "models/weapons/w_eq_smokegrenade.mdl",
    entity = "cw_smoke_grenade",
    price = 850,
    amount = 10,
    separate = true,
    pricesep = 300,
    noship = true,
    allowed = {TEAM_ILLEGALDEALER},
})






DarkRP.createShipment("AR15", {
    model = "models/weapons/w_rif_m4a1.mdl",
    entity = "cw_ar15",
    price = 850,
    amount = 10,
    separate = true,
    pricesep = 2200,
    noship = true,
    allowed = {TEAM_HEAVYDEALER},
})

DarkRP.createShipment("FN SCAR-H", {
    model = "models/cw2/rifles/w_scarh.mdl",
    entity = "cw_scarh",
    price = 850,
    amount = 10,
    separate = true,
    pricesep = 2600,
    noship = true,
    allowed = {TEAM_HEAVYDEALER},
})

DarkRP.createShipment("G3A3", {
    model = "models/weapons/w_snip_g3sg1.mdl",
    entity = "cw_g3a3",
    price = 850,
    amount = 10,
    separate = true,
    pricesep = 2550,
    noship = true,
    allowed = {TEAM_HEAVYDEALER},
})

DarkRP.createShipment("H&K G36C", {
    model = "models/weapons/cw20_g36c.mdl",
    entity = "cw_g36c",
    price = 850,
    amount = 10,
    separate = true,
    pricesep = 2400,
    noship = true,
    allowed = {TEAM_HEAVYDEALER},
})

DarkRP.createShipment("L85A2", {
    model = "models/weapons/w_cw20_l85a2.mdl",
    entity = "cw_l85a2",
    price = 850,
    amount = 10,
    separate = true,
    pricesep = 2600,
    noship = true,
    allowed = {TEAM_HEAVYDEALER},
})

DarkRP.createShipment("M14 EBR", {
    model = "models/weapons/w_cstm_m14.mdl",
    entity = "cw_m14",
    price = 850,
    amount = 10,
    separate = true,
    pricesep = 3000,
    noship = true,
    allowed = {TEAM_HEAVYDEALER},
})

DarkRP.createShipment("M249", {
    model = "models/weapons/cw2_0_mach_para.mdl",
    entity = "cw_m249_official",
    price = 850,
    amount = 10,
    separate = true,
    pricesep = 8000,
    noship = true,
    allowed = {TEAM_HEAVYDEALER},
})










