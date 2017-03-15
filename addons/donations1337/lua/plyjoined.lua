meta = FindMetaTable("Player")

function meta:Process()
	if not DBCONNECTED then return end
	self.pweapons = {}
	local 	selectPlayer = prepareAndRun(SQLPatterns.selPly,self:SteamID())	
	timer.Simple(0, function() 
		if selectPlayer:isRunning() then
		selectPlayer:wait() end
		local data = selectPlayer:getData()
		--print(#data)
		if not data or #data == 0 then
			writeDBLog("New player "..self:SteamID().." joined, adding to playerbase")
			prepareAndRun(	SQLPatterns.sendPly,
							self:SteamID(),
							self:SteamID64(),
							self:GetUserGroup(),
							os.time()	)
			
		else
			if data[1].usergroup ~= self:GetUserGroup() then
				prepareAndRun(SQLPatterns.updateUGroup, self:GetUserGroup(), self:SteamID64()) 
			end

			local pweapons = selectPlayer:getData()
			pweapons = pweapons[1].permaweapons
			if #pweapons > 0 then
				local weps = split(pweapons,' ')
				self.pweapons = {}
				for k,v in pairs(weps) do
					table.insert(self.pweapons,#self.pweapons+1,v)
				end

			end
			
		end
		self.initSpawnEnded = true
	end)
end


function givePWeapons(ply)
	local jobTable = ply:getJobTable()
	if jobTable.PlayerLoadout and jobTable.PlayerLoadout(ply) then return end
	if isDonator(ply) then
		ply:Give("weapon_vape")
	end

	if not ply.initSpawnEnded then
		timer.Simple(1,function() givePWeapons(ply) end)
		return
	end
	if ply:isArrested() then return end
	if #ply.pweapons == 0 or ply.pweapons == nil then return end
	for k,v in pairs(ply.pweapons) do
		local wep = ents.Create(v)
		local ammo = wep:GetPrimaryAmmoType()
		ply:SetAmmo(0,ammo)
		ply:Give(v)
	end
end

hook.Add("PlayerPostLoadout","permaweapons",givePWeapons) 



amount:[["m9k_luger",				400,"P08 Luger"],
			["m9k_coltpython",		400,"Colt Python"],
			["m9k_ragingbull",		400,"Raging Bull"],
			["m9k_model3russian",		400,"S & W Model 3 Russian"],
			["m9k_model500",		400,"S&W Model 500"],
			["m9k_m29satan",		400,"M29 Satan"],
			["m9k_deagle",			400,"Desert Eagle"],
			["m9k_scoped_taurus",		400,"Raging Bull - Scoped"],
			["m9k_model627",		400,"S&W Model 627"],
			["m9k_m92beretta",		400,"M92 Beretta"],
			["m9k_sig_p229r",		400,"SIG Sauer P229R"],
			["m9k_hk45",			400,"HK45C"],
			["m9k_colt1911",		400,"Colt 1911"],
			["weapon_vape_medicinal"		,200,"Medicinal Vape"],
			["weapon_vape_hallucinogenic"	,100,"Hallucinogenic Vape"],
			["weapon_vape_juicy"			,100,"Juicy Vape"],
			["weapon_vape_american"			,100,"American Vape"],
			["weapon_vape" 					,100,"Vape"]]