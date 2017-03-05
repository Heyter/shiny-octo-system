AddCSLuaFile( "autorun/client/cl_init.lua" )
util.AddNetworkString("NLRBox")

function SendNLRBox(ply,cmd,args) 
	print("ZHOPA")
	net.Start("NLRBox")
	net.Send(ply)
end 
hook.Add("PlayerDeath", "NLRPanel", SendNLRBox) 

function PlayerRespawn(ply,cmd,args) 
	if( !ply:Alive() ) then 
		 ply:Spawn() 
	end 
end

net.Receive("NLRBox",function(len,ply) return PlayerRespawn(ply) end)