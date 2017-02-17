AddCSLuaFile( "cl_init.lua" );
AddCSLuaFile( "shared.lua" );
include( "shared.lua" );

function ENT:Initialize()
	self:SetModel( "models/props_lab/box01a.mdl" );
	self:PhysicsInit( SOLID_VPHYSICS );
	self:SetMoveType( MOVETYPE_VPHYSICS );
	self:SetSolid( SOLID_VPHYSICS );
	self:SetUseType( SIMPLE_USE );
	self:SetColor( Color( 150, 150, 150 ) );
	local phys = self:GetPhysicsObject();
	if phys:IsValid() then phys:Wake() end;
	self.IsUpgrade = true;
end

/*
function ENT:Use( activator, caller )
end
*/