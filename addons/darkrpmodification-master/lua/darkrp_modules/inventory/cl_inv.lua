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
	local str = net.ReadString()
	local val = net.ReadFloat()
	
	if val > 0 then
		cl_inv[str] = val
	else
		cl_inv[str] = nil
	end
end)

