--#NoSimplerr#
util.AddNetworkString("sendCountries")
util.AddNetworkString("askCountry")

local Countries = {}

local function updateCountries()
	net.Start("sendCountries")
	net.WriteTable(Countries)
	net.Broadcast()
end

hook.Add( "PlayerInitialSpawn", "requestCountry", function(ply)
	net.Start("askCountry")
	net.Send(ply)
end)

net.Receive("askCountry",function(len, ply)
	local x = net.ReadString()
	Countries[ply:SteamID()] = x
	updateCountries()
end)

