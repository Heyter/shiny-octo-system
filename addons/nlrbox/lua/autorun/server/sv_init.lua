AddCSLuaFile( "autorun/client/cl_init.lua" )

function SendNLRBox(ply,cmd,args) 
	ply:ConCommand("drawnlrbox")
end 
hook.Add("PlayerDeath", "NLRPanel", SendNLRBox) 

function PlayerRespawn(ply,cmd,args) 
	if( !ply:Alive() ) then 
		 ply:Spawn() 
	end 
end 
concommand.Add("nlrspawn",PlayerRespawn)