/*---------------------------------------------------------------------------
	
	Creator: TheCodingBeast - TheCodingBeast.com
	This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. 
	To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/
	
---------------------------------------------------------------------------*/

-- Table
local CommandsTable = {

{
	type 	= 1,
	cmd 	= "/dropmoney", 
	text 	= "Бросить деньги", 
	args 	= { arg1_show = true, arg1_text = "10", arg2_show = false, arg2_text = "" } 
},

{
	type 	= 1,
	cmd 	= "/give", 
	text 	= "Дать деньги", 
	args 	= { arg1_show = true, arg1_text = "10", arg2_show = false, arg2_text = "" } 
},
{
	type 	= 2,
	cmd 	= "/drop", 
	text 	= "Выбросить текущее оружие", 
	args 	= { arg1_show = false, arg1_text = "", arg2_show = false, arg2_text = "" } 
},
{
	type 	= 2,
	cmd 	= "/makeshipment", 
	text 	= "Сделать партию", 
	args 	= { arg1_show = false, arg1_text = "", arg2_show = false, arg2_text = "" } 
},
{
	type 	= 2,
	cmd 	= "/unownalldoors", 
	text 	= "Продать все двери", 
	args 	= { arg1_show = false, arg1_text = "", arg2_show = false, arg2_text = "" } 
},
{
	type 	= 2,
	cmd 	= "/requestlicense", 
	text 	= "Запросить лицензию", 
	args 	= { arg1_show = false, arg1_text = "", arg2_show = false, arg2_text = "" } 
}}

-- Variables
local PANEL = {}

-- Panel
function PANEL:Init()

	self:SetSize( 299, 105 ) -- Height (2 Args): 130
	self.Paint = function( pnl, w, h )

		draw.RoundedBox( 0, 0, 0, w - 0, h - 0, TCB_Settings.SoftBlack )
		draw.RoundedBox( 0, 2, 2, w - 4, h - 4, TCB_Settings.ButtonColor2 )

	end

	self.parg1 = vgui.Create( "DPanel", self )
	self.parg1:SetSize( self:GetWide() - 16, 34 )
	self.parg1:SetPos( 8, 8 )
	self.parg1.Paint = function( pnl, w, h )

		draw.RoundedBox( 0, 0, 0, w - 0, h - 0, TCB_Settings.SoftBlack )
		draw.RoundedBox( 0, 2, 2, w - 4, h - 4, TCB_Settings.LightBrown )
		draw.RoundedBox( 0, 4, 4, w - 8, h - 8, TCB_Settings.ButtonColor3 )

	end

	self.arg1 = vgui.Create( "DTextEntry", self.parg1 )
	self.arg1:SetSize( self.parg1:GetWide() - 8, self.parg1:GetTall() - 8 )
	self.arg1:SetPos( 4, 4 )
	self.arg1:SetText( "" )
	self.arg1:SetEnabled( false )
	self.arg1.Paint = function( pnl, w, h ) pnl:DrawTextEntryText(TCB_Settings.WhiteColor, TCB_Settings.Blue1Color, TCB_Settings.WhiteColor) end


	/*self.parg2 = vgui.Create( "DPanel", self )
	self.parg2:SetSize( self:GetWide() - 16, 34 )
	self.parg2:SetPos( 8, self.parg1:GetTall() + 14 )
	self.parg2.Paint = function( pnl, w, h )

		draw.RoundedBox( 0, 0, 0, w - 0, h - 0, TCB_Settings.SoftBlack )
		draw.RoundedBox( 0, 2, 2, w - 4, h - 4, Color( 149, 165, 166, 255 ) )
		draw.RoundedBox( 0, 4, 4, w - 8, h - 8, Color( 127, 140, 141, 255 ) )

	end

	self.arg2 = vgui.Create( "DTextEntry", self.parg2 )
	self.arg2:SetSize( self.parg2:GetWide() - 8, self.parg2:GetTall() - 8 )
	self.arg2:SetPos( 4, 4 )
	self.arg2:SetText( "" )
	self.arg2:SetEnabled( false )
	self.arg2.Paint = function( pnl, w, h ) pnl:DrawTextEntryText(TCB_Settings.WhiteColor, TCB_Settings.Blue1Color, TCB_Settings.WhiteColor) end*/

	self.button = vgui.Create( "DButton", self )
	self.button:SetSize( self:GetWide() - 16, 34 )
	self.button:SetPos( 8, self.arg1:GetTall() + 36 )	-- Y (2 Args): self.arg1:GetTall() * 2 + 36
	self.button:SetText( "" )
	self.button.Type 	= 1
	self.button.Text 	= ""
	self.button.Hover 	= false
	self.button.Status 	= false
	self.button.OnCursorEntered	= function() self.button.Hover = true  end
	self.button.OnCursorExited 	= function() self.button.Hover = false end
	self.button.DoClick = function() end
	self.button.Paint = function( pnl, w, h )

		draw.RoundedBox( 0, 0, 0, w - 0, h - 0, TCB_Settings.SoftBlack )

		if self.button.Type == 1 then
			draw.RoundedBox( 0, 2, 2, w - 4, h - 4, TCB_Settings.Green1Color )
			draw.RoundedBox( 0, 4, 4, w - 8, h - 8, TCB_Settings.Green2Color )
		else
			draw.RoundedBox( 0, 2, 2, w - 4, h - 4, TCB_Settings.Blue1Color )
			draw.RoundedBox( 0, 4, 4, w - 8, h - 8, TCB_Settings.Blue2Color )
		end

		draw.DrawText( self.button.Text, "Trebuchet24", w / 2 + 1, 5 + 1, TCB_Settings.BlackColor, 1 )
		draw.DrawText( self.button.Text, "Trebuchet24", w / 2 + 0, 5 + 0, TCB_Settings.WhiteColor, 1 )

	end

end

-- Update
function PANEL:UpdateInfo( item )

	-- Arg 1
	local Arg1_Text = item['args']['arg1_text']
	if Arg1_Text == "" then Arg1_Text = "" end

	-- Arg 2
	local Arg2_Text = item['args']['arg2_text']
	if Arg2_Text == "" then Arg2_Text = "" end

	-- Set Args
	self.arg1:SetText( Arg1_Text )
	--self.arg2:SetText( Arg2_Text )

	-- Set Status
	self.arg1:SetEnabled( item['args']['arg1_show'] )
	--self.arg2:SetEnabled( item['args']['arg2_show'] )

	-- Set Text
	self.button.Text = item['text']

	-- Set Type
	self.button.Type = item['type']

	-- Set Command
	local ButtonClick = function() end


	if not tobool(item['args']['arg1_show']) then

		ButtonClick = function() RunConsoleCommand( "tcb_f4menu_close" ) RunConsoleCommand( "say", item['cmd'] ) 
		end
		self.parg1:SetVisible(false)
		self:SetSize( 299, 50 ) 
		self.button:SetPos( 8, 8 )
	else
		ButtonClick = function() RunConsoleCommand( "tcb_f4menu_close" ) RunConsoleCommand( "say", item['cmd'].." "..self.arg1:GetValue() ) end
	end

	self.button.DoClick = ButtonClick

end

-- Derma
vgui.Register( "tcb_panel_item_cmd", PANEL, "DPanel" )


-- Variables
local PANEL = {}
local TCB_Scroll

-- Panel
function PANEL:Init()

	self:SetSize( 650 - 2, 620 - 2 )
	self:SetPos( 250, 2 )
	self.Paint = function()

		draw.RoundedBoxEx( 0, 0, 0, self:GetWide(), self:GetTall(),TCB_Settings.Transparent, false, true, false, false )

	end

	TCB_Scroll = vgui.Create( "tcb_panel_scroll", self )

	-- Fill Data
	self:FillData( TCB_Scroll )

end

-- Fill Data
function PANEL:FillData( parent )

	local StartYPosl = 0
	local StartYPosr = 0
	local StartXPos = 0
	local StartYPos = 0
	local ItemTable = CommandsTable
	for i, item in ipairs( ItemTable ) do

		CurrentItem = vgui.Create( "tcb_panel_item_cmd", parent )
		if StartXPos == 0 then
			StartYPos = StartYPosl
		else
			StartYPos = StartYPosr
		end

		CurrentItem:SetPos( StartXPos, StartYPos )

		CurrentItem:UpdateInfo( item )

		if StartXPos == 0 then
			StartXPos = StartXPos + CurrentItem:GetWide() + 10
			StartYPosl = StartYPosl + CurrentItem:GetTall() + 5
		elseif StartXPos > 0 then
			StartXPos = 0
			StartYPosr = StartYPosr + CurrentItem:GetTall() + 5
		end
		
	
	end

end

-- Refill Data
function PANEL:RefillData()

	-- Remove Items
	TCB_Scroll:Clear()

	-- Scroll Fix
	TCB_Scroll:ScrollFix()
	
	-- Fill Items
	self:FillData( TCB_Scroll )

end

-- Derma 
vgui.Register( "tcb_panel_commands", PANEL, "DPanel" )