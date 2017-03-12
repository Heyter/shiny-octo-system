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
