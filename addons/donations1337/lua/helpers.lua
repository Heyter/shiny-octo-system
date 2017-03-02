meta = FindMetaTable("Player")
qrs = {}
qrs.sendPlyQueryPattern 	= "INSERT INTO players (`steamid`, `steamid64`, `money`, `usergroup`, `firstjoined`) VALUES(?, ?, ?, ?, ?)"
qrs.selPlyQueryPattern 		= "SELECT * FROM players WHERE `steamid` = ?"
qrs.sendLogQueryPattern		= "INSERT INTO log (`time`,`entry`) VALUES (?, ?)"
function genericOnSuccess(q,data)
	print("DB query returned")

end

function genericOnError(q, err, sql)
	print("An error occured while executing the query: " .. err)
	print(sql)
end

function meta:Process()
	if not DBCONNECTED then return end
	local 	selectPlayer = db:prepare(qrs.selPlyQueryPattern)
			selectPlayer.onSuccess = genericOnSuccess
			selectPlayer.onError = genericOnError
			selectPlayer:setString(1,self:SteamID())
			selectPlayer:start()
	timer.Simple(0, function() 
		if selectPlayer:isRunning() then
		selectPlayer:wait() end
		local data = selectPlayer:getData()
		--print(#data)
		--PrintTable(data)
		if not data or #data == 0 then
			writeDBLog("New player "..self:SteamID().." joined, adding to playerbase")
			local 	sendPlyQuery = db:prepare(qrs.sendPlyQueryPattern)
					sendPlyQuery.onSuccess = genericOnSuccess
					sendPlyQuery.onError = genericOnError
					sendPlyQuery:setString(1,self:SteamID())
					sendPlyQuery:setNumber(2,tonumber(self:SteamID64()))
					sendPlyQuery:setNumber(3,self:getDarkRPVar("money") or 0)
					sendPlyQuery:setString(4,self:GetUserGroup())
					sendPlyQuery:setNumber(5,os.time())
					sendPlyQuery:start()
		end
	end)
end

function writeDBLog(str)
	local 	sendlog = db:prepare(qrs.sendLogQueryPattern)
			sendlog.onSuccess = genericOnSuccess
			sendlog.onError = genericOnError
			sendlog:setNumber(1,os.time())
			sendlog:setString(2,str)
			sendlog:start()
	end