/*---------------------------------------------------------------------------
	
	Creator: TheCodingBeast - TheCodingBeast.com
	This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. 
	To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/
	
---------------------------------------------------------------------------*/

-- Variables
local PANEL = {}

-- Panel
function PANEL:Init()

	self:SetSize( 650 - 2, 620 - 2 )
	self:SetPos( 250, 2 )
	self.Paint = function()

		draw.RoundedBoxEx( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 0, 0, 0, 0 ), false, true, false, false )

		draw.DrawText( "Loading Website ...", "Trebuchet24", self:GetWide() / 2, self:GetTall() / 2, Color( 255, 255, 255, 255 ), 1 )

	end

	local WebPanel = vgui.Create( "HTML", self )
	WebPanel:SetPos( 6, 6 )
	WebPanel:SetSize( self:GetWide() - 12, self:GetTall() - 12 )
	WebPanel:OpenURL( TCB_Settings.WebPanel_1 )

end

-- Refill
function PANEL:RefillData()

end

-- Derma 
vgui.Register( "tcb_panel_custom1", PANEL, "DPanel" )

-- Variables
local PANEL = {}

-- Panel
function PANEL:Init()

	self:SetSize( 650 - 2, 620 - 2 )
	self:SetPos( 250, 2 )
	self.Paint = function()

		draw.RoundedBoxEx( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 0, 0, 0, 0 ), false, true, false, false )

		draw.DrawText( "Loading Website ...", "Trebuchet24", self:GetWide() / 2, self:GetTall() / 2, Color( 255, 255, 255, 255 ), 1 )

	end

	local WebPanel = vgui.Create( "HTML", self )
	WebPanel:SetPos( 6, 6 )
	WebPanel:SetSize( self:GetWide() - 12, self:GetTall() - 12 )
	WebPanel:OpenURL( TCB_Settings.WebPanel_2 )

end

-- Refill
function PANEL:RefillData()

end

-- Derma 
vgui.Register( "tcb_panel_custom2", PANEL, "DPanel" )

-- Variables
local PANEL = {}

-- Panel
function PANEL:Init()

	self:SetSize( 650 - 2, 620 - 2 )
	self:SetPos( 250, 2 )
	self.Paint = function()

		draw.RoundedBoxEx( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 0, 0, 0, 0 ), false, true, false, false )

		draw.DrawText( "Loading Website ...", "Trebuchet24", self:GetWide() / 2, self:GetTall() / 2, Color( 255, 255, 255, 255 ), 1 )

	end

	local WebPanel = vgui.Create( "HTML", self )
	WebPanel:SetPos( 6, 6 )
	WebPanel:SetSize( self:GetWide() - 12, self:GetTall() - 12 )
	WebPanel:OpenURL( TCB_Settings.WebPanel_3 )

end

-- Refill
function PANEL:RefillData()

end

-- Derma 
vgui.Register( "tcb_panel_custom3", PANEL, "DPanel" )

-- Variables
local PANEL = {}

-- Panel
function PANEL:Init()

	self:SetSize( 650 - 2, 620 - 2 )
	self:SetPos( 250, 2 )
	self.Paint = function()

		draw.RoundedBoxEx( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 0, 0, 0, 0 ), false, true, false, false )

		draw.DrawText( "Loading Website ...", "Trebuchet24", self:GetWide() / 2, self:GetTall() / 2, Color( 255, 255, 255, 255 ), 1 )

	end

	local WebPanel = vgui.Create( "HTML", self )
	WebPanel:SetPos( 6, 6 )
	WebPanel:SetSize( self:GetWide() - 12, self:GetTall() - 12 )
	WebPanel:OpenURL( TCB_Settings.WebPanel_4 )

end

-- Refill
function PANEL:RefillData()

end

-- Derma 
vgui.Register( "tcb_panel_custom4", PANEL, "DPanel" )
PANEL = {}
function PANEL:Init()
	self:SetTitle("")
	self:SetSize( 300, 100 )
	self:Center()
	self.Paint = function()

		draw.RoundedBoxEx( 0, 0, 0, self:GetWide(), self:GetTall(), TCB_Settings.BaseColor, false, true, false, false )

		

	end
	self.label = vgui.Create("DLabel",self)
	self.label:SetPos(15,15)
	self.label:SetSize(250,30)
	self.label:SetText("Внимание, ссылка откроется в браузере")

	self.urllable = vgui.Create( "DLabelURL", self )
	self.urllable:SetURL("http://madbay.net/community/index.php")
	self.urllable:SetText("Открыть в браузере")
	--self.urllable:SetFont("Trebuchet24")
	self.urllable:SetPos(15,40)
	self.urllable:SetSize(250,20)
	self.urllable:SetTextColor(TCB_Settings.PrimaryColor)
	hook.Add("TCB_F4Menu_Close","CloseBrowserPopup",function() self:Remove() end)
end
function PANEL:SetLink(str)
	self.urllable:SetURL(str)
end
vgui.Register( "TCB_Browser_Popup", PANEL, "DFrame" )