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

AddCSLuaFile("shared.lua")
include("shared.lua")
include("autorun/evidence_settings.lua")

util.AddNetworkString("evidence_pickup_time")
util.AddNetworkString("evidence_pickup")
util.AddNetworkString("evidence_stop_pickup")

function ENT:Initialize()
	self:SetModel(Evidence.Settings.TheModel)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:DrawShadow( false )
	timer.Simple( Evidence.Settings.RemovesAfter, function() if not IsValid(self) then return end self:Remove() end)
	timer.Simple( 0.2, function()
		if self:GetKiller() then
			if self:GetKiller():IsPlayer() then
				self:SetNWString("Killer",self:GetKiller():Nick())
			end
		else
			self:Remove()
			return
		end
		if self:GetVictim() then
			if self:GetVictim():IsPlayer() then
				self:SetNWString("Victim",self:GetVictim():Nick())
			end
		else
			self:SetNWString("Victim","Unknown")
		end
	end)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then phys:EnableMotion(false) end
	self:SetAngles(Angle(0,0,0))
end
