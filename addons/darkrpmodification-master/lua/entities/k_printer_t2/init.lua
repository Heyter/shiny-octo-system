AddCSLuaFile( "cl_init.lua" );
AddCSLuaFile( "shared.lua" );
include( "shared.lua" );

-- EDIT DEEZ & NOTHING ELSE --            -- if you want..
local function SetValues( ent )
	ent.printTime = 10; -- Default print time.
	ent.minPrint = 18; -- Minimum print amount.
	ent.maxPrint = 22; -- Maximum print amount.
	ent.upgradedExtra = ent.maxPrint * 0.5; -- The additional income received on upgraded printers.
	ent.printerColor = Color( 100, 100, 100, 255 ); -- The color of the printer prop.
	ent.coolantSystem = false; -- Toggles the coolant system.
	ent.coolantLoss = 0.5; -- The Percentage loss for each print of the coolant is enabled.
end;
------------------------------

local PrintMore;
function ENT:Initialize()
	self:SetModel( "models/props_lab/reciever01a.mdl" );
	self:PhysicsInit( SOLID_VPHYSICS );
	self:SetMoveType( MOVETYPE_VPHYSICS );
	self:SetSolid( SOLID_VPHYSICS );
	local phys = self:GetPhysicsObject();
	phys:Wake();

	SetValues( self );
	
	self:SetColor( self.printerColor );
	self.damage = 500;
	self.IsMoneyPrinter = true;
	self:SetNWInt( "Amount", 0 );
	self:SetNWInt( "Health", 500 );
	self:SetNWBool( "Upgraded", false );
	if self.coolantSystem then
		self:SetNWInt( "Coolant", 100 );
		self:SetNWBool( "CoolantToggle", true );
	end;
	timer.Simple( 0.1, function() PrintMore( self ) end );
	self:Getowning_ent():AddPrinter()
end;

function ENT:OnTakeDamage( dmg )
	self.damage = ( self.damage or 500 ) - math.ceil( dmg:GetDamage() );
	if self.damage < 0 then self.damage = 0 end;
	self:SetNWInt( "Health", self.damage );
end;

function ENT:StartTouch( hitEnt )
	if self:GetNWBool( "CoolantToggle" ) then
		if hitEnt.IsCoolant then
			self.Coolant = hitEnt;
			local amount = self:GetNWInt( "Coolant" ) + 100;
			if amount > 100 then amount = 100 end;
			self:SetNWInt( "Coolant", amount );
			self.Coolant:Remove();
		end;
	end;
	if ( hitEnt.IsUpgrade ) then 
		if ( !self:GetNWBool( "Upgraded" ) ) then
			self:SetNWBool( "Upgraded", true );
			hitEnt:Remove();
		end;
	end
end

function ENT:Use( activator )
	if ( activator:IsPlayer() and self:GetNWInt( "Amount" ) > 0 ) then
		activator:addMoney( self:GetNWInt( "Amount" ) );
		DarkRP.notify( activator, 0, 4, "Вы собрали $" .. self:GetNWInt( "Amount" ) .. " из " .. self.PrintName );
		self:SetNWInt( "Amount", 0 );
	end;
end;

function ENT:Destruct()
	local vPoint = self:GetPos();
	local effectdata = EffectData();
	effectdata:SetStart( vPoint );
	effectdata:SetOrigin( vPoint );
	effectdata:SetScale( 1 );
	util.Effect( "Explosion", effectdata );
	DarkRP.notify( self:Getowning_ent(), 1, 4, "Ваш " .. self.PrintName .. " взорвался!" );
end;

function ENT:BurstIntoFlames()
	DarkRP.notify( self:Getowning_ent(), 0, 4, "Ваш " .. self.PrintName .. " загорелся!" );
	self.burningup = true;
	local burntime = math.random( 8, 18 );
	self:Ignite( burntime, 0 );
	timer.Simple( burntime, function() self:Fireball() end );
end;

function ENT:Fireball()
	if not self:IsOnFire() then self.burningup = false return end;
	local dist = math.random( 20, 280 ); -- Explosion radius
	self:Destruct();
	for k, v in pairs( ents.FindInSphere( self:GetPos(), dist ) ) do
		if not v:IsPlayer() and not v:IsWeapon() and v:GetClass() ~= "predicted_viewmodel" and not v.IsMoneyPrinter then
			v:Ignite( math.random( 5, 22 ), 0 );
		elseif v:IsPlayer() then
			local distance = v:GetPos():Distance( self:GetPos() );
			v:TakeDamage( distance / dist * 100, self, self );
		end;
	end;
	self:Remove();
end;

PrintMore = function( ent )
	if not IsValid( ent ) then return end;
	if ent.damage <= 0 then return end;
	
	timer.Simple( ent.printTime / 2, function()
		if not IsValid( ent ) then return end;
		ent:CreateMoney();
	end );
end;

function ENT:CreateMoney()
	if not IsValid( self ) then return end;
	if self:IsOnFire() then return end;
	
	if self:GetNWBool( "CoolantToggle" ) then
		local coolantLeft = self:GetNWInt( "Coolant" ) - self.coolantLoss;
		self:SetNWInt( "Coolant", coolantLeft );
		if coolantLeft <= 0 then
			self:SetNWInt( "Coolant", 0 );
			self.damage = self.damage - 5;
			self:SetNWInt( "Health", self.damage );
			self.sparking = true;
			timer.Simple( 0.3, function() self.sparking = false end );
		end;
	end;
	
	local PrintAmount = math.random( self.minPrint, self.maxPrint );
	if self:GetNWBool( "Upgraded" ) then
		PrintAmount = PrintAmount + math.ceil( self.upgradedExtra );
	end;
	
	local TotalAmount = self:GetNWInt( "Amount" ) + PrintAmount;
	self:SetNWInt( "Amount", TotalAmount );
	
	if self.damage < 500 then 
		self.damage = self.damage + 1;
		self:SetNWInt( "Health", self.damage );
	end;
	
	timer.Simple( self.printTime / 2, function() PrintMore( self ) end );
end

function ENT:Think()
	if self.damage then
		if ( self.damage <= 0 ) then
			if not self:IsOnFire() then
				self.damage = 0;
				self:SetNWInt( "Health", 0 );
				
				self:BurstIntoFlames();	
			end;
		end;
	end;

	if self:WaterLevel() > 0 then
		self:Destruct();
		self:Remove();
		return;
	end;

	if not self.sparking then return end;

	local effectdata = EffectData();
	effectdata:SetOrigin( self:GetPos() );
	effectdata:SetMagnitude( 1 );
	effectdata:SetScale( 1 );
	effectdata:SetRadius( 2 );
	util.Effect( "Sparks", effectdata );
end;

function ENT:OnRemove()
	if self.sound then
		self.sound:Stop();
	end;
	self:Getowning_ent():RemovePrinter()
end;