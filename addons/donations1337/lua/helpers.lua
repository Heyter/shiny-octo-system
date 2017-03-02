UNIX_1_DAY =  86400
function genericOnSuccess(q,data)
	--print("DB query returned again")

end

function genericOnError(q, err, sql)
	ply = {}
	for k,v in player.GetAll() do
		if isAdmin(v) then
			table.insert(ply,v)
		end
	end
	DarkRP.notify(ply,1,10,"Ошибки в SQL! Передай это ближайшему доступному кодеру.")
	print("An error occured while executing the query: " .. err)
	print(sql)
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

function addOrUpdateRemove(ply64,time,type)
	local sel = prepareAndRun(SQLPatterns.checkPending,ply64,os.time(),type)
	if sel:isRunning() then sel:wait() end
	data = sel:getData()
	if #data == 0 then
		return prepareNotRun(SQLPatterns.addPending,ply64,time,type)
	else
		return prepareNotRun(SQLPatterns.updatePending,time,data[1]['id'])
	end

end
function writeDBLog(str)
	prepareAndRun(SQLPatterns.sendLog, os.time(), str)
	end
