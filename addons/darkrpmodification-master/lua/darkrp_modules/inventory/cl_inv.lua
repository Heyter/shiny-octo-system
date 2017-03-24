cl_inv = {}
cl_sweps = {}
cl_ships = {}
cl_foods = {}
net.Receive( "clearinv", function()  
	table.Empty(cl_inv)
	table.Empty(cl_sweps)
	table.Empty(cl_ships)
	table.Empty(cl_foods)  
end)

net.Receive( "item", function()    
	local k = net.ReadInt(32)
	local v = net.ReadTable()
	
	cl_inv[k] = v
end)

net.Receive( "itemr", function()    
	local k = net.ReadInt(32)
	cl_inv[k] = nil
	
end)

local meta = FindMetaTable("Player")

function meta:GetWeedPrice()
	local sum = 0
	for k,v in pairs(cl_inv) do
		if k != "maxitens" then
			if weedPrices[v.class] != nil then
				sum = sum + weedPrices[v.class]
			end
		end
	end
	return sum
end

function meta:SellWeeds()
	net.Start("sellweeds")
	net.SendToServer()
end

net.Receive("getweedprices",function()
	local ply = LocalPlayer()
	if ply.priceCallback then
		local price = net.ReadInt(32)
		ply.priceCallback(price)
	end

end)