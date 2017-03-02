meta = FindMetaTable("Player")

function meta:Process()
	if not DBCONNECTED then return end
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

			
		end
	end)
end


