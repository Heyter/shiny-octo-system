AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel( "models/props/de_inferno/bed.mdl" )
	
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	self:SetUseType(SIMPLE_USE)
	
	local phys = self:GetPhysicsObject()
	phys:EnableMotion( false )
	
	if ( hooker.collidebed ) then
		self:SetCollisionGroup( COLLISION_GROUP_WORLD )
	end
	
	self:SetupSeats()
	
	self.die_time = CurTime() + hooker.bedexpire
end

function ENT:SetupSeats()
	local pod_data = list.Get( "Vehicles" )[ "Pod" ]
	
	local ang = self:GetAngles()
	ang:RotateAroundAxis( ang:Right(), 90 )
	
	local pod1 = ents.Create( pod_data.Class )
	pod1:SetModel( pod_data.Model )
	pod1:SetPos( self:LocalToWorld( Vector( 32, -10, 28 ) ) )
	pod1:SetAngles( ang )
	pod1:SetParent( self )
	pod1:SetNoDraw( true )
	pod1:SetNotSolid( true )
	
	for k,v in pairs( pod_data.KeyValues ) do
		pod1:SetKeyValue( k, v )
	end
	
	pod1.hooker_seat = true
	
	pod1:Spawn()
	
	self.pod1 = pod1
	
	local pod2 = ents.Create( pod_data.Class )
	pod2:SetModel( pod_data.Model )
	pod2:SetPos( self:LocalToWorld( Vector( 32, 13, 28 ) ) )
	pod2:SetAngles( ang )
	pod2:SetParent( self )
	pod2:SetNoDraw( true )
	pod2:SetNotSolid( true )
	
	for k,v in pairs( pod_data.KeyValues ) do
		pod2:SetKeyValue( k, v )
	end
	
	pod2.hooker_seat = true
	
	pod2:Spawn()
	
	self.pod2 = pod2
	
	if ( hooker.collidebed ) then
		self.pod1:SetCollisionGroup( COLLISION_GROUP_WORLD )
		self.pod2:SetCollisionGroup( COLLISION_GROUP_WORLD )
	end
end

hook.Add( "PlayerLeaveVehicle", "attemptSpawnFix", function( ply, veh )
	if ( !veh.hooker_seat ) then return end

	timer.Simple( 0, function()
		if ( !IsValid( ply ) ) then return end

		if ( ply.lastPositionVehicle ) then
			ply:SetPos( ply.lastPositionVehicle )
			ply.lastPositionVehicle = nil
		end
	end )
end )

hook.Add( "CanPlayerEnterVehicle", "stopPodEnter", function( ply, veh )
	for k,v in pairs( ents.FindByClass( "hooker_bed" ) ) do
		if ( v.banging ) then continue end
		
		if ( v.pod1 == veh or v.pod2 == veh ) then
			return false
		end
	end
end )

util.AddNetworkString( "hooker visual" )

function ENT:Begin( hooker_person, ply )
	self.banging = true
	self.die_time = nil 

	hooker_person.lastPositionVehicle = hooker_person:GetPos()
	hooker_person:EnterVehicle( self.pod1 )
	
	ply.lastPositionVehicle = ply:GetPos()
	ply:EnterVehicle( self.pod2 )
	
	net.Start( "hooker visual" )
		net.WriteBit( false )
	net.Send( { ply, hooker_person } )
		
	self.ambient_time = CurTime() + hooker.moan_time
	
	timer.Simple( hooker.bang_time, function()
		net.Start( "hooker visual" )
			net.WriteBit( true )
		net.Send( { ply, hooker_person } )
		
		if ( IsValid( self ) ) then
			self:Remove()
		end
	end )
end

function ENT:Think()
	if ( self.ambient_time and self.ambient_time < CurTime() ) then
		util.ScreenShake( self:GetPos(), 5, 5, 2, 1000 )
		sound.Play( table.Random( hooker.moans ), self:GetPos() )
		
		self.ambient_time = CurTime() + hooker.moan_time
	end
	
	if ( self.die_time and self.die_time < CurTime() ) then
		self:Remove()
	end
end