include( "shared.lua" );

function DrawInformation()
	local tr = LocalPlayer():GetEyeTrace();
	if not ( tr.Entity:GetClass() == "money_printer_upgrade" ) then return end; 
	
	local w = 84
	if IsValid( tr.Entity ) and tr.Entity:GetPos():Distance( LocalPlayer():GetPos() ) < 100 then
		draw.RoundedBox( 4, ScrW() / 2 - ( w / 2 ), ScrH() / 2 - 40, w, 20, Color( 255, 255, 255, 100 ) ); 
		draw.SimpleText( "Охладитель", "DermaDefault", ScrW() / 2, ScrH() / 2 - 30, color_black, 1, 1 );
	end;
end;

function ENT:Draw()
	self.Entity:DrawModel()
	DrawInformation()
end

hook.Add( "HUDPaint", "KCoolantNotif", DrawInformation );
