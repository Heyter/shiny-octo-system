/*
 *   VOICE
 *     VISUALIZER
 *
 *   Version 1.2
 *      - Will now also work in TTT
 *      - Added some TTT Tutorials / Tips
 *
 *   Version 1.1
 *      - Code is now much smaller
 *      - Fixed panel being displayed twice
 *
 *   Version 1.0
 *      - Initial Release
 */
// Code based on Garry's Base Gamemode
vv = {}
local PANEL = {}
local PlayerVoicePanels = {}
/*
 * CONFIG
 */

// Color
vv.BarColor = {
    [0] = Color(255, 0, 0), -- Over 0% -> Red
    [25] = Color(255, 255, 0), -- Over 25 % -> Yellow
    [50] = Color(0, 255, 0) -- Over 50% -> Green
}

// Adjust Bar Height
-- This is a PERFECT setting - Be sure before changing it
-- Default: 40
vv.BarHeightMultiplier = 40

// Update Rate
-- If you want it faster, increase the rate
-- If you want it slower, decrease the rate
-- Default: 0.1
vv.UpdateRate = 0.1

// Single Bar Width
-- If you want more bars, decrease the value
-- and increase the Bar Count
-- Default: 5
vv.SingleBarWidth = 5

// Bar Count
-- How many bars do you want to be displayed?
-- Default: 30 (Perfect setting with bar width 5)
vv.BarCount = 30

// Bar Distance
-- Distance between 2 Bars
-- Default: 2
vv.BarDistance = 2

// Background Color
-- Background Color of the bar itself
-- This HAS to be a function
-- Default: Black
vv.BackgroundColor = function(panel, ply)
    -- Tip if you have a TTT server
    -- This will normalize the background color of the panel (Green for Inno, Blue for Detective and Red in private Traitor Voice Channel)
    -- Change the line under me to: return panel.Color
    return Color(0,0,0)
end

// Name Color
-- Color of the name
-- This HAS to be a function
-- Default: White
vv.NameColor = function(panel, ply)
    return Color(255,255,255)
end

// Name Font
-- Font of the name
-- This HAS to be a function
-- Default: GModNotify
vv.NameFont = function(panel, ply)
    return "GModNotify"
end

/* 
 * DO NOT EDIT ANYTHING FROM HERE !
 */

function PANEL:Init()
	self.Avatar = vgui.Create("AvatarImage", self)
	self.Avatar:Dock(LEFT)
	self.Avatar:SetSize(32, 32)

	self.Color = Color(0,0,0)

	self:SetSize(250, 32 + 8)
	self:DockPadding(4, 4, 4, 4)
	self:DockMargin(2, 2, 2, 2)
	self:Dock(BOTTOM)
    
    self.Past = {}
end

function PANEL:Setup(ply)  
	self.ply = ply
	--self.LabelName:SetText(ply:Nick())
	self.Avatar:SetPlayer(ply)
	
	self.Color = team.GetColor(ply:Team())
    timer.Create("PanelThink" .. ply:UniqueID(), vv.UpdateRate, 0, function()
        if self.UpdatePast ~= nil then
            self:UpdatePast()
        end
    end)
	
	self:InvalidateLayout()
    
    -- wow.. TTT Gamemode overwrites the .Paint() function
    if GetConVarString("terrortown") then
        self.VVPaint = self.Paint
        
        timer.Simple(0, function()
            local ttt_paint = self.Paint
            self.Paint = function(s, w, h)
                ttt_paint(s, w, h)
                s:VVPaint(w, h)
            end
        end)
    end
end

function PANEL:UpdatePast()
    table.insert(self.Past, self.ply:VoiceVolume())
    
    local len = #self.Past
    if len > (vv.BarCount-1) then
        table.remove(self.Past, 1)
    end
end 

function PANEL:GetBarColor(p)
    local barcolor = Color(0,0,0)
   
    for i,v in pairs(vv.BarColor) do
        if p > i then
            barcolor = v
        end
    end
   
    return barcolor
end

function PANEL:Paint(w, h)
	if not IsValid(self.ply) then return end
	draw.RoundedBox(4, 0, 0, w, h, vv.BackgroundColor(self, self.ply))
    
    for i,v in pairs(self.Past) do
        local barh = v * vv.BarHeightMultiplier
        local barcolor = self:GetBarColor(v * 100)
        surface.SetDrawColor(barcolor)
        surface.DrawRect(35 + i * (vv.BarDistance + vv.SingleBarWidth), 36 - barh, vv.SingleBarWidth, barh)
    end
    
    -- Draw Name
    surface.SetFont(vv.NameFont(self, self.ply))
    local w,h = surface.GetTextSize(self.ply:Nick())
    
    surface.SetTextColor(vv.NameColor(self, self.ply))
    surface.SetTextPos(40, 40/2 - h/2)
    surface.DrawText(self.ply:Nick())
end

function PANEL:Think()
	if self.fadeAnim then
		self.fadeAnim:Run()
	end
end

function PANEL:FadeOut(anim, delta, data)	
	if anim.Finished then	
		if IsValid(PlayerVoicePanels[self.ply]) then
			PlayerVoicePanels[self.ply]:Remove()
			PlayerVoicePanels[self.ply] = nil
			return
		end		
        
        return 
    end
			
	self:SetAlpha(255 - (255 * (delta*2)))
end
derma.DefineControl("VoiceNotify", "", PANEL, "DPanel") 
timer.Simple(1, function() derma.DefineControl("VoiceNotify", "", PANEL, "DPanel")  end)