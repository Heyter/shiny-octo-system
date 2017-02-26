--  _      _____  ___   _   __ ___________  ________   __
-- | |    |  ___|/ _ \ | | / /|  ___|  _  \ | ___ \ \ / /
-- | |    | |__ / /_\ \| |/ / | |__ | | | | | |_/ /\ V / 
-- | |    |  __||  _  ||    \ |  __|| | | | | ___ \ \ /  
-- | |____| |___| | | || |\  \| |___| |/ /  | |_/ / | |  
-- \_____/\____/\_| |_/\_| \_/\____/|___/   \____/  \_/                                                                                                            
--      ___      .__   __.   ______   .__   __. ____    ____ .___  ___.   ______    __    __       _______.    __       _______     ___       __  ___ .______      
--     /   \     |  \ |  |  /  __  \  |  \ |  | \   \  /   / |   \/   |  /  __  \  |  |  |  |     /       |   |  |     |   ____|   /   \     |  |/  / |   _  \     
--    /  ^  \    |   \|  | |  |  |  | |   \|  |  \   \/   /  |  \  /  | |  |  |  | |  |  |  |    |   (----`   |  |     |  |__     /  ^  \    |  '  /  |  |_)  |    
--   /  /_\  \   |  . `  | |  |  |  | |  . `  |   \_    _/   |  |\/|  | |  |  |  | |  |  |  |     \   \       |  |     |   __|   /  /_\  \   |    <   |      /     
--  /  _____  \  |  |\   | |  `--'  | |  |\   |     |  |     |  |  |  | |  `--'  | |  `--'  | .----)   |      |  `----.|  |____ /  _____  \  |  .  \  |  |\  \----.
-- /__/     \__\ |__| \__|  \______/  |__| \__|     |__|     |__|  |__|  \______/   \______/  |_______/       |_______||_______/__/     \__\ |__|\__\ | _| `._____|

include("autorun/evidence_settings.lua")

ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.PrintName 		= "Улика"
ENT.Author 			= "Anonymous Leakr"
ENT.Spawnable 		= false
ENT.AdminSpawnable 	= false

function ENT:SetupDataTables()
	self:NetworkVar("Entity",1 , "Victim")
	self:NetworkVar("Entity",2 , "Killer")
end

local Investigating_Sounds = {
"ambient/materials/dinnerplates1.wav",
"ambient/materials/dinnerplates2.wav",
"ambient/materials/dinnerplates3.wav",
"ambient/materials/dinnerplates4.wav",
"ambient/materials/dinnerplates5.wav",
"ambient/materials/footsteps_glass1.wav",
"ambient/materials/footsteps_glass2.wav"
}

if CLIENT then
	surface.CreateFont( "evidence_big", {
		font = "HUDNumber5",
		size = 40,
		weight = 500,
		antialias = true,
		outline = false
	} )
	surface.CreateFont( "evidence_small", {
		font = "HUDNumber5",
		size = 24,
		weight = 500,
		antialias = true,
		outline = false
	} )	
	surface.CreateFont( "evidence_tiny", {
		font = "HUDNumber5",
		size = 11,
		weight = 100,
		antialias = false,
		outline = false
	} )	

	function ENT:Draw()
		if Evidence.Settings.ShowToAllPlayers or (Evidence.Settings.AllowCP and LocalPlayer():isCP()) or (string.find(string.lower(team.GetName(LocalPlayer():Team())), Evidence.Settings.AllowJobName)) then
			self.Entity:DrawModel()
			local tr 	= LocalPlayer():GetEyeTrace()
			local w = ScrW()
			local h = ScrH()
			local x,y,width,height = w/2-w/10, h/2-60, w/5, h/15
			if Evidence.Settings.EntityHalo then
				render.SetMaterial(Material("Sprites/light_glow02_add"))
				render.DrawQuadEasy(self:WorldSpaceCenter( ), (EyePos() - self:WorldSpaceCenter( )):GetNormal(), 75, 75, Evidence.Settings.EntityHaloColor, 0)
			end
			if self:GetPos():Distance(LocalPlayer():GetPos()) <= Evidence.Settings.ShowDistance then
				local alpha = 255
				if Evidence.Settings.AlphaDistance then
					alpha = 150 - (self.Entity:GetPos():Distance(LocalPlayer():GetPos()) / 3)
				end
				if not self:GetNWString("Killer") or self:GetNWString("Killer") == "" then
					self:SetNWString("Killer",self:GetKiller():Nick())
				end
				if not self:GetNWString("Victim") or self:GetNWString("Victim") == "" then
					self:SetNWString("Victim",self:GetVictim():Nick())
				end
				local killer	= self:GetNWString("Killer") or "Unknown"
				local victim 	= self:GetNWString("Victim") or "Unknown"
				local angl 		= self:GetAngles()
				local pos 		= self:GetPos() + angl:Up() * (math.sin(CurTime() * 2) * 2)
				local ang 		= LocalPlayer():EyeAngles()
				ang:RotateAroundAxis(ang:Right(), 90)
				ang:RotateAroundAxis(ang:Up(), -90)
				ang:RotateAroundAxis(ang:Up(), math.sin(CurTime() * 3) * 5)
				cam.Start3D2D((pos + Vector(0,0,20)), ang, 0.1) 
					draw.RoundedBox(0, -145	, 0		, 	300	, 	100	, 	Color(0,0,0,alpha))
					draw.RoundedBox(0, -145+2, 0+2	, 	300-4, 	100-4, 	Color(Evidence.Settings.BGColor.r, Evidence.Settings.BGColor.g, Evidence.Settings.BGColor.b, alpha))
					if Evidence.Settings.WaterMark then
						draw.RoundedBox(0, 76, 5, 74, 14, Color(0,175,175,alpha*1.75))
						draw.RoundedBox(0, 76+1, 5+1, 74-2, 14-2, Color(0,0,0,alpha*1.75))
						draw.DrawText("Love to Anonymous Leakr", "evidence_tiny", 114, 6, Color(255, 255, 255, alpha*1.75), TEXT_ALIGN_CENTER)
					end
					draw.SimpleTextOutlined(self.PrintName, "evidence_big", 5, 17, Color(Evidence.Settings.TitleColor.r, Evidence.Settings.TitleColor.g, Evidence.Settings.TitleColor.b, alpha), 1, 1, 1, Color(0,0,0,alpha*1.5))
					if Evidence.Settings.ShowKiller then
						draw.SimpleTextOutlined("Убийца: " .. killer, "evidence_small", 2, 42, Color(Evidence.Settings.KillerColor.r, Evidence.Settings.KillerColor.g, Evidence.Settings.KillerColor.b, alpha*1.5), 1, 1, 0.9, Color(0,0,0,alpha*1.5))				
						draw.SimpleTextOutlined("Жертва: " .. victim, "evidence_small", 2, 63, Color(Evidence.Settings.VictimColor.r, Evidence.Settings.VictimColor.g, Evidence.Settings.VictimColor.b, alpha*1.5), 1, 1, 0.9, Color(0,0,0,alpha*1.5))	
					else
						draw.SimpleTextOutlined("Жертва: " .. victim, "evidence_small", 2, 53, Color(Evidence.Settings.VictimColor.r, Evidence.Settings.VictimColor.g, Evidence.Settings.VictimColor.b, alpha*1.5), 1, 1, 0.9, Color(0,0,0,alpha*1.5))
					end			
					if (Evidence.Settings.AllowCP and LocalPlayer():isCP()) or
					string.find(string.lower(team.GetName(LocalPlayer():Team())), Evidence.Settings.AllowJobName) then
						draw.SimpleTextOutlined("Нажмите Е чтоб расследовать", "evidence_small", 2, 83, Color(Evidence.Settings.Allowed.r, Evidence.Settings.Allowed.g, Evidence.Settings.Allowed.b, alpha*1.5), 1, 1, 0.9, Color(0,0,0,alpha*1.5))	
					else
						draw.SimpleTextOutlined("Вы не можете расследовать", "evidence_small", 2, 83, Color(Evidence.Settings.NotAllowed.r, Evidence.Settings.NotAllowed.g, Evidence.Settings.NotAllowed.b, alpha*1.5), 1, 1, 0.9, Color(0,0,0,alpha*1.5))	
					end
				cam.End3D2D() 
			end
			if self.Entity:GetNWBool("BeingPicked") == true and self.Entity:GetNWEntity("activator") == LocalPlayer() then
				local ttime = self.Entity:GetNWFloat("EndTime") - self.Entity:GetNWFloat("StartTime")
				local curtime = CurTime() - self.Entity:GetNWFloat("StartTime")
				local status = math.Clamp(curtime/ttime, 0, 1)
				local BarWidth = status * (width - 16)
				cam.Start2D();
					draw.RoundedBox(0, x-2, y*1.3-2, width+4, height+4, Color(200-(status*200), 0+(status*200), 0, 255))
					draw.RoundedBox(0, x, y*1.3, width, height, Color(0,0,0,255))
					draw.RoundedBox(0, x, y*1.3, BarWidth, height, Color(255-(status*255), 0+(status*255), 0, 255))
					draw.SimpleText("Расследуется", "evidence_small", w/2, (y*1.3) + height*0.25, Color(255,255,255,255), 1, 1)
					draw.SimpleText(math.Round(status*100) .."%", "evidence_small", w/2, (y*1.3) + height*0.75, Color(255,255,255,255), 1, 1)
					draw.RoundedBox(0, x,  (y*1.3) + height*0.5, width, 2, Color(200-(status*200), 0+(status*200), 0, 255))
				cam.End2D();
			end
		else
			self:SetNoDraw( true )
			self:DrawShadow( false )
			self:SetNotSolid( true )
		end
	end
end

function ENT:StartPickUp(activator)
	if activator:GetEyeTrace().Entity == self.Entity then
		if self.Entity:GetNWBool("BeingPicked") != true then
			self.Entity:SetNWBool("BeingPicked", true)
			self.Entity:SetNWFloat("StartTime", CurTime())
			self.Entity:SetNWFloat("EndTime", CurTime() + Evidence.Settings.InvestigationTime)
			self.Entity:SetNWEntity("activator",activator)
		end
	else
		self.Entity:SetNWBool("BeingPicked", false)
	end
end

function ENT:Think()
	local activator = self.Entity:GetNWEntity("activator")
	if not activator then return end
	if not activator:IsPlayer() then return end
	if not IsValid(self.Entity) then self:Remove() return end
	if not IsValid(activator) then self.Entity:SetNWBool("BeingPicked", false) return end
	if activator:GetEyeTrace().Entity != self.Entity then self.Entity:SetNWBool("BeingPicked", false) return end
	if self.Entity:GetNWBool("BeingPicked") then
		if not timer.Exists("PickUp_Sound_"..self.Entity:EntIndex()) then
			local sound_num = math.random(1,#Investigating_Sounds)
			self:EmitSound(Investigating_Sounds[sound_num], 100, 100)
			timer.Create("PickUp_Sound_"..self.Entity:EntIndex(), 1.5, Evidence.Settings.InvestigationTime/1.5, function()
				if not IsValid(self.Entity) then return end
				if activator:GetEyeTrace().Entity != self.Entity or not self.Entity:GetNWBool("BeingPicked") then self.Entity:SetNWBool("BeingPicked", false) timer.Destroy("PickUp_Sound_"..self.Entity:EntIndex()) return end
				sound_num = math.random(1,#Investigating_Sounds)
				self:EmitSound(Investigating_Sounds[sound_num], 100, 100)
			end)
		end
		if CurTime() >= self.Entity:GetNWFloat("EndTime") then
			if activator:GetEyeTrace().Entity != self.Entity then self.Entity:SetNWBool("BeingPicked", false) return end
			timer.Destroy("PickUp_Sound_"..self.Entity:EntIndex())
			self.Entity:SetNWBool("BeingPicked", false)
			self.Entity:PickUp()
		end
	end
end

function ENT:PickUp()
	if SERVER then
		local activator = self.Entity:GetNWEntity("activator")
		if Evidence.Settings.EnableCustomWantedText then
			self:GetKiller():wanted(nil,Evidence.Settings.CustomWantedText)
		else
			self:GetKiller():wanted(nil,"Убийство " .. self:GetNWString("Victim") .. "!")
		end
		self:Remove()
	end
end

		
		
function ENT:Use(activator)
	if self.Entity:GetNWBool("BeingPicked") then return end
	if not activator:IsPlayer() then return end
	if not activator:GetEyeTrace().Entity == self.Entity then return end
	if not self:GetKiller():IsPlayer() then self.Entity:Remove() return end
	if Evidence.Settings.AllowCP then
		if not activator:isCP() then return end
	else
		if not string.find(string.lower(team.GetName(activator:Team())), Evidence.Settings.AllowJobName) then return end
	end
	if Evidence.Settings.InstantTake then
		if Evidence.Settings.EnableCustomWantedText then
			self:GetKiller():wanted(nil,Evidence.Settings.CustomWantedText)
		else
			self:GetKiller():wanted(nil,"Убийство " .. self:GetNWString("Victim") .. "!")
		end
		self:Remove()				
	else
		self.Entity:StartPickUp(activator)
	end
end