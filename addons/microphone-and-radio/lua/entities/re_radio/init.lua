
require("voicechannel")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:SpawnFunction(ply, tr)
    if not tr.HitWorld then return end

    local ent = ents.Create("re_radio")
    ent:SetPos(tr.HitPos + Vector(0, 0, 50))
    ent:Spawn()

    return ent
end

function ENT:OnRemove()
    self.Band:Unregister(0, self)
end

function ENT:Initialize()
    self.Band = voicechannel.GetBand("Radio")
    self.Band:Register(0, self, true, false)

    self:SetModel("models/props_lab/citizenradio.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(USE_TOGGLE)
	self:CPPISetOwner(self.dt.owning_ent)

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end

    self.dt.On = true
end

function ENT:InSpeakerRange(ply)
    return self.dt.On and ply:GetShootPos():Distance(self:LocalToWorld(Vector(0, 0, 64))) < 500
end

function ENT:Use(activator, caller)
    if not activator:IsPlayer() then return end

    self.dt.On = not self.dt.On
end

function ENT:Think()
end
