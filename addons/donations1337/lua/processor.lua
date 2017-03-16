function addmoney(v)
	local ply = player.GetBySteamID64(v.steamid64)
	if not ply then return end
	local money = v.amount
	local id = v.id
	local query = db:prepare(SQLPatterns.updatePStatus) 
			query:setNumber(1, id)
			query.affectedPlayer = ply
			query.moneyValue = money
			query.ply64 = v.steamid64
			query.onSuccess = wrapSuccess(function(q) 	q.affectedPlayer:addMoney(q.moneyValue) 
											writeDBLog("Added ".. money.." dolalrs to "..v.steamid64)
											notify64(q.ply64, "Вы получили "..q.moneyValue.." долларов")
											end)
			query.onError = gnericOnError
			query:start()
end

function addgroup(v)
	local ply64 = v.steamid64
	local ply = util.SteamIDFrom64(v.steamid64)
	local time = os.time() + UNIX_1_DAY*v.amount
	local group = v.addargs
	local id = v.id
	local trans = db:createTransaction()
		trans:addQuery(prepareNotRun(SQLPatterns.updatePStatus, id))
		trans:addQuery(addOrUpdateRemove(ply64, time, "removegroup"))
		trans:addQuery(prepareNotRun(SQLPatterns.updateUGroup, group, ply64))
		trans.ply = ply
		trans.group = group
		trans.onSuccess = wrapSuccess(function(tr) 	ULib.ucl.addUser(tr.ply, {}, {}, tr.group) 
										writeDBLog("Modified ".. ply .." group to ".. group)
										local play = player.GetBySteamID(tr.ply)
										if play then
											chatAnnounce(play:Nick().." теперь "..group) 
										end
										notify(tr.ply, "Поздравляем! Вы теперь ".. tr.group)
										end)
		trans.onError = genericOnError
		trans:start()
end

function removegroup(v)
	local ply64 = v.steamid64
	local ply = util.SteamIDFrom64(v.steamid64)
	local id = v.id
	local trans = db:createTransaction()
		trans:addQuery(prepareNotRun(SQLPatterns.updatePStatus, id))
		trans:addQuery(prepareNotRun(SQLPatterns.updateUGroup, "user", ply64))
		trans.ply = ply
		trans.onSuccess = wrapSuccess(function(q) 	ULib.ucl.removeUser(q.ply)
										writeDBLog("Removed access from"..ply)
										notify(q.ply, "Вы снова обычный игрок,  пора продлить подписку")
										end)
		trans.onError = genericOnError
		trans:start()

end

function addpweapon(v)
	local ply64 = v.steamid64
	local ply = util.SteamIDFrom64(v.steamid64)
	local id = v.id
	local wep = v.addargs
	local time = os.time() + UNIX_1_DAY*v.amount
	local weps = getPWeapons(ply) or {}
	table.RemoveByValue(weps,wep)
	table.insert(weps, #weps+1, wep)
	local stringweps = table.concat(weps, ' ')
	local trans = db:createTransaction()
		trans:addQuery(prepareNotRun(SQLPatterns.updatePStatus, id))
		trans:addQuery(addOrUpdateRemove(ply64, time, "removepweapon",wep))
		trans:addQuery(prepareNotRun(SQLPatterns.updatePWeps, stringweps, ply64))
		trans.wep = wep
		trans.ply = ply
		trans.onSuccess = wrapSuccess(function(tr)	writeDBLog("Added permaweapon "..tr.wep.." to "..tr.ply)
										notify(tr.ply, "Вам пришло новое пермаоружие")
										local p = player.GetBySteamID(tr.ply)
										if p and p:IsValid() then
											p:Process()
											givePWeapons(p)
										end
									end)
		trans.onError = genericOnError
		trans:start()
end

function removepweapon(v)
	local ply64 = v.steamid64
	local ply = util.SteamIDFrom64(v.steamid64)
	local id = v.id
	local wep = v.addargs
	local weps = getPWeapons(ply) or {}
	table.RemoveByValue(weps,wep)
	local stringweps = table.concat(weps, ' ')
	local trans = db:createTransaction()
		trans:addQuery(prepareNotRun(SQLPatterns.updatePStatus, id))
		trans:addQuery(prepareNotRun(SQLPatterns.updatePWeps, stringweps, ply64))
		trans.wep = wep
		trans.ply = ply
		trans.onSuccess = wrapSuccess(function(tr)	writeDBLog("REmoved permaweapon "..tr.wep.." to "..tr.ply)
										notify(tr.ply, "Срок действия пермаоружия истек")
										local ply = player.GetBySteamID(tr.ply)
										if ply and ply:isValid() then
											ply:Process()
											givePWeapons(ply)
										end
										end)
		trans.onError = genericOnError
		trans:start()
end

function processPendings()
	if not DBCONNECTED then return end
	local pendings = prepareAndRun(SQLPatterns.getpending, os.time())
	if pendings:isRunning() then pendings:wait() end
	local data = pendings:getData()
	--print("Processing ".. #data.." pendings now")
	for k, v in pairs(data) do
		if v.type == "addmoney" then
			xpcall(addmoney,errCall,v)
			
		end
		if v.type == "addgroup" then
			xpcall(addgroup,errCall,v)
			
		end
		if v.type == "removegroup" then
			xpcall(removegroup,errCall,v)
				
		end
		if v.type == "addpweapon" then
			xpcall(addpweapon,errCall,v)
  
		end
		if v.type == "removepweapon" then
			xpcall(removepweapon,errCall,v)
		


		end
  
	end

end

timer.Create("SQLprocessor", 10, 0, processPendings) // 5 minutes