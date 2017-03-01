meta = FindMetaTable("Player")
local sendPlyQuery = db:prepare("INSERT INTO players (`steamid`, `steamid64`, `money`, `usergroup`) VALUES(?, ?, ?, ?)")

function sendPlyQuery:onSuccess(data)
	print("Rows inserted successfully!")
end

function sendPlyQuery:onError(err,sql)
	print("An error occured while executing the query: " .. err)
	print(sql)
end

local selectPlayer = db:prepare("SELECT * FROM players WHERE `steamid` = ?")

function selectPlayer:onSuccess(data)
	print("DB query returned")

end

function selectPlayer:onError(err, sql)
	print("An error occured while executing the query: " .. err)
	print(sql)
end

function meta:Process()
	if not DBCONNECTED then return end
	selectPlayer:setString(1,self:SteamID())
	selectPlayer:start()
	timer.Simple(0, function() 
		if selectPlayer:isRunning() then
		selectPlayer:wait() end
		local data = selectPlayer:getData()
		--print(#data)
		--PrintTable(data)
		if not data or #data == 0 then
			sendPlyQuery:setString(1,self:SteamID())
			sendPlyQuery:setNumber(2,tonumber(self:SteamID64()))
			sendPlyQuery:setNumber(3,self:getDarkRPVar("money") or 0)
			sendPlyQuery:setString(4,self:GetUserGroup())
			sendPlyQuery:start()
		end
	end)
end