include( "shared.lua" );

local LabelBackgroundColor 	= ENT.Label_BG;				
local LabelTextColor 		= ENT.Label_TextColor;

function ENT:Initialize()
end 

function ENT:Draw()
	self.Entity:DrawModel();
	
	local Pos = self:GetPos();
	local Ang = self:GetAngles();
	
    local owner = self:Getowning_ent();
	owner = ( IsValid( owner ) and owner:Nick( ) ) or "Покинул игру";
	
	txt1 = self.PrintName;
	txt2 = "$" ..self:GetNWInt( "Amount" );
	txt3 = self:GetNWInt( "Health" );
	opacity1 = txt3 / 2;
	
	surface.SetFont( "HUDNumber5" );
	local TextWidthLabel = surface.GetTextSize( txt1 );
	local TextWidthOwner = surface.GetTextSize( owner );
	
	Ang:RotateAroundAxis( Ang:Up(), 90 );
	
	cam.Start3D2D( Pos + Ang:Up() * 3.5, Ang, 0.09 )
		draw.WordBox( 6, -TextWidthLabel * 0.5 - 5, -50, txt1, "HUDNumber5", LabelBackgroundColor, LabelTextColor );
	cam.End3D2D();
	
	cam.Start3D2D( Pos + Ang:Up() * 3.5, Ang, 0.06 )
		draw.WordBox( 6, -TextWidthOwner * 0.5, 0, owner, "HUDNumber5", LabelBackgroundColor, LabelTextColor );
	cam.End3D2D();
	
	Ang:RotateAroundAxis( Ang:Forward(), 90 );
	
	cam.Start3D2D( Pos + Ang:Up() * 7.3, Ang, 0.07 )
		draw.RoundedBox( 0, -24 - 100, -22, 70, 42, LabelBackgroundColor );
		draw.RoundedBox( 0, -24 - 95, -22, 60, 42, Color( 255, 0, 0, 255 ) );
		draw.RoundedBox( 0, -24 - 95, -22, 60, 42, Color( 0, 255, 0, opacity1 ) );
		if self:GetNWBool( "Upgraded" ) then
			surface.SetDrawColor( 255, 255, 255, 255 );
			surface.SetMaterial( Material( "icon16/star.png" ) );
			surface.DrawTexturedRect( -124, 22, 16, 16 );
			draw.SimpleText( "Улучшен", "Trebuchet18", -106, 22, Color( 255, 255, 255, 255 ) );
		end;
		
		draw.RoundedBox( 0, -40, -22, 164, 42, LabelBackgroundColor );
		draw.RoundedBox( 0, -35, -22, 154, 42, Color( 50, 100, 50, 255 ) );
				
		draw.SimpleText( txt3, "HUDNumber5", -89, 0, Color( 0, 0, 0, 255 ), 1, 1 );
		draw.SimpleText( txt2, "HUDNumber5", 43, 0, Color( 0, 0, 0, 255 ), 1, 1 );
				
		if self:GetNWBool( "CoolantToggle" ) then
			draw.RoundedBox( 0, -124, -44, 248, 15, LabelBackgroundColor );
			draw.RoundedBox( 0, -119, -44, 238, 15, Color( 180, 180, 180, 255 ) );
			draw.RoundedBox( 0, -119, -44, ( ( 238 / 100 ) * self:GetNWInt( "Coolant" ) ), 15, Color( 0, 255, 255, 255 ) );
			draw.SimpleText( "Осталось охладителя: " .. self:GetNWInt( "Coolant" ), "DermaDefault", -59, -37, Color( 0, 0, 0 ), 1, 1 );
		end;
	cam.End3D2D();
end;

function ENT:Think()
end;