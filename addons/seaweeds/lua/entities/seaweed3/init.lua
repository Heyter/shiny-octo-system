--[[---------------------------------------------------------------------------
This is an example of a custom entity.
---------------------------------------------------------------------------]]
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
function ENT:Initialize()
	self:SetModel("models/props_foliage4/blood_root.mdl")
	self:PhysicsInit(SOLID_OBB)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_OBB)

end

function ENT:SetParent(ent)
	self.parent = ent

end

function ENT:OnRemove()
	if self.parent and self.parent:IsValid() then
		self.parent:OnWeedRemoved()
	end

end

function ENT:AcceptInput( Name, Activator, Caller )	
	if Activator:IsPlayer() then
		hook.Call("PocketUse",nil,Activator,self)
	end
end
