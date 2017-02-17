local ply = LocalPlayer()
local plyMeta = FindMetaTable("Player")
plyMeta.markers = {["foo"] = "bar"}

net.Receive( "CombineRequest", 
	function()
	local ply = LocalPlayer()
	 --print( "I got it!2" )
	 local vec = net.ReadVector()
	 local i = #ply.markers+1
	 ply.markers[i] = vec

	 timer.Simple( 30, function() 
	 	for i,k in pairs(ply.markers) do
	 		if k==vec then
	 			table.remove(ply.markers,i)
	 			break
	 		end
	 	end
	  end )
end )


function drawmarkers()
	local ply = LocalPlayer()
	if not istable(ply.markers) or not ply.markers or ply.markers == nil then
		
		ply.markers = {["foo"] = "bar"}
		
	end
	
	for i,pos in ipairs(ply.markers) do
		dist = pos:Distance(EyePos())
		pos = pos:ToScreen()
		surface.SetDrawColor(255,255,255)
		surface.SetMaterial( Material( "materials/Waypoint.png" ) )
		surface.DrawTexturedRect(pos.x, pos.y, 50, 77)
		draw.SimpleText( math.ceil(dist),"DermaDefault", pos.x+25, pos.y+80, Color( 255, 255, 255, 255 ),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	end
end
hook.Add("HUDPaint", "DrawMarkers", drawmarkers)