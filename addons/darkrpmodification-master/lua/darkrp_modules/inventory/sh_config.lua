-- #NoSimplerr#names_helper = {	}timer.Simple(0,function()	for k,v in pairs(weapons.GetList()) do		--print(v,v.ClassName,v.PrintName)		names_helper[v.ClassName] = v.PrintName		--PrintTable(v)	end	--PrintTable(names_helper)	--print("Namehelpers initialized with",#names_helper,"elements")end)inv_whitelist = {	spawned_weapon = true,	armor = true,	health_pack = true,	k_printer_upgrade = true,	k_coolant_cell = true}