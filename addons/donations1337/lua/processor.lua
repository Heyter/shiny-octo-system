function processPendings()
	if not DBCONNECTED then return end
	local pendings = prepareAndRun(SQLPatterns.getpending, os.time())
	if pendings:isRunning() then pendings:wait() end
	local data = pendings:getData()
	--print("Processing ".. #data.." pendings now")
	for k, v in pairs(data) do
		if v.type == "addmoney" then
			local ply = player.GetBySteamID64(v.steamid64)
			if not ply then continue end
			local money = v.amount
			local id = v.id
			local query = db:prepare(SQLPatterns.updatePStatus) 
					query:setNumber(1, id)
					query.affectedPlayer = ply
					query.moneyValue = money
					query.ply64 = v.steamid64
					query.onSuccess = function(q) 	q.affectedPlayer:addMoney(q.moneyValue) 
													writeDBLog("Added ".. money.." dolalrs to "..v.steamid64)
													notify64(q.ply64, "Вы получили "..q.moneyValue.." долларов")
													end
					query.onError = gnericOnError
					query:start()
			
		end
		if v.type == "addgroup" then
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
				trans.onSuccess = function(tr) 	ULib.ucl.addUser(tr.ply, {}, {}, tr.group) 
												writeDBLog("Modified ".. ply .." group to ".. group)
												notify(tr.ply, "Поздравляем! Вы теперь ".. tr.group)
												end
				trans.onError = genericOnError
				trans:start()
			
		end
		if v.type == "removegroup" then
			local ply64 = v.steamid64
			local ply = util.SteamIDFrom64(v.steamid64)
			local id = v.id
			local trans = db:createTransaction()
				trans:addQuery(prepareNotRun(SQLPatterns.updatePStatus, id))
				trans:addQuery(prepareNotRun(SQLPatterns.updateUGroup, "user", ply64))
				trans.ply = ply
				trans.onSuccess = function(q) 	ULib.ucl.removeUser(q.ply)
												writeDBLog("Removed access from"..ply)
												notify(tr.ply, "Вы снова обычный игрок,  пора продлить подписку")
												end
				trans.onError = genericOnError
				trans:start()
				
		end
		if v.type == "addpweapon" then
			local ply64 = v.steamid64
			local ply = util.SteamIDFrom64(v.steamid64)
			local id = v.id
			local wep = v.addargs
			local time = os.time() + UNIX_1_DAY*v.amount
			local weps = getPWeapons(ply) or {}
			PrintTable(weps)
			table.RemoveByValue(weps,wep)
			table.insert(weps, #weps+1, wep)
			PrintTable(weps)
			local stringweps = table.concat(weps, ' ')
			local trans = db:createTransaction()
				trans:addQuery(prepareNotRun(SQLPatterns.updatePStatus, id))
				trans:addQuery(addOrUpdateRemove(ply64, time, "removepweapon"))
				trans:addQuery(prepareNotRun(SQLPatterns.updatePWeps, stringweps, ply64))
				trans.wep = wep
				trans.ply = ply
				trans.onSuccess = function(tr)	writeDBLog("Added permaweapon "..tr.wep.." to "..tr.ply)
												notify(tr.ply, "Вам пришло новое пермаоружие")
												end
				trans.onError = genericOnError
				trans:start()
  
		end
		if v.type == "removepweapon" then
			local ply64 = v.steamid64
			local ply = util.SteamIDFrom64(v.steamid64)
			local id = v.id
			local weps = getPWeapons(ply) or {}
			table.RemoveByValue(weps,wep)
			local trans = db:createTransaction()
				trans:addQuery(prepareNotRun(SQLPatterns.updatePStatus, id))
				trans:addQuery(prepareNotRun(SQLPatterns.updatePWeps, stringweps, ply64))
				trans.wep = wep
				trans.ply = ply
				trans.onSuccess = function(tr)	writeDBLog("REmoved permaweapon "..tr.wep.." to "..tr.ply)
												notify(tr.ply, "Срок действия пермаоружия истек")
												end
				trans.onError = genericOnError
				trans:start()
		


		end
  
	end

end

timer.Create("SQLprocessor", 10, 0, processPendings) // 5 minutes