--€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€--
--          =--Leaked by Teoren  --=             --
--€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€-€--

if SERVER then
	AddCSLuaFile("doorhandle/shared.lua")
	AddCSLuaFile("doorhandle/arizard_derma.lua")
	AddCSLuaFile("doorhandle/config.lua")
	AddCSLuaFile("doorhandle/client.lua")

	include("doorhandle/shared.lua")
	include("doorhandle/config.lua")
	include("doorhandle/server.lua")
else
	include("doorhandle/shared.lua")
	include("doorhandle/config.lua")
	include("doorhandle/arizard_derma.lua")
	include("doorhandle/client.lua")
end
