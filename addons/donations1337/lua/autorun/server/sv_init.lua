--#NoSimplerr#
print("Donator 1337 loading")
require( "mysqloo" )
include("connect.lua")
include("patterns.lua")
include("helpers.lua")
include("plyjoined.lua")
include("processor.lua")
--include("helpers.lua")

function ProcessNewPly(ply)
	ply:Process() 
end

hook.Add("PlayerInitialSpawn","SQLJoin",ProcessNewPly)

