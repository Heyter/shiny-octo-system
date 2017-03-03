--€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€--
--          =--Leaked by Teoren  --=             --
--€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€--

local function DoorHandleAllowed( ply )
	if DOORHANDLE.AdminOnly == false or (DOORHANDLE.AdminOnly == ply:IsAdmin()) then
		return true
	else
		print( ply:Nick().." attempted to use doorhandle, but they were denied access.")
		return false
	end
end


concommand.Add("doorhandle_setcolor",function(ply, cmd, args)

	if not DoorHandleAllowed( ply ) then return end

	if #args < 5 then return end -- don't do anything if there arent enough arguments.

	local door = ents.GetByIndex( args[1] )

	if door:isDoor() then
		if not IsValid(door) then return end
		if not door:isDoor() then return end
		if door:getDoorOwner() ~= ply and not (ply:IsSuperAdmin()) then return end

		if DOORHANDLE.AllowTransparency == false then
			args[5] = 255
		end

		door.DoorData.doorColor = Color( args[2], args[3], args[4], args[5] )
		for k,v in ipairs(player.GetAll()) do
			v:SendDoorDataSingle( door )
		end

		DOORHANDLE:StoreDoorData( door )
	end

end)

concommand.Add("doorhandle_setscale",function(ply, cmd, args)

	if not DoorHandleAllowed( ply ) then return end

	if #args < 2 then return end
	local door = ents.GetByIndex( args[1] )

	if door then
		if not IsValid(door) then return end
		if not door:isDoor() then return end
		if door:getDoorOwner() ~= ply and not (ply:IsSuperAdmin()) then return end

		local scale = math.Clamp( tonumber(args[2]) or DOORHANDLE.DefaultTextScale, DOORHANDLE.MinTextScale, DOORHANDLE.MaxTextScale ) -- don't want overly large or overly small labels.
		door.DoorData.textScale = scale
		for k,v in ipairs(player.GetAll()) do
			v:SendDoorDataSingle( door )
		end

		DOORHANDLE:StoreDoorData( door )
	end

end)

concommand.Add("doorhandle_setfont",function(ply, cmd, args)

	if not DoorHandleAllowed( ply ) then return end

	if #args < 2 then return end
	local door = ents.GetByIndex( args[1] )

	if door then
		if not IsValid(door) then return end
		if not door:isDoor() then return end
		if door:getDoorOwner() ~= ply and not (ply:IsSuperAdmin()) then return end

		local fontIndex = tonumber(args[2])
		door.DoorData.fontIndex = fontIndex
		for k,v in ipairs(player.GetAll()) do
			v:SendDoorDataSingle( door )
		end

		DOORHANDLE:StoreDoorData( door )
	end

end)

--reset doorhandle data when the door gets sold
hook.Add("playerKeysSold","DOORHANDLE_ResetDoorHandleData", function( ply, ent, money )
	ent.DoorData.fontIndex = 1
	ent.DoorData.doorColor = DOORHANDLE.DefaultColor
	ent.DoorData.textScale = DOORHANDLE.DefaultTextScale

	for k,v in ipairs(player.GetAll()) do -- update doors on players
		v:sendDoorData()
	end

end)

if not file.Exists("doorhandle_doordata", "DATA") then
	file.CreateDir("doorhandle_doordata")
end
if not file.Exists("doorhandle_doordata/"..game.GetMap()..".txt", "DATA") then
	file.Write("doorhandle_doordata/"..game.GetMap()..".txt", "")
end

function DOORHANDLE:StoreDoorData( door )
	if door.DoorData.owner then return end
	if not door:CreatedByMap() then return end
	if not door.DoorData then return end
	-- data we should save:
	local col = door.DoorData.doorColor or Color(255,255,255)
	local scl = door.DoorData.textScale or 1
	local fidx = door.DoorData.fontIndex or 1

	local customDoorData = {
		doorColor = col,
		textScale = scl,
		fontIndex = fidx,
	}


	local masterTableFile = "doorhandle_doordata/"..game.GetMap()..".txt"

	local masterTable = util.JSONToTable( file.Read( masterTableFile, "DATA" )  ) or {}

	masterTable[ "door_"..tostring( door:MapCreationID() ) ] = customDoorData

	-- PrintTable( masterTable )
	-- print("\n\n")

	file.Write(masterTableFile, util.TableToJSON(masterTable) ) -- save it back

end

concommand.Add("doorhandle_storedoordata", function(ply, cmd, args)

	if not ply:IsSuperAdmin() then return end
	if #args < 1 then return end
	local door = ents.GetByIndex( args[1] )

	if door then
		if not IsValid(door) then return end
		if not door:isDoor() then return end
		if door:getDoorOwner() ~= ply and not (ply:IsSuperAdmin()) then return end

		DOORHANDLE:StoreDoorData( door )
	end
end)

concommand.Add("doorhandle_senddoordata", function(ply, cmd, args)
	if not ply:IsSuperAdmin() then return end

	if #args < 1 then return end
	local door = ents.GetByIndex( args[1] )

	if door then
		if not IsValid(door) then return end
		if not door:isDoor() then return end
		if door:getDoorOwner() ~= ply and not (ply:IsSuperAdmin()) then return end

		ply:SendDoorDataSingle( door )
		print("sending door data",args[1])
		-- 76561198030665201
	end
end)

concommand.Add("doorhandle_senddoordata_all", function(ply, cmd, args)
	if not ply:IsSuperAdmin() then return end
	ply:sendDoorData()
	print("sending all door data")
end)

concommand.Add("doorhandle_loaddoordata", function(ply, cmd, args)
	if not ply:IsSuperAdmin() then return end
	DOORHANDLE:LoadDoorData()
end)

function DOORHANDLE:LoadDoorData()
	local masterTableFile = "doorhandle_doordata/"..game.GetMap()..".txt"

	local masterTable = util.JSONToTable( file.Read( masterTableFile, "DATA" ) ) or {}

	for id_string, data in pairs( masterTable ) do
		local id = tonumber( string.sub( id_string, 6, -1 ) )
		local door = ents.GetMapCreatedEntity( id )

		if door then
			if door.DoorData then
				door.DoorData.doorColor = data.doorColor
				door.DoorData.textScale = data.textScale
				door.DoorData.fontIndex = data.fontIndex
			end
			--print("door "..id_string)
			--PrintTable(door.DoorData)
		end

	end
end

local PLAYER = FindMetaTable( "Player" )

util.AddNetworkString( "DOORHANDLE_SendDoorDataSingle" )

function PLAYER:SendDoorDataSingle( door )

	--door.DoorData = { "hyuck" }

	--DOORHANDLE:LoadDoorData()

	net.Start("DOORHANDLE_SendDoorDataSingle")
	net.WriteFloat( door:EntIndex() )
	net.WriteTable( door.DoorData or {} )

	--PrintTable(door.DoorData)
	net.Send( self )
end

hook.Add("DarkRPFinishedLoading", "DOORHANDLE_LoadDoorData", function()
	timer.Create("ReDoDoorDataLoading", 1, 20, function()
		DOORHANDLE:LoadDoorData()
	end)
	DOORHANDLE:LoadDoorData()
end)

hook.Add("PlayerLoadout", "DOORHANDLE_SendDoorData", function( ply )
	--ply:sendDoorData()
end)

concommand.Add("doorinfo_server", function(ply)
	local tr = ply:GetEyeTrace()
	if tr.Entity then
		if tr.Entity.DoorData then
			PrintTable(tr.Entity:GetTable())
		end
		local max = tr.Entity:OBBMaxs()
		local min = tr.Entity:OBBMins()

		local norm = (max - min)
		norm:Normalize()
		local brush_ang = norm:Angle()

		print(tr.Entity:GetClass())
		print(tr.Entity:GetAngles())
		print(tr.Entity:GetModel())
		print(tr.Entity:MapCreationID())

	end
end)

-- hook.Add("InitPostEntity", "DOORHANDLE_LoadDoorData", function()
--
-- 	timer.Create("RedoDoorData", 5, 10, function()
-- 		DOORHANDLE:LoadDoorData()
-- 	end)
-- end)
