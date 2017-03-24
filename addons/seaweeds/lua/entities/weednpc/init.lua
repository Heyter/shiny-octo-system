AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

util.AddNetworkString( "weedmenudialogue" )

function ENT:Initialize( )
	self:SetModel( "models/eli.mdl" )
	self:SetHullType( HULL_HUMAN )
	self:SetHullSizeNormal( )
	self:SetNPCState( NPC_STATE_SCRIPT )
	self:SetSolid(  SOLID_BBOX )
	self:CapabilitiesAdd( CAP_ANIMATEDFACE, CAP_TURN_HEAD )
	self:SetUseType( SIMPLE_USE )
	self:DropToFloor()
	
end

function ENT:OnTakeDamage()
	return false
end 

function ENT:AcceptInput( Name, Activator, Caller )	
	if !Activator.cantUse and Activator:IsPlayer() then
		Activator.cantUse = true
		net.Start( "weedmenudialogue" )
			net.WriteEntity(self)
		net.Send( Activator )
		timer.Simple(1.5, function()
			Activator.cantUse = false
		end)
	end
end