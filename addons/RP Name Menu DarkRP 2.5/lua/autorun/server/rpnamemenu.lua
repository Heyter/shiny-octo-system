// Made by Tomasas http://steamcommunity.com/id/tomasas/

local BlackList = {"nigga", "fag", "gayboy", "penis"} //simply insert a name encased in quotes and seperate it with a comma

concommand.Add("c_rpname", function(ply, cmd, args)

	if !ply.ForcedNameChange and (!ply.DarkRPVars or ply.DarkRPVars and (ply.DarkRPVars.rpname and ply.DarkRPVars.rpname != ply:SteamName() and ply.DarkRPVars.rpname != "NULL")) then return end
	
	for i=1, #BlackList do
		if string.find(string.lower(args[1]), string.lower(BlackList[i])) then
			DarkRP.notify(ply, 1, 10, "This name not allowed!")
			umsg.Start("openRPNameMenu", ply)
			umsg.End()
			return
		end
	end
	
	DarkRP.retrieveRPNames(args[1], function(taken)
		if taken and ply:IsValid() then
			DarkRP.notify(ply, 1, 10, "This name is already being used!")
			umsg.Start("openRPNameMenu", ply)
			umsg.End()
		elseif ply:IsValid() then
			ply.ForcedNameChange = nil
			DarkRP.storeRPName(ply, args[1])
		end
	end)
end)


hook.Add("PlayerAuthed", "RPNameChecking", function(ply)
	timer.Simple(9, function() //let darkrp load their name before checking
		if !ply:IsValid() then return end
		if ply.DarkRPVars and (!ply.DarkRPVars.rpname or ply.DarkRPVars.rpname == ply:SteamName() or ply.DarkRPVars.rpname == "NULL") then
			umsg.Start("openRPNameMenu", ply)
			umsg.End()
		end
	end) 
end)
//©Tomasas 2013