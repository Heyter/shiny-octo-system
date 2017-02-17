/*---------------------------------------------------------------------------
	
	Creator: TheCodingBeast - TheCodingBeast.com
	This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. 
	To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/
	
---------------------------------------------------------------------------*/

-- Variables
local PANEL = {}
local TCB_Scroll

-- Panel
function PANEL:Init()
	-- Main Frame
	self:SetSize( 608, 72 )
	self:SetText("")
	self.Paint = function( pnl, w, h )

		draw.RoundedBox( 0, 0, 0, w - 0, h - 0, TCB_Settings.SoftBlack )
		draw.RoundedBox( 0, 2, 2, w - 4, h - 4, TCB_Settings.ButtonColor2 )

	end
	self.mshown = false

	-- Model View
	self.model = vgui.Create( "ModelImage", self )
	self.model:SetSize( 72, 72 )
	self.model:SetPos( 2, 2 )
	self.model:SetModel( "models/player/alyx.mdl" )
	self.modelpath = 0

		-- Job Name
	self.info = vgui.Create( "DPanel", self )
	self.info:SetSize( 310, 56 )
	self.info:SetPos( 80, 10 )
	self.info.name 	= "-"
	self.info.wep 	= ""
	self.info.Paint = function( pnl, w, h )

		--draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255, 20 ) )

		draw.DrawText( self.info.name, "Trebuchet24", w / 2 + 1, 5 + 1, TCB_Settings.BlackColor, 1 )
		draw.DrawText( self.info.name, "Trebuchet24", w / 2 + 0, 5 + 0, TCB_Settings.PrimaryColor, 1 )

		draw.DrawText( self.info.wep, "HUDSmall", w / 2 + 1, 34 + 1, TCB_Settings.BlackColor, 1 )
		draw.DrawText( self.info.wep, "HUDSmall", w / 2 + 0, 34 + 0, TCB_Settings.WhiteColor, 1 )

	end

	-- Join Button
	self.join = vgui.Create( "DButton", self )
	self.join:SetSize( 200, 34 )
	self.join:SetPos( self:GetWide() - 200 - 10, 10 )
	self.join:SetText( "" )
	self.join.Hover 	= false
	self.join.Status 	= false
	self.join.Extended  = false
	self.join.OnCursorEntered	= function() self.join.Hover = true  end
	self.join.OnCursorExited 	= function() self.join.Hover = false end
	self.join.DoClick = function() end
	self.join.Paint = function( pnl, w, h )

		draw.RoundedBox( 0, 0, 0, w - 0, h - 0, TCB_Settings.SoftBlack )
		draw.RoundedBox( 0, 2, 2, w - 4, h - 4, TCB_Settings.Green1Color )
		draw.RoundedBox( 0, 4, 4, w - 8, h - 8, TCB_Settings.Green2Color )

		if self.join.Hover == true then
			draw.RoundedBox( 0, 4, 4, w - 8, h - 8, TCB_Settings.SoftBlack )
		end

		if self.join.Status == true then
			draw.RoundedBox( 0, 2, 2, w - 4, h - 4, TCB_Settings.Gray1Color )
			draw.RoundedBox( 0, 4, 4, w - 8, h - 8, TCB_Settings.Gray2Color )
		end

		draw.DrawText( "Взять работу", "Trebuchet24", w / 2 + 1, 5 + 1, TCB_Settings.BlackColor, 1 )
		draw.DrawText( "Взять работу", "Trebuchet24", w / 2 + 0, 5 + 0, TCB_Settings.WhiteColor, 1 )

	end

	-- Slots
	self.slots = vgui.Create( "DPanel", self )
	self.slots:SetSize( 200, 20 )
	self.slots:SetPos( self:GetWide() - 200 - 10, 50 )
	self.slots.text = "0 / 0"
	self.slots.Paint = function( pnl, w, h )

		draw.DrawText( self.slots.text, "Trebuchet18", w/ 2, 0, TCB_Settings.WhiteColor, 1 )

	end



end

-- Update
function PANEL:UpdateInfo( job, team, name, model, max, players, description, vote, cmd )

	self.info.name 		= name
	self.info.wep 		= description
	self.slots.text 	= players.." / "..max
	
	if max != 0 and max != "#" and tonumber(players) >= max then
		self.join.Status = true
	end

	if team == LocalPlayer():Team() then
		self.join.Status = true
	end

	if job['NeedToChangeFrom'] and LocalPlayer():Team() != job['NeedToChangeFrom'] then
		self.join.Status = true
	end

	local closeFunc = function() RunConsoleCommand( "tcb_f4menu_close" ) end
	
	if self.join.Status != true then
		
		if vote then
			self.join.DoClick = fn.Compose{closeFunc, fn.Partial(RunConsoleCommand, "darkrp", "vote" .. cmd)}
		else
			self.join.DoClick = fn.Compose{closeFunc, fn.Partial(RunConsoleCommand, "darkrp", cmd)}
		end
		
	end
	
	model = DarkRP.getPreferredJobModel(job.team) or model
	
	self.model:SetModel( model )
	if istable(job.model) then
		
		self.model.OnMouseReleased = function()self:ShowModelSelection(job, team, name, model, max, players, description, vote, cmd) end
		self.Paint = function( pnl, w, h )

		draw.RoundedBox( 0, 0, 0, w - 0, h - 0, TCB_Settings.SoftBlack )
		draw.RoundedBox( 0, 2, 2, w - 4, h - 4, TCB_Settings.ButtonColor2 )
		draw.RoundedBox(0,0,0,1,h,TCB_Settings.PrimaryColor)
		self.model:SetCursor( "hand" )
		end

	end

end

function PANEL:ShowModelSelection(job, team, name, model, max, players, description, vote, cmd)
	
	if !self.selection or !self.selection.visible then
		self.selection = vgui.Create("tcb_panel_jobs_select_model")
		self.selection:UpdateInfo(job,self)

	else
		self.selection:Close()
	end
	


end

vgui.Register( "tcb_panel_jobs_item", PANEL, "DPanel" )

--Model selection panel
local PANEL = {} --"tcb_panel_jobs_select_model

function PANEL:Init()
	hook.Call("TCB_F4Menu_Close")
	w = ScrW()
	h = ScrH()
	self:SetPos((w/2)+450,(h/2)-325)
	self:SetSize(100,650)
	self:SetBackgroundColor(TCB_Settings.BaseColor)
	self.visible = false
	self.scroll = vgui.Create("tcb_panel_scroll",self)
	self.scroll:SetSize(200,620)


	self.closebtn = vgui.Create("DButton",self)
	self.closebtn:SetPos(0,620)
	self.closebtn:SetSize(100,30)
	self.closebtn:SetText("")
	self.closebtn.DoClick = function() self:Close() end
	self.closebtn.Paint = function()
	draw.RoundedBox(0,0,0,100,30,TCB_Settings.ButtonColor3)
	draw.DrawText( "Закрыть", "HUDSmall", 20, 6, TCB_Settings.PrimaryColor )
	end
	hook.Add("TCB_F4Menu_Close","Close TCB_model",function() self:Close() end)

end


function PANEL:UpdateInfo(job, parent)
    self.scroll:Clear()
    self.parent = parent
    self.visible = true
    if not istable(job.model) then return end
    local YPos = 5
    local XPos = 10

    local preferredModel = DarkRP.getPreferredJobModel(job.team)
    for i, mdl in ipairs(job.model) do
        btn = vgui.Create("tcb_panel_jobs_select_model_item", self.scroll)
        btn:UpdateInfo(job, mdl, self)
        btn:SetPos(XPos, YPos)
        YPos = YPos + btn:GetTall()+5
      
        if preferredModel == mdl then
            btn:SetSelected(true)
            btn.Paint= function()
            draw.RoundedBox(0,0,0,60,60,TCB_Settings.PrimaryColor)
            draw.RoundedBox(0,1,1,58,58,TCB_Settings.ButtonColor3)

            	
        end
            
        end
    end
    self.scroll:ScrollFix()
end


function PANEL:Close()

	self:SetVisible(false)
	self.visible = false
	--self.closebtn:SetVisible(false)
end
--Derma
vgui.Register( "tcb_panel_jobs_select_model", PANEL, "DPanel" )

--Model selection panel icon

local PANEL = {}--tcb_panel_jobs_select_model_item

function PANEL:Init()
	self:SetSize(60, 60)
    self:SetText("")
    self:SetColor()
    self.model = self.model or vgui.Create("ModelImage", self)
    self.model:SetSize(60, 60)
    self.model:SetPos(0, 0)
    self.model.OnMousePressed = fn.Partial(self.OnMousePressed, self)
    self.model.OnMouseReleased = fn.Partial(self.OnMouseReleased, self)
    self.model: SetCursor("hand")

end

function PANEL:OnMousePressed()
    self.model:SetSize(50, 50)
    self.model:SetPos(5, 5)
end

function PANEL:OnMouseReleased()
    DarkRP.setPreferredJobModel(self.job.team, self.strModel)
    local parent = self.hostPanel.parent
    
 
    parent.modelpath = self.strModel
    parent = parent:GetParent():GetParent()
    if parent and ValidPanel(parent) then

    	parent = parent:GetParent()
    	parent:RefillData()
    end

    self.hostPanel:Close()

    
end
function PANEL:Paint(pnl, w, h)
	draw.RoundedBox(0,0,0,60,60,TCB_Settings.ButtonColor3)
end
function PANEL:UpdateInfo(job, model, host)
    self.hostPanel = host
    self.strModel = model
    self.model:SetModel(model, 1, "000000000")
    self.job = job
    self:SetTooltip(model)
end


-- Derma
vgui.Register( "tcb_panel_jobs_select_model_item", PANEL, "DButton" )

-- Variables
local PANEL = {}

-- Panel
function PANEL:Init()

	-- Main Frame
	self:SetSize( 650 - 2, 620 - 2 )
	self:SetPos( 250, 2 )
	self.Paint = function()

		draw.RoundedBoxEx( 0, 0, 0, self:GetWide(), self:GetTall(), TCB_Settings.Transparent, false, true, false, false )

	end

	TCB_Scroll = vgui.Create( "tcb_panel_scroll", self )

	-- Fill Data
	self:FillData( TCB_Scroll )

end

-- Fill Data
function PANEL:FillData( parent )

	local StartYPos = 0

	for i, job in ipairs(RPExtraTeams) do
		
		local ShowThisItem = true
		if TCB_Settings.HideWrongJob == true then

			if job.customCheck 		and not job.customCheck(LocalPlayer()) 				then ShowThisItem = false end
			if job.NeedToChangeFrom and job.NeedToChangeFrom != LocalPlayer():Team() 	then ShowThisItem = false end

		end
		
		if ShowThisItem == true then
			CurrentJob = vgui.Create( "tcb_panel_jobs_item", parent )
			CurrentJob:SetPos( 0, StartYPos )

			-- Update
			local job_team 	= job['team'] 			or ""
			local job_name 	= job['name']			or ""
			local job_desc	= job['description']	or ""
			local job_max	= job['max'] 			or 0
			local job_vote	= job['vote']			or false
			local job_cmd	= job['command']		or ""

			local job_ply	= team.NumPlayers( job['team'] ) or 0
			local job_mdl	= ""

			if job_max == 0 then job_max = "#" end 		// ∞

			if istable( job['model'] ) then job_mdl = job['model'][1] else job_mdl = job['model'] end

			CurrentJob:UpdateInfo( job, job_team, job_name, job_mdl, job_max, job_ply, job_desc, job_vote, job_cmd )

			StartYPos = StartYPos + CurrentJob:GetTall() + 11
		end

	end

	if TCB_Settings.HideWrongJob == true then
		
		local HideElementsMsg = vgui.Create( "tcb_panel_hidden", parent )
		HideElementsMsg:SetPos( 0, StartYPos )

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
vgui.Register( "tcb_panel_jobs", PANEL, "DPanel" )