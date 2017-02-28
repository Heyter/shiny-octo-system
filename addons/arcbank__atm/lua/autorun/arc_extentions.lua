-- ARCLib - Some function extensions I made to make my life easier.
-- This file is under a Creative Commons Attribution 4.0 International Licence
-- http://creativecommons.org/licenses/by/4.0/
-- You can mess around with it, mod it to your liking, and even redistribute it.
-- However, you must credit me.
ARCLib = ARCLib or {}
local ver = 1.27
if !ARCLib.Version || ARCLib.Version < ver then -- This checks if another ARCLib already exists. Probably used by another of my Addons.
	MsgN("ARCLib INIT v"..ver)
	ARCLib.Version = ver
	function ARCLib.InBetween(min,inp,max)
		return min <= inp && inp <= max
	end
	function ARCLib.ExBetween(min,inp,max)
		return min < inp && inp < max
	end
	function ARCLib.ConvertColor(col)
		assert( IsColor( col ), "ARCLib.ConvertColor: I wanted a color, but I got some sort of wierd "..type( col ).." thing..." )
		return col.r, col.g, col.b, col.a
	end
	function ARCLib.TableAmount(tab)
		local am = 0
		for i=0,table.maxn(tab) do
			if tab[i] then
				am = am + 1
			end
		end
		return am
	end
	function ARCLib.RecursiveHasValue(tab,value)
		local result = false
		for k,v in pairs(tab) do
			if istable(v) then
				result = result or ARCLib.RecursiveHasValue(v,value)
			end
			result = result or (v == value)
		end
		return result
	end
	function ARCLib.GetPlayerBySteamID(steamid) -- Gets a player by their SteamID
		local ply = nil
		if !isstring(steamid) then return NULL end
		for _, v in pairs( player.GetHumans() ) do
			if v:SteamID() == steamid then
				ply = v
			end
		end
		if !IsValid(ply) then
			ply = {} --If no player is found, return a dummy player.
			function ply:SteamID() return steamid end
			function ply:Nick() return "[Player Offline]" end
			function ply:IsPlayer() return false end
			function ply:IsValid() return false end
		end
		return ply
	end

	function ARCLib.GetNearestPlayer(pos,plyex) -- Gets the nearest player relative to pos. plyex is the player to exclude.
		local dist = math.huge
		local ply = NULL
		for _, v in pairs( player.GetAll() ) do
			local newdist = pos:DistToSqr( v:GetPos() )
			if newdist < dist && v != plyex then
				ply = v
				dist = newdist
			end
		end
		return ply
	end
	function ARCLib.GetNearestEntity(pos,class) -- Gets the nearest entity relative to pos. Defined by classname
		if !isstring(class) then return NULL end
		local dist = math.huge
		local ply = NULL
		for _, v in pairs( ents.FindByClass(class) ) do
			local newdist = pos:DistToSqr( v:GetPos() )
			if newdist < dist then
				ply = v
				dist = newdist
			end
		end
		return ply
	end
	function ARCLib.FloorDec(num,decimal) -- Floors a number nearest to the specified decimal
		return math.floor(num*(10^decimal))/(10^decimal)
	end
	function ARCLib.AddDir(dir) -- recursively adds everything in a directory to be downloaded by client. (Fixed by ARitz Cracker)
		if SERVER then
			local files, directories = file.Find( dir.."/*", "GAME" )
			if !files then return end
			for _,v in pairs(files) do
				resource.AddFile(dir.."/"..v)
			end
			for _, fdir in pairs(directories) do
				if fdir != ".svn" && fdir != "_svn" then -- Don't spam people with useless .svn folders
					ARCLib.AddDir(dir.."/"..fdir) -- Recursion ho!
				end
			end
		else
			--MsgN("Did you really try to add resources on the client, you dolt?")
		end
	end
	function ARCLib.DigiNumber(num,zeros) -- Puts zeros in front of a number. Useful for "retro" displays
		if num == 0 then
			return string.rep( "0", zeros ).."0"
		end
		return string.rep( "0", zeros-math.floor(math.log10(num)) )..tostring(math.floor(num))
	end
	function ARCLib.TimeString(sec,tab) -- Converts seconds to a human-readable form
		if(!tab || tab == {}) then -- I don't really like this, but it's for the sake of making it translatable!
			tab = {}
			tab.nd = "and"
			tab.second = "second"
			tab.seconds = "seconds"
			tab.minute = "minute"
			tab.minutes = "minutes"
			tab.hour = "hour"
			tab.hours = "hours"
			tab.day = "day"
			tab.days = "days"
			tab.forever = "forever"
			tab.now = "now"
		end
		if !sec || !isnumber(sec) || sec == math.huge then
			return tab.forever
		end
		sec = math.Round(sec)
		local min = math.floor(sec/60)
		local hour = math.floor(sec/3600)
		local day = math.floor(sec/86400)
		if sec <= 0 then
			return tab.now
		end
		if sec == 1 then
			return "1 "..tab.second
		end
		if sec < 60 then
			return ""..sec.." "..tab.seconds
		else
			if min < 60 then
				if min == 1 then
					if (sec%60) == 1 then
						return "1 "..tab.minute.." "..tab.nd.." 1 "..tab.second
					else
						return "1 "..tab.minute.." "..tab.nd.." "..(sec%60).." "..tab.seconds
					end
				else
					if (sec%60) == 1 then
						return ""..min.." "..tab.minutes.." "..tab.nd.." 1 "..tab.second
					else
						return ""..min.." "..tab.minutes.." "..tab.nd.." "..(sec%60).." "..tab.seconds
					end
				end
			else
				if hour < 24 then
					if hour == 1 then
						if (min%60) == 1 then
							return "1 "..tab.hour.." "..tab.nd.." 1 "..tab.minute
						else
							return "1 "..tab.hour.." "..tab.nd.." "..(min%60).." "..tab.minutes
						end
					else
						if (min%60) == 1 then
							return ""..hour.." "..tab.hours.." "..tab.nd.." 1 "..tab.minute
						else
							return ""..hour.." "..tab.hours.." "..tab.nd.." "..(min%60).." "..tab.minutes
						end
						
					end
				else
					if day == 1 then
						if (hour%24) == 1 then
							return "1 "..tab.day.." "..tab.nd.." 1 "..tab.hour
						else
							return "1 "..tab.day.." "..tab.nd.." "..(hour%24).." "..tab.hours
						end
					else
						if (hour%24) == 1 then
							return ""..day.." "..tab.days.." "..tab.nd.." 1 "..tab.hour
						else
							return ""..day.." "..tab.days.." "..tab.nd.." "..(hour%24).." "..tab.hours
						end
					end
				end
			end
		end
		return "forever"
	end
	function ARCLib.RandomRound(number) -- Randomly rounds things.
		if tobool(math.Round(math.random())) then
			return math.Round(number)
		else
			if tobool(math.Round(math.random())) then
				return math.floor(number)
			else	
				return math.ceil(number)
			end
		end
	end
	function ARCLib.RandomExp(min,max) -- Picks a random number in an exponential-curve-like way.
		min = min - 1
		local relativemax = max - min
		local result = ARCLib.RandomRound(2^(math.Rand(1,relativemax)/(relativemax*0.30102999566398119521373889472449))*(relativemax/10))
		if result < 1 then
			result = 1
		end
		return result + min
	end
   function ARCLib.MoneyLimit(num) -- Used for ARCBank
		if !num || !isnumber(num) then return "Invalid" end
		if num < 1e14 then
			return string.Comma(num)
		else
			return "A wasted life"
		end
    end
   function ARCLib.ShortScale(num,dec) -- Formats a number to a string using the short number scale
			--https://en.wikipedia.org/wiki/Names_of_large_numbers
			if !num || !isnumber(num) then return "Invalid" end
			if !dec then dec = 2 end
            if num < 1e6 then
				return string.Comma(num)
            elseif num < 1e9 then
				return tostring(ARCLib.FloorDec( num/1e6, dec )).." Million"
            elseif num < 1e12 then
				return tostring(ARCLib.FloorDec( num/1e9, dec )).." Billion"
            elseif num < 1e15 then
				return tostring(ARCLib.FloorDec( num/1e12, dec )).." Trillion"
			elseif num < 1e18 then
				return tostring(ARCLib.FloorDec( num/1e15, dec )).." Quadrillion"
			elseif num < 1e21 then
				return tostring(ARCLib.FloorDec( num/1e18, dec )).." Quintillion"
			elseif num < 1e24 then
				return tostring(ARCLib.FloorDec( num/1e21, dec )).." Sextillion"
			elseif num < 1e27 then
				return tostring(ARCLib.FloorDec( num/1e24, dec )).." Septillion"
			elseif num < 1e30 then
				return tostring(ARCLib.FloorDec( num/1e27, dec )).." Octillion"
			elseif num < 1e33 then
				return tostring(ARCLib.FloorDec( num/1e30, dec )).." Nonillion"
			elseif num < 1e36 then
				return tostring(ARCLib.FloorDec( num/1e33, dec )).." Decillion"
			elseif num < 1e39 then
				return tostring(ARCLib.FloorDec( num/1e36, dec )).." Undecillion"
			elseif num < 1e42 then
				return tostring(ARCLib.FloorDec( num/1e39, dec )).." Duodecillion"
			elseif num < 1e45 then
				return tostring(ARCLib.FloorDec( num/1e42, dec )).." Tredecillion"
			elseif num < 1e48 then
				return tostring(ARCLib.FloorDec( num/1e45, dec )).." Quattuordecillion"
			elseif num < 1e51 then
				return tostring(ARCLib.FloorDec( num/1e48, dec )).." Quindecillion"
			elseif num < 1e54 then
				return tostring(ARCLib.FloorDec( num/1e51, dec )).." Sexdecillion"
			elseif num < 1e57 then
				return tostring(ARCLib.FloorDec( num/1e54, dec )).." Septendecillion"
			elseif num < 1e60 then
				return tostring(ARCLib.FloorDec( num/1e57, dec )).." Octodecillion"
			elseif num < 1e63 then
				return tostring(ARCLib.FloorDec( num/1e60, dec )).." Novemdecillion"
			elseif num < 1e66 then
				return tostring(ARCLib.FloorDec( num/1e63, dec )).." Vigintillion"
            else
				return "A huge number"
            end
    end
	function ARCLib.BoolToNumber(bool) -- Turns a boolean into a 0 or 1. Useful for math operations.
		if bool then
			return 1
		else
			return 0
		end
	end
	function ARCLib.SplitString(str,num) -- Splits a string at every num characters
		local length = string.len(str)
		if length <= num then return {str} end
		local tn = 2
		local strings = {string.Left( str, num )}
		local rs = string.Right( str, string.len(str)-num )
		local rl = string.len(rs)
		while string.len(rs) > num do
			strings[tn] = string.Left( rs, num )
			tn = tn + 1
			rs = string.Right( rs, string.len(rs)-num )
			
		end
		strings[tn] = rs
		return strings
	end
	if SERVER then
		function ARCLib.MsgCL(ply,msg)
			if ply && ply:IsPlayer() then
				ply:PrintMessage( HUD_PRINTTALK, msg)
			else
				MsgN(msg)
			end
		end
	
		NOTIFY_GENERIC = 0 --These constants are only pre-defined on the client. So if we're using NotifyPlayer, then better to do it here!
		NOTIFY_ERROR = 1
		NOTIFY_UNDO = 2
		NOTIFY_HINT = 3
		NOTIFY_CLEANUP = 4
		util.AddNetworkString( "ARCLib_Notify" )
		function ARCLib.NotifyPlayer(ply,str,typ,time,sound)
			net.Start("ARCLib_Notify")
			net.WriteString(str)
			net.WriteUInt(typ,4)
			net.WriteUInt(time,16)
			net.WriteBit(sound)
			net.Send(ply)
		
		end
	
	
	
		if timer.Exists( "ARCLib_SoundCheck" ) then
			timer.Destroy( "ARCLib_SoundCheck" )
		end
		timer.Create( "ARCLib_SoundCheck", 1, 0, function() 
			for k,v in pairs(player.GetAll()) do
				v.ARCLIB_SOUND_COUNT = 0;
			end
		end )
		timer.Start( "ARCLib_SoundCheck" ) 
		util.AddNetworkString( "ARCLib_Sound" )
		ARCLib.SoundWhitelist = {}

		net.Receive( "ARCLib_Sound", function(length,ply)
			if ply.ARCLIB_SOUND_COUNT && ply.ARCLIB_SOUND_COUNT > 5 then -- Can't blame a guy for trying. Every 0.2 seconds may still be annoying... 
				ply:Kick("Spamming Sound")
			end
			
			local ent = net.ReadEntity() 
			local snd = net.ReadString() 
			local lvl = net.ReadUInt(8)
			local ptch = net.ReadUInt(8)
			if !IsValid(ent) || ent:IsWorld() then return end
			local validsound = false
			
			for k,v in pairs(ARCLib.SoundWhitelist) do
				validsound = validsound or (v.ent == ent:GetClass() && v.snd == snd && v.lvl == lvl && v.ptch == ptch)
			end
			
			if validsound then
				net.Start("ARCLib_Sound")
				net.WriteEntity(ent)
				net.WriteString(snd)
				net.WriteUInt(lvl,8)
				net.WriteUInt(ptch,8)
				net.SendOmit(ply)
				if !ply.ARCLIB_SOUND_COUNT then
					ply.ARCLIB_SOUND_COUNT = 0
				end
				ply.ARCLIB_SOUND_COUNT = ply.ARCLIB_SOUND_COUNT + 1
			else
				ARCLib.MsgCL(ply,"ARCLib: Invalid sound. (Not on sound whitelist)")
			end
		end)
	else
		
		ARCLib.Icons16 = {}
		for k, v in pairs(file.Find( "materials/icon16/*.png", "GAME" )) do
			ARCLib.Icons16[string.Replace(v,".png","")] = Material ("icon16/"..v, "nocull")
		end
		ARCLib.Icons32 = {}
		for k, v in pairs(file.Find( "materials/icon32/*.png", "GAME" )) do
			ARCLib.Icons32[string.Replace(v,".png","")] = Material ("icon32/"..v, "nocull")
		end
		ARCLib.Icons32t = {}
		for k, v in pairs(file.Find( "materials/icon32_t/*.vmt", "GAME" )) do
			ARCLib.Icons32t[string.Replace(v,".vmt","")] = surface.GetTextureID("icon32_t/"..string.Replace(v,".vmt",""))
		end
		function ARCLib.PlaySoundOnOtherPlayers(snd,ent,lvl,ptch) -- Plays a sound on people's clients.
			if !lvl then lvl = 75 end
			if !ptch then ptch = 100 end
			net.Start("ARCLib_Sound") -- Now I know any client can just do lua_run_cl with this, BUT IT'S SO FUCKING USEFUL...
			net.WriteEntity(ent)
			net.WriteString(snd)
			net.WriteUInt(lvl,8)
			net.WriteUInt(ptch,8)
			net.SendToServer()
		end
		net.Receive( "ARCLib_Sound", function(length)
			local ent = net.ReadEntity() 
			local snd = net.ReadString() 
			local lvl = net.ReadUInt(8)
			local ptch = net.ReadUInt(8)
			if IsValid(ent) then
				sound.Play(snd, ent:GetPos(), lvl, ptch ) 
			end
		end)
		net.Receive( "ARCLib_Notify", function(length)
			local msg = net.ReadString() 
			local typ = net.ReadUInt(4)
			local time = net.ReadUInt(16)
			local sound = tobool(net.ReadBit())
			notification.AddLegacy(msg,typ,time) 
			if sound then
				if typ == NOTIFY_ERROR then
					 
					LocalPlayer():EmitSound("buttons/button8.wav" )
				else
					LocalPlayer():EmitSound("ambient/water/drip"..math.random(1, 4)..".wav" )
				end
			end
		end)
		if timer.Exists( "ARCLib_DumpCachedStrings" ) then
			timer.Destroy( "ARCLib_DumpCachedStrings" )
		end
		timer.Create( "ARCLib_DumpCachedStrings", 300, 0, function() 
			ARCLib.CachedStrings = {}
		end )
		ARCLib.CachedStrings = {}
		function ARCLib.FitText(text,font,length) -- Splits strings for text boxes. (length) is in pix. Supports "\n"
		--Note: This is a pretty messy thing. DON'T USE EVERY FRAME FOR LOADSA TEXT!
			--if #text < 2097152 then
				if ARCLib.CachedStrings[text..font] then -- I wonder if this will actually save performence...
					return ARCLib.CachedStrings[text..font]
				end
			--end
		--Note: Optimize. It's dirty as FUCK!
			text = string.Replace(text,"\n"," \n")
			surface.SetFont( font )
			local badword = ""
			local OKToGo = true
			local strings = string.Explode(" ",text)
			for k, v in pairs(strings) do -- Quick n' dirty fix
				strings[k] = v.." "
				local badstring , _ = surface.GetTextSize(strings[k])
				if badstring > length then
					OKToGo = false
					badword = tostring(strings[k])
				end
			end
			
			if OKToGo then
				local tempstring = ""
				local fittedstrings = {}
				local i = 1
				while #strings > 0 do
					--MsgN(#strings)
					local tempstringlen , _ = surface.GetTextSize(tempstring)
					local string1len , _ = surface.GetTextSize(strings[1])
					--MsgN(tempstringlen.."+"..string1len.." <= "..length.." && "..strings[1])
					while (tempstringlen+string1len <= length) && strings[1] do
						
						tempstring = tempstring .. table.remove( strings, 1 )
						tempstringlen , _ = surface.GetTextSize(tempstring)
						if strings[1] then
							string1len , _ = surface.GetTextSize(strings[1])
						else
							string1len = 0
						end
					end
					fittedstrings[i] = tempstring
					tempstring = ""
					i = i + 1
				end
				i = #fittedstrings
				while i > 0 do
					local newlinecheck = string.Explode("\n",fittedstrings[i])
					table.remove(fittedstrings,i)
					local ii = #newlinecheck
					while ii > 0 do
						table.insert(fittedstrings,i,newlinecheck[ii])
						ii = ii - 1
					end
					i = i - 1
				end
				while table.HasValue(fittedstrings,"") do -- Some checks to make sure everything is right
					table.RemoveByValue(fittedstrings,"")
				end
				while table.HasValue(fittedstrings," ") do
					table.RemoveByValue(fittedstrings," ")
				end
				--if #text < 2097152 then
					ARCLib.CachedStrings[text..font] = fittedstrings
				--end
				return fittedstrings
			else
				return {"Word too long.","("..badword..")"}
			end
		end
		
		ARCLib.StringThinkPhase = 0
		ARCLib.StringThink_Strings = {}
		ARCLib.StringThink_i = 1
		ARCLib.StringThink_fittedstrings = {}
		ARCLib.StringThink_callback = nil
		ARCLib.StringThink_Percent = 0
		ARCLib.StringThink_tempstring = ""
		ARCLib.StringThink_length = 0
		ARCLib.StringThink_tempstringlen = nil
		ARCLib.StringThink_string1len = nil
		ARCLib.StringThink_font = ""
		function ARCLib.FitTextRealtime(text,font,length,callback) -- Splits strings for text boxes. (length) is in pix. Supports "\n"
		-- Realtime version, this was made so that your computer doesn't freeze while processing massive amounts of text.
			if ARCLib.StringThinkPhase > 0 then
				callback(1,{"Busy"})
				return
			end
			text = string.Replace(text,"\n"," \n")
			surface.SetFont( font )
			ARCLib.StringThink_font = font
			local badword = ""
			local OKToGo = true
			ARCLib.StringThink_Strings = string.Explode(" ",text)
			for k, v in pairs(ARCLib.StringThink_Strings) do -- Quick n' dirty fix
				ARCLib.StringThink_Strings[k] = v.." "
				local badstring , _ = surface.GetTextSize(ARCLib.StringThink_Strings[k])
				if badstring > length then
					OKToGo = false
					badword = tostring(ARCLib.StringThink_Strings[k])
				end
			end
			
			if OKToGo then
				ARCLib.StringThink_callback = callback
				ARCLib.StringThinkPhase = 1
				ARCLib.StringThink_length = length
			else
				callback(1,{"Word too long.","("..badword..")"})
			end
		end
		hook.Add( "Think", "ARCLib Stringthink", function()
			if ARCLib.StringThinkPhase == 1 then
				--MsgN("ARCLib.StringThinkPhase 1")
				ARCLib.StringThink_tempstring = ""
				ARCLib.StringThink_fittedstrings = {}
				ARCLib.StringThink_i = 1
				ARCLib.StringThinkPhase = 2
				ARCLib.LoadPerBase = #ARCLib.StringThink_Strings
			elseif ARCLib.StringThinkPhase == 2 then---
				--MsgN("ARCLib.StringThinkPhase 2")
				for i = 1,25 do
					if #ARCLib.StringThink_Strings > 0 then
						--MsgN(#ARCLib.StringThink_Strings)
						surface.SetFont( ARCLib.StringThink_font )
						ARCLib.StringThink_tempstringlen , _ = surface.GetTextSize(ARCLib.StringThink_tempstring)
						ARCLib.StringThink_string1len , _ = surface.GetTextSize(ARCLib.StringThink_Strings[1])
						while (ARCLib.StringThink_tempstringlen+ARCLib.StringThink_string1len <= ARCLib.StringThink_length) && ARCLib.StringThink_Strings[1] do
							ARCLib.StringThink_tempstring = ARCLib.StringThink_tempstring .. table.remove( ARCLib.StringThink_Strings, 1 )
							ARCLib.StringThink_tempstringlen , _ = surface.GetTextSize(ARCLib.StringThink_tempstring)
							if ARCLib.StringThink_Strings[1] then
								ARCLib.StringThink_string1len , _ = surface.GetTextSize(ARCLib.StringThink_Strings[1])
							else
								ARCLib.StringThink_string1len = 0
							end
						end
						
						ARCLib.StringThink_fittedstrings[ARCLib.StringThink_i] = ARCLib.StringThink_tempstring
						ARCLib.StringThink_tempstring = ""
						ARCLib.StringThink_i = ARCLib.StringThink_i + 1
					else
						ARCLib.StringThinkPhase = 3
					end
				end
				local per = (#ARCLib.StringThink_Strings/ARCLib.LoadPerBase - 1)*-1
				ARCLib.StringThink_callback(per*0.5,"Loading... ("..math.floor(per * 50).."%)")
			elseif ARCLib.StringThinkPhase == 3 then
				--MsgN("ARCLib.StringThinkPhase 3")
				ARCLib.LoadPerBase = #ARCLib.StringThink_fittedstrings
				ARCLib.StringThink_i = #ARCLib.StringThink_fittedstrings
				ARCLib.StringThinkPhase = 4
			elseif ARCLib.StringThinkPhase == 4 then
				--MsgN("ARCLib.StringThinkPhase 4")
				for i = 1,85 do
					if ARCLib.StringThink_i > 0 then
						--MsgN(ARCLib.StringThink_i)
						local newlinecheck = string.Explode("\n",ARCLib.StringThink_fittedstrings[ARCLib.StringThink_i])
						table.remove(ARCLib.StringThink_fittedstrings,ARCLib.StringThink_i)
						local ii = #newlinecheck
						while ii > 0 do
							table.insert(ARCLib.StringThink_fittedstrings,ARCLib.StringThink_i,newlinecheck[ii])
							ii = ii - 1
						end
						ARCLib.StringThink_i = ARCLib.StringThink_i - 1
					else
						ARCLib.StringThinkPhase = 5
					end
				end
				local per = (ARCLib.StringThink_i/ARCLib.LoadPerBase - 1)*-1
				ARCLib.StringThink_callback(0.5 + per*0.5,"Loading... ("..math.floor(50 + per * 50).."%)")
			elseif ARCLib.StringThinkPhase == 5 then
				--MsgN("ARCLib.StringThinkPhase 5")
				while table.HasValue(ARCLib.StringThink_fittedstrings,"") do -- Some checks to make sure everything is right
					table.RemoveByValue(ARCLib.StringThink_fittedstrings,"")
				end
				while table.HasValue(ARCLib.StringThink_fittedstrings," ") do
					table.RemoveByValue(ARCLib.StringThink_fittedstrings," ")
				end
				ARCLib.StringThink_callback(1,ARCLib.StringThink_fittedstrings)
				ARCLib.StringThinkPhase = 0
				ARCLib.StringThink_Strings = {}
				ARCLib.StringThink_i = 1
				ARCLib.StringThink_fittedstrings = {}
				ARCLib.StringThink_callback = nil
				ARCLib.StringThink_Percent = 0
				ARCLib.StringThink_tempstring = ""
				ARCLib.StringThink_length = 0
			end
		end)
	end
end

