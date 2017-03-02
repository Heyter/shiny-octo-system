function processPendings()
	local pendings = prepareAndRun(SQLPatterns.getpending)
	if pendings:isRunning() then pendings:wait() end
	local data = pendings:getData()
	print("Processing ".. #data.." pendings now")
	for k,v in pairs(data) do
		if v.type == "addmoney" then
			local ply = player.GetBySteamID64(tostring(v.steamid64))
			if not ply then continue end
			local money = v.amount
			local id = v.id
			local query = db:prepare(SQLPatterns.updatePStatus) 
					query:setNumber(1,id)
					query.affectedPlayer = ply
					query.moneyValue = money
					query.onSuccess = function(q) q.affectedPlayer:addMoney(q.moneyValue) end
					query.onError = gnericOnError
					query:start()
			writeDBLog("Added ".. money.." dolalrs to"..v.steamid64)
		end

	end

end

timer.Create("SQLprocessor",60*5,0,processPendings)