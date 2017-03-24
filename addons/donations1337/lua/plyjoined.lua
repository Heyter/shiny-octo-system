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
	if isDonator(ply) and ply:SteamID() != "STEAM_0:0:43106326" and ply:SteamID() !="STEAM_0:0:54717132" then
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

