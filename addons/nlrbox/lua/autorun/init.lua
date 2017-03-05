AddCSLuaFile("autorun/client/cl_init_nlr.lua" )

if CLIENT then
	include("autorun/client/cl_init_nlr.lua")
else
	include("autorun/server/sv_init_nlr.lua")
end