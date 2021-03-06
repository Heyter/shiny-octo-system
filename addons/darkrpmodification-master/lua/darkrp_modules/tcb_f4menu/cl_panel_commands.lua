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
	type 	= 1,
	cmd 	= "/cheque", 
	text 	= "Выдать чек", 
	args 	= { arg1_show = true, arg1_text = "Name", arg2_show = true, arg2_text = "Amount" } 

},
{
	type 	= 1,
	cmd 	= "/demote", 
	text 	= "Уволить", 
	args 	= { arg1_show = true, arg1_text = "Name", arg2_show = true, arg2_text = "Reason" } 

},
{
	type 	= 1,
	cmd 	= "/rpname", 
	text 	= "Сменить имя", 
	args 	= { arg1_show = true, arg1_text = "Name", arg2_show = false, arg2_text = "" } 

},
{
	type 	= 1,
	cmd 	= "/drop", 
	text 	= "Выбросить текущее оружие", 
	args 	= { arg1_show = false, arg1_text = "", arg2_show = false, arg2_text = "" } 
},
{
	type 	= 1,
	cmd 	= "/unownalldoors", 
	text 	= "Продать все двери", 
	args 	= { arg1_show = false, arg1_text = "", arg2_show = false, arg2_text = "" } 
},
}
local policeCommands = {
	{
	type 	= 2,
	cmd 	= "/Wanted", 
	text 	= "Объявить розыск", 
	args 	= { arg1_show = true, arg1_text = "Имя игрока", arg2_show = true, arg2_text = "Причина" } 
	},{
	type 	= 2,
	cmd 	= "/warrant", 
	text 	= "Запросить ордер", 
	args 	= { arg1_show = true, arg1_text = "Имя игрока", arg2_show = true, arg2_text = "Причина" }
	},{
	type 	= 2,
	cmd 	= "/unwanted", 
	text 	= "Снять розыск", 
	args 	= { arg1_show = true, arg1_text = "Имя игрока", arg2_show = false, arg2_text = "Причина" }
	},
}

local policeChiefCommands = table.Copy(policeCommands)
table.insert(policeChiefCommands,
{
	type 	= 2,
	cmd 	= "/givelicense", 
	text 	= "Выдать лицензию", 
	args 	= { arg1_show = false, arg1_text = "Имя игрока", arg2_show = false, arg2_text = "Причина" }
})

local mayorCommands = {
	{
	type 	= 3,
	cmd 	= "/placelaws", 
	text 	= "Экран с законами", 
	args 	= { arg1_show = false, arg1_text = "Имя игрока", arg2_show = false, arg2_text = "Причина" }
	},

{
	type 	= 3,
	cmd 	= "/addlaw", 
	text 	= "Добавить закон", 
	args 	= { arg1_show = true, arg1_text = "Закон", arg2_show = false, arg2_text = "Причина" }
	},

{
	type 	= 3,
	cmd 	= "/removelaw", 
	text 	= "Убрать закон", 
	args 	= { arg1_show = true, arg1_text = "Номер линии", arg2_show = false, arg2_text = "Причина" }
	},

{
	type 	= 3,
	cmd 	= "/lottery", 
	text 	= "Начать лотерею", 
	args 	= { arg1_show = false, arg1_text = "Имя игрока", arg2_show = false, arg2_text = "Причина" }
	},

{
	type 	= 3,
	cmd 	= "/givelicense", 
	text 	= "Выдать лицензию", 
	args 	= { arg1_show = false, arg1_text = "Имя игрока", arg2_show = false, arg2_text = "Причина" }
	},
}
-- Variables
local PANEL = {}

-- Panel
function PANEL:Init()

	self:SetSize( 299, 50 )  -- Height (2 Args): 130
	self.Paint = function( pnl, w, h )

		draw.RoundedBox( 0, 0, 0, w - 0, h - 0, TCB_Settings.SoftBlack )
		draw.RoundedBox( 0, 2, 2, w - 4, h - 4, TCB_Settings.ButtonColor2 )

	end

	self.button = vgui.Create( "DButton", self )
	self.button:SetSize( self:GetWide() - 16, 34 )
	self.button:SetPos( 8, 8 )	-- Y (2 Args): self.arg1:GetTall() * 2 + 36
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
			if self.button.Hover == true then
				draw.RoundedBox( 0, 2, 2, w - 4, h - 4, TCB_Settings.Green2Color )
				draw.RoundedBox( 0, 4, 4, w - 8, h - 8, TCB_Settings.SoftBlack )
			else
				draw.RoundedBox( 0, 2, 2, w - 4, h - 4, TCB_Settings.Green1Color )
				draw.RoundedBox( 0, 4, 4, w - 8, h - 8, TCB_Settings.Green2Color )
			end
		elseif self.button.Type == 2 then
			if self.button.Hover == true then
				draw.RoundedBox( 0, 2, 2, w - 4, h - 4, TCB_Settings.Blue2Color )
				draw.RoundedBox( 0, 4, 4, w - 8, h - 8, TCB_Settings.SoftBlack )
			else
				draw.RoundedBox( 0, 2, 2, w - 4, h - 4, TCB_Settings.Blue1Color )
				draw.RoundedBox( 0, 4, 4, w - 8, h - 8, TCB_Settings.Blue2Color )
			end
		else
			if self.button.Hover == true then
				draw.RoundedBox( 0, 2, 2, w - 4, h - 4, Color(220,62,62) )
				draw.RoundedBox( 0, 4, 4, w - 8, h - 8, TCB_Settings.SoftBlack )
			else
				draw.RoundedBox( 0, 2, 2, w - 4, h - 4, Color(220,62,62) )
				draw.RoundedBox( 0, 4, 4, w - 8, h - 8, Color(206,57,57) )
			end
		end

		draw.DrawText( self.button.Text, "Trebuchet24", w / 2 + 1, 5 + 1, TCB_Settings.BlackColor, 1 )
		draw.DrawText( self.button.Text, "Trebuchet24", w / 2 + 0, 5 + 0, TCB_Settings.WhiteColor, 1 )

	end

end

-- Update
function PANEL:UpdateInfo( item )

	-- Set Text
	self.button.Text = item['text']
	-- Set Type
	self.button.Type = item['type']
	-- Set Command
	local parent = self:GetParent():GetParent():GetParent()
	local ButtonClick = function() end
	if not item['args']['arg1_show'] then
		ButtonClick = function() RunConsoleCommand("tcb_f4menu_close") RunConsoleCommand( "say", item['cmd'] ) end 
	else
		ButtonClick = function() parent.popup:UpdateInfo(item)
									parent.popup:SetVisible(true) end
	end
		
		
	self.button.DoClick = ButtonClick

end

-- Derma
vgui.Register( "tcb_panel_item_cmd", PANEL, "DPanel" )

PANEL = {}


function PANEL:Init()
	self:SetDeleteOnClose(false)
	self:SetSize( 299, 105 ) -- Height (2 Args): 130
	self:Center()
	self.Paint = function( pnl, w, h )

		draw.RoundedBox( 0, 0, 0, w - 0, h - 0, TCB_Settings.SoftBlack )
		draw.RoundedBox( 0, 2, 2, w - 4, h - 4, TCB_Settings.ButtonColor2 )

	end
	self.parg1 = vgui.Create( "DPanel", self )
	self.parg1:SetSize( self:GetWide() - 16, 34 )
	self.parg1:SetPos( 8, 28 )
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
	self.arg1.OnMousePressed = function() self.arg1:SetText("") end

	self.parg2 = vgui.Create( "DPanel", self )
	self.parg2:SetSize( self:GetWide() - 16, 34 )
	self.parg2:SetPos( 8, self.parg1:GetTall() + 14 )
	self.parg2.Paint = function( pnl, w, h )

		draw.RoundedBox( 0, 0, 0, w - 0, h - 0, TCB_Settings.SoftBlack )
		draw.RoundedBox( 0, 2, 2, w - 4, h - 4, TCB_Settings.LightBrown )
		draw.RoundedBox( 0, 4, 4, w - 8, h - 8, TCB_Settings.ButtonColor3 )

	end

	self.arg2 = vgui.Create( "DTextEntry", self.parg2 )
	self.arg2:SetSize( self.parg2:GetWide() - 8, self.parg2:GetTall() - 8 )
	self.arg2:SetPos( 4, 4 )
	self.arg2:SetText( "" )
	self.arg2:SetEnabled( false )
	self.arg2.Paint = function( pnl, w, h ) pnl:DrawTextEntryText(TCB_Settings.WhiteColor, TCB_Settings.Blue1Color, TCB_Settings.WhiteColor) end
	self.arg2.OnMousePressed = function() self.arg2:SetText("") end

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

function PANEL:UpdateInfo( item )
	self:SetTitle(item['cmd'])
	-- Arg 1
	local Arg1_Text = item['args']['arg1_text']
	if Arg1_Text == "" then Arg1_Text = "" end

	-- Arg 2
	local Arg2_Text = item['args']['arg2_text']
	if Arg2_Text == "" then Arg2_Text = "" end

	-- Set Args
	self.arg1:SetText( Arg1_Text )
	self.arg2:SetText( Arg2_Text )

	-- Set Status
	self.arg1:SetEnabled( item['args']['arg1_show'] )
	self.arg2:SetEnabled( item['args']['arg2_show'] )

	-- Set Text
	self.button.Text = item['text']

	-- Set Type
	self.button.Type = item['type']

	-- Set Command
	local ButtonClick = function() end
	local close = function() self:SetVisible(false) end

	if not item['args']['arg1_show'] then

		ButtonClick = function() close() RunConsoleCommand( "say", item['cmd'] ) 
		end
		self.parg1:SetVisible(false)
		self:SetSize( 299, 50+40 ) 
		self.button:SetPos( 8, 28 )
	elseif item['args']['arg1_show'] and not item['args']['arg2_show'] then
		ButtonClick = function() close() RunConsoleCommand( "say", item['cmd'].." "..self.arg1:GetValue() ) end
		self.parg1:SetVisible(true)
		self.parg2:SetVisible(false)
		self:SetSize( 299, 110 )
		self.button:SetPos( 8, 28+40 )
	else
		ButtonClick = function() close() RunConsoleCommand( "say", item['cmd'].." "..self.arg1:GetValue().." "..self.arg2:GetValue() ) end
		self.parg1:SetVisible(true)
		self.parg2:SetVisible(true)
		self:SetSize( 299, 150 )
		self.button:SetPos( 8, 28+40+40 )
		self.parg2:SetPos( 8, 28+40)
	end

	self.button.DoClick = ButtonClick

end

vgui.Register("cmd_popup",PANEL, "DFrame")
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
	self.popup = vgui.Create( "cmd_popup", self )
	self.popup:SetVisible(false)
	-- Fill Data
	self:FillData( TCB_Scroll )
	if LocalPlayer():isMayor() then
		self:FillData(TCB_Scroll,self.lastY+20,mayorCommands)
	elseif LocalPlayer():isCP() then
		if LocalPlayer():Team() == TEAM_CHIEF then
			self:FillData(TCB_Scroll,self.lastY+20,policeChiefCommands)
		else
			self:FillData(TCB_Scroll,self.lastY+20,policeCommands)
		end
	end

	hook.Add("TCB_F4Menu_Close","Closef4popup",function()
		self.popup:SetVisible(false)
	end)
end

-- Fill Data
function PANEL:FillData( parent ,startY, items)

	local StartYPosl = startY or 0
	local StartYPosr = startY or 0
	local StartXPos = 0

	local StartYPos = 0
	local ItemTable = items or CommandsTable
	for i, item in ipairs( ItemTable ) do

		CurrentItem = vgui.Create( "tcb_panel_item_cmd", parent )
		if StartYPosl <= StartYPosr then
			
			StartYPos = StartYPosl
			StartXPos = 0
		else
			
			StartYPos = StartYPosr
			StartXPos = 299+10
		end

		CurrentItem:SetPos( StartXPos, StartYPos )

		CurrentItem:UpdateInfo( item )
		
		if StartXPos == 0 then
	
			StartYPosl = StartYPosl + CurrentItem:GetTall() + 5
		elseif StartXPos != 0 then
			
			StartYPosr = StartYPosr + CurrentItem:GetTall() + 5
		end
		
	
	end
	self.lastY = StartYPosl

end

-- Refill Data
function PANEL:RefillData()

	-- Remove Items
	TCB_Scroll:Clear()

	-- Scroll Fix
	TCB_Scroll:ScrollFix()
	
	-- Fill Items
	self:FillData( TCB_Scroll )
	if LocalPlayer():isMayor() then
		self:FillData(TCB_Scroll,self.lastY+20,mayorCommands)
	elseif LocalPlayer():isCP() then
		if LocalPlayer():Team() == TEAM_CHIEF then
			self:FillData(TCB_Scroll,self.lastY+20,policeChiefCommands)
		else
			self:FillData(TCB_Scroll,self.lastY+20,policeCommands)
		end
	end

end

function PANEL:OnClose()

end
-- Derma 
vgui.Register( "tcb_panel_commands", PANEL, "DPanel" )