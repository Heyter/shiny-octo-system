include("shared.lua")

local funny_text =  {
	"Oooooh Baby",
	"Yeah, give it to me hard",
	"Mmmmm you like that daddy?",
	"Harder, Harder, Harder!"
}

surface.CreateFont( "hookerHUD", {
	font = "Roboto",
	size = 20,
	weight = 400,
	antialias = true
} )

net.Receive( "hooker visual", function()
	local bit = tobool( net.ReadBit() )
	
	if ( bit == true ) then
		hook.Remove( "HUDPaint", "beginHookerHUD" )
		return
	end
	
	local txt = table.Random( funny_text )
	local txt_stamp = CurTime()
	
	local static_stamp = CurTime()
	local fade_in = true
	
	local txt_change = 2
	local wait_for_it = 0
	hook.Add( "HUDPaint", "beginHookerHUD", function()
		if ( fade_in and CurTime() - static_stamp > (hooker.bang_time-5) ) then
			fade_in = false
			static_stamp = CurTime()
		end
		
		if ( !fade_in ) then
			local perc = 1 - ( ( CurTime() - static_stamp ) / 5 )

			wait_for_it = perc
		else
			wait_for_it = math.min( 1, ( CurTime() - static_stamp ) / 5 )
		end
		
		surface.SetDrawColor( 0, 0, 0, 255*wait_for_it )
		surface.DrawRect( 0, 0, ScrW(), ScrH() )
		
		if ( wait_for_it < 1 ) then return end
		
		local perc = 1 - ( ( CurTime() - txt_stamp ) / txt_change )
		
		surface.SetDrawColor( 255*perc, 255*perc, 255*perc, 255 )
		surface.DrawRect( 0, 0, ScrW(), ScrH() )
		
		if ( perc <= 0 ) then
			txt_stamp = CurTime()
			txt = table.Random( funny_text )
		end
		
		draw.SimpleText( txt, "hookerHUD", ScrW()/2, (math.sin(CurTime()*10)*5)+(ScrH()/2), Color( 0*perc, 0*perc, 0*perc, 255*perc ), 1, 1 )
	end )
end )