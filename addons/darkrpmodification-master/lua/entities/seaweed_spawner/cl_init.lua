--[[---------------------------------------------------------------------------
This is an example of a custom entity.
---------------------------------------------------------------------------]]
include("shared.lua")
local deb = false
function ENT:Initialize()
end

function ENT:Draw()
	if deb then
		self:DrawModel()
	end
end

function ENT:Think()
end
