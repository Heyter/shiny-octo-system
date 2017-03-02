UNIX_1_DAY =  86400
function genericOnSuccess(q,data)
	print("DB query returned again")

end

function genericOnError(q, err, sql)
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

function writeDBLog(str)
	prepareAndRun(SQLPatterns.sendLog, os.time(), str)
	end
