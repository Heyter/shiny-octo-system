/*---------------------------------------------------------------------------
	
	Creator: TheCodingBeast - TheCodingBeast.com
	This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. 
	To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/
	
---------------------------------------------------------------------------*/

-- Variables
local PANEL = {}

-- Panel
function PANEL:Init()

	self:SetSize( self:GetParent():GetWide() - 20, self:GetParent():GetTall() - 20 )
	self:SetPos( 10, 10 )
	self.Paint = function() end

	self.VBar.Paint 			= function( pnl, w, h ) draw.RoundedBox( 4, 0, 0, w, h, TCB_Settings.SoftBlack ) end 
	self.VBar.btnUp.Paint 		= function( pnl, w, h ) draw.RoundedBox( 4, 2, 2, w - 4, h - 4, TCB_Settings.Gray3Color ) draw.DrawText( "▲", "HudHintTextSmall", 3, 2, TCB_Settings.WhiteColor ) end
	self.VBar.btnDown.Paint 	= function( pnl, w, h ) draw.RoundedBox( 4, 2, 2, w - 4, h - 4, TCB_Settings.Gray3Color ) draw.DrawText( "▼", "HudHintTextSmall", 3, 2, TCB_Settings.WhiteColor ) end
	self.VBar.btnGrip.Paint 	= function( pnl, w, h ) draw.RoundedBox( 4, 2, 2, w - 4, h - 4, TCB_Settings.Gray3Color ) end

	-- Dirty Fix
	self:ScrollFix()

end

-- Scroll Fix
function PANEL:ScrollFix()

	-- Dirty Fix
	local ScrollFix = vgui.Create( "DPanel", self )
	ScrollFix:SetSize( 0, self:GetTall() + 1 )
	ScrollFix:SetPos( 0, 0 )
	ScrollFix.Paint = function() end 

end

-- Derma
vgui.Register( "tcb_panel_scroll", PANEL, "DScrollPanel" )



-- Variables
local PANEL = {}

-- Panel
function PANEL:Init()

	self:SetSize( 608, 30 )
	self.Paint = function( pnl, w, h )

		draw.RoundedBox( 0, 0, 0, w - 0, h - 0, TCB_Settings.SoftBlack )
		draw.RoundedBox( 0, 2, 2, w - 4, h - 4, TCB_Settings.BaseColor )

		draw.DrawText( "Некоторые вещи могут не отображаться из-за вашей работы или ранга!", "HUDSmall", w/2+1, 7+1, TCB_Settings.BlackColor, 1 )
		draw.DrawText( "Некоторые вещи могут не отображаться из-за вашей работы или ранга!", "HUDSmall", w/2+0, 7+0, TCB_Settings.PrimaryColor, 1 )

	end

end

-- Derma
vgui.Register( "tcb_panel_hidden", PANEL, "DPanel" )