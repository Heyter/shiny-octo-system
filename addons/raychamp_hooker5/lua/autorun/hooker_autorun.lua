
hooker = hooker or {}

if ( SERVER ) then
	AddCSLuaFile( "hooker/config.lua" )

	include( "hooker/config.lua" )
else
	include( "hooker/config.lua" )
end
