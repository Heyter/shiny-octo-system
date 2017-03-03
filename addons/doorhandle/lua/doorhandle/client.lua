--€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€--
--          =--Leaked by Teoren  --=             --
--€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€--

include("doorhandle/arizard_derma.lua")

if DOORHANDLE.French == true then
	DOORHANDLE.strings = DOORHANDLE.fr_strings
end

DOORHANDLE.Doors = {}

function DOORHANDLE:CreateFonts()
	local hookData = hook.Run( "DOORHANDLE_AddExtraFonts", DOORHANDLE.PresetFonts )
	if hookData then DOORHANDLE.PresetFonts = hookData end

	for k, fontstandard in ipairs(DOORHANDLE.PresetFonts) do
		surface.CreateFont("doorHandle_3D2D_Tiny".."_"..fontstandard, {
			font = fontstandard,
			size = 26*2,
			antialias = true,
			weight = 400
		})
		surface.CreateFont("doorHandle_3D2D_Small".."_"..fontstandard, {
			font = fontstandard,
			size = 36*2,
			antialias = true,
			weight = 400
		})

		surface.CreateFont("doorHandle_3D2D_Medium".."_"..fontstandard, {
			font = fontstandard,
			size = 46*2,
			antialias = true,
			weight = 400
		})
		surface.CreateFont("doorHandle_3D2D_Large".."_"..fontstandard, {
			font = fontstandard,
			size = 76*2,
			antialias = true,
			weight = (fontstandard == "Impact") and 400 or 800 -- impact looks horrid at 800 weight
		})
	end
end

DOORHANDLE:CreateFonts()

function DOORHANDLE:FindDoors()
	local rotating = ents.FindByClass("prop_door_rotating")
	local brush = ents.FindByClass("func_door")
	local brush2 = ents.FindByClass("func_door_rotating")
	self.Doors = {}
	for k,v in ipairs(rotating) do
		table.insert(self.Doors, v)
	end
	for k,v in ipairs(brush) do
		table.insert(self.Doors, v)
	end
	for k,v in ipairs(brush2) do
		table.insert(self.Doors, v)
	end
	--PrintTable( self.Doors )
end

hook.Add("InitPostEntity","DOORHANDLE:FindDoors", function()
	DOORHANDLE:FindDoors()
end)

DOORHANDLE:FindDoors() -- for some reason, this needs to be re-called every now and then.
timer.Create("DoorhandleFindDoors", 10, 0, function() DOORHANDLE:FindDoors() end)

function DOORHANDLE:GetDoors()

	local valid = {}

	for k,door in ipairs(self.Doors) do
		if IsValid( door ) then
			if door:GetPos():Distance( LocalPlayer():EyePos() ) < self.ViewDistance then
				table.insert(valid, door)
			end
		end
	end

	return valid
end

function DOORHANDLE:DrawDoorInfo( door )

	if door:IsVehicle() then return end

	local data = door:getDoorData()

	local drawcol = table.Copy( self.DefaultColor )
	local drawFont = "_"..self.PresetFonts[1]

	if data.doorColor then
		drawcol = table.Copy( data.doorColor )
	end

	local o_drawcol = table.Copy( drawcol )

	--drawcol.a = 255

	if data.fontIndex then
		if self.PresetFonts[data.fontIndex] then
			drawFont = "_"..self.PresetFonts[data.fontIndex]
		end
	end

	local tr = LocalPlayer():GetEyeTrace()

	-- we want to start fading out 40% before the end of the view distance
	local dist = door:GetPos():Distance( LocalPlayer():EyePos() )
	local fadedist = self.ViewDistance * 0.6


	if dist > fadedist then
		local frac = InverseLerp( dist, self.ViewDistance, fadedist )
		frac = math.Clamp( frac, 0, 1 )
		drawcol.a = o_drawcol.a*frac
	end

	if data.title then
		local candraw = false

		if data.owner and self.LookAt.PlayerOwnedText == true then
			if tr.Entity then
				if tr.Entity == door then
					candraw = true 
				end
			end
		elseif data.groupOwn and self.LookAt.GroupOwnableText == true then
			if tr.Entity then
				if tr.Entity == door then
					candraw = true 
				end
			end
		elseif data.nonOwnable == true and self.LookAt.NonOwnableText == true then
			if tr.Entity then
				if tr.Entity == door then
					candraw = true 
				end
			end
		else
			candraw = true
		end

		if candraw == true then
			ArizardShadowText( string.sub( data.title, 1, 48) , "doorHandle_3D2D_Large"..drawFont, 0, -104, drawcol , TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1)
		end
	end
	-- 76561198030665201
	if data.nonOwnable == true then
		-- do nothing
	elseif data.owner then
		local owner = door:getDoorOwner()
		local name = "Nil"

		if owner.Nick then
			name = owner:Nick()
		end

		local candraw = false
		if self.LookAt.PlayerOwnedText == true then
			candraw = false
			if tr.Entity then
				if tr.Entity == door then
					candraw = true 
				end
			end
		else
			candraw = true
		end

		if candraw == true then
			ArizardShadowText( name.."" , "doorHandle_3D2D_Small"..drawFont, 0, 0, drawcol , TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1)

			if data.allowedToOwn or data.extraOwners then
				ArizardShadowText( DOORHANDLE.strings.co_owners..":" , "doorHandle_3D2D_Tiny"..drawFont, 0, 64, drawcol , TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1)
				local coowners = {}
				for k,v in pairs( data.allowedToOwn or {} ) do
					for _,pl in ipairs( player.GetAll() ) do
						if pl:UserID() == k then
							table.insert(coowners, pl:Nick())
						end
					end
				end
				for k,v in pairs( data.extraOwners or {} ) do
					for _,pl in ipairs( player.GetAll() ) do
						if pl:UserID() == k then
							table.insert(coowners, pl:Nick())
						end
					end
				end
				for k,v in ipairs(coowners) do
					ArizardShadowText( v , "doorHandle_3D2D_Tiny"..drawFont, 0, 64+36*(k), drawcol , TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1)
				end
			end
		end
	elseif data.groupOwn then
		local candraw = false

		if self.LookAt.GroupOwnableText == true then
			candraw = false
			if tr.Entity then
				if tr.Entity == door then
					candraw = true 
				end
			end
		else
			candraw = true
		end

		if candraw then
			ArizardShadowText( data.groupOwn , "doorHandle_3D2D_Small"..drawFont, 0, 0, drawcol , TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1)
		end
	else -- draw the "Purchse this door" text
		local candraw = false -- purchase text

		if self.LookAt.PurchaseText == true then
			candraw = false
			if tr.Entity then
				if tr.Entity == door then
					candraw = true 
				end
			end
		else
			candraw = true
		end

		if not data.teamOwn then -- test if the door is purchasable by the player.
			candraw = true
		else

			local whoCanBuy = ""
			local buyers = {}
			for k,v in pairs( data.teamOwn ) do
				table.insert(buyers, k)
			end

			for i = 1, #buyers do
				whoCanBuy = whoCanBuy..team.GetName( buyers[i] ) -- aww ye string formatting makin this look good
				if i == (#buyers-1) then
					whoCanBuy = whoCanBuy.." "..DOORHANDLE.strings._and.." "
				elseif i < #buyers then
					whoCanBuy = whoCanBuy..", "
				end
			end

			whoCanBuy = whoCanBuy.." "..DOORHANDLE.strings.only.."."

			ArizardShadowText(""..whoCanBuy.."", "doorHandle_3D2D_Small".."_"..self.PresetFonts[1], 0,80, Color(255,255,255, 50) , TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1)
			
			candraw = false

		end


		if candraw and self.DisplayBuyableText then
			ArizardShadowText(DOORHANDLE.strings.purchasetext, "doorHandle_3D2D_Small".."_"..self.PresetFonts[1], 0, 0, Color(255,255,255) , TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1)
		end

	end





end

DOORHANDLE.ValidDoorClasses = {
	["prop_door_rotating"] = true,
	["func_door"] = true,
	["func_door_rotating"] = true
}

function DOORHANDLE:DoorIsValid( door )
	if self.ValidDoorClasses[door:GetClass()] == true then
		return true
	else
		return false
	end
end

function DOORHANDLE:RenderDoors()

	local doors = self:GetDoors()

	for k, door in ipairs( doors ) do

		local drawpos = door:LocalToWorld(door:OBBCenter()):ToScreen()
		local doorpos = door:LocalToWorld(door:OBBCenter()) + ( ( door:GetClass() == "prop_door_rotating" or door:GetClass() == "func_door_rotating") and Vector(0,0,64-54) or Vector(0,0,0))
		local doorang = door:GetAngles()+Angle(0,90,90) + ( ( door:GetClass() == "func_door" or door:GetClass() == "func_door_rotating" ) and Angle(0,90,0) or Angle(0,0,0))
		local thickness = (door:GetClass() == "prop_door_rotating" and 1.1 or 3)

		--if door:Get

		local data = door:getDoorData()

		--hotfix for specific model doors
		local angmod = {
			["models/props/storedoor1.mdl"] = Angle(0,90,0)
		}

		for model, ang in pairs( angmod ) do
			if door:GetModel() == model then
				doorang = doorang + ang
			end
		end


		-- for func_doors which are at 90* to the world
		if door:GetClass() == "func_door" or door:GetClass() == "func_door_rotating" then
			local max = door:OBBMaxs()
			local min = door:OBBMins()

			local norm = (max - min)
			norm:Normalize()
			local brush_ang = norm:Angle()

			if (math.abs(brush_ang.yaw) > 45) then doorang = doorang + Angle(0,90,0) end

		end

		if door:GetClass() == "func_door_rotating" then
			local axis = door:GetAngles():Forward()
			--doorang:RotateAroundAxis( axis, 0*door:GetAngles().roll )
			doorang = Angle(doorang.pitch, doorang.yaw, doorang.roll-(door:GetAngles().roll*2) )
		end

		local scale = self.DefaultTextScale
		--if data.textScale and data.owner then scale = data.textScale end
		if data.owner then
			if data.textScale then
				scale = data.textScale
			else
				scale = self.DefaultTextScale
			end
		else
			scale = self.BuyableTextScale
		end

		if data.nonOwnable == true or data.groupOwn then
			if data.textScale then
				scale = data.textScale
			end
		end

		cam.Start3D2D(doorpos+doorang:Up()*thickness, doorang, 0.025*scale )
			self:DrawDoorInfo( door )
		cam.End3D2D()
		local odoorang = doorang
		doorang:RotateAroundAxis( odoorang:Right(), 180 )
		cam.Start3D2D(doorpos+odoorang:Up()*thickness, doorang, 0.025*scale )
			self:DrawDoorInfo( door )
		cam.End3D2D()

	end

end

hook.Add("PostDrawTranslucentRenderables", "DOORHANDLE:RenderDoors", function()
	DOORHANDLE:RenderDoors()
end)

hook.Add("HUDDrawDoorData","RemoveDoorHUD",function( ent )

	if ent:isDoor() then return true end

end) -- disable default door drawing


-- let's create a GUI for this sucker
-- gui needs to do 3 things:
-- edit text scale
-- edit text color
-- edit text font (from preset fonts)

function DOORHANDLE:OpenMenu( door )

	if not DOORHANDLE:Allowed( LocalPlayer() ) then
		return
	end

	if not door then return end

	local frame = vgui.Create("arizard_window")
	-- top bar is 28, bottom bar is 8
	-- total unusable height = 36
	local w, h = 424,220
	local uw, uh = 424 - 8, 220 - 8 -- usable dimensions, after padding


	frame.door = door

	frame:SetSize(w,h+36)
	frame:SetPos(0,ScrH()-(h+36)-8)
	frame:CenterHorizontal()
	frame:SetTitle("doorHandle Menu")
	frame:SetPrimaryColor( HexColor("#e67e22") )
	frame:SetSecondaryColor( HexColor("#ecf0f1", 4) )

	frame.colorpicker = vgui.Create("DColorMixer", frame)
	frame.colorpicker:SetSize( uh, uh )
	frame.colorpicker:SetPos( 4,4 + 28 )
	frame.colorpicker:SetColor( door.DoorData.doorColor or Color(255,255,255) )

	function frame.colorpicker:ValueChanged( color )
		--print( color, self:GetColor() )
		self:GetParent().door.DoorData.doorColor = color
	end

	frame.slider = vgui.Create("Slider", frame)
	frame.slider:SetSize(200, 104)
	frame.slider:SetPos( uh+4+4, 4+28)
	frame.slider:SetMin( self.MinTextScale )
	frame.slider:SetMax( self.MaxTextScale )
	frame.slider:SetValue( door.DoorData.textScale or self.DefaultTextScale )
	frame.slider:SetDecimals(2)
	frame.slider.TextArea:SetTextColor(Color(255,255,255))

	function frame.slider:Paint(w,h)
		ArizardShadowText( DOORHANDLE.strings.Text_Scale, "arizard_derma_Small", 12, 8, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1)
		surface.SetDrawColor( 255, 255, 255, 4 )
		draw.RoundedBox(4, 0, 0, w, h, Color(255,255,255,4) )
	end

	function frame.slider:OnValueChanged()
		self:GetParent().door.DoorData.textScale = self:GetValue()
	end

	frame.fontpanel = vgui.Create("DPanel", frame)
	frame.fontpanel:SetSize(200,104)
	frame.fontpanel:SetPos(uh+8, 8+28+104)

	function frame.fontpanel:Paint(w,h)
		ArizardShadowText( DOORHANDLE.strings.Font, "arizard_derma_Small", 12, 8, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1)
		surface.SetDrawColor( 255, 255, 255, 4 )
		draw.RoundedBox(4, 0, 0, w, h, Color(255,255,255,4) )
	end

	function frame:OnRemove()
		RunConsoleCommand( "doorhandle_setscale", self.door:EntIndex(), self.door.DoorData.textScale or self.DefaultTextScale )
		RunConsoleCommand( "doorhandle_setfont", self.door:EntIndex(), self.door.DoorData.fontIndex or 1 )
		local col = self.door.DoorData.doorColor or table.Copy(DOORHANDLE.DefaultColor)
		RunConsoleCommand( "doorhandle_setcolor", self.door:EntIndex(), col.r, col.g, col.b, col.a )
	end

	frame.fontpanel.button = vgui.Create("arizard_button", frame.fontpanel)
	frame.fontpanel.button:SetSize( frame.fontpanel:GetWide()-16, 32 )
	frame.fontpanel.button:SetPos(8, frame.fontpanel:GetTall()/2 - 16 )
	frame.fontpanel.button:SetText( self.PresetFonts[door.DoorData.fontIndex] or self.PresetFonts[1] )

	function frame.fontpanel.button:DoClick()

		local menu = vgui.Create("DMenu")

		for i = 1, #DOORHANDLE.PresetFonts do
			local fontname = DOORHANDLE.PresetFonts[i]
			menu:AddOption( fontname, function()
				self:GetParent():GetParent().door.DoorData.fontIndex = i
				self:SetText( fontname )
			end ):SetIcon("icon16/text_smallcaps.png")
		end

		menu:Open()

	end


end
concommand.Add("doorhandle_openmenu", function()
	local tr = LocalPlayer():GetEyeTrace()
	if tr.Entity then
		if tr.Entity:isDoor() then
			if (tr.Entity:getDoorOwner() == LocalPlayer()) or (LocalPlayer():IsSuperAdmin() == true) then
				DOORHANDLE:OpenMenu(tr.Entity)
			end
		end
	end
end)

concommand.Add("doorinfo", function()
	local tr = LocalPlayer():GetEyeTrace()
	if tr.Entity then
		if tr.Entity.DoorData then
			PrintTable(tr.Entity.DoorData)
		end
		local max = tr.Entity:OBBMaxs()
		local min = tr.Entity:OBBMins()

		local norm = (max - min)
		norm:Normalize()
		local brush_ang = norm:Angle()

		print(tr.Entity:GetClass())
		print(tr.Entity:GetAngles())
		print(tr.Entity:GetModel())
		
		
	end
end)

net.Receive("DOORHANDLE_SendDoorDataSingle", function()
	local index = net.ReadFloat()
	local data = net.ReadTable()

	local door = ents.GetByIndex( index )
	if door then
		--PrintTable( door.DoorData )
		--door.DoorData = table.Copy( data ) --why pls
		if data and door.DoorData then
			table.CopyFromTo( data, door.DoorData )
		end
	end
end)

function DOORHANDLE:Allowed( ply )
	if DOORHANDLE.AdminOnly == false or (DOORHANDLE.AdminOnly == ply:IsAdmin()) then
		return true
	else
		print( ply:Nick().." attempted to use doorhandle, but they were denied access.")
		return false
	end
end

hook.Add("InitPostEntity", "DOORHANDLE_AddButtonsAndPropertiesMenu", function()

	if DOORHANDLE:Allowed( LocalPlayer() ) then
		-- add this shizz to the keys menu
		-- thanks Partixel for this code :)
		local function AddButtonToFrame(Frame)
			Frame:SetTall(Frame:GetTall() + 110)
			local button = vgui.Create("DButton", Frame)
			button:SetPos(10, Frame:GetTall() - 110)
			button:SetSize(180, 100)
			return button
		end
		hook.Add("onKeysMenuOpened", "doorHandleMenu", function( ent, Frame)
			if DOORHANDLE.UseKeysMenu == true then
				if ent:getDoorOwner() == LocalPlayer() or LocalPlayer():IsSuperAdmin() then
					local doorHandleMenu = AddButtonToFrame(Frame)
					doorHandleMenu:SetText(DOORHANDLE.strings.Edit_Title_Appearance)
					doorHandleMenu.DoClick = function()
						DOORHANDLE:OpenMenu( ent )
					end
				end
			end
		end)

		-- add to context menu

		properties.Add( "doorHandle_OpenMenu",
			{
				MenuLabel = DOORHANDLE.strings.Open_Doorhandle_Menu,
				Order = 1,
				MenuIcon = "icon16/text_smallcaps.png",
				Filter = function( self, ent, ply )
					if IsValid( ent ) then
						local owner = ent:getDoorOwner()
						return ( ( (owner == ply) or LocalPlayer():IsSuperAdmin() ) and ent:isDoor())
					end
				end,
				Action = function( self, ent )
					local owner = ent:getDoorOwner()
					if owner == LocalPlayer() or LocalPlayer():IsSuperAdmin() then
						DOORHANDLE:OpenMenu( ent )
					end
				end
			}
		)
	end
end)
