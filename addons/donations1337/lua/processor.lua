function processPendings()
	if not DBCONNECTED then return end
	local pendings = prepareAndRun(SQLPatterns.getpending,os.time())
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
			writeDBLog("Added ".. money.." dolalrs to "..v.steamid64)
		end
		if v.type == "addgroup" then
			local ply64 = v.steamid64
			local ply = util.SteamIDFrom64(v.steamid64)
			local time = os.time() + UNIX_1_DAY*v.amount
			local group = v.addargs
			local id = v.id
			local trans = db:createTransaction()
				trans:addQuery(prepareNotRun(SQLPatterns.updatePStatus,id))
				trans:addQuery(addOrUpdateRemove(ply64,time,"removegroup"))
				trans:addQuery(prepareNotRun(SQLPatterns.updateUGroup,group,ply64))
				trans.ply = ply
				trans.group = group
				trans.onSuccess = function(tr) ULib.ucl.addUser(tr.ply,{},{},tr.group) end
				trans.onError = genericOnError
				trans:start()
			writeDBLog("Modified ".. ply .." group to ".. group)
		end
		if v.type == "removegroup" then
			local ply64 = v.steamid64
			local ply = util.SteamIDFrom64(v.steamid64)
			local id = v.id
			local trans = db:createTransaction()
				trans:addQuery(prepareNotRun(SQLPatterns.updatePStatus,id))
				trans:addQuery(prepareNotRun(SQLPatterns.updateUGroup,"user",ply64))
				trans.ply = ply
				trans.onSuccess = function(q) ULib.ucl.removeUser(q.ply) end
				trans.onError = genericOnError
				trans:start()
				writeDBLog("Removed access from"..ply)
		end

	end

end

timer.Create("SQLprocessor",30,0,processPendings)