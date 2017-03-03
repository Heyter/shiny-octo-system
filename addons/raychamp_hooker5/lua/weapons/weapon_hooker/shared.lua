AddCSLuaFile()

if CLIENT then
	SWEP.PrintName 		= "Sexual Pleasure"
	SWEP.Slot 			= 1
	SWEP.SlotPos 		= 1
	SWEP.DrawAmmo 		= false
	SWEP.DrawCrosshair 	= false
end

SWEP.Author 				= "RayChamp"
SWEP.Instructions 			= "Left click to offer sex"
SWEP.Contact 				= ""
SWEP.Purpose 				= ""

SWEP.WorldModel				= "models/props_borealis/bluebarrel001.mdl"
SWEP.ViewModel 				= "models/props_borealis/bluebarrel001.mdl"

SWEP.ViewModelFOV 			= 62
SWEP.ViewModelFlip 			= false
SWEP.AnimPrefix	 			= "rpg"

SWEP.UseHands 				= true

SWEP.Spawnable 				= true
SWEP.AdminOnly 				= true

SWEP.Primary.ClipSize 		= -1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 			= ""

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= 0
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= ""


DarkRP.declareChatCommand{
	command = hooker.acceptcommand,
	description = "Pay the hooker for sex.",
	delay = 1.5
}

function SWEP:DrawWorldModel()

end

function SWEP:Initialize()
	self:SetHoldType( "normal" ) 
end

if ( SERVER ) then
	util.AddNetworkString( "hooker price set" )
	util.AddNetworkString( "hooker request" )
	
	net.Receive( "hooker request", function( length, ply )
		local target = net.ReadEntity()
		local price = net.ReadInt( 32 )
		
		local wep = ply:GetActiveWeapon()
		
		if ( IsValid( ply.sex_bed ) ) then
			ply.sex_bed:Remove()
		end
		
		if ( !IsValid( wep ) or wep:GetClass() != "weapon_hooker" ) then return end
		
		target:ChatPrint( ply:Nick().." wants to have sex with you for "..DarkRP.formatMoney(price)..", type /"..hooker.acceptcommand.." to accept." )
		
		local ent = wep:CreateBed()

		target.sex_with = {
			ply = ply,
			bed = ent,
			price = price
		}
		
		ply.sex_bed = ent
	end )
	
	DarkRP.defineChatCommand( hooker.acceptcommand, function( ply, args )
		if ( !ply.sex_with or !IsValid( ply.sex_with.ply ) ) then
			ply:ChatPrint( "You don't have any hookers that want to have sex with you." )
			return
		end
		
		local data = ply.sex_with
		local hooker = data.ply
		
		if ( !ply:canAfford( data.price ) ) then
			ply:ChatPrint( "You can't afford to have sex with the hooker!" )
			return
		end
		
		if ( !hooker:HasWeapon( "weapon_hooker" ) ) then
			ply:ChatPrint( "This player is no longer a hooker!" )
			return
		end
		
		if ( hooker:GetPos():Distance( data.bed:GetPos() ) >= 600 ) then
			ply:ChatPrint( "The hooker is to far away from the bed!" )
			return
		end
		
		if ( ply:GetPos():Distance( data.bed:GetPos() ) >= 600 ) then
			ply:ChatPrint( "The bed is to far away to have sex with the hooker!")
			return
		end
		
		ply:addMoney( -data.price )
	
		hooker:addMoney( data.price )
		
		data.bed:Begin( hooker, ply )
	end )
else
	net.Receive( "hooker price set", function()
		local wep = LocalPlayer():GetActiveWeapon()

		if ( IsValid( wep.bed ) ) then
			wep.bed:Remove()
		end
		
		local target = net.ReadEntity()
		local bed = ClientsideModel( "models/props/de_inferno/bed.mdl" )
		
		wep.bed = bed
		wep.stop_tell = true

		hook.Add( "PlayerBindPress", "pickupBedInput", function( ply, bind )
			if ( bind != "+attack" and bind != "+attack2" ) then return end
			
			wep.bed:Remove()
			
			hook.Remove( "PlayerBindPress", "pickupBedInput" )
			
			Derma_StringRequest( "Sex Price", "How much do you want to charge "..target:Nick().."?", "", function( txt )
				local int = tonumber( txt )
				
				if ( !int or int < 0 ) then return end
				
				net.Start( "hooker request" )
					net.WriteEntity( target )
					net.WriteInt( int, 32 )
				net.SendToServer()
			end )
			
			return true
		end )
	end )
end

function SWEP:CreateBed()
	local tr = self:GetBedTrace()
		
	local ent = ents.Create( "hooker_bed" )
	ent:SetPos( tr.HitPos )
	ent:SetAngles( Angle( 0, 0, 0 ) )
	ent:Spawn()
	
	return ent
end

function SWEP:PrimaryAttack()
	if ( CLIENT ) then return end
	
	local tr = self.Owner:GetEyeTrace()
	local ent = tr.Entity
	
	if ( !IsValid( ent ) or !ent:IsPlayer() or ent:GetPos():Distance( self.Owner:GetPos() ) >= 150 ) then 
		self.Owner:ChatPrint( "You have to point at somebody." )
		return 
	end
	
	net.Start( "hooker price set" )
		net.WriteEntity( ent )
	net.Send( self.Owner )
end

function SWEP:SecondaryAttack()
	if ( self:GetNextPrimaryFire() < CurTime() ) then
		self:PrimaryAttack()
	end
end

function SWEP:GetBedTrace()
	local owner_tr = util.TraceLine({
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * 90 ),
		filter = { self.Owner }
	})
	
	return util.TraceLine({
		start = owner_tr.HitPos,
		endpos = owner_tr.HitPos-Vector(0,0,500),
		filter = { self.Owner }
	})
end

function SWEP:Think()
	if ( SERVER ) then return end
	
	if ( !IsValid(self.bed) ) then return end
	
	local tr = self:GetBedTrace()
	
	self.bed:SetRenderMode( RENDERMODE_TRANSALPHA )
	self.bed:SetColor( Color( 0, 200, 0, 150 ) )
	self.bed:SetPos( tr.HitPos )
	self.bed:SetAngles( Angle( 0, 0, 0 ) )
end

function SWEP:DrawHUD()
	if ( IsValid( self.bed ) ) then
		draw.SimpleText( "Place the bed where you want to have sex at.", "hookerHUD", ScrW()/2, 100, color_white, 1, 1 )
	elseif ( !self.stop_tell ) then
		draw.SimpleText( "Click on someone you want to have sex with", "hookerHUD", ScrW()/2, 100, color_white, 1, 1 )
	end
end