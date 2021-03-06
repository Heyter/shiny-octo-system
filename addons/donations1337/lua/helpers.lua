UNIX_1_DAY =  86400
function genericOnSuccess(q,data)
	--print("DB query returned again")

end

function wrapSuccess(f)
	return function(val) xpcall(f,errCall,val) end

end
function genericOnError(q, err, sql)
	ply = {}
	for k,v in pairs(player.GetAll()) do
		if isAdmin(v) then
			table.insert(ply,v)
		end
	end
	DarkRP.notify(ply,1,10,"Ошибки в SQL! Передай это ближайшему доступному кодеру.")
	print("An error occured while executing the query: " .. err)
	print(sql)
end

function errCall(msg)
	print(msg)
	file.Append("DonationsErrLog.txt",msg..'\n')
	ply = {}
	for k,v in pairs(player.GetAll()) do
		if isAdmin(v) then
			table.insert(ply,v)
		end
	end
	DarkRP.notify(ply,1,10,"Ошибки в системе донатов! Передай это ближайшему доступному кодеру.")
end

function prepareAndRun(query, ...)
	if not DBCONNECTED then return false end
	local args = {...}
	local toRun = db:prepare(query)
	toRun.onSuccess = genericOnSuccess
	toRun.onError = genericOnError
	--PrintTable(args)
	for k,v in ipairs(args) do
		if type(v) == "string" then
			toRun:setString(k,v)
		end
		if type(v) == "number" then
			toRun:setNumber(k,v)
		end
	end
	toRun:start()
	return toRun
end

function prepareNotRun(query, ...)
	if not DBCONNECTED then return false end
	local args = {...}
	local toRun = db:prepare(query)
	toRun.onSuccess = genericOnSuccess
	toRun.onError = genericOnError
	--PrintTable(args)
	for k,v in ipairs(args) do
		if type(v) == "string" then
			toRun:setString(k,v)
		end
		if type(v) == "number" then
			toRun:setNumber(k,v)
		end
	end
	return toRun
end

function addOrUpdateRemove(ply64,time,type,addargs)
	addargs = addargs or ""
	local sel = prepareAndRun(SQLPatterns.checkPending,ply64,os.time(),type,addargs)
	if sel:isRunning() then sel:wait() end
	data = sel:getData()
	addargs = addargs or 'none'
	if #data == 0 then
		return prepareNotRun(SQLPatterns.addPending,ply64,time,type,addargs)
	else
		time = data[1]['addedon'] + (time - os.time())
		return prepareNotRun(SQLPatterns.updatePending,time,data[1]['id'])
	end

end

function notify(p,s)
	local ply = player.GetBySteamID(p)
	if not ply then return end
	DarkRP.notify(ply,0,10,s)
end
function notify64(p,s)
	local ply = player.GetBySteamID64(p)
	if not ply then return end
	DarkRP.notify(ply,0,10,s)
end

function writeDBLog(str)
	prepareAndRun(SQLPatterns.sendLog, os.time(), str)
	end

function split(s)
	local ret = {}
	if #s>0 then
		for i in string.gmatch(s, "%S+") do
	   		table.insert(ret,#ret+1,i)
		end
		return ret
	else return false end
end

function getPWeapons(id)
	local query = prepareAndRun(SQLPatterns.selPly,id)
	if query:isRunning() then query:wait() end
	local data = query:getData()
	if #data == 0 then return false end
	return split(data[1]['permaweapons'])
end

function chatAnnounce(text)
	for k,p in pairs(player.GetAll()) do
		p:ChatPrint(text)
	end
end