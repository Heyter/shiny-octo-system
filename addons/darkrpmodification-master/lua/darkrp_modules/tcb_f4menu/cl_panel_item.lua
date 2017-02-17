/*---------------------------------------------------------------------------
	
	Creator: TheCodingBeast - TheCodingBeast.com
	This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. 
	To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/
	
---------------------------------------------------------------------------*/

-- Variables
local PANEL = {}

-- Panel
function PANEL:Init()

	-- Main Frame
	self:SetSize( 608, 76 )
	self.Paint = function( pnl, w, h )

		draw.RoundedBox( 0, 0, 0, w - 0, h - 0, TCB_Settings.SoftBlack )
		draw.RoundedBox( 0, 2, 2, w - 4, h - 4, TCB_Settings.ButtonColor2 )

	end

	-- Model View
	self.model = vgui.Create( "ModelImage", self )
	self.model:SetSize( 72, 72 )
	self.model:SetPos( 4, 2 )
	self.model:SetModel( "models/props_lab/reciever01b.mdl" )

	-- Item Name
	self.info = vgui.Create( "DPanel", self )
	self.info:SetSize( 310, 56 )
	self.info:SetPos( 80, 10 )
	self.info.name 	= "-"
	self.info.two 	= ""
	self.info.Paint = function( pnl, w, h )

		--draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255, 20 ) )

		draw.DrawText( self.info.name, "Trebuchet24", w / 2 + 1, 5 + 1, TCB_Settings.BlackColor, 1 )
		draw.DrawText( self.info.name, "Trebuchet24", w / 2 + 0, 5 + 0, TCB_Settings.WhiteColor, 1 )

		draw.DrawText( self.info.two, "Trebuchet18", w / 2 + 1, 34 + 1, TCB_Settings.BlackColor, 1 )
		draw.DrawText( self.info.two, "Trebuchet18", w / 2 + 0, 34 + 0, TCB_Settings.WhiteColor, 1 )

	end

	-- Join Button
	self.buy = vgui.Create( "DButton", self )
	self.buy:SetSize( 200, 34 )
	self.buy:SetPos( self:GetWide() - 200 - 10, 10 )
	self.buy:SetText( "" )
	self.buy.Hover 	= false
	self.buy.Status = false
	self.buy.OnCursorEntered	= function() self.buy.Hover = true  end
	self.buy.OnCursorExited 	= function() self.buy.Hover = false end
	self.buy.DoClick = function() end
	self.buy.Paint = function( pnl, w, h )

		draw.RoundedBox( 0, 0, 0, w - 0, h - 0, TCB_Settings.SoftBlack )
		draw.RoundedBox( 0, 2, 2, w - 4, h - 4, TCB_Settings.Green1Color )
		draw.RoundedBox( 0, 4, 4, w - 8, h - 8, TCB_Settings.Green2Color )

		if self.buy.Hover == true then
			draw.RoundedBox( 0, 4, 4, w - 8, h - 8, TCB_Settings.SoftBlack )
		end

		if self.buy.Status == true then
			draw.RoundedBox( 0, 2, 2, w - 4, h - 4, TCB_Settings.Gray1Color )
			draw.RoundedBox( 0, 4, 4, w - 8, h - 8, TCB_Settings.Gray2Color )
		end

		draw.DrawText( "Купить", "Trebuchet24", w / 2 + 1, 5 + 1, TCB_Settings.BlackColor, 1 )
		draw.DrawText( "Купить", "Trebuchet24", w / 2 + 0, 5 + 0, TCB_Settings.WhiteColor, 1 )

	end

	-- Slots
	self.slots = vgui.Create( "DPanel", self )
	self.slots:SetSize( 200, 20 )
	self.slots:SetPos( self:GetWide() - 200 - 10, 50 )
	self.slots.text = "-"
	self.slots.Paint = function( pnl, w, h )

		draw.DrawText( self.slots.text, "Trebuchet18", w/ 2, 0, TCB_Settings.WhiteColor, 1 )

	end
	
end

-- Update
function PANEL:UpdateInfo( item, type, check )

	self.model:SetModel( item.model )

	self.info.name 	= item.name

	if type == "weapons" then
		self.slots.text = "Цена: "..DarkRP.formatMoney( item.pricesep )
		if not LocalPlayer():canAfford( item.pricesep ) then
			self.buy.Status = true
		end

		if GAMEMODE.Config.restrictbuypistol and not table.HasValue(item.allowed, LocalPlayer():Team()) then
			self.buy.Status = true
		end
		if item.customCheck and not item.customCheck( LocalPlayer() ) then
			self.buy.Status = true 
		end
	else
		self.slots.text = "Цена: "..DarkRP.formatMoney( item.price )
		if not LocalPlayer():canAfford( item.price ) then
			self.buy.Status = true
		end

		if istable(item.allowed) and table.Count(item.allowed) >= 1 and not table.HasValue(item.allowed, LocalPlayer():Team()) then
			self.buy.Status = true 
		end
		
		if item.customCheck and not item.customCheck( LocalPlayer() ) then
			self.buy.Status = true 
		end
	end

	local closeFunc = function() RunConsoleCommand( "tcb_f4menu_close" ) end
	if type == "entities" then
		self.info.two 	= "Максимум: "..item.max
		if self.buy.Status != true then
			self.buy.DoClick = fn.Compose{closeFunc, fn.Partial(RunConsoleCommand, "DarkRP", item.cmd)}
		end
	elseif type == "weapons" then
		self.info.two 	= "-"
		if self.buy.Status != true then
			self.buy.DoClick = fn.Compose{closeFunc, fn.Partial(RunConsoleCommand, "DarkRP", "buy", item.name)}
		end
	elseif type == "shipments" then
		self.info.two 	= "Оружие: "..item.amount
		if self.buy.Status != true then
			self.buy.DoClick = fn.Compose{closeFunc, fn.Partial(RunConsoleCommand, "DarkRP", "buyshipment", item.name)}
		end
	elseif type == "ammo" then
		self.info.two 	= "Патроны: "..item.amountGiven
		if self.buy.Status != true then
			self.buy.DoClick = fn.Compose{closeFunc, fn.Partial(RunConsoleCommand, "DarkRP", "buyammo", item.ammoType)}
		end
	elseif type == "vehicles" then
		self.info.name 	= item.label or item.name
		self.info.two 	= "-"
		if self.buy.Status != true then
			self.buy.DoClick = fn.Compose{closeFunc, fn.Partial(RunConsoleCommand, "DarkRP", "buyvehicle", item.name)}
		end
	else
		self.info.two 	= "-"
	end
	
end

-- Derma 
vgui.Register( "tcb_panel_item", PANEL, "DPanel" )